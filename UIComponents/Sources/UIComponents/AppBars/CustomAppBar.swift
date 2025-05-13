//
//  SwiftUIView.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI
import Assets

public struct CustomAppBar: View {

    private let title: String
    private let backAction: (() -> Void)?

    public init(title: String, backAction: (() -> Void)? = nil) {
        self.title = title
        self.backAction = backAction
    }

    public var body: some View {
        HStack {
            if let backAction = backAction {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27, height: 27)
                    .font(.headline)
                    .foregroundStyle(AppColor.primaryText)
                    .padding(.trailing, 20)
                    .onTapGesture(perform: backAction)
            }


            Text(title)
                .font(AppFont.largeTitle)
                .foregroundStyle(AppColor.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        CustomAppBar(title: "Hola Title")

        CustomAppBar(title: "Hola Title") {
            print("back")
        }
    }
}
