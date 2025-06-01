//
//  ClassesStudentDIContainer.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 30/05/25.
//

import ClasslyNetworking
import Core

public final class ClassesStudentDIContainer {

    public init() { }

    // MARK: - Network
    private lazy var networkManager = NetworkManager()

    // MARK: - Datasources
    private lazy var schedulesDS = ScheduleDataSourceImpl(networkingManager: networkManager)

    // MARK: - Repositories
    private lazy var schedulesRepo = ScheduleRepositoryImpl(remoteDataSource: schedulesDS)

    // MARK: - Use cases (public)
    lazy var loadStudentClasses: LoadStudentClasses = LoadStudentClassesImpl(repository: schedulesRepo)
    lazy var addAttendance: AddAttendance = AddAttendanceImpl(repository: schedulesRepo)
}
