//
//  PDFTable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 A table is a two dimensional list.
 It can be styled and can contain different data.
 */
public class PDFTable: PDFDocumentObject {

    /**
     Styling used for drawing
     */
    public var style: PDFTableStyle = PDFTableStyleDefaults.simple

    /**
     All cell data
     */
    public var cells: [[PDFTableCell]] = []

    /**
     List of relative widths. Values are between 0.0 and 1.0 and should sum up to 1.0
     */
    public var widths: [CGFloat] = []

    /**
     Padding is the distance between the cell content and its borders.
     */
    public var padding: CGFloat = 0

    /**
     Margin is the distance between the cell borders and other cells
     */
    public var margin: CGFloat = 0

    /**
     Header rows will be drawn on every page
     */
    public var showHeadersOnEveryPage: Bool = false

    /**
     Specifies how page breaks should be handled
     */
    public var pageBreakMode: PDFPageBreakMode = .never

    /**
     Count of rows and columns in this table
     */
    public private(set) var size: (rows: Int, columns: Int)

    /// Creates a new table with the given size and populates it with empty cells
    ///
    /// - Parameter size: Row and column count of table
    public convenience init(size: (rows: Int, columns: Int)) {
        self.init(rows: size.rows, columns: size.columns)
    }

    /// Creates a new table with the given size and populates it with empty cells.
    /// - Parameters:
    ///   - rows: Rows of table, must be greater than 0
    ///   - columns: Columns of table, must be greater than 0
    public init(rows: Int, columns: Int) {
        assert(rows >= 0, "Can't create a table with negative row count")
        assert(columns >= 0, "Can't create a table with negative column count")
        self.size = (rows: rows, columns: columns)
        self.cells = (0..<rows).map({ _ in (0..<columns).map({ _ in PDFTableCell() }) })
        self.widths = (0..<columns).map({ _ in 1.0 / CGFloat(columns) })
    }

    /**
     Creates a new `PDFTable` with the same properties
     */
    internal var copy: PDFTable {
        let table = PDFTable(size: self.size)
        table.style = self.style
        table.cells = self.cells
        table.widths = self.widths
        table.padding = self.padding
        table.margin = self.margin
        table.showHeadersOnEveryPage = self.showHeadersOnEveryPage
        return table
    }

    // Access shorthands

    public var rows: PDFTableRows {
        self[rows: 0..<size.rows]
    }

    public var columns: PDFTableColumns {
        self[columns: 0..<size.columns]
    }

    public var content: [[PDFTableContentable?]] {
        get {
            self.rows.content
        }
        set {
            self.rows.content = newValue
        }
    }

    public var alignment: [[PDFTableCellAlignment]] {
        get {
            self.rows.alignment
        }
        set {
            self.rows.alignment = newValue
        }
    }

    // MARK: - Equatable

    /// Compares two instances of `PDFTable` for equality
    ///
    /// - Parameters:
    ///   - other: Another instance of `PDFTable`
    /// - Returns: `true`, if `attributes`, `tag`, `style`, `cells`, `widths`, `padding`, `margin`, `showHeadersOnEveryPage` equal; otherwise `false`
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else { return false }

        guard let otherTable = other as? PDFTable else {
            return false
        }
        guard self.style == otherTable.style else {
            return false
        }
        guard self.cells.count == otherTable.cells.count else {
            return false
        }
        for i in 0..<self.cells.count where self.cells[i] != otherTable.cells[i] {
            return false
        }
        guard self.widths == otherTable.widths else {
            return false
        }
        guard self.padding == otherTable.padding else {
            return false
        }
        guard self.margin == otherTable.margin else {
            return false
        }
        guard self.showHeadersOnEveryPage == otherTable.showHeadersOnEveryPage else {
            return false
        }
        return true
    }
}
