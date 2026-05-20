import SwiftUI
import SwiftData

//perfil del usuario
struct PerfilView: View {
    @Query private var favoritas: [SongFavorita]

    var body: some View {
        ZStack {

            // fondo degradado
            LinearGradient(
                colors: [Color.purple, Color.pink],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 20) {

                    // el header
                    ZStack(alignment: .top) {

                        // fondo negro del header
                        Color.black
                            .frame(height: 260)
                            .ignoresSafeArea(edges: .top)
                            .clipShape(
                                RoundedCorner(
                                    radius: 40,
                                    corners: [.bottomLeft, .bottomRight]
                                )
                            )

                        VStack(spacing: 15) {

                            // imagen usuario perfil
                            Image("perfil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.purple, lineWidth: 4)
                                )
                                .padding(.top, 30)

                            //nombre usuario
                            Text("LAURA SALAS")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)

                            // secciones del perfil
                            VStack(spacing: 15) {

                                perfilCard(texto: "Canciones escuchadas")

                                VStack(spacing: 15) {

                                    Text("Favoritas")
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    ForEach(favoritas) { song in

                                        HStack(spacing: 15) {

                                            AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(10)

                                            VStack(alignment: .leading) {

                                                Text(song.trackName)
                                                    .foregroundColor(.white)
                                                    .bold()

                                                Text(song.artistName)
                                                    .foregroundColor(.gray)
                                                    .font(.caption)
                                            }

                                            Spacer()
                                        }
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .cornerRadius(15)
                                    }
                                }
                                .padding(.horizontal)

                                perfilCard(texto: "Artistas favoritos")

                                perfilCard(texto: "Playlists creadas")
                            }
                            .padding(.top)
                        }
                    }
                }
            }
        }
    }

    // tarjeta reutilizable
    func perfilCard(texto: String) -> some View {
        ZStack {
            Color.black

            HStack {
                Text(texto)
                    .foregroundColor(.white)
                    .bold()

                Spacer()
            }
            .padding()
        }
        .frame(height: 60)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

#Preview {
    PerfilView()
}