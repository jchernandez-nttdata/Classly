//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    associatedtype Failure: Error

    func execute(request: Request) async -> Result<Response, Failure>
}
