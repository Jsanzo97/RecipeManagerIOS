//
//  IngredientRecipeTypes.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 IngredientRecipeTypesNetwork
 
 Network layer for retrieve ingredient types functionality
 */
final class IngredientRecipeTypesNetwork {
    
    /// Network of type IngredientRecipeTypesNetwork used to call the get ingredient types web service
    private let network: Network<IngredientRecipeTypesResponse>
    
    /**
     Initialization method for the IngredientRecipeTypesNetwork class
     - Parameter network: The type of network web service for the get ingredient types functionality
     */
    init(network: Network<IngredientRecipeTypesResponse>) {
        self.network = network
    }
    
    /**
     Call the get ingredient types web service
     - Returns: An Observable with an object of type IngredientRecipeTypesResponse
     */
    func getIngredientRecipeTypes() -> Observable<IngredientRecipeTypesResponse> {
        return network.getRequest("\(Constants.Urls.getIngredientTypes)", rootJSONEntity: "", parameters: nil)
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the get ingredient types web service
 */
extension IngredientRecipeTypesResponse: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        ingredientTypes = try map.value("ingredient_types")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        ingredientTypes >>> map["ingredient_types"]
    }
}

extension IngredientType: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        ingredientType = try map.value("type")
    }
    
}
