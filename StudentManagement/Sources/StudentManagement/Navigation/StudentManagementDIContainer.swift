//
//  StudentManagementDIContainer.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import ClasslyNetworking

public final class StudentManagementDIContainer {

    public init() { }

    private lazy var networkManager = NetworkManager()

    // MARK: - Datasources
    private lazy var studentDS  = StudentsDataSourceImpl(networkingManager: networkManager)

    // MARK: - Repositories
    private lazy var studentsRepo  = StudentsRepositoryImpl(remoteDataSource: studentDS)

    // MARK: - Use cases (public)
    lazy var loadStudentsUseCase: LoadStudents = LoadStudentsImpl(repository: studentsRepo)
    lazy var addStudentUseCase: AddStudent = AddStudentImpl(repository: studentsRepo)
    lazy var editStudentUseCase: EditStudent = EditStudentImpl(repository: studentsRepo)
}
