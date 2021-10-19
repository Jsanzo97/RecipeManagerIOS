//
//  NetworkVoid.swift
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
final class NetworkVoid {
    
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
    
    // MARK: - POST Request methods
    
    /**
     Run an HTTP request of type POST with the authentication header included
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter parameters: the content of the json body which is sent inside the request
     - Returns: A completable object
     */
    func postRequest(_ path: String, parameters: [String: Any]?) -> Completable {
        let absolutePath = "\(endPoint)\(path)"
        return Completable.create(subscribe: { (observer) -> Disposable in
            _ = RxAlamofire
                .request(.post, absolutePath, parameters: parameters, encoding: JSONEncoding.default)
                .flatMap { request in
                    return request.validate(statusCode: 200..<300)
                        .validate().rx.responseString()
                }
                .observeOn(self.scheduler)
                .subscribe(onError: { (error) in
                    observer(.error(error))
                }, onCompleted: {
                    observer(.completed)
                })
            return Disposables.create()
        })
    }
    
    /**
     Run an HTTP request of type POST with the authentication header included and query params
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter parameters: the content of the json body which is sent inside the request
     - Parameter queryParams: parameters to be included in the URL
     - Returns: A completable object
     */
    func postRequestWithUserQueryParam(_ path: String, parameters: [String: Any]?, queryParam: String) -> Completable {
        let absolutePath = "\(endPoint)\(path)"
        
        var urlComponent = URLComponents(string: absolutePath)!
        let queryItems = [URLQueryItem](arrayLiteral: URLQueryItem(name: "username", value: queryParam))
        urlComponent.queryItems = queryItems

        let headers = [ "Content-Type": "application/json" ]
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!)
        request.allHTTPHeaderFields = headers
        
        return Completable.create(subscribe: { (observer) -> Disposable in
            _ = RxAlamofire
                .request(request)
                .flatMap { request in
                    return request.validate(statusCode: 200..<300)
                        .validate().rx.responseString()
                }
                .observeOn(self.scheduler)
                .subscribe(onError: { (error) in
                    observer(.error(error))
                }, onCompleted: {
                    observer(.completed)
                })
            return Disposables.create()
        })
    }
    
    // MARK: - DELETE Request methods
    
    /**
     Run an HTTP request of type DELETE with the authentication header included
     - Parameter path: it usually includes the specific web service we would like to call
     - Parameter parameters: the content of the json body which is sent inside the request
     - Returns: Acompletable object
     */
    func deleteRequest(_ path: String, parameters: [String: Any]?) -> Completable {
        let absolutePath = "\(endPoint)\(path)"
        return Completable.create(subscribe: { (observer) -> Disposable in
            _ = RxAlamofire
                .request(.delete, absolutePath, parameters: parameters, encoding: URLEncoding.default)
                .flatMap { request in
                    return request.validate(statusCode: 200..<300)
                        .validate().rx.responseString()
                }
                .observeOn(self.scheduler)
                .subscribe(onError: { (error) in
                    observer(.error(error))
                }, onCompleted: {
                    observer(.completed)
                })
            return Disposables.create()
        })
    }
}
