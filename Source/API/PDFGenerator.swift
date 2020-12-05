//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Factory which converts a document into a PDF file
 */
public class PDFGenerator: PDFGeneratorProtocol, CustomStringConvertible {

    // MARK: - INTERNAL VARS

    /**
     Document which will be converted
     */
    internal var document: PDFDocument

    /**
     List of header and footer objects extracted from the document
     */
    internal var headerFooterObjects: [PDFLocatedRenderObject] = []

    /**
     Layout which holds current state
     */
    internal var layout = PDFLayout()

    /**
     Current page which increments during preparation
     */
    internal var currentPage: Int = 1

    /**
     Total page count used for displaying in rendered PDF
     */
    public var totalPages: Int = 1

    /**
     Layout information used for columns layout
     */
    internal var columnState = PDFColumnLayoutState()

    /**
     Group holding elements which will be rendered on each page if not nil
     */
    internal var masterGroup: PDFGroupObject?

    /**
     Generator wide padding used for calculations of groups
     */
    internal var currentPadding = EdgeInsets.zero

    /**
     Relative value tracking progress
     */
    public let progress = Progress.discreteProgress(totalUnitCount: 3)
    
    /**
     Delegate for image processing. Called after resizing and scaling and before drawing.
     */
    public var imageDelegate: PDFGeneratorImageDelegate?

    /**
     Font of each container.
     These values are used for simple text objects
     */
    internal lazy var fonts: [PDFContainer: Font] = .init(uniqueKeysWithValues: PDFContainer.allCases.map({ container in
        (container, Font.systemFont(ofSize: PDFConstants.defaultFontSize))
    }))

    /**
     Enables debugging on all generator instance
     */
    public var debug: Bool = false

    /**
     Text color of each container.
     These values are used for simple text objects
     */
    internal lazy var textColor: [PDFContainer: Color] = .init(uniqueKeysWithValues: PDFContainer.allCases.map({ container in
        (container, Color.black)
    }))

    // MARK: - PUBLIC INITS

    /**
     Initializes the generator with a document.

     - parameter document: The document which will be converted
     */
    public init(document: PDFDocument) {
        self.document = document

        layout.margin = document.layout.margin
    }

    // MARK: - INTERNAL FUNCS

    /**
     Resets the generator
     */
    internal func resetGenerator() {
        layout.reset()
        columnState.reset()
        currentPage = 1
        fonts = fonts.mapValues { _ in
            Font.systemFont(ofSize: PDFConstants.defaultFontSize)
        }
        textColor = textColor.mapValues { _ in
            Color.black
        }
    }
}
