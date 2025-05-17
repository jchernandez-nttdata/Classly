//
//  AssistancesView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import SwiftUI
import UIComponents
import Assets
import Core

struct AssistancesView: View {
    @StateObject private var viewModel: AssistancesViewModel

    public init(viewModel: AssistancesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    let list = ["2025-05-16", "2025-12-17", "2025-05-18", "2025-05-19", "2025-05-20"]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 20) {
                CustomAppBar(
                    title: "Assistances",
                    backAction: viewModel.goBack
                )

                ClassScheduleCard(
                    classSchedule: viewModel.schedule,
                    studentsEnrolled: 0
                )

                List(list, id: \.self) { date in
                    AssistanceDateTile(
                        date: DateUtils.formatDate(date.toDate() ?? .now),
                        onSelect: {
                            print("show assistances")
                        }
                    )
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, 10)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .refreshable(action: {})

            }
            .padding()

            CircularButton(onTap: {})
        }
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        //        .onAppear(perform: viewModel.loadEnrolledStudents)
    }
}

#Preview {
    AssistancesView(
        viewModel: AssistancesViewModel(
            schedule: ClassSchedule(
                id: 1,
                dayOfWeek: .friday,
                startTime: "9:00",
                endTime: "10:00",
                className: "Marinera Norteña",
                locationName: "San Borja"
            )
        )
    )
}
