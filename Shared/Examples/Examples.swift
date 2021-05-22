//
//  Examples.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.05.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation

struct ExampleSection {

    let header: String
    let examples: [Example]

}

struct Example {

    let name: String
    let factory: ExampleFactory

}

enum Examples {

    static var factories: [ExampleSection] {
        [
            .init(header: "Popular Examples", examples: [
                .init(name: "Text", factory: TextExampleFactory()),
                .init(name: "List", factory: ListExampleFactory()),
                .init(name: "Images", factory: ImageExampleFactory()),
                .init(name: "Groups", factory: GroupExampleFactory()),
                .init(name: "Table", factory: TableExampleFactory()),
                .init(name: "Lines", factory: LineSeparatorExampleFactory()),
                .init(name: "Document Settings", factory: DocumentSettingsExampleFactory()),
                .init(name: "Table of Contents", factory: TableOfContentsExampleFactory()),
                .init(name: "Header & Footer", factory: HeaderFooterExampleFactory()),
                .init(name: "Multi Section", factory: MultiSectionExampleFactory()),
                .init(name: "Multi Documents", factory: MultipleDocumentsExampleFactory()),
                .init(name: "Metadata", factory: MetadataExampleFactory()),
                .init(name: "Pagination", factory: PaginationExampleFactory()),
                .init(name: "Text Styles", factory: TextStylesExampleFactory()),
                .init(name: "External Documents", factory: ExternalDocumentExampleFactory()),
                .init(name: "Object Attributes", factory: ObjectAttributesExampleFactory())
            ]),
            .init(header: "Developer Examples", examples: [
                .init(name: "Experiment", factory: ExperimentFactory()),
            ])
        ]
    }

    static var defaultFactory: Example {
        return factories[1].examples[0]
    }
}

