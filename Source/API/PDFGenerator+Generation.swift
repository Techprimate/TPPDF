//
//  PDFGenerator+Generation.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Gives the generator the functionality to convert a `PDFDocument` into a `PDF`
 */
extension PDFGenerator {

    // MARK: - PUBLIC FUNCS

    /// nodoc
    public func generateURL(filename: String) throws -> URL {
        try self.generateURL(filename: filename, info: nil)
    }

    /// nodoc
    public func generate(to url: URL) throws {
        try self.generate(to: url, info: nil)
    }

    /**
     Generates PDF data and writes it to a temporary file.

     - parameter to:    URL where file should be saved.
     - parameter info:  PDF file information

     - throws:          PDFError
     */
    public func generate(to url: URL, info: PDFInfo?) throws {
        let context = PDFContextGraphics.createPDFContext(url: url, bounds: document.layout.bounds, info: info ?? document.info)
        try generatePDFContext(context: context)
        PDFContextGraphics.closePDFContext(context)
    }

    /// nodoc
    public func generateData() throws -> Data {
        try self.generateData(info: nil)
    }

    /**
     Generates PDF data and returns it

     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter info:      Metadata Information added to file

     - returns:             PDF Data

     - throws:              PDFError
     */
    public func generateData(info: PDFInfo?) throws -> Data {
        let (data, context) = PDFContextGraphics.createPDFDataContext(bounds: document.layout.bounds, info: info ?? document.info)
        try generatePDFContext(context: context)
        PDFContextGraphics.closePDFContext(context)
        return data as Data
    }

    // MARK: - INTERNAL FUNCS

    /**
     Generate PDF Context from PDFCommands

     - throws: PDFError
     */
    public func generatePDFContext(context: PDFContext) throws {
        let renderObjects = try createRenderObjects()
        try render(objects: renderObjects, in: context)
    }

    /**
     Creates a list of container-object pairs which will be rendered.

     - returns: List of renderable objects
     */
    public func createRenderObjects() throws -> [PDFLocatedRenderObject] {
        layout.margin = document.layout.margin

        // First calculate master objects
        var masterObjects: [PDFLocatedRenderObject] = []
        if let masterGroup = document.masterGroup {
            masterObjects = try masterGroup.calculate(generator: self, container: .contentLeft)
        }
        resetGenerator()

        // Extract content objects
        let contentObjects = PDFGenerator.extractContentObjects(objects: document.objects)

        // Extract header & footer objects
        let footers = PDFGenerator.extractFooterObjects(objects: document.objects)
        let headers = PDFGenerator.extractHeaderObjects(objects: document.objects)

        headerFooterObjects = headers + footers

        // Only add space between content and footer if there are objects in footer.
        if footers.isEmpty {
            document.layout.space.footer = 0
        }

        // Only add space between content and header if there are objects in header.
        if headers.isEmpty {
            document.layout.space.header = 0
        }

        // Progress tracking
        var calculationProgress = Progress.discreteProgress(totalUnitCount: Int64(contentObjects.count))
        progress.addChild(calculationProgress, withPendingUnitCount: 1)

        // Set layout margin according to document spec
        layout.margin = document.layout.margin

        // Save calculated page count from reseting
        totalPages = try estimateTotalPageCount(of: contentObjects, progress: calculationProgress)

        // Progress tracking
        calculationProgress = Progress.discreteProgress(totalUnitCount: Int64(contentObjects.count))
        progress.addChild(calculationProgress, withPendingUnitCount: 1)

        // Set layout margin according to document spec
        layout.margin = document.layout.margin

        // Calculate
        return try calculateRenderObjects(contentObjs: contentObjects, masterObj: masterObjects, progress: calculationProgress)
    }

