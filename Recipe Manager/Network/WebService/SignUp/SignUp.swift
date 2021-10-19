//
//  SignUp.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 SignUpNetwork
 
 Network layer for sign up functionality
 */
final class SignUpNetwork {
    
    /// Network of type NetworkVoid used to call the sign up web service
    private let network: NetworkVoid
    
    /**
     Initialization method for the SignUpNetwork class
     - Parameter network: The type of network web service for the sign up functionality
     */
    init(network: NetworkVoid) {
        self.network = network
    }
    
    /**
     Call the sign up web service
     - Parameter requestParameters: list of paratemers needed to call the login web service. Further info, see "SignUpRequest"
     - Returns: A completable object
     */
    func signUp(with requestParameters : SignUpRequest) -> Completable {
        return network.postRequest("\(Constants.Urls.signUp)", parameters: requestParameters.toJSON())
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the sign up web service
 */
extension SignUpRequest: ImmutableMappable {
    
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
