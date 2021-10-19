//
//  CreateRecipe.swift
//  Recipe Manager
//

import Foundation
import RxSwift
import ObjectMapper

/**
 CreateRecipeNetwork
 
 Network layer for create recipe functionality
 */
final class CreateRecipeNetwork {
    
    /// Network of type NetworkVoid used to call the create recipe web service
    private let network: NetworkVoid
    
    /**
     Initialization method for the CreateRecipeNetwork class
     - Parameter network: The type of network web service for the create recipe functionality
     */
    init(network: NetworkVoid) {
        self.network = network
    }
    
    /**
     Call the create recipe web service
     - Parameter requestParameters: list of paratemers needed to call the create recipe web service. Further info, see "CreateRecipeRequest"
     - Returns: A completable object
     */
    func createRecipe(with requestParameters : CreateRecipeRequest, queryParam: String) -> Completable {
        return network.postRequestWithUserQueryParam("\(Constants.Urls.createRecipe)", parameters: requestParameters.toJSON(), queryParam: queryParam)
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the create recipe web service
 */
extension CreateRecipeRequest: ImmutableMappable {
    
    // JSON -> Model
    init(map: Map) throws {
        name = try map.value("name")
        description = try map.value("description")
        durationInHours = try map.value("durationInHours")
        difficult = try map.value("difficult")
        ingredients = try map.value("ingredients")
        category = try map.value("category")
        subcategories = try map.value("subcategories")
    }
    
    // Model -> JSON
    func mapping(map: Map) {
        name >>> map["name"]
        description >>> map["description"]
        durationInHours >>> map["durationInHours"]
        difficult >>> map["difficult"]
        ingredients >>> map["ingredients"]
        category >>> map["category"]
        subcategories >>> map["subcategories"]
    }
}