    internal func estimateTotalPageCount(of contentObjects: [PDFLocatedRenderObject], progress: Progress) throws -> Int {
        // Only calculate render header & footer metrics if page has content.
        if !contentObjects.isEmpty && !(contentObjects.first?.1 is PDFExternalPageObject) {
            _ = try addHeaderFooterObjects()
        }

        var hasAddedHeaderFooterToPage = false

        // Iterate all objects and let them calculate the required rendering bounds
        var needsPageBreak = false
        for (pdfObjectIdx, locatedPdfObject) in contentObjects.enumerated() {
            let (container, pdfObject) = locatedPdfObject
            if let tocObject = pdfObject as? PDFTableOfContentObject {
                // Create table of content from objects
                tocObject.list = PDFGenerator.createTableOfContentList(objects: contentObjects,
                                                                       styles: tocObject.options.styles,
                                                                       symbol: tocObject.options.symbol)
            }
            let objects = try pdfObject.calculate(generator: self, container: container)
            var prevObj: PDFLocatedRenderObject?
            for (objIdx, obj) in objects.enumerated() {
                if needsPageBreak {
                    // Skip adding page break between external pages
                    if !(prevObj?.1 is PDFExternalPageObject) && !(obj.1 is PDFExternalPageObject) {
                        needsPageBreak = false
                        _ = try PDFPageBreakObject().calculate(generator: self, container: container)
                        currentPage += 1
                    }
                }

                if obj.1 is PDFExternalPageObject {
                    // Do not add counter if one of the following is true:
                    // - external page is the first element
                    if !(pdfObjectIdx == 0 && objIdx == 0) {
                        currentPage += 1
                    }
                    needsPageBreak = true
                } else {
                    if !hasAddedHeaderFooterToPage {
                        hasAddedHeaderFooterToPage = true
                        _ = try addHeaderFooterObjects()
                    }
                }

                if let pageBreak = obj.1 as? PDFPageBreakObject, !pageBreak.stayOnSamePage {
                    currentPage += 1
                    hasAddedHeaderFooterToPage = false
                }
                prevObj = obj
            }
            progress.completedUnitCount += 1
        }

        let result = currentPage

        // Reset all changes made by metrics calculation to generator
        resetGenerator()

        return result
    }

    private func calculateRenderObjects(contentObjs: [PDFLocatedRenderObject], masterObj: [PDFLocatedRenderObject], progress: Progress) throws -> [PDFLocatedRenderObject] {
        guard !contentObjs.isEmpty else {
            return []
        }

        var result = [PDFLocatedRenderObject]()

        var hasAddedMasterToPage = false
        var hasAddedHeaderFooterToPage = false

        result += masterObj
        hasAddedMasterToPage = true
        // If the first content object is an external page document, skip headers and footers
        if !(contentObjs.first?.1 is PDFExternalDocumentObject) {
            result += try addHeaderFooterObjects()
        }
        hasAddedHeaderFooterToPage = true

        // Iterate all objects and let them calculate the required rendering
        var needsPageBreak = false
        for (container, pdfObject) in contentObjs {
            let objects = try pdfObject.calculate(generator: self, container: container)
            var prevObj: PDFLocatedRenderObject?
            for obj in objects {
                if needsPageBreak {
                    if !(prevObj?.1 is PDFExternalPageObject) && !(obj.1 is PDFExternalPageObject) {
                        needsPageBreak = false
                        result += try PDFPageBreakObject().calculate(generator: self, container: container)
                        currentPage += 1
                    }
                }
                if !(obj.1 is PDFExternalPageObject) {
                    if !hasAddedMasterToPage {
                        hasAddedMasterToPage = true

                        // Add master objects to page
                        result += masterObj
                    }
                    if !hasAddedHeaderFooterToPage {
                        hasAddedHeaderFooterToPage = true

                        // Only calculate render header & footer metrics if page has content.
                        result += try addHeaderFooterObjects()
                    }
                }

                result.append(obj)

                if obj.1 is PDFExternalPageObject {
                    needsPageBreak = true
                }

                if let pageBreak = obj.1 as? PDFPageBreakObject, !pageBreak.stayOnSamePage {
                    currentPage += 1
                    hasAddedHeaderFooterToPage = false
                    hasAddedMasterToPage = false
                }
                prevObj = obj
            }
            progress.completedUnitCount += 1
        }

        return result
    }

    /**
     Returns a list of all header and footer objects with their corresponding container.
     This list also contains the pagination object

     - throws: PDFError

     - returns: List of renderable objects
     */
    private func addHeaderFooterObjects() throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        layout.heights.resetHeaderFooterHeight()

        let pagination = document.pagination

        if pagination.container != .none {
            if !pagination.hiddenPages.contains(currentPage) && currentPage >= pagination.range.start && currentPage <= pagination.range.end {
                let text = pagination.style.format(page: currentPage, total: totalPages)
                let attributedText = NSAttributedString(string: text, attributes: pagination.textAttributes)
                let textObject = PDFAttributedTextObject(attributedText: PDFAttributedText(text: attributedText))
                result += try textObject.calculate(generator: self, container: pagination.container)
            }
        }
        for (container, headerFooter) in headerFooterObjects {
            result += try headerFooter.copy.calculate(generator: self, container: container)
        }

        if debug {
            result += try headerFooterDebugLines()
        }

