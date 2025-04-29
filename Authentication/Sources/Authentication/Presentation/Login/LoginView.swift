//
//  LoginView.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI
import Assets

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
        }
        .padding()
        .background(AppColor.background)
    }
}

#Preview {
    LoginView(viewModel: .preview)
}

extension View {
    func padding(
        top: CGFloat = 0,
        bottom: CGFloat = 0,
        left: CGFloat = 0,
        right: CGFloat = 0
    ) -> some View {
        self.padding(.top, top)
            .padding(.bottom, bottom)
            .padding(.leading, left)
            .padding(.trailing, right)
    }
}
