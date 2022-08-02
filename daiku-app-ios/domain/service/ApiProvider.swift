//
//  ApiProvider.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/21.
//

import Combine
import FirebaseAuth

struct ApiProvider {
    
    var data: Data? = Data()
    
    static func provider<T, F: Decodable>(service: T) async throws -> AnyPublisher<F, ApiError> where T: ApiService {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let (token) = try? await firebaseIdToken().value
        
        if token == nil {
            throw ApiError.responseError("E0002")
        }
        
        let sessionConfig = URLSessionConfiguration.default
        if service.isAuth {
            sessionConfig.httpAdditionalHeaders = [
                "Authorization": "Bearer \(token!)"
            ]
        }
        let session = URLSession(configuration: sessionConfig)
        return session
            .dataTaskPublisher(for: try self.urlRequest(service: service, token: token))
            .receive(on: DispatchQueue.main)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let erroObj = try decoder.decode(ApiErrorResponse.self, from: element.data)
                    print(erroObj)
                    let errorCd = erroObj.errorCd
                    throw ApiError.responseError(errorCd)
                }
                return element.data
            }
            .decode(type: F.self, decoder: decoder)
            .mapError{ error in
                if let error = error as? ApiError {
                    return error
                }
                
                if error is URLError {
                    return ApiError.invalidURL
                }
                
                if error is DecodingError {
                    return ApiError.parseError
                }
                
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
            
        
    }
    
}

extension ApiProvider {
    static func urlRequest<T: ApiService>(service: T, token: String?) throws -> URLRequest {
        
        let url: String = service.baseURL
        let path: String = service.path
        
        var request = URLRequest(url: URL(string: url + path)!)
        
        switch service.httpMethod {
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
        }
        
        switch service.requestType {
        case .requestParametes(parameters: let parameters):
            return request.encoded(parameters: parameters)
        case .requestBodyToJson(body: let body):
            return try request.encoded(body: body)
        case .request:
            return request
            
        }
    }
    
    static func firebaseIdToken() async -> Task<String?, Error> {
        Task.detached { () -> String? in
            let res: AuthTokenResult? = try await Auth.auth().currentUser?.getIDTokenResult(forcingRefresh: true)
            return res?.token
        }
        
        
    }
}
