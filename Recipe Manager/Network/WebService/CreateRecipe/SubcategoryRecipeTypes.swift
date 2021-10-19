//
//  SubcategoryRecipeTypes.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 IngredientRecipeTypesNetwork
 
 Network layer for retrieve subcategory types functionality
 */
final class SubcategoryRecipeTypesNetwork {
    
    /// Network of type SubcategoryRecipeTypesResponse used to call the get difficult types web service
    private let network: Network<SubcategoryRecipeTypesResponse>
    
    /**
     Initialization method for the SubcategoryRecipeTypesNetwork class
     - Parameter network: The type of network web service for the get subcategory types functionality
     */
    init(network: Network<SubcategoryRecipeTypesResponse>) {
        self.network = network
    }
    
    /**
     Call the get subcategory types web service
     - Returns: An Observable with an object of type SubcategoryRecipeTypesResponse
     */
    func getSubcategoryRecipeTypes() -> Observable<SubcategoryRecipeTypesResponse> {
        return network.getRequest("\(Constants.Urls.getSubcategories)", rootJSONEntity: "", parameters: nil)
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the get subcategory types web service
 */
extension SubcategoryRecipeTypesResponse: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        subcategoryTypes = try map.value("subcategories")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        subcategoryTypes >>> map["subcategories"]
    }
}
