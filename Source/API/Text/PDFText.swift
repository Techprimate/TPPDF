//
//  PDFText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/**
 Protocol all text objects should implement
 */
public class PDFText: PDFDocumentObject, CustomStringConvertible, Hashable {

    /**
     TODO: Documentation
     */
    internal var copy: PDFText {
        fatalError()
    }

    /**
     TODO: Documentation
     */
    public static func != (lhs: PDFText, rhs: PDFText) -> Bool {
        !(lhs == rhs)
    }

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFText, rhs: PDFText) -> Bool {
        if let attributedLhs = lhs as? PDFAttributedText, let attributedRhs = rhs as? PDFAttributedText {
            return attributedLhs == attributedRhs
        } else if let simpleLhs = lhs as? PDFSimpleText, let simpleRhs = rhs as? PDFSimpleText {
            return simpleLhs == simpleRhs
        }
        return false
    }

    public func hash(into hasher: inout Hasher) {
        fatalError()
    }
}

