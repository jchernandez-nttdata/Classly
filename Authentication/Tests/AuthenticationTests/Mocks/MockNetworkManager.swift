//
//  MockNetworkManager.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

@testable import Authentication
@testable import ClasslyNetworking

actor MockNetworkManager: NetworkManagerProtocol {
    private var _customResponse: Any?
    private var _customError: Error?
    private var _receivedRequest: Any?

    func setCustomResponse(_ response: Any?) {
        _customResponse = response
    }

    func setCustomError(_ error: Error?) {
        _customError = error
    }

    func getReceivedRequest<T>(as type: T.Type) -> T? {
        return _receivedRequest as? T
    }

    func performRequest<T: Request>(_ request: T) async throws -> T.Response {
        _receivedRequest = request

        if let error = _customError {
            throw error
        }

        guard let typedResponse = _customResponse as? T.Response else {
            fatalError("Mock response type does not match expected response type \(T.Response.self)")
        }

        return typedResponse
    }
}
