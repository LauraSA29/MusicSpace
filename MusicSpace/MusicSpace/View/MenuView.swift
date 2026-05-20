import SwiftUI

// vista del menú de navegación de la app
struct MenuView: View {

    @State private var eleccion = 0

    var body: some View {
        ZStack(alignment: .bottom) {

            // pantallas de la app
            Group {

                switch selectedTab {

                case 0:
                    HomeView()
                        .transition(.move(edge: .leading)) // transición para la pantalla de inicio

                case 1:
                    BuscarView()
                        .transition(.opacity) // transición para la pantalla de búsqueda

                case 2:
                    PerfilView()
                        .transition(.move(edge: .trailing)) // transición para la pantalla de perfil

                default:
                    HomeView()
                }
            }
            .animation(.easeInOut(duration: 0.3), value: selectedTab)

            // barra de navegación con los botones para cambiar de pantalla
            HStack {

                Spacer()

                Button {
                    eleccion = 0
                } label: {
                    Image(systemName: "house.fill") // inicio home
                        .font(.title2)
                        .foregroundColor(eleccion == 0 ? .white : .gray)
                }

                Spacer()

                Button {
                    eleccion = 1
                } label: {
                    Image(systemName: "magnifyingglass") // buscar
                        .font(.title2)
                        .foregroundColor(eleccion == 1 ? .purple : .gray)
                }

                Spacer()

                Button {
                    eleccion = 2
                } label: {
                    Image(systemName: "person") // perfil
                        .font(.title2)
                        .foregroundColor(eleccion == 2 ? .purple : .gray)
                }

                Spacer()
            }
            .padding()
            .background(
                Color.black
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MenuView()
}