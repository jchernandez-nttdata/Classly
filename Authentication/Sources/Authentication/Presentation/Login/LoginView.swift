//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI

public struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: 20) {
            Text("Classly")
                .font(.largeTitle)

            TextField("Correo", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)

            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            Button("Entrar") {
                viewModel.login()
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(viewModel: .init())
}
