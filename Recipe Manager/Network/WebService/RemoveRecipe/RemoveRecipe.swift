//
//  RemoveRecipe.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 SignUpNetwork
 
 Network layer for remove recipe functionality
 */
final class RemoveRecipeNetwork {
    
    /// Network of type RemoveRecipeNetwork used to call the remove recipe web service
    private let network: NetworkVoid
    
    /**
     Initialization method for the RemoveRecipeNetwork class
     - Parameter network: The type of network web service for the remove recipe functionality
     */
    init(network: NetworkVoid) {
        self.network = network
    }
    
    /**
     Call the remove recipe web service
     - Parameter requestParameters: list of paratemers needed to call the remove recipe web service. Further info, see "RemoveRecipeRequest"
     - Returns: A completable object
     */
    func removeRecipe(with requestParameters : RemoveRecipeRequest) -> Completable {
        return network.deleteRequest("\(Constants.Urls.removeRecipe)", parameters: requestParameters.toJSON())
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the remove recipe web service
 */
extension RemoveRecipeRequest: ImmutableMappable {
    
    // JSON -> Model
    init(map: Map) throws {
        name = try map.value("name")
        username = try map.value("username")
    }
    
    // Model -> JSON
    func mapping(map: Map) {
        name >>> map["name"]
        username >>> map["username"]
    }
}
