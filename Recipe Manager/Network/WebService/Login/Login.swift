//
//  Login.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 LoginNetwork
 
 Network layer for login functionality
 */
final class LoginNetwork {
    
    /// Network of type networkVoid used to call the login web service
    private let network: NetworkVoid
    
    /**
     Initialization method for the LoginNetwork class
     - Parameter network: The type of network web service for the login functionality
     */
    init(network: NetworkVoid) {
        self.network = network
    }
    
    /**
     Call the login web service
     - Parameter requestParameters: list of paratemers needed to call the login web service. Further info, see "LoginRequest"
     - Returns: A completable object
     */
    func login(with requestParameters : LoginRequest) -> Completable {
        return network.postRequest("\(Constants.Urls.login)", parameters: requestParameters.toJSON())
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the login web service
 */
extension LoginRequest: ImmutableMappable {
    
    // JSON -> Model
    init(map: Map) throws {
        username = try map.value("username")
        password = try map.value("password")
    }
    
    // Model -> JSON
    func mapping(map: Map) {
        username >>> map["username"]
        password >>> map["password"]
    }
}

/**
 Mapping for the json response received from the server when calling the login web service
 
extension LoginResponse: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        message = try map.value("message")
    }
    
    // Model -> JSON
    func mapping(map: Map) {
        message >>> map["message"]
    }
}*/
