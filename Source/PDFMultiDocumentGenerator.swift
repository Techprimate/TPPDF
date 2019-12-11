//
//  PDFMultiDocumentGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.12.2019
//

/**
 Generates a PDF from multiple `PDFDocument` by appending them.
 */
public class PDFMultiDocumentGenerator {

    /**
     Bounds of first document, set on initialisation
     */
    private let bounds: CGRect

    /**
     Generator instances for each document
     */
    private var generators: [PDFGenerator]

    /**
     Instance of  `Progress` used to track and control the multi-document generation
     */
    public let progress: Progress

    /**
     Instances of `Progess` used to track and control each individual document generation
     */
    public let progresses: [Progress]

    /**
     Flag to enable or disable the debug overlay
     */
    public var debug = false

    /**
     Initialises a new multi-document generator for generating the giving documents.
     It will use the page layout of the first document.

     The instance property `progress` is initalised to the total document count.

     - parameter documents: Array of `PDFDocument` instances, which will all be rendered into a single PDF context
     */
    public init(documents: [PDFDocument] = []) {
        assert(!documents.isEmpty, "At least one document is required!")
        self.generators = documents.map(PDFGenerator.init(document:))
        self.progresses = self.generators.map { $0.progress }

        self.bounds = documents.first?.layout.bounds ?? .zero

        progress = Progress.discreteProgress(totalUnitCount: Int64(documents.count))
    }

    /**
     Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.

     Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.

     - parameter filename: Name of output file, `.pdf` will be appended if not given
     - parameter info: Instance of `PDFInfo` with meta file information, defaults to default initialiser of `PDFInfo`

     - returns: Temporary URL to the output file

     - throws: Exception, if something went wrong
     */
    public func generateURL(filename: String, info: PDFInfo = PDFInfo()) throws -> URL {
        let url = FileManager.generateTemporaryOutputURL(for: filename)
        try generate(into: url, info: info)
        return url
    }

    /**
    Creates a file  at the given file URL,  generates the PDF context data and writes the result idata nto the file.

    - parameter target: URL of output file,
    - parameter info: Instance of `PDFInfo` with meta file information, defaults to default initialiser of `PDFInfo`

    - throws: Exception, if something went wrong
    */
    public func generate(into target: URL, info: PDFInfo = PDFInfo()) throws {
        assert(!generators.isEmpty, "At least one document is required!")
        UIGraphicsBeginPDFContextToFile(target.path, bounds, info.generate())
        try processDocuments()
        UIGraphicsEndPDFContext()
    }

    /**
    Generates and returns the PDF context data.

    - parameter info: Instance of `PDFInfo` with meta file information, defaults to default initialiser of `PDFInfo`

    - throws: Exception, if something went wrong

    - returns:PDF data
    */
    public func generateData(info: PDFInfo = PDFInfo()) throws -> Data {
        assert(!generators.isEmpty, "At least one document is required!")
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, bounds, info.generate())
        try processDocuments()
        UIGraphicsEndPDFContext()
        return data as Data
    }

    /**
     Sequentially processes each document and draws into a PDF context.

     Make sure to call `UIGraphicsBeginPDFContextToData()` before,
     and `UIGraphicsEndPDFContext` after calling this method.
     */
    internal func processDocuments() throws {
        for generator in generators {
            generator.debug = debug
            progress.addChild(generator.progress, withPendingUnitCount: 1)
            try generator.generatePDFContext()
        }
    }
}