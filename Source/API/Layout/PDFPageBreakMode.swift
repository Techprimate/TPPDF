//
//  PageBreakMode.swift
//  TPPDF
//
//  Created by James Wild on 15/06/2021.
//

import Foundation

/// Specifies how page breaks are to be handled:
/// - never: Avoid page breaks by moving to the next page. If taller than a page, the PDF will fail to generate as a page break is inevitable.
/// - avoid: Avoid page breaks by moving to the next page. If taller than a page, split at page breaks.
/// - allow: Split wherever a page break happens to land.
public enum PDFPageBreakMode {
    case never
    case avoid
    case allow
}
