//
//  ScheduleDetailView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import SwiftUI

struct ScheduleDetailView: View {
    @StateObject private var viewModel: ScheduleDetailViewModel

    public init(viewModel: ScheduleDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text(viewModel.schedule.className)
    }
}

#Preview {
    ScheduleDetailView(
        viewModel: ScheduleDetailViewModel(
            schedule: ClassSchedule(
                id: 1,
                dayOfWeek: .friday,
                startTime: "9:00",
                endTime: "10:00",
                className: "Marinera Norteña"
            )
        )
    )
}
