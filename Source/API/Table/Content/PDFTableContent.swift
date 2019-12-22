//
//  PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: Documentation
 */
public class PDFTableContent: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    internal var type: ContentType = ContentType.none

    /**
     TODO: Documentation
     */
    internal var content: Any?

    /**
     TODO: Documentation
     */
    public init(content: Any?) throws {
        try self.setContent(content: content)
    }

    /**
     TODO: Documentation
     */
    internal init(type: ContentType, content: Any?) {
        self.type = type
        self.content = content
    }

    /**
     TODO: Documentation
     */
    internal func setContent(content: Any?) throws {
        if content == nil {
            self.type = .none
            self.content = nil
        } else if content is String {
            self.type = .string
            self.content = content
        } else if content is UIImage {
            self.type = .image
            self.content = content
        } else if content is NSAttributedString {
            self.type = .attributedString
            self.content = content
        } else if content is Int || content is Double || content is Float {
            self.type = .string
            self.content = String(describing: content!)
        } else {
            throw PDFError.tableContentInvalid(value: content)
        }
    }

    /**
     TODO: Documentation
     */
    internal var isString: Bool {
        return type == .string
    }

    /**
     TODO: Documentation
     */
    internal var isAttributedString: Bool {
        return type == .attributedString
    }

    /**
     TODO: Documentation
     */
    internal var isImage: Bool {
        return type == .image
    }

    /**
     TODO: Documentation
     */
    internal var stringValue: String? {
        return type == .string ? content as? String : nil
    }

    /**
     TODO: Documentation
     */
    internal var attributedStringValue: NSAttributedString? {
        return type == .attributedString ? content as? NSAttributedString : nil
    }

    /**
     TODO: Documentation
     */
    internal var imageValue: UIImage? {
        return type == .image ? content as? UIImage : nil
    }
}