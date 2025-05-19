//
//  ClassManagementDIContainer.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import ClasslyNetworking

public final class ClassManagementDIContainer {

    public init() { }

    // MARK: - Singletons compartidos en el módulo
    private lazy var networkManager = NetworkManager()

    // MARK: - Datasources
    private lazy var locationsDS = LocationsDataSourceImpl(networkingManager: networkManager)
    private lazy var schedulesDS = SchedulesDataSourceImpl(networkingManager: networkManager)
    private lazy var studentsDS = StudentsDataSourceImpl(networkingManager: networkManager)
    private lazy var attendancesDS = AttendancesDataSourceImpl(networkingManager: networkManager)

    // MARK: - Repositories
    private lazy var locationsRepo = LocationsRepositoryImpl(remoteDataSource: locationsDS)
    private lazy var schedulesRepo = SchedulesRepositoryImpl(remoteDataSource: schedulesDS)
    private lazy var studentsRepo = StudentsRepositoryImpl(remoteDataSource: studentsDS)
    private lazy var attendancesRepo = AttendancesRepositoryImpl(remoteDataSource: attendancesDS)

    // MARK: - Use cases (public)
    lazy var loadLocations: LoadLocations = LoadLocationsImpl(repository: locationsRepo)
    lazy var loadClassSchedulesByLocation: LoadClassSchedulesByLocation  = LoadClassSchedulesByLocationImpl(repository: schedulesRepo)
    lazy var loadEnrolledStudentsBySchedule: LoadEnrolledStudentsBySchedule = LoadEnrolledStudentsByScheduleImpl(repository: schedulesRepo)
    lazy var unenrollStudent: UnenrollStudent = UnenrollStudentImpl(repository: schedulesRepo)
    lazy var loadStudentsQuery: LoadStudentsQuery = LoadStudentsQueryImpl(repository: studentsRepo)
    lazy var enrollStudent: EnrollStudent = EnrollStudentImpl(repository: schedulesRepo)
    lazy var loadAttendancesDates: LoadAttendancesDates = LoadAttendancesDatesImpl(repository: attendancesRepo)
    lazy var loadStudentAttendances: LoadStudentAttendances = LoadStudentAttendancesImpl(repository: attendancesRepo)
}
