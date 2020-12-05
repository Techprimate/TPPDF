//
//  PDFAttributedText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Attributed text objects hold an instance of `NSAttributedString`

 Use this class for advanced text drawing
 */
public class PDFAttributedText: PDFText {

    /**
     Text which will be drawn
     */
    public var text: NSAttributedString

    /**
     Initializer

     - parameter text: Text, which will be drawn
     */
    public init(text: NSAttributedString) {
        self.text = text
    }

    /**
     Creats a new `PDFAttributedText` with the same properties
     */
    override internal var copy: PDFText {
        PDFAttributedText(text: text)
    }
    
    public override func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFAttributedText, rhs: PDFAttributedText) -> Bool {
        guard lhs.text == rhs.text else {
            return false
        }
        return true
    }
}
