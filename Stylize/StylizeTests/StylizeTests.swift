//
//  StylizeTests.swift
//  StylizeTests
//
//  Created by Alex Fish on 10/01/2015.
//  Copyright (c) 2015 alexefish. All rights reserved.
//

import UIKit
import XCTest
import Stylize

class StylizeTests: XCTestCase {

    var string: NSAttributedString?
    let range = NSMakeRange(0, 1)

    override func setUp() {
        super.setUp()
        string = NSAttributedString(string: "Test String")
    }

    func testUnderlineAttributeIsAdded() {
        let style = Stylize.underline(NSUnderlineStyle.StyleSingle)
        checkAttribute(NSUnderlineStyleAttributeName, style: style)
    }

    func testUnderlineAttibuteIsAddedToARange() {
        let style = Stylize.underline(NSUnderlineStyle.StyleSingle, range: range)
        checkAttributeInRange(NSUnderlineStyleAttributeName, style: style)
    }

    func testForegroundColorIsAdded() {
        let style = Stylize.foreground(UIColor.redColor())
        checkAttribute(NSForegroundColorAttributeName, style: style)
    }

    func testForegroundColorIsAddedToARange() {
        let style = Stylize.foreground(UIColor.redColor(), range: range)
        checkAttributeInRange(NSForegroundColorAttributeName, style: style)
    }

    func testBackgroundColorIsAdded() {
        let style = Stylize.background(UIColor.redColor())
        checkAttribute(NSBackgroundColorAttributeName, style: style)
    }

    func testBackgroundColorIsAddedToARange() {
        let style = Stylize.background(UIColor.redColor(), range: range)
        checkAttributeInRange(NSBackgroundColorAttributeName, style: style)
    }

    func testUnderlineColorIsAdded() {
        let style = Stylize.underline(UIColor.redColor())
        checkAttribute(NSUnderlineColorAttributeName, style: style)
    }

    func testUnderlineColorIsAddedToARange() {
        let style = Stylize.underline(UIColor.redColor(), range: range)
        checkAttributeInRange(NSUnderlineColorAttributeName, style: style)
    }

    func testLinkIsAdded() {
        let style = Stylize.link(NSURL(string: "")!)
        checkAttribute(NSLinkAttributeName, style: style)
    }

    func testLinkIsAddedToARange() {
        let style = Stylize.link(NSURL(string: "")!, range: range)
        checkAttributeInRange(NSLinkAttributeName, style: style)
    }

    func testParagraphIsAdded() {
        let style = Stylize.paragraph(NSParagraphStyle())
        checkAttribute(NSParagraphStyleAttributeName, style: style)
    }

    func testParagraphIsAddedToARange() {
        let style = Stylize.paragraph(NSParagraphStyle(), range: range)
        checkAttributeInRange(NSParagraphStyleAttributeName, style: style)
    }

    func testKernIsAdded() {
        let style = Stylize.kern(1)
        checkAttribute(NSKernAttributeName, style: style)
    }

    func testKernIsAddedToARange() {
        let style = Stylize.kern(1, range: range)
        checkAttributeInRange(NSKernAttributeName, style: style)
    }

    func testBaselineIsAdded() {
        let style = Stylize.baseline(1)
        checkAttribute(NSBaselineOffsetAttributeName, style: style)
    }

    func testBaselineIsAddedToARange() {
        let style = Stylize.baseline(1, range: range)
        checkAttributeInRange(NSBaselineOffsetAttributeName, style: style)
    }

    func testStrikethroughIsAdded() {
        let style = Stylize.strikethrough(NSUnderlineStyle.PatternDash)
        checkAttribute(NSStrikethroughStyleAttributeName, style: style)
    }

    func testStrikethroughIsAddedToARange() {
        let style = Stylize.strikethrough(NSUnderlineStyle.PatternDash, range: range)
        checkAttributeInRange(NSStrikethroughStyleAttributeName, style: style)
    }

    func testStrikethroughColorIsAdded() {
        let style = Stylize.strikethrough(UIColor.redColor())
        checkAttribute(NSStrikethroughColorAttributeName, style: style)
    }

    func testStrikethroughColorIsAddedtoARange() {
        let style = Stylize.strikethrough(UIColor.redColor(), range: range)
        checkAttributeInRange(NSStrikethroughColorAttributeName, style: style)
    }

    func testShadowIsAdded() {
        let style = Stylize.shadow(NSShadow())
        checkAttribute(NSShadowAttributeName, style: style)
    }

    func testShadowIsAddedToRange() {
        let style = Stylize.shadow(NSShadow(), range: range)
        checkAttributeInRange(NSShadowAttributeName, style: style)
    }

    func testStrokeWidthIsAdded() {
        let style = Stylize.stroke(1)
        checkAttribute(NSStrokeWidthAttributeName, style: style)
    }

    func testStrokeWidthIsAddedToRange() {
        let style = Stylize.stroke(1, range: range)
        checkAttributeInRange(NSStrokeWidthAttributeName, style: style)
    }

    func testStrokeColorIsAdded() {
        let style = Stylize.stroke(UIColor.redColor())
        checkAttribute(NSStrokeColorAttributeName, style: style)
    }

    func testStrokeColorIsAddedToRange() {
        let style = Stylize.stroke(UIColor.redColor(), range: range)
        checkAttributeInRange(NSStrokeColorAttributeName, style: style)
    }

    func testLetterpressIsAdded() {
        let style = Stylize.letterpress()
        checkAttribute(NSTextEffectAttributeName, style: style)
    }

    func testLetterpressIsAddedToRange() {
        let style = Stylize.letterpress(range: range)
        checkAttributeInRange(NSTextEffectAttributeName, style: style)
    }

    func testStylesAreComposed() {
        let baseline = Stylize.baseline(1)
        let kern = Stylize.kern(1)
        let style = Stylize.compose(baseline, kern)

        checkAttribute(NSBaselineOffsetAttributeName, style: style)
        checkAttribute(NSKernAttributeName, style: style)
    }

    func testStylesAreComposedInRange() {
        let baseline = Stylize.baseline(1, range: range)
        let kern = Stylize.kern(1, range: range)
        let style = Stylize.compose(baseline, kern)

        checkAttributeInRange(NSBaselineOffsetAttributeName, style: style)
        checkAttributeInRange(NSKernAttributeName, style: style)
    }
}

extension StylizeTests {

    func checkAttribute(name: AttributeName, style: StringStyle) {
        let testString  = style(string!)

        var found = attributeFound(name, string: testString)

        XCTAssertTrue(found, "\(name) attribute was not added")
    }

    func checkAttributeInRange(name: AttributeName, style: StringStyle) {
        let testString  = style(string!)

        var found    = attributeFound(name, string: testString, range: range)
        var notFound = attributeFound(name, string: testString, range: NSMakeRange(1, 5))

        XCTAssertTrue(found, "\(name) attribute was not added at the correct range")
        XCTAssertFalse(notFound, "\(name) attribute was added at the wrong range")
    }

    func attributeFound(name: AttributeName, string: NSAttributedString) -> Bool {
        var found = false

        string.enumerateAttribute(name, inRange: NSMakeRange(0, string.length), options: NSAttributedStringEnumerationOptions.Reverse, usingBlock: { attributes, _, _ in
            found = attributes != nil
        })

        return found
    }

    func attributeFound(name: AttributeName, string: NSAttributedString, range: NSRange) -> Bool {
        var found = false

        string.enumerateAttribute(name, inRange: range, options: NSAttributedStringEnumerationOptions.Reverse, usingBlock: { attributes, _, _ in
            found = attributes != nil
        })

        return found
    }
}