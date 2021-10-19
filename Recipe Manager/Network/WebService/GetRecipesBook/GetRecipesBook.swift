//
//  GetRecipesBook.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper
import CoreLocation

/**
 GetRecipesBookNetwork
 
 Network layer for get recipes book functionality
 */
public final class GetRecipesBookNetwork {
    
    /// Network of type RecipeBook used to call the get recipes book web service
    private let network: Network<RecipeBook>
    
    /**
     Initialization method for the GetRecipesBookNetwork class
     - Parameter network: The type of network web service for the get recipes book functionality
     */
    init(network: Network<RecipeBook>) {
        self.network = network
    }
    
    /**
    Call the get recipes book web service
    - Parameter requestParameters: list of paratemers needed to call the remove recipe web service. Further info, see "GetRecipesBookRequest"
    - Returns: An Observable of type RecipeBook
    */
    func getRecipesBook(with requestParameters: GetRecipesBookRequest) -> Observable<RecipeBook> {
        return network.getRequest(Constants.Urls.getRecipesBook, rootJSONEntity: Constants.JSONEntity.bookRecipesKey, parameters: requestParameters.dictionary)
    }
}

/**
 Mapping for the json response received from the server when calling the get recipe book web service
 */
extension RecipeBook: ImmutableMappable {
    // JSON -> Object
    
    public init(map: Map) throws {
        recipes = try map.value("recipes")
    }
}

extension Recipe: ImmutableMappable {
    // JSON -> Object
    
    public init(map: Map) throws {
        category = try map.value("category")
        description = try map.value("description")
        difficult = try map.value("difficult")
        duration = try map.value("duration")
        ingredients = try map.value("ingredients")
        name = try map.value("name")
        subcategories = try map.value("subcategories")
    }
}

extension Ingredient: ImmutableMappable {
    // JSON -> Object
    
    public init(map: Map) throws {
        calories = try map.value("calories")
        name = try map.value("name")
        type = try map.value("type")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        calories >>> map["calories"]
        name >>> map["name"]
        type >>> map["type"]
    }
}

extension Subcategory: ImmutableMappable {
    // JSON -> Object
    
    public init(map: Map) throws {
        name = try map.value("value")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        name >>> map["value"]
        
    }
}

