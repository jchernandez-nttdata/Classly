//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

@testable import Authentication
@testable import ClasslyNetworking

final class MockNetworkManager: NetworkManagerProtocol {
    var customResponse: Any?
    var customError: Error?
    var receivedRequest: Any?

    func performRequest<T: Request>(_ request: T) async throws -> T.Response {
        receivedRequest = request

        if let error = customError {
            throw error
        }

        guard let typedResponse = customResponse as? T.Response else {
            fatalError("Mock response type does not match expected response type \(T.Response.self)")
        }

        return typedResponse
    }
}

