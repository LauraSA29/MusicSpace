import SwiftUI

// para redondear solo algunas esquinas de los headers en las vistas
struct RoundedCorner: Shape {
    var radius: CGFloat = 25
    var corners: UIRectCorner = .allCorners

    // función que dibuja con las esquinas redondeadas según los parámetros que le metas
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}