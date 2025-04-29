//
//  LoginView.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI
import Assets
import Core
import UIComponents

public struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: AssetImage.logoClassly)
                .resizable()
                .scaledToFit()
                .frame(height: 120)

            TextField("Email", text: $viewModel.email)
                .padding(top: 13, bottom: 13, left: 15, right: 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppColor.border, lineWidth: 1)
                )

            SecureField("Password", text: $viewModel.password)
                .padding(top: 13, bottom: 13, left: 15, right: 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppColor.border, lineWidth: 1)
                )

            CustomButton(title: "Log in") {
                viewModel.login()
            }
            .padding(.bottom, 30)

            Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(AppColor.primaryText)
        }
        .padding()
        .background(AppColor.background)
    }
}

#Preview {
    LoginView(viewModel: .init())
}
