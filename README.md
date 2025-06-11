# Classly – App de gestión para academias de danza

## 📖 Tabla de contenidos

1. [Descripción general](#descripción-general)
2. [Características principales](#características-principales)
3. [Arquitectura del proyecto](#arquitectura-del-proyecto)
4. [Consideraciones y funcionalidades](#consideraciones-y-funcionalidades)
   - [Nuevos módulos](#nuevos-módulos)
   - [Navegación](#navegación)
   - [Testing](#testing)
   - [FaceID](#faceid)
   - [QRScanner](#qrscanner)
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

---

### Navegación

La app por su arquitectura basada en módulos, se decidió desacoplar al máximo en los distintos features. La navegación está centralizada en un módulo específico llamado **Navigation**, el cual se encarga de:

- Controlar el flujo de navegación global.

- Proveer coordinadores para cada feature.

- Importar todos los módulos e inicializarlos
  
Este módulo contiene un objeto central llamado AppCoordinator, que se encarga de determinar y controlar en qué estado de navegación se encuentra la app: autenticación, vista de administrador o vista de estudiante.

La raíz de la app es NavigationRootView, que actúa como un router declarativo: renderiza la vista correspondiente según el estado interno del AppCoordinator.

1.  AppCoordinator.swift
   
Coordina toda la navegación global según el rol del usuario. Inicializa coordinadores según el UserRole (.admin o .student) y actualiza el estado.

2. NavigationRootView.swift
   
Vista raíz de la app. Muestra una vista distinta según el state del AppCoordinator.
```swift
switch coordinator.state {
case .authentication:
    authCoordinator?.start()
case .admin:
    AdminTabView()
case .student:
    StudentTabView()
}
```

3. Admin y Student TabView

Vista principal para usuarios admin y student. Muestra un TabView con vistas, llamando al método `start()` que devuelve la vista 

4. ClasslyApp.swift
Punto de entrada de la app. Usa NavigationRootView como vista inicial.
```swift
@main
struct ClasslyApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationRootView()
        }
    }
}
```

Cada módulo (StudentManagement, ClassManagement, PaymentsManagement, ClassesStudent, etc.) sigue el mismo patrón de navegación. A continuación, se describen los componentes clave y su propósito:

1. FeatureCoordinator (ej. StudentManagementCoordinator.swift)
Controla la navegación dentro del módulo.
```swift
@Published var path = NavigationPath()

func build(route: Route) -> AnyView
func start() -> AnyView
```
* Usa un enum Route para definir los destinos posibles.
* Crea vistas usando inyección de dependencias desde el DIContainer.
* Expone start() que retorna la vista raíz del módulo.

2. FeatureDIContainer (ej. StudentManagementDIContainer.swift)
Se encarga de construir y proveer:

- NetworkManager
- DataSource
- Repository
- UseCases

3. FeatureRootView (ej. StudentManagementRootView.swift)
Vista contenedora que:

* Usa NavigationStack enlazada a coordinator.path
* Muestra la vista inicial
* Usa .navigationDestination para renderizar las rutas
```swift
NavigationStack(path: $coordinator.path) {
    coordinator.build(route: .studentsList)
        .navigationDestination(for: StudentManagementRoute.self) { route in
            coordinator.build(route: route)
        }
}
```

---

### Testing

Classly utiliza una estrategia de testing modular y orientada a capas, alineada con el principio de responsabilidad única. Las pruebas están implementadas usando Swift Testing

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

<img width="329" alt="image" src="https://github.com/user-attachments/assets/1a52cbdc-9202-46e1-8b0d-4afe0a21a296" />


Para poder probar de forma efectiva los distintos componentes de la app (use cases, repositories, datasources, view models, etc.), se aplicaron los siguientes principios y consideraciones:

- **Inversión de dependencias**  
  Las clases dependen de abstracciones (protocolos) en lugar de implementaciones concretas. Esto permite reemplazar fácilmente las dependencias reales por mocks en los tests.

- **Inyección de dependencias**  
  Todas las dependencias necesarias para un componente (como un `repository` o `datasource`) se pasan mediante el inicializador, lo que facilita el control del entorno de prueba.

- **Separación de responsabilidades (SRP)**  
  Cada clase tiene una única responsabilidad. Por ejemplo, los repositorios orquestan la lógica entre capas, pero no contienen lógica de validación ni formateo.

- **Estrategia de mocks/fakes**  
  Para probar comportamiento, se implementan versiones falsas (`MockRepository`, `MockRemoteDataSource`, etc.) que simulan respuestas predecibles, incluyendo conteo de llamadas y datos recibidos.

En cada test se prueban los posibles casos de éxito y de error. Ejemplo:
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
---
### FaceID
Se buscó que la app tenga el objetivo de permitir a los usuarios autenticar su inicio de sesión usando Face ID (o Touch ID) mediante un flujo seguro con Keychain y LocalAuthentication.

#### Implementación
1. Protocolo BiometricManagerProtocol
Define las operaciones clave:
```swift
func isBiometricAvailable() -> Bool
func hasUsedBiometricsBefore() -> Bool
func authenticate() async -> Bool
func saveCredentials(username: String, password: String) throws
func retrieveCredentials() -> (username: String, password: String)?
func clearCredentials()
```

2. Biometric manager

Implementa el protocolo usando:
* LAContext para autenticación biométrica.
* KeychainManager para guardar credenciales seguras.

Funciones clave:

* authenticate(): Llama a Face ID.
* saveCredentials(...): Guarda credenciales en Keychain.
* retrieveCredentials(): Recupera usuario y contraseña si existen.
* clearCredentials(): Elimina credenciales antiguas.

Todo se maneja dentro de un actor para garantizar la seguridad y evitar posibles fallos de concurrencia de acuerdo con Swift6

3. Integración con LoginViewModel
* login():
   - Si login es exitoso, guarda las credenciales si la biometría está habilitada y autorizada.
* authenticateWithBiometrics():
   - Verifica si hay credenciales biométricas válidas.
   - Si se autentica correctamente, autocompleta email y password y ejecuta login() automáticamente.

```swift
func authenticateWithBiometrics() {
    let biometricResult = await biometricManager.authenticate()
    if biometricResult {
        let credentials = await biometricManager.retrieveCredentials()
        if let credentials = credentials {
            self.email = credentials.username
            self.password = credentials.password
            self.login()
        }
    }
}
```

> **Nota importante**  
>  
> La implementación de almacenamiento de credenciales sensibles (usuario y contraseña) en Keychain se realizó **únicamente con fines didácticos**.  
>  
> En una aplicación de producción, se recomienda **no almacenar credenciales en texto plano**, incluso si están en Keychain. Es preferible utilizar **tokens de sesión, refresh tokens** u otros mecanismos más seguros y estandarizados.

---

### QRScanner
Para la app se buscaba que el usuario escanee un código QR con la cámara del dispositivo para poder marcar su asistencia en la clase. Este flujo:

- Solicita permisos de cámara.
- Configura una sesión de captura con AVFoundation.
- Muestra en tiempo real lo que capta la cámara.
- Detecta automáticamente un código QR y lo procesa.

#### 1. `CameraManager`: es el centro de control de la cámara. Se encarga de:

- Pedir permisos.
- Configurar la sesión de captura (input de cámara + output para QR).
- Manejar el escaneo del código.
- Iniciar y detener la sesión.

Primero pedimos permisos de cámara
```swift
func requestCameraPermission() async {
    let status = AVCaptureDevice.authorizationStatus(for: .video)

    switch status {
    case .authorized:
        self.permissionGranted = true
        await self.setupCamera() // Solo si ya está autorizado
    case .notDetermined:
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        if granted {
            self.permissionGranted = true
            await self.setupCamera()
        } else {
            self.permissionDenied = true
        }
    default:
        self.permissionDenied = true
    }
}
```

Posteriormente configuramos la cámara
```swift
private func setupCamera() async {
    let session = AVCaptureSession()

    // 1. Seleccionamos la cámara trasera
    guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
    let videoInput = try AVCaptureDeviceInput(device: videoDevice)
    session.addInput(videoInput)

    // 2. Preparamos para detectar QR
    let metadataOutput = AVCaptureMetadataOutput()
    session.addOutput(metadataOutput)
    metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
    metadataOutput.metadataObjectTypes = [.qr]

    // 3. Iniciamos la sesión en un hilo de fondo
    await withCheckedContinuation { continuation in
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
            Task { @MainActor in
                self.isSessionRunning = true
                continuation.resume()
            }
        }
    }

    self.captureSession = session
}
```
**Conceptos importantes:**
- AVCaptureSession = el motor que coordina la entrada (cámara) y salida (código QR).
- AVCaptureMetadataOutput = permite detectar QR en tiempo real.
- .startRunning() se lanza en un hilo de fondo para no bloquear la UI.

Los datos del qr escaneado se reciben en el siguiente método del delegate:
```swift
extension CameraManager: AVCaptureMetadataOutputObjectsDelegate {
    nonisolated func metadataOutput(_ output: AVCaptureMetadataOutput,
                                    didOutput metadataObjects: [AVMetadataObject],
                                    from connection: AVCaptureConnection) {

        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else { return }

        handleScannedCode(stringValue)
    }
}
```
#### 2. `CameraPreviewView` y `CameraPreviewViewRepresentable`
A continuación mostramos lo que está capturando la cámara. SwiftUI no tiene vistas nativas para mostrar la cámara, así que se hace un puente con UIKit.
1. Creamos una vista puente con UIKit (UIView) para mostrar la cámara en SwiftUI:
```swift
final class CameraPreviewView: UIView {
    func setupPreviewLayer(with session: AVCaptureSession) {
        let newPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        newPreviewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(newPreviewLayer)
        previewLayer = newPreviewLayer
    }
}
```
2. Y la usamos en SwiftUI con `UIViewRepresentable`:
```swift
struct CameraPreviewViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CameraPreviewView {
        let view = CameraPreviewView()
        cameraManager.setupPreviewLayer(in: view)
        return view
    }
}
```
#### 3. `QRScanView`
QRScanView es la pantalla donde el usuario escanea el código QR. Se encarga de:

- Mostrar la vista previa de la cámara si hay permiso.
- Mostrar overlays, loading o errores.
- Reaccionar al código escaneado.

```swift
var body: some View {
    VStack {
        CustomAppBar(title: "Scan QR", backAction: viewModel.goBack)

        ZStack {
            if cameraManager.permissionGranted {
                CameraPreviewViewRepresentable(cameraManager: cameraManager)
                    .onReceive(cameraManager.$scannedCode) { code in
                        if let code = code {
                            Task {
                                await viewModel.handleScannedCode(code)
                            }
                        }
                    }
                QRScannerOverlay() // UI decorativo opcional
            } else if cameraManager.permissionDenied {
                PermissionDeniedView()
            } else {
                LoadingCameraView()
            }
        }
        .task {
            await cameraManager.requestCameraPermission()
        }
        .onDisappear {
            Task {
                await cameraManager.stopSession()
            }
        }

        Image(uiImage: AssetImage.logoClassly)
            .resizable()
            .scaledToFit()
            .frame(height: 40)
    }
}
```
