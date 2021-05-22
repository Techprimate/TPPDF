//
//  PDFDocument.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
/**
 The main class users interact with.
 This object holds the information about the document and also all PDF objects.
 */
public class PDFDocument: CustomStringConvertible {

    // MARK: - PUBLIC VARS

    /**
     Holds all layout information
     */
    public var layout: PDFPageLayout

    /**
     Holds all document information
     */
    public var info: PDFInfo = PDFInfo()

    /**
     Holds all pagination information
     */
    public var pagination = PDFPagination()

    /**
     Holds strong references to all text styles
     */
    public var styles: [PDFTextStyle] = []

    /// Configuration for document/paper background
    public var background = PDFDocumentBackground()

    // MARK: - INTERNAL VARS

    /**
     All objects inside the document and the container they are located in
     */
    internal var objects: [PDFLocatedRenderObject] = []

    /**
     Group holding a template or elements which will be rendered on all pages behind the actual content
     */
    internal var masterGroup: PDFGroupObject?

    // MARK: - PUBLIC INITIALIZERS

    /**
     Creates a new document with the given layout

     - parameter layout: Layout information for document
     */
    public init(layout: PDFPageLayout) {
        self.layout = layout
    }

    /**
     Creates a new document with a predefined `PDFPageFormat`

     - parameter layout: Predefined page formats
     */
    public init(format: PDFPageFormat) {
        self.layout = format.layout
    }

    // MARK: - Elements

    // MARK: Layout

    /**
     Adds a empty space in the given container, between the previous and the next element

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter space: Space distance in points
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }

    // MARK: - Lines

    /**
     Adds a horizontal line spearator to the given container. The line starts at the left indentation and ends at the right indentation.
     Customize by adjusting parameter `style`.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter style: Style of line
     */
    public func addLineSeparator(_ container: PDFContainer = PDFContainer.contentLeft, style: PDFLineStyle) {
        objects += [(container, PDFLineSeparatorObject(style: style))]
    }

    // MARK: Image

    /**
     Adds an image to the given container.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter image: Image object
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, image: PDFImage) {
        objects += [(container, PDFImageObject(image: image))]
    }

    /**
     Adds an image row to the given container.
     This image row will fill the full available width between left indentation and right indentation.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, imagesInRow images: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: images, spacing: spacing))]
    }

    // MARK: Text

    /**
     Shorthand public function to add a String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        add(container, textObject: PDFSimpleText(text: text, spacing: lineSpacing))
    }

    /**
     Adds an text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter textObject: Simple text object
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, textObject: PDFSimpleText) {
        objects += [(container, PDFAttributedTextObject(simpleText: textObject))]
    }

    /**
     Shorthand public function to add a attributed String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter text: An attributed string
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, attributedText: NSAttributedString) {
        add(container, attributedTextObject: PDFAttributedText(text: attributedText))
    }

    /**
     Adds an attributed text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter textObject: Attributed text object
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, attributedTextObject: PDFAttributedText) {
        objects += [(container, PDFAttributedTextObject(attributedText: attributedTextObject))]
    }

    /**
     Set font in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the font will be set, defaults to `PDFContainer.contentLeft`
     - parameter font: Font of text
     */
    public func set(_ container: PDFContainer = PDFContainer.contentLeft, font: Font) {
        objects += [(container, PDFFontObject(font: font))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    public func resetFont(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFFontObject(font: Font.systemFont(ofSize: PDFConstants.defaultFontSize)))]
    }

    /**
     Set text color in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the text color will be set, defaults to `PDFContainer.contentLeft`
     - parameter color: Color of the text
     */
    public func set(_ container: PDFContainer = PDFContainer.contentLeft, textColor: Color) {
        objects += [(container, PDFTextColorObject(color: textColor))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    public func resetTextColor(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFTextColorObject(color: Color.black))]
    }

    // MARK: Table

    /**
     Adds a table object to the document in the defined container
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }

    // MARK: List

    /**
     Adds a list object to the document in the defined container
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }

    // MARK: Section

    /**
     Adds a section object to the document
     */
    public func add(section: PDFSection) {
        objects += [(.contentLeft, PDFSectionObject(section: section))]
    }

    // MARK: Layout

    /**
     Change the indentation in a container, use the parameter `left` to define from which side.

     - parameter container: Container whose indentation should be changed, defaults to `PDFContainer.contentLeft`
     - parameter indent: Points from the side
     - parameter left: If `true` then the left side indentation is set, else the right indentation is set
     */
    public func set(_ container: PDFContainer = PDFContainer.contentLeft, indent: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indent, left: left, insideSectionColumn: false))]
    }

    /**
     Change the absolute top offset in a container

     - parameter container: Container whose current absoilute offset should be changed, defaults to `PDFContainer.contentLeft`
     - parameter absoluteOffset: Points from the top
     */
    public func set(_ container: PDFContainer = PDFContainer.contentLeft, absoluteOffset: CGFloat) {
        objects += [(container, PDFOffsetObject(offset: absoluteOffset))]
    }

    /**
     Creates a new page
     */
    public func createNewPage() {
        objects += [(.contentLeft, PDFPageBreakObject())]
    }

    /**
     Adds a style to the index
     */
    public func add(style: PDFTextStyle) -> PDFTextStyle {
        self.styles.append(style)
        return style
    }

    /**
     Adds a table of content
     */
    public func add(tableOfContent: PDFTableOfContent) {
        objects += [(.contentLeft, PDFTableOfContentObject(list: PDFList(indentations: []), options: tableOfContent))]
    }

    // MARK: - Column Wrapping

    /**
     Starts a column section with automatic wrapping
     */
    public func enable(_ container: PDFContainer = PDFContainer.contentLeft, columns: Int, widths: [CGFloat], spacings: [CGFloat]) {
        assert(columns > 1, "A column wrap section must have more than one column")
        assert(widths.count >= columns, "A colum wrap section must have at least the same amount of width values as columns")
        assert(spacings.count == widths.count - 1, "A colum wrap section must have exactly one less spacing value than the widths")
        objects += [(container, PDFColumnWrapSectionObject(columns: columns, widths: widths, spacings: spacings))]
    }

    /**
     Finishes a column section
     */
    public func disableColumns(_ container: PDFContainer = PDFContainer.contentLeft, addPageBreak: Bool = true) {
        objects += [(container, PDFColumnWrapSectionObject(isDisable: true, addPageBreak: addPageBreak))]
    }

    /**
     Add a group object to the given container
     */
    public func add(_ container: PDFContainer = PDFContainer.contentLeft, group: PDFGroup) {
        objects += [(container, PDFGroupObject(objects: group.objects,
                                               allowsBreaks: group.allowsBreaks,
                                               isFullPage: false,
                                               backgroundColor: group.backgroundColor,
                                               backgroundImage: group.backgroundImage,
                                               backgroundShape: group.backgroundShape,
                                               outline: group.outline,
                                               padding: group.padding))]
    }

    /**
     Replaces current master group with the given one
     */
    public func set(master group: PDFMasterGroup) {
        self.masterGroup = PDFGroupObject(objects: group.objects,
                                          allowsBreaks: group.allowsBreaks,
                                          isFullPage: group.isFullPage,
                                          backgroundColor: group.backgroundColor,
                                          backgroundImage: group.backgroundImage,
                                          backgroundShape: group.backgroundShape,
                                          outline: group.outline,
                                          padding: group.padding)
    }

    /**
     Adds an external document to the document
     */
    public func add(externalDocument doc: PDFExternalDocument) {
        objects += [(.none, PDFExternalDocumentObject(url: doc.url,
                                                      pages: doc.pages))]
    }
}
