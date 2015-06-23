//
//  Example of one way to use enums in Swift to define rest endpoint APIs
//

import UIKit

func getBaseURL() -> String
{
    return "http://example.com/v1/"
}

// Make this a protocol extension for iOS 9/ Swift 2.0
protocol EndpointProtocol
{
    var urlString: String { get }
    var URL: NSURL? { get }
}

enum EndPoint: EndpointProtocol
{
    enum EndpointStrings: String
    {
        case LoginString = "login"
        case GetString = "profile/%d/details"
        case GetDetailString = "profile/information/%@"
    }
    
    case Login
    case Get(Int)
    case DetailInformation(String)
    
    private var endpointString: String {
        get {
            switch self {
            case .Login:
                return EndpointStrings.LoginString.rawValue
            case .Get(let parameter):
                return String(format: EndpointStrings.GetString.rawValue, parameter)
            case .DetailInformation(let parameter):
                return String(format: EndpointStrings.GetDetailString.rawValue, parameter)
            }
        }
    }
    
    var urlString: String {
        get {
            return getBaseURL() + self.endpointString
        }
    }
    
    var URL: NSURL? {
        get {
            return NSURL(string: self.urlString)
        }
    }
}

// Usage examples:
println(EndPoint.Login.urlString)
println(EndPoint.Get(5).urlString)
if let aURL = EndPoint.Login.URL
{
    println(aURL)
}
println(EndPoint.DetailInformation("phone-number").urlString)
