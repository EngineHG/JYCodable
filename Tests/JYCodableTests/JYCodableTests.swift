import XCTest
@testable import JYCodable

final class JYCodableTests: XCTestCase {
    
    enum SampleEnum: String, Codable {
        case a, b
    }
    
    struct SampleModel: Codable {
        @Default<Nil> var aEnum: SampleEnum?
        //@Default<Nil> var str: String?
        @Default<String.Empty> var str: String
    }
    
    func testNilEnum() throws {
        
        let rightJson = #"""
        {
            "aEnum" : "a",
            "str": "123"
        }
        """#
        
        let placeHolderjson = #"""
        {
            "aEnum" : "c",
            "str": 123
        }
        """#
        
        let rightModel = rightJson.jy.toModel(SampleModel.self)
        let placeHolderModel = placeHolderjson.jy.toModel(SampleModel.self)
        
        XCTAssertNotNil(rightModel?.aEnum)
        XCTAssertNil(placeHolderModel?.aEnum)
        
        print("aModel->", rightModel)
        print("cModel->", placeHolderModel)
    }
}
