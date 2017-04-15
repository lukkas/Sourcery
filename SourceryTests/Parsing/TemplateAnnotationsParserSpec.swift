//
// Created by Krzysztof Zablocki on 16/01/2017.
// Copyright (c) 2017 Pixle. All rights reserved.
//

import Quick
import Nimble
import PathKit
import SourceKittenFramework
@testable import Sourcery

private func build(_ source: String) -> [String: SourceKitRepresentable]? {
    return Structure(file: File(contents: source)).dictionary
}

class TemplateAnnotationsParserSpec: QuickSpec {
    // swiftlint:disable function_body_length
    override func spec() {
        describe("InlineParser") {
            let source =
                    "// sourcery:inline:Type.AutoCoding\n" +
                    "var something: Int\n" +
                    "// sourcery:end\n"

            let result =
                    TemplateAnnotationsParser.parseAnnotations("inline", contents: source)

            it("tracks it") {
                expect(result.annotatedRanges["Type.AutoCoding"]).to(equal(NSRange(location: 35, length: 19)))
            }

            it("removes content between the markup") {
                expect(result.contents).to(equal("\n"))
            }
        }
    }
}
