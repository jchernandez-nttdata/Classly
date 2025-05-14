//
//  ClassListView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import SwiftUI
import UIComponents

struct ClassListView: View {
    @StateObject private var viewModel: ClassListViewModel
    @State private var didLoadLocations = false

    public init(viewModel: ClassListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    let list2: [ClassSchedule] = [
        ClassSchedule(id: 1, dayOfWeek: .monday, startTime: "10:00", endTime: "11:00", className: "Marinera norteña")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            CustomAppBar(title: "Classes")

            CustomSelectableField(
                selectedItem: $viewModel.selectedLocationString,
                items: viewModel.locations.map( \.self.name )
            )
            .padding(.bottom, 10)

            List(list2) { classSchedule in
                ClassTile(classSchedule: classSchedule) {
                    print("hola")
                }
                .listRowInsets(EdgeInsets())
                .padding(top: 10, bottom: 10)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)

        }
        .padding()
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .onAppear {
            if !didLoadLocations {
                viewModel.loadLocations()
                didLoadLocations = true
            }

        }
    }
}

#Preview {
    ClassListView(viewModel: ClassListViewModel())
}

