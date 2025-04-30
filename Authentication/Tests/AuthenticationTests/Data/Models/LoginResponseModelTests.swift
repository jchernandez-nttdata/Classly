//
//  LoginResponseModelTests.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

import Testing
@testable import Authentication
import Foundation

struct LoginResponseModelTests {
    @Test
    func testDecodingLoginResponseFromJSON() throws {
        let jsonData = """
        {
            "id": 1,
            "name": "Test User",
            "email": "test@email.com",
            "dni": "12345678",
            "password": "secret",
            "phone": "987654321",
            "role": "admin"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(LoginResponse.self, from: jsonData)
        
        #expect(response.id == 1)
        #expect(response.name == "Test User")
        #expect(response.email == "test@email.com")
        #expect(response.role == "admin")
    }
}
