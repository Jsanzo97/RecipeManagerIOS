//
//  CategoryRecipeTypes.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 IngredientRecipeTypesNetwork
 
 Network layer for retrieve category types functionality
 */
final class CategoryRecipeTypesNetwork {
    
    /// Network of type CategoryRecipeTypesNetwork used to call the get category types web service
    private let network: Network<CategoryRecipeTypesResponse>
    
    /**
     Initialization method for the CategoryRecipeTypesResponse class
     - Parameter network: The type of network web service for the get category types functionality
     */
    init(network: Network<CategoryRecipeTypesResponse>) {
        self.network = network
    }
    
    /**
     Call the get category types web service
     - Returns: An Observable with an object of type CategoryRecipeTypesResponse
     */
    func getCategoryRecipeTypes() -> Observable<CategoryRecipeTypesResponse> {
        return network.getRequest("\(Constants.Urls.getCategories)", rootJSONEntity: "", parameters: nil)
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the get category types web service
 */
extension CategoryRecipeTypesResponse: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        categoryTypes = try map.value("categories")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        categoryTypes >>> map["categories"]
    }
}

extension Category: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        category = try map.value("category")
    }
    
}
