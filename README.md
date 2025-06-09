# Classly – App de gestión para academias de danza

## 📖 Tabla de contenidos

1. [Descripción general](#descripción-general)
2. [Características principales](#características-principales)
3. [Arquitectura del proyecto](#arquitectura-del-proyecto)
4. [Estructura del proyecto](#estructura-del-proyecto)
5. [Tecnologías y herramientas](#tecnologías-y-herramientas)
6. [Instalación y ejecución](#instalación-y-ejecución)
7. [Prácticas recomendadas y principios aplicados](#prácticas-recomendadas-y-principios-aplicados)
8. [Capturas de pantalla (opcional)](#capturas-de-pantalla-opcional)
9. [Próximos pasos y TODO](#próximos-pasos-y-todo)
10. [Créditos y agradecimientos](#créditos-y-agradecimientos)

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

