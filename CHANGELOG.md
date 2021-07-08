# Change Log

## [Unreleased](https://github.com/techprimate/TPPDF/tree/HEAD) (2021-??-??)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.3.5...2.4.0)

**Implemented enhancements:**

- Added paper background colors (#244)

**Fixed bugs:**

**Closed issues:**

- Issue #244

**Merged pull requests:**

## [Unreleased](https://github.com/techprimate/TPPDF/tree/2.3.5) (2021-04-11)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.3.4...2.3.5)

**Fixed bugs:**

- Fixed `PDFList` not calculating available content height correctly (#267)
- Removed `PDFTable` initializer size defaults (#269)

**Closed issues:**

- Issue #267
- Issue #269

**Merged pull requests:**

- PR #268 (by philprime)

## [2.3.4](https://github.com/techprimate/TPPDF/tree/2.3.4) (2021-03-15)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.3.3...2.3.4)

**Fixed bugs:**

- Fixed table header position when activating `showHeaderOnEveryPage` (#222)

**Closed issues:**

- Issue #222

**Merged pull requests:**

- PR #264 (by Sgkhour)

## [2.3.3](https://github.com/techprimate/TPPDF/tree/2.3.3) (2021-01-06)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.3.2...2.3.3)

**Fixed bugs:**

- Fixed empty pages between external documents (#247)
- Fixed total page count calculations (#248)

**Closed issues:**

- Issue #247
- Issue #248

**Merged pull requests:**

- PR #258

## [2.3.2](https://github.com/techprimate/TPPDF/tree/2.3.2) (2020-12-05)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.3.1...2.3.2)

**Implemented enhancements:**

- Added optional table cell splicing disabling (#205)

**Fixed bugs:**

- Fixed carthage version missing (#236)

**Closed issues:**

- Issue #205
- Issue #222
- Issue #236
- Issue #243
- Issue #249
- Issue #233

**Merged pull requests:**

- PR #223
- PR #252 [by lpeancovschi]
- PR #255

## [2.3.1](https://github.com/techprimate/TPPDF/tree/2.3.1) (2020-09-23)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.3.0...2.3.1)

**Fixed bugs:**

- Fixed invalid US page formats (#225)

**Closed issues:**

- Issue #225

**Merged pull requests:**

- PR #226

## [2.3.0](https://github.com/techprimate/TPPDF/tree/2.3.0) (2020-07-16)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.2.0...2.3.0)

**Implemented enhancements:**

- Removed deprecated functions
- Added `CaseIterable` to `PDFPageFormat`

## [2.2.0](https://github.com/techprimate/TPPDF/tree/2.2.0) (2020-06-27)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.1.2...2.2.0)

**Implemented enhancements:**

- macOS Support!

**Closed issues:**

- Issue #193

**Merged pull requests:**

- PR #217

## [2.1.2](https://github.com/techprimate/TPPDF/tree/2.1.2) (2020-06-23)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.1.1...2.1.2)

**Fixed bugs:**

- Height of image captions are now calcuated correctly (Issue #208)

**Closed issues:**

- Issue #208

**Merged pull requests:**

- PR #214 [by chrisgonzgonz]


## [2.1.1](https://github.com/techprimate/TPPDF/tree/2.1.1) (2020-06-16)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.1.0...2.1.1)

**Implemented enhancements:**

- Added raw representable to `PDFTableCellAlignment`
- Added support for groups inside section columns

**Fixed bugs:**

- Fixed indentations inside sections

## [2.1.0](https://github.com/techprimate/TPPDF/tree/2.1.0) (2020-06-15)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.0.1...2.1.0)

**Implemented enhancements:**

- Added raw representable values to `PDFPageFormat`
- Added raw representable type to `PDFLineType`
- Added constant `none` to `PDFTableCellStyle` and `PDFTableCellBorders`
- Added background color to `PDFSectionColumn` (Issue #122)

**Fixed bugs:**

- Added note to documentation about not reusing `PDFSection` instances (Issue #122)
- Added missing font and text color reset to generator

**Closed issues:**

- Issue #73
- Issue #122
- Issue #204
- Issue #197
- Issue #189
- Issue #186
- Issue #184
- Issue #183

**Merged pull requests:**

- Issue #211

## [2.0.1](https://github.com/techprimate/TPPDF/tree/2.0.1) (2020-05-31)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/2.0.0...2.0.1)

**Implemented enhancements:**

- Removed JSON representation
- Added deprecation for `table.generateCells`

**Fixed bugs:**

- Missing page break after space which overlaps page end (#204)

**Closed issues:**

- Issue #204

## [2.0.0](https://github.com/techprimate/TPPDF/tree/2.0.0) (2020-05-19)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.6.0...2.0.0)

**Implemented enhancements:**

- Table Merging
- Swift Package Manager Support
- Hyperlinks in texts

**Fixed bugs:**

- External document including empty pages 

**Closed issues:**

- Issue #41
- Issue #86
- Issue #148
- Issue #178
- Issue #179
- Issue #182
- Issue #183
- Issue #184
- Issue #185
- Issue #186
- Issue #196
- Issue #197

**Merged pull requests:**

- Issue #181

## [1.6.0](https://github.com/techprimate/TPPDF/tree/1.6.0) (2020-03-23)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.5.4...1.6.0)

**Implemented enhancements:**

- Added progress reporting using iOS internal `Foundation.Progress` (Issue #155)
- Added a better test example experience
- Added support to embed external PDF document (Issue #31)
- Added clickable URL support for images (Issue #170)
- Added support for NSAttributedString link attributes (Issue #71)
- Added subscript range access to PDFTable and deprecated `PDFTable.setCellStyle`

**Fixed bugs:**

- Fixed TravisCI configuration

**Closed issues:**

- Issue #155
- Issue #31
- Issue #170
- Issue #71

**Merged pull requests:**

- Issue #171
- Issue #172
- Issue #174
- Issue #177

## [1.5.4](https://github.com/techprimate/TPPDF/tree/1.5.4) (2019-06-06)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.5.3...1.5.4)

**Implemented enhancements:**

- Fixed carthage support once again

## [1.5.3](https://github.com/techprimate/TPPDF/tree/1.5.3) (2019-06-06)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.5.2...1.5.3)

**Implemented enhancements:**

- Fixed padding in groups 

## [1.5.2](https://github.com/techprimate/TPPDF/tree/1.5.2) (2019-06-06)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.5.1...1.5.2)

**Implemented enhancements:**

- Added group breaking

## [1.5.1](https://github.com/techprimate/TPPDF/tree/1.5.1) (2019-06-06)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.5.0...1.5.1)

**Implemented enhancements:**

- Added merge/combining of multiple documents (Issue #67)

**Closed issues:**

- Issue #67

## [1.5.0](https://github.com/techprimate/TPPDF/tree/1.5.0) (2019-06-05)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.4.1...1.5.0)

**Implemented enhancements:**

- Changed framework methods to be "more Swift(y)"
- Added groups
- Added dynamic shapes for group background
- Added column with automatic wrapping (Issue #113)
- Added document wide text styles (Issue #57)
- Added automatic table of content based on text styles (Issue #58)

**Fixed bugs:**

- Fixed line separator in header and footer (Issue #88)
- Fixed image in footer layout calcuations (Issue #132)

**Closed issues:**

- Issue #9
- Issue #57
- Issue #58
- Issue #88
- Issue #113
- Issue #118
- Issue #127
- Issue #132
- Issue #136
- Issue #137
- Issue #138

## [1.4.1](https://github.com/techprimate/TPPDF/tree/1.4.1) (2019-05-19)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.4.0...1.4.1)

**Fixed bugs:**

- Carthage missing shared scheme (#135)

**Closed issues:**

- #135

## [1.4.0](https://github.com/techprimate/TPPDF/tree/1.4.0) (2019-04-17)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.3.3...1.4.0)

**Implemented enhancements:**

- Added rounded corner clipping to images (#123)
- Added Swift 5 support

**Fixed bugs:**

- Line separator skewed (#128)

**Closed issues:**

- Issue #123
- Issue #125
- Issue #128

## [1.3.3](https://github.com/techprimate/TPPDF/tree/1.3.3) (2019-03-13)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.3.2...1.3.3)

**Implemented enhancements:**

- Changed accessibility of `PDFGenerator`

**Closed issues:**

- Issue #101
- Issue #103
- Issue #108
- Issue #109
- Issue #111
- Issue #113
- Issue #114

**Merged pull requests:**

- PR #106 [by protspace]
- PR #119 [by yhelfronda]

## [1.3.2](https://github.com/techprimate/TPPDF/tree/1.3.2) (2019-01-22)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.3.1...1.3.2)

**Implemented enhancements:**

- Changed accessor methods of `PDFPageFormat` to be publicly accessible.
- Added public accessor method to `PDFPageLayout`

**Closed issues:**

- Issue #11
- Issue #111

**Merged pull requests:**

- PR #106 [by protspace]

## [1.3.1](https://github.com/techprimate/TPPDF/tree/1.3.1) (2018-11-13)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.3.0...1.3.1)

**Fixed bugs:**

- Issue #98

## [1.3.0](https://github.com/techprimate/TPPDF/tree/HEAD) (2018-10-03)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.2.1...1.3.0)

**Implemented enhancements:**

- Support for Swift 4.2

**Merged pull requests:**

- PR #94 [by techprimate-phil]

## [1.2.0](https://github.com/techprimate/TPPDF/tree/1.2.0) (2018-07-12)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.1.2...1.2.0)

**Implemented enhancements:**

- Added options to `PDFImage`, allowing more precise control about resizing and compression.
- Improvements to internal image resizing and compression methods.

**Closed issues:**

- Issue #77
- Issue #78

## [1.1.2](https://github.com/techprimate/TPPDF/tree/1.1.2) (2018-07-12)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.1.1...1.1.2)

**Implemented enhancements:**

- `PDFLineStyle` now allows to set a border radius, if drawn as rectangle.

**Fixed bugs:**

- JPEG Compression of `PDFImage` not working when quality set to zero.

**Closed issues:**

- Issue #78

**Merged pull requests:**

- PR #77 [by emericspiroux]

## [1.1.1](https://github.com/techprimate/TPPDF/tree/1.1.1) (2018-06-29)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.1.0...1.1.1)

**Implemented enhancements:**

- Made PDFPageLayout accessor public

**Fixed bugs:**

- Strong retain cycle in PDFList

**Closed issues:**

- Issue #76

## [1.1.0](https://github.com/techprimate/TPPDF/tree/1.1.0) (2018-05-07)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.0.3...1.1.0)

**Implemented enhancements:**

- Multi Column Sections (#9)

**Merged pull requests:**

- PR #63

## [1.0.3](https://github.com/techprimate/TPPDF/tree/1.0.3) (2018-05-07)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.0.2...1.0.3)

**Implemented enhancements:**

- Added `PDFGenerator.generate(document:, to:)`

**Closed issues:**

- Issue #55
- Issue #64

## [1.0.2](https://github.com/techprimate/TPPDF/tree/1.0.2) (2018-04-18)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.0.1...1.0.2)

**Fixed bugs:**

- Carthage scheme not available

**Closed issues:**

- Issue #59

## [1.0.1](https://github.com/techprimate/TPPDF/tree/1.0.1) (2018-04-16)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/1.0.0...1.0.1)

**Merged pull requests:**

- PR #56 [by kf99916]

## [1.0.0](https://github.com/techprimate/TPPDF/tree/1.0.0) (2018-04-08)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.4.0...1.0.0)

**Implemented enhancements:**

- Rebuilt whole library, too much for one changelog

## [0.4.0](https://github.com/techprimate/TPPDF/tree/0.4.0) (2017-06-05)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.3.0...0.4.0)

**Implemented enhancements:**

- Added property `landscapeSize` to `PageFormat` which returns the size as landscape
- Split `PDFGenerator` into multiple files
- Added Carthage support
- Added table styling

**Closed issues:**

- Issue #2
- Issue #4
- Issue #7

## [0.3.0](https://github.com/techprimate/TPPDF/tree/0.3.0) (2017-01-19)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.2.0...0.3.0)

**Implemented enhancements:**

- Added command for new page creation `creteNewPage()`
- Added image caption and how image should fit, as parameter in `addImage(image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit)`
- Image is moved to new page if there is not enough rest space
- Added pagination, define position using `paginationContainer`
- Added `imageQuality` to reduce pdf file size
- Added command `addImagesInRow(images: [UIImage], captions: [NSAttributedString], sizeFit: ImageSizeFit)` for rendering two images next to each other
- Images can be added to header or footer
- Line separator can be drawn in header or footer
- Text font in table can be modified in `addTable(..., textFont: UIFont)`
- Added paragraph support in table, moves to new page if not enough space
- Add metadata information to PDF file
- Improved PDF generation of large files
- Added command `setFont(font: UIFont)` to change the font in a container
- Added command `resetFont(container: Container)` to reset the font of a container to default

**Merged pull requests:**

- PR #3 from kf99916/master


## [0.2.0](https://github.com/techprimate/TPPDF/tree/0.2.0) (2016-11-07)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.1.5...0.2.0)

**Implemented enhancements:**

- Updated to Swift 3.0

## [0.1.5](https://github.com/techprimate/TPPDF/tree/0.1.5) (2016-11-09)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.1.4...0.1.5)

## [0.1.4](https://github.com/techprimate/TPPDF/tree/0.1.4) (2016-08-24)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.1.3...0.1.4)

**Implemented enhancements:**

- Added offset command `SetOffset(points: CGFloat)`

**Fixed bugs:**

- Small link issues in `CHANGELOG.md`

## [0.1.3](https://github.com/techprimate/TPPDF/tree/0.1.3) (2016-08-21)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.1.2...0.1.3)

**Implemented enhancements:**

- Added indentation command `SetIndentation(points: CGFloat)`

## [0.1.2](https://github.com/techprimate/TPPDF/tree/0.1.2) (2016-08-16)
[Full Changelog](https://github.com/techprimate/TPPDF/compare/0.1.1...0.1.2)

**Fixed bugs:**

- Footer space is rendering correctly now
