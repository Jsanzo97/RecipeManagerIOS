//
//  DifficultRecipeTypes.swift
//  Recipe Manager
//


import Foundation
import RxSwift
import ObjectMapper

/**
 DifficultRecipeTypesNetwork
 
 Network layer for retrieve difficult types functionality
 */
final class DifficultRecipeTypesNetwork {
    
    /// Network of type DifficultRecipeTypesNetwork used to call the get difficult types web service
    private let network: Network<DifficultRecipeTypesResponse>
    
    /**
     Initialization method for the DifficultRecipeTypesNetwork class
     - Parameter network: The type of network web service for the get difficult types functionality
     */
    init(network: Network<DifficultRecipeTypesResponse>) {
        self.network = network
    }
    
    /**
     Call the get difficult types web service
     - Returns: An Observable with an object of type DifficultRecipeTypesResponse
     */
    func getDifficultRecipeTypes() -> Observable<DifficultRecipeTypesResponse> {
        return network.getRequest("\(Constants.Urls.getDifficultTypes)", rootJSONEntity: "", parameters: nil)
    }
}

/**
 Mapping for the json request sent from the app to the server when calling the get difficult types web service
 */
extension DifficultRecipeTypesResponse: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        difficultTypes = try map.value("difficulties")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        difficultTypes >>> map["difficulties"]
    }
}

extension Difficult: ImmutableMappable {
    
    // JSON -> Model
    public init(map: Map) throws {
        difficult = try map.value("difficult")
    }
    
}
