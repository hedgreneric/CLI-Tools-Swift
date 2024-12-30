import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CLI_Tools_SwiftTests.allTests),
    ]
}
#endif
