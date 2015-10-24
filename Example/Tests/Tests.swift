import UIKit
import XCTest
import RSDTesting
import RSDRESTServices
import RSDSerialization

class Tests: AsynchronousTestCase {
    var iTunes = APISite(name: "Apple", uri: "http://itunes.apple.com/")
    var session: APISession?
    var called: Bool = false
    
    override func setUp() {
        super.setUp()
        called = false
    }
    
    override func tearDown() {
        called = false
        super.tearDown()
    }
    
    
    func testRestCallToiTunes() {
        self.session = APISession(site: self.iTunes, configurationBlock: nil)
        
        let endpointUrl = URLAndParameters(url: "search", parameters: ("term", "Pink+Floyd"))
        let endpoint = APIEndpoint(method: "GET", url: endpointUrl)
        let parser = APIDataResponseParser()
        let request = APIRequest(baseURL: self.session?.baseURL, endpoint: endpoint, bodyEncoder: nil, responseParser: parser, additionalHeaders: nil)
        let call = APICall(session: self.session!, request: request)
        var returnedResponse: NSData?
        var returnedError: NSError?
        
        call.executeRespondWithObject { (data, error) -> () in
            returnedResponse = data
            returnedError = error
            self.called = true
        }
        
        XCTAssertTrue(self.waitForResponse{ self.called })
        
        XCTAssertTrue(returnedResponse != nil)
        XCTAssertTrue(returnedError == nil)
        
        let data = returnedResponse!
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
        NSLog("%@", str)
        
        let jsonOptional: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        
        XCTAssertTrue(jsonOptional != nil)
        let json: JSON = jsonOptional!
        
        // Note that JSON converted types are NS* types from
        // the Foundation library
        let nsJsonDict = json as! NSDictionary
        let nsResultCount = nsJsonDict["resultCount"] as! NSNumber
        XCTAssertTrue(nsResultCount.integerValue == 50)
        
        let nsResults = nsJsonDict["results"]as! NSArray
        XCTAssertTrue(nsResults.count == 50)
        
        let nsTrack = nsResults[0] as! NSDictionary
        XCTAssertTrue(nsTrack.count == 32)
        
        let nsArtistName = nsTrack["artistName"] as! NSString
        XCTAssertTrue(nsArtistName == "Pink Floyd")
        
        // Note that JSON converted types can be converted to
        // Swift Value types anyway.
        var swJsonDict = json as! [String: JSON]
        let swResultCount = swJsonDict["resultCount"]as! Int
        XCTAssertTrue(swResultCount == 50)
        
        var swResults = swJsonDict["results"] as! [JSON]
        XCTAssertTrue(swResults.count == 50)
        
        var swTrack = swResults[0] as! [String: JSON]
        XCTAssertTrue(swTrack.count == 32)
        
        let swArtistName = swTrack["artistName"] as! String
        XCTAssertTrue(swArtistName == "Pink Floyd")
    }

}
