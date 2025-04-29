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

struct LoginView<U: LoginUseCase>: View {
    @StateObject private var viewModel: LoginViewModel<U>

    public init(viewModel: LoginViewModel<U>) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: AssetImage.logoClassly)
                .resizable()
                .scaledToFit()
                .frame(height: 120)

            CustomTextField(placeholder: "Email", text: $viewModel.email)

            CustomTextField(placeholder: "Password", type: .secure, text: $viewModel.password)

            CustomButton(title: "Log in") {
                viewModel.login()
            }
            .padding(.bottom, 30)

            Image(systemName: "faceid")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(AppColor.secondaryText)
        }
        .padding()
        .background(AppColor.background)
        .navigationBarHidden(true)
    }
}
