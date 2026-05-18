import SwiftUI

struct MenuView: View {

    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {

            // pantallas de la app
            Group {
                switch selectedTab {
                case 0:
                    HomeView()

                case 1:
                    BuscarView()

                case 2:
                    PerfilView()

                default:
                    HomeView()
                }
            }

            // barra inferior personalizada (para la navegación)
            HStack {

                Spacer()

                Button {
                    selectedTab = 0
                } label: {
                    Image(systemName: "house.fill")
                        .font(.title2)
                        .foregroundColor(selectedTab == 0 ? .white : .gray)
                }

                Spacer()

                Button {
                    selectedTab = 1
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(selectedTab == 1 ? .purple : .gray)
                }

                Spacer()

                Button {
                    selectedTab = 2
                } label: {
                    Image(systemName: "person")
                        .font(.title2)
                        .foregroundColor(selectedTab == 2 ? .purple : .gray)
                }

                Spacer()
            }
            .padding()
            .background(
                Color.black
                    .ignoresSafeArea(edges: .bottom)
            )
            .clipShape(
                RoundedCorner(
                    radius: 35,
                    corners: [.topLeft, .topRight]
                )
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MenuView()
}