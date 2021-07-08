import CoreGraphics
import Foundation
import Quick
import Nimble
import XCTest
@testable import TPPDF

#if os(iOS)
class PDFTableObjectSpec: XCTestCase {

    /// Preconditions:
    /// - Multiple pages
    /// - No cell splicing
    /// - No column headers on every page
    func testCells_unmergedCellsMultiplePagesNoSplicingTableNoHeadersEveryPage_shouldNotAddHeadersToEveryPage() throws {
        let rows = 20
        let columns = 4
        let count = rows * columns

        let table = generateTable(rows: rows, columns: columns)
        table.showHeadersOnEveryPage = false
        let result = try calculate(table: table)

        // should return correct cell count including necessary page breaks
        XCTAssertEqual(result.count, count + 1)
        XCTAssertTrue(result[56].1 is PDFPageBreakObject)

        // check cell frames

        let columnXPositions: [CGFloat] = [70, 117.5, 260, 402.5]
        let columnWidths: [CGFloat] = [27.5, 122.5, 122.5, 122.5]

        let rowYPositions: [CGFloat] = [
            // Page 1
            // Headers
            70,  // 70,                     // Header Row 0
            117, // 70 + 37 + 10,           // Header Row 1
            164, // 70 + (37 + 10) * 2,     // Header Row 2
            // First smaller rows
            211, // 70 + (37 + 10) * 3,     // Row 3
            258, // 70 + (37 + 10) * 4,     // Row 4
            305, // 70 + (37 + 10) * 5,     // Row 5
            352, // 70 + (37 + 10) * 6,     // Row 6
            399, // 70 + (37 + 10) * 7,     // Row 7
            446, // 70 + (37 + 10) * 8,                      // Row 8
            493, // 70 + (37 + 10) * 9,                      // Row 9
            // Larger rows
            540, // 70 + (37 + 10) * 10,                     // Row 10
            598, // 70 + (37 + 10) * 10 + (48 + 10) * 1,     // Row 11
            656, // 70 + (37 + 10) * 10 + (48 + 10) * 2,     // Row 12
            714, // 70 + (37 + 10) * 10 + (48 + 10) * 3,     // Row 13
            // Page 2
            70, // 70 + (48 + 10),                         // Row 14
            128, // 70 + (48 + 10) * 1,                     // Row 15
            186, // 70 + (48 + 10) * 2,                     // Row 16
            244, // 70 + (48 + 10) * 3,                     // Row 17
            302, // 70 + (48 + 10) * 4,                     // Row 18
            360, // 70 + (48 + 10) * 5,                     // Row 19
        ]
        let rowHeights: [CGFloat] = [
            // Page 1
            // Headers
            37, // Header Row 0
            37, // Header Row 1
            37, // Header Row 2
            // First smaller rows
            37, // Row 3
            37, // Row 4
            37, // Row 5
            37, // Row 6
            37, // Row 7
            37, // Row 8
            37, // Row 9
            // Larger rows
            48, // Row 10
            48, // Row 11
            48, // Row 12
            48, // Row 13
            // Page 2
            48, // Row 14
            48, // Row 15
            48, // Row 16
            48, // Row 17
            48, // Row 18
            48, // Row 19
        ]

        for rowIdx in 0..<14 {
            for colIdx in 0..<columnXPositions.count {
                let locatedCell = result[rowIdx * columns + colIdx]

                XCTAssertEqual(locatedCell.1.frame.origin.x, columnXPositions[colIdx], "Cell \(rowIdx),\(colIdx) has invalid x position")
                XCTAssertEqual(locatedCell.1.frame.origin.y, rowYPositions[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid y position")
                XCTAssertEqual(locatedCell.1.frame.width, columnWidths[colIdx], "Cell \(rowIdx),\(colIdx) has invalid width")
                XCTAssertEqual(locatedCell.1.frame.height, rowHeights[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid height")
            }
        }
        for rowIdx in 14..<rowYPositions.count {
            for colIdx in 0..<columnXPositions.count {
                let locatedCell = result[rowIdx * columns + colIdx + 1] // add one for page break offset

                XCTAssertEqual(locatedCell.1.frame.origin.x, columnXPositions[colIdx], "Cell \(rowIdx),\(colIdx) has invalid x position")
                XCTAssertEqual(locatedCell.1.frame.origin.y, rowYPositions[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid y position")
                XCTAssertEqual(locatedCell.1.frame.width, columnWidths[colIdx], "Cell \(rowIdx),\(colIdx) has invalid width")
                XCTAssertEqual(locatedCell.1.frame.height, rowHeights[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid height")
            }
        }
    }

    /// Preconditions:
    /// - Multiple pages
    /// - No cell splicing
    /// - Column headers on every page
    func testCells_unmergedCellsMultiplePagesNoSplicingTableHeadersEveryPage_shouldDuplicateHeadersToEveryPage() throws {
        let rows = 20
        let columns = 4
        let count = rows * columns

        let table = generateTable(rows: rows, columns: columns)
        table.showHeadersOnEveryPage = true
        let result = try calculate(table: table)

        // should return correct cell count including necessary page breaks
        XCTAssertEqual(result.count, count + 1 + 12)
        XCTAssertTrue(result[56].1 is PDFPageBreakObject)

        // check cell frames

        let columnXPositions: [CGFloat] = [70, 117.5, 260, 402.5]
        let columnWidths: [CGFloat] = [27.5, 122.5, 122.5, 122.5]

        let rowYPositions: [CGFloat] = [
            // Page 1
            // Headers
            70,  // 70,                     // Header Row 0
            117, // 70 + 37 + 10,           // Header Row 1
            164, // 70 + (37 + 10) * 2,     // Header Row 2
            // First smaller rows
            211, // 70 + (37 + 10) * 3,     // Row 3
            258, // 70 + (37 + 10) * 4,     // Row 4
            305, // 70 + (37 + 10) * 5,     // Row 5
            352, // 70 + (37 + 10) * 6,     // Row 6
            399, // 70 + (37 + 10) * 7,     // Row 7
            446, // 70 + (37 + 10) * 8,                      // Row 8
            493, // 70 + (37 + 10) * 9,                      // Row 9
            // Larger rows
            540, // 70 + (37 + 10) * 10,                     // Row 10
            598, // 70 + (37 + 10) * 10 + (48 + 10) * 1,     // Row 11
            656, // 70 + (37 + 10) * 10 + (48 + 10) * 2,     // Row 12
            714, // 70 + (37 + 10) * 10 + (48 + 10) * 3,     // Row 13
            // Page 2
            // Headers
            70,  // 70,                     // Header Row 0
            117, // 70 + 37 + 10,           // Header Row 1
            164, // 70 + (37 + 10) * 2,     // Header Row 2
            211, // 70 + (37 + 10) * 3,         // Row 14
            269, // 70 + (37 + 10) * 3 + (48 + 10) * 1,     // Row 15
            327, // 70 + (37 + 10) * 3 + (48 + 10) * 2,     // Row 16
            385, // 70 + (37 + 10) * 3 + (48 + 10) * 3,     // Row 17
            443, // 70 + (37 + 10) * 3 + (48 + 10) * 4,     // Row 18
            501, // 70 + (37 + 10) * 3 + (48 + 10) * 5,     // Row 19
        ]
        let rowHeights: [CGFloat] = [
            // Page 1
            // Headers
            37, // Header Row 0
            37, // Header Row 1
            37, // Header Row 2
            // First smaller rows
            37, // Row 3
            37, // Row 4
            37, // Row 5
            37, // Row 6
            37, // Row 7
            37, // Row 8
            37, // Row 9
            // Larger rows
            48, // Row 10
            48, // Row 11
            48, // Row 12
            48, // Row 13
            // Page 2
            // Headers
            37, // Header Row 0
            37, // Header Row 1
            37, // Header Row 2
            48, // Row 14
            48, // Row 15
            48, // Row 16
            48, // Row 17
            48, // Row 18
            48, // Row 19
        ]

        for rowIdx in 0..<14 {
            for colIdx in 0..<columnXPositions.count {
                let locatedCell = result[rowIdx * columns + colIdx]

                XCTAssertEqual(locatedCell.1.frame.origin.x, columnXPositions[colIdx], "Cell \(rowIdx),\(colIdx) has invalid x position")
                XCTAssertEqual(locatedCell.1.frame.origin.y, rowYPositions[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid y position")
                XCTAssertEqual(locatedCell.1.frame.width, columnWidths[colIdx], "Cell \(rowIdx),\(colIdx) has invalid width")
                XCTAssertEqual(locatedCell.1.frame.height, rowHeights[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid height")
            }
        }
        for rowIdx in 14..<rowYPositions.count {
            for colIdx in 0..<columnXPositions.count {
                let locatedCell = result[rowIdx * columns + colIdx + 1] // add one for page break offset

                XCTAssertEqual(locatedCell.1.frame.origin.x, columnXPositions[colIdx], "Cell \(rowIdx),\(colIdx) has invalid x position")
                XCTAssertEqual(locatedCell.1.frame.origin.y, rowYPositions[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid y position")
                XCTAssertEqual(locatedCell.1.frame.width, columnWidths[colIdx], "Cell \(rowIdx),\(colIdx) has invalid width")
                XCTAssertEqual(locatedCell.1.frame.height, rowHeights[rowIdx], "Cell \(rowIdx),\(colIdx) has invalid height")
            }
        }
    }

    private func generateTable(rows: Int, columns: Int) -> PDFTable {
        let table = PDFTable(rows: rows, columns: columns)
        table.widths = [0.1, 0.3, 0.3, 0.3]
        table.margin = 10
        table.padding = 10
        table.pageBreakMode = .never
        table.style.columnHeaderCount = 3

        for row in 0..<table.size.rows {
            table[row, 0].content = "\(row)".asTableContent
            for column in 1..<table.size.columns {
                table[row, column].content = "\(row),\(column)".asTableContent
            }
        }
        return table
    }

    private func calculate(table: PDFTable) throws -> [PDFLocatedRenderObject] {
        let container = PDFContainer.contentLeft
        let generator = PDFGenerator(document: .init(format: .a4))
        let tableObject = PDFTableObject(table: table)
        return try tableObject.calculate(generator: generator, container: container)
    }
}
#endif
