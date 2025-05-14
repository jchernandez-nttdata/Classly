//
//  ClassListView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import SwiftUI
import UIComponents

struct ClassListView: View {
    //    @StateObject private var viewModel: StudentsListViewModel

    //    public init(viewModel: StudentsListViewModel) {
    //        _viewModel = StateObject(wrappedValue: viewModel)
    //    }
    @State private var selectedLocation: String?
    let list: [Location] = [
        Location(id: 1, locationName: "San Borja", address: "address"),
        Location(id: 2, locationName: "Mira", address: "address"),
        Location(id: 3, locationName: "San", address: "address"),
        Location(id: 4, locationName: "Borja", address: "address"),
        Location(id: 5, locationName: "SBorja", address: "address"),
        Location(id: 6, locationName: "SBverorja", address: "address"),
        Location(id: 7, locationName: "SBoervrja", address: "address"),
        Location(id: 8, locationName: "SBo223rja", address: "address"),
        Location(id: 9, locationName: "SBo232rja", address: "address"),
        Location(id: 10, locationName: "SBorf2fja", address: "address")
    ]

    let list2: [ClassSchedule] = [
        ClassSchedule(id: 1, dayOfWeek: .monday, startTime: "10:00", endTime: "11:00", className: "Marinera norteña")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            CustomAppBar(title: "Classes")

            CustomSelectableField(
                selectedItem: $selectedLocation,
                items: list.map( \.self.locationName )
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
        //        .loadingIndicator(viewModel.isLoading)
        .onAppear {
            //            viewModel.loadStudents()
        }
    }
}

#Preview {
    ClassListView()
}

