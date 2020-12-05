//
//  PDFGeneratorImageDelegate.swift
//  TPPDF
//
//  Created by Chris Gonzales on 10/10/20.
//

import Foundation

public protocol PDFGeneratorImageDelegate: class {
    func generator(willBeginDrawingImage image: PDFImage, with context: CGContext, in frame: CGRect)
}

typealias PDFGeneratorDelegate = PDFGeneratorImageDelegate // for extensibility
