//
//  PDFSimpleText.swift
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
 Text and spacing of a text object.

 Use this class for simple and quick text drawing
 */
public class PDFSimpleText: PDFText {

    /**
     Text to be drawn
     */
    public var text: String

    /**
     Line spacing if multiple lines
     */
    public var spacing: CGFloat

    /**
     Weak reference to style used by this text object
     */
    public weak var style: PDFTextStyle?

    /**
     Initalizer

     - parameter text: Text to be drawn
     - parameter spacing: Spacing between text lines, defaults to 0
     - parameter style: Reference to style, defaults to nil
     */
    public init(text: String, spacing: CGFloat = 0, style: PDFTextStyle? = nil) {
        self.text = text
        self.spacing = spacing
        self.style = style
    }

    /**
     Creates a new `PDFSimpleText` with the same properties
     */
    override internal var copy: PDFText {
        PDFSimpleText(text: self.text, spacing: self.spacing, style: self.style)
    }
    
    override public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(spacing)
    }
    
    public static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        guard lhs.text == rhs.text else {
            return false
        }
        guard lhs.spacing == rhs.spacing else {
            return false
        }
        return true
    }
}
