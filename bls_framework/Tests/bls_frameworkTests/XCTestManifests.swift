import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(bls_frameworkTests.allTests),
    ]
}
#endif