        return result
    }

    /**
     TODO: Documentation
     */
    private func headerFooterDebugLines() throws -> [PDFLocatedRenderObject] {
        let headerFooterDebugLineStyle = PDFLineStyle(type: .dashed, color: .orange, width: 1)

        let yPositions = [
            layout.margin.top + layout.heights.maxHeaderHeight(),
            layout.margin.top + layout.heights.maxHeaderHeight() + document.layout.space.header,
            document.layout.height - layout.margin.bottom - layout.heights.maxFooterHeight(),
            document.layout.height - layout.margin.bottom - layout.heights.maxFooterHeight() - document.layout.space.footer
        ]

        var lines: [PDFLineObject] = []

        for y in yPositions {
            let start = CGPoint(x: 0, y: y)
            let end = CGPoint(x: document.layout.bounds.width, y: y)

            lines.append(PDFLineObject(style: headerFooterDebugLineStyle, startPoint: start, endPoint: end))
        }

        var result: [PDFLocatedRenderObject] = []
        for line in lines {
            result += try line.calculate(generator: self, container: .contentLeft)
        }

        return result
    }

    /**
     Renders a list of objects in their corresponding container

     - throws: PDFError, if rendering fails
     */
    internal func render(objects: [PDFLocatedRenderObject], in context: PDFContext) throws {
        let renderProgress = Progress.discreteProgress(totalUnitCount: Int64(objects.count))
        progress.addChild(renderProgress, withPendingUnitCount: 1)

        // if first element is an external document, do not create the page
        if objects.first?.1 is PDFExternalPageObject == false {
            PDFContextGraphics.beginPDFPage(in: context, for: document.layout.bounds)
            // if there is a background color set, fill the page with it
            if let color = document.background.color {
                PDFGraphics.drawRect(in: context, rect: document.layout.bounds, outline: .none, fill: color)
            }
            drawDebugPageOverlay(in: context)
        }

        for (container, object) in objects {
            try render(object: object, in: container, in: context)
            renderProgress.completedUnitCount += 1
        }

        PDFContextGraphics.endPDFPage(in: context)
    }

    /**
     Render a object in its corresponding container

     - throws: PDFError, if rendering fails
     */
    internal func render(object: PDFRenderObject, in container: PDFContainer, in context: PDFContext) throws {
        try object.draw(generator: self, container: container, in: context)
    }

    // MARK: - INTERNAL STATIC FUNCS

    /**
     Filters out all objects which are in the header area

     - parameter objects: List objects

     - returns: List of all header objects
     */
    internal static func extractHeaderObjects(objects: [PDFLocatedRenderObject]) -> [PDFLocatedRenderObject] {
        objects.filter { $0.0.isHeader }
    }

    /**
     Filters out all objects which are in the footer area

     - parameter objects: List objects

     - returns: List of all footer objects
     */
    internal static func extractFooterObjects(objects: [PDFLocatedRenderObject]) -> [PDFLocatedRenderObject] {
        objects.filter { $0.0.isFooter }
    }

    /**
     Filters out all objects which are in the content area

     - parameter objects: List objects

     - returns: List of all content objects
     */
    internal static func extractContentObjects(objects: [PDFLocatedRenderObject]) -> [PDFLocatedRenderObject] {
        objects.filter { !$0.0.isFooter && !$0.0.isHeader }
    }

    /**
     TODO: Documentation
     */
    internal static func createTableOfContentList(objects: [PDFLocatedRenderObject],
                                                  styles: [WeakPDFTextStyleRef],
                                                  symbol: PDFListItemSymbol) -> PDFList {
        var elements: [(Int, PDFAttributedTextObject)] = []
        for (_, obj) in objects {
            if let textObj = obj as? PDFAttributedTextObject,
                let style = textObj.simpleText?.style,
                let styleIndex = styles.firstIndex(where: { $0.value === style }) {
                elements.append((styleIndex, textObj))
            }
        }
        let list = PDFList(indentations: styles.enumerated().map { (pre: CGFloat($0.offset + 1) * 10, past: 10) })
        var stack = Stack<PDFListItem>()
        for (index, element) in elements {
            let item = PDFListItem(symbol: symbol, content: element.simpleText?.text)

            stack.pop(to: index)
            if index == 0 {
                list.addItem(item)
                stack.push(item)
            } else if let parent = stack.peek(at: index - 1) {
                parent.addItem(item)
                stack.push(item)
            } else {
                for i in stack.count..<index {
                    let placeholderItem = PDFListItem(symbol: .none, content: nil)
                    stack.push(placeholderItem)
                    stack.peek(at: i - 1)?.addItem(placeholderItem)
                }
                stack.peek(at: index - 1)?.addItem(item)
                stack.push(item)
            }
        }
        return list
    }
}
