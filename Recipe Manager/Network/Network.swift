//
//  Network.swift
//  Recipe Manager
//


import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

/**
 Network
 
This class provides the main networking functionality. It includes the main HTTP methods (GET, POST, PUT, DELETE...) adapted to our system.
 */
final class Network<T: ImmutableMappable> {
    
    // MARK: - Properties & Initialization
    
    /// The URL identifier of the server from the one the data is obtained
    private let endPoint: String
    /// The scheduler on which the request will be enqueued
    private let scheduler: ConcurrentDispatchQueueScheduler
    
     /**
     Initialization method for the Network<T: ImmutableMappable> class
     - Parameter endPoint: URL identifier of the server from the one the data is obtained
     */
    init(_ endPoint: String) {
        self.endPoint = Constants.endpoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    // MARK: - GET Request methods
    
    /**
     Run an HTTP request of type GET with the authentication header included
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter jsonKey: if the json response is returned inside the main body of a 'root entity', this parameter should be used
     - Returns: An Observable with an object of type 'T'.
     */
    func getRequest(_ path: String, rootJSONEntity jsonKey: String, parameters: [String: Any]?) -> Observable<T> {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .json(.get, absolutePath, parameters: parameters, encoding: URLEncoding.default)
            .observeOn(scheduler)
            .map({ json -> T in
                let jsonData: [String : Any] = json as! [String : Any]
                return try Mapper<T>().map(JSONObject: jsonData)
            }
        )
    }
    
    // MARK: - POST Request methods
    
    /**
     Run an HTTP request of type POST with the authentication header included
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter parameters: the content of the json body which is sent inside the request
     - Returns: An Observable with an object of type 'T'.
     */
    func postRequest(_ path: String, parameters: [String: Any]?) -> Observable<T> {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .json(.post, absolutePath, parameters: parameters, encoding: JSONEncoding.default)
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
}
