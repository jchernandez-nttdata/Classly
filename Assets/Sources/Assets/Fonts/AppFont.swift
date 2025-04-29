//
//  AppFont.swift
//  Assets
//
//  Created by Juan Carlos Hernandez Castillo on 28/04/25.
//

import SwiftUI

public struct AppFont {
    public static let largeTitle = Font.system(size: 34, weight: .bold)     // Títulos grandes, como el de la pantalla de inicio o principal
    public static let title = Font.system(size: 28, weight: .semibold)      // Títulos secundarios, por ejemplo, en vistas de clases o perfil

    public static let headline = Font.system(size: 22, weight: .semibold)   // Subtítulos importantes, como encabezados de secciones
    public static let subheadline = Font.system(size: 20, weight: .regular)  // Subtítulos secundarios, como detalles de clases

    public static let body = Font.system(size: 17, weight: .regular)        // Texto de cuerpo estándar, para descripciones o contenido largo
    public static let callout = Font.system(size: 16, weight: .regular)      // Texto destacado, como botones o etiquetas
    public static let caption = Font.system(size: 14, weight: .light)        // Texto pequeño, como información adicional o pie de página

    public static let footnote = Font.system(size: 12, weight: .light)       // Para información adicional que no necesita resaltar
    public static let small = Font.system(size: 10, weight: .light)          // Muy pequeño, usado en detalles muy específicos o instrucciones
}
