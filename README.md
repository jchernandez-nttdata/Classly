# Classly – App de gestión para academias de danza

## 📖 Tabla de contenidos

1. [Descripción general](#descripción-general)
2. [Características principales](#características-principales)
3. [Arquitectura del proyecto](#arquitectura-del-proyecto)
4. [Consideraciones y funcionalidades](#consideraciones-y-funcionalidades)
   - [Nuevos módulos](#nuevos-módulos)
   - [Testing](#testing)
---

## Descripción general

> Classly es una aplicación móvil para academias de danza, diseñada para ayudar a administrar clases, estudiantes, horarios, asistencias y pagos. Existen dos tipos de usuarios: **administradores** y **estudiantes**, cada uno con flujos personalizados.

---

## Características principales

### Administrador:
- Gestión de estudiantes (registrar, editar, eliminar).
- Gestión de clases, horarios y sedes.
- Registro y control de pagos por clase o paquetes.

### Estudiante:
- Ver clases disponibles según sede y nivel.
- Registrar asistencia escaneando un QR en el salón.
- Consultar historial de asistencias.

---

##  Arquitectura del proyecto

El proyecto sigue una arquitectura modularizada, donde cada funcionalidad principal (como autenticación, navegación, gestión de clases, etc.) se organiza en módulos independientes usando Swift Packages.

Esto permite mantener el código más limpio, reutilizable y fácil de mantener, ya que cada módulo tiene una responsabilidad única y puede evolucionar sin afectar a los demás.

### Niveles de módulos en el proyecto
1. Módulos base
Estos módulos contienen elementos reutilizables y compartidos entre todo el proyecto:

- UIComponents: componentes visuales personalizados y reutilizables.
- Assets: colores, tipografías e imágenes del branding.
- Core: utilidades generales, extensiones y helpers comunes.

2. Módulos de infraestructura
Proveen funcionalidades transversales que no dependen de los features:
- Analytics: capa para el rastreo de eventos y métricas de uso.
- RemoteConfig: permite cambiar comportamientos de la app de forma remota.
- DataPersistence: almacenamiento local como UserDefaults y Keychain.
- ClasslyNetworking: módulo encargado de la comunicación con servicios remotos, que se importa desde un repositorio remoto externo por motivos didácticos.
Se encuentra en el siguiente repo: https://github.com/jchernandez-nttdata/ClasslyNetworking

3. Módulos de feature
Cada módulo encapsula una funcionalidad específica de la app (como login, gestión de estudiantes, asistencias, etc.).
Siguen el patrón MVVM y están completamente desacoplados unos de otros. Entre estos se encuentran: 
- Authentication
- StudentManagement
- ClassManagement
- PaymentsManagement
- ClassesStudent
- HistoryStudent

4. Módulo de navegación
  Navigation es el orquestador principal.

  Se encarga de iniciar los coordinadores de cada feature.
  Decide a qué flujo ir (ej. admin o estudiante) después del login.
  Ensambla toda la aplicación.

5. Proyecto principal
  ClasslyApp: este es el entry point de la app (la @main App).

### Diagrama: 
![Diagramas-Diagrama APP drawio (1)](https://github.com/user-attachments/assets/2ccbbd0b-38ca-422f-ab50-b20483dbfce1)

---

## Consideraciones y funcionalidades

### Nuevos módulos
Para integrar nuevos módulos, como se había mencionado anteriormente, se están utilizando Swift Packages. Para agregar uno al proyecto se realizan los siguientes pasos:

1. En el proyecto, seleccionamos File -> New -> Package:
   <img width="631" alt="image" src="https://github.com/user-attachments/assets/da525acf-af28-48e8-a729-e224e67eef88" />

2. Seleccionamos Library, seleccionamos testing si es necesario, y finalmente definimos un nombre con el target del proyecto
   <img width="810" alt="image" src="https://github.com/user-attachments/assets/d180bf3b-467a-471c-86ad-88f60772cecf" />

3. Configuramos el package desde el archivo Package.swift. Lo indispensable es definir las plataformas que soporta. Para este caso esto se va a utilizar a partir de iOS 16

```swift
import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MyLibrary",
            targets: ["MyLibrary"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MyLibrary"),

    ]
)
```
4. En el target del proyecto se integra el package
<img width="1440" alt="image" src="https://github.com/user-attachments/assets/7d549f4e-1453-4efb-a1b5-1e875ebfd5e6" />
<img width="397" alt="image" src="https://github.com/user-attachments/assets/e89c15aa-4463-4658-ae52-831f5ad2b0a6" />

5. Se pueden añadir dependencias locales de la siguiente manera:
```swift
import PackageDescription

let package = Package(
    name: "MyLibrary",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MyLibrary",
            targets: ["MyLibrary"]),
    ],
    dependencies: [
        .package(path: "../Assets"),
        .package(path: "../Core"),
        .package(path: "../UIComponents")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MyLibrary",
            dependencies: [
                "Assets",
                "Core",
                "UIComponents"
            ]
        ),

    ]
)

```

6. De igual manera se pueden integrar dependencias remotas, como el ejemplo de RemoteConfig que integra Firebase, posterior a integrarlo con SwiftPackageManager en el proyecto

<img width="1103" alt="image" src="https://github.com/user-attachments/assets/ff37e49f-19f3-488a-8814-b96ba6d8a0f9" />


```swift
import PackageDescription

let package = Package(
    name: "RemoteConfigClient",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RemoteConfigClient",
            targets: ["RemoteConfigClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "11.13.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RemoteConfigClient",
            dependencies: [
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk")
            ],
            resources: [
                .process("RemoteConfigDefaults.plist")
            ]
        ),

    ]
)

```

### Testing

Classly utiliza una estrategia de testing modular y orientada a capas, alineada con el principio de responsabilidad única. Las pruebas están implementadas usando [Swift Testing](https://github.com/pointfreeco/swift-testing)

#### 📁 Estructura

Cada módulo debe contar con su propio target de tests, organizado para mantener una separación clara entre lógica de negocio, datos y presentación (Ejemplo en el módulo de Authentication)
```swift
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Authentication",
            dependencies: [
                "Assets",
                "Core",
                "UIComponents",
                "DataPersistance",
                "AnalyticsService"
            ]
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]
        ),
    ]
```

La carpeta de tests copia la estructura del código para que sea fácil encontrar el test de cada archivo. Así se conoce qué se está probando y todo está más mantenible.

Para poder probar de forma efectiva los distintos componentes de la app (use cases, repositories, datasources, view models, etc.), se aplicaron los siguientes principios y consideraciones:

- **Inversión de dependencias**  
  Las clases dependen de abstracciones (protocolos) en lugar de implementaciones concretas. Esto permite reemplazar fácilmente las dependencias reales por mocks en los tests.

- **Inyección de dependencias**  
  Todas las dependencias necesarias para un componente (como un `repository` o `datasource`) se pasan mediante el inicializador, lo que facilita el control del entorno de prueba.

- **Separación de responsabilidades (SRP)**  
  Cada clase tiene una única responsabilidad. Por ejemplo, los repositorios orquestan la lógica entre capas, pero no contienen lógica de validación ni formateo.

- **Estrategia de mocks/fakes**  
  Para probar comportamiento, se implementan versiones falsas (`MockRepository`, `MockRemoteDataSource`, etc.) que simulan respuestas predecibles, incluyendo conteo de llamadas y datos recibidos.

Ejemplo:
```swift
import Testing
@testable import Authentication
@testable import ClasslyNetworking
import Foundation

struct AuthRemoteDataSourceTests {

    @Test
    func testLoginSuccess() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        await mockManager.setCustomResponse(LoginResponse(
            id: 1,
            name: "Test",
            email: "test@email.com",
            dni: "12345678",
            password: "secret",
            phone: "999999999",
            role: "admin"
        ))
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)
        let tPasswordParam = "1234"
        let tEmailParam = "test@email.com"

        // Act
        let userResponse = try await dataSource.login(email: tEmailParam, password: tPasswordParam)

        // Assert
        // Request
        let receivedRequest = await mockManager.getReceivedRequest(as: LoginApiRequest.self)
        #expect(receivedRequest?.body.email == tEmailParam)
        #expect(receivedRequest?.body.password == tPasswordParam)

        // Response
        #expect(userResponse.email == "test@email.com")
        #expect(userResponse.role == .admin)
    }

    @Test
    func testLoginUnauthorized() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        await mockManager.setCustomError(NetworkError.invalidResponse(statusCode: 401))
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)

        do {
            // Act
            _ = try await dataSource.login(email: "wrong@email.com", password: "wrong")
        } catch let error as LoginError {
            // Assert
            #expect(error == .unauthorized)
        }
    }

    @Test
    func testLoginInvalidData() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        await mockManager.setCustomError(NetworkError.invalidResponse(statusCode: 400))
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)

        do {
            // Act
            _ = try await dataSource.login(email: "wrong@email.com", password: "wrong")
        } catch let error as LoginError {
            // Assert
            #expect(error == .invalidData)
        }
    }

    @Test
    func testLoginUnknownError() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        await mockManager.setCustomError(NetworkError.requestFailed(NSError(domain: "", code: 0)))
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)

        do {
            // Act
            _ = try await dataSource.login(email: "test@email.com", password: "1234")
        } catch let error as LoginError {
            // Assert
            #expect(error == .serverError)
        }
    }
}

```
