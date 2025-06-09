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

A nivel interno, cada módulo **feature** implementa el patrón MVVM (Model-View-ViewModel), que separa la lógica de negocio de la interfaz gráfica, facilitando pruebas y mantenibilidad.

La navegación entre pantallas se maneja usando Coordinadores, lo que evita que las vistas tengan conocimiento de otras vistas o flujos.
