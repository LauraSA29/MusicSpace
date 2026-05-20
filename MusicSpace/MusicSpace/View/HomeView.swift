import SwiftUI
import SwiftData

// inicio de la app
struct HomeView: View {
    @StateObject var vm = MusicViewModel()
    @Environment(\.modelContext) private var context
    @Query private var favoritas: [SongFavorita]

    var body: some View {
        ZStack {

            // fondo c degradado colores
            LinearGradient(
                colors: [Color.purple, Color.pink],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // encabezado
                header

                // para hacer scroll y ver todos los datos
                ScrollView(showsIndicators: false) {

                    VStack(alignment: .leading, spacing: 20) {

                        // las canciones populares y novedades
                        Text("Canciones populares:")
                            .font(.headline)
                            .padding(.horizontal)

                        popularSection

                        Text("Novedades:")
                            .font(.headline)
                            .padding(.horizontal)

                        novedadesSection
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            vm.canciones()
        }
    }

    // el encabezado de la app
    var header: some View {

        ZStack {

            Color.black
                .ignoresSafeArea(edges: .top)

            // header con curvas
            Color.black
                .frame(height: 120)
                .clipShape(
                    RoundedCorner(
                        radius: 40,
                        corners: [.bottomLeft, .bottomRight]
                    )
                )

            HStack {

                // la foto
                Circle()
                    .stroke(Color.purple, lineWidth: 3)
                    .frame(width: 60, height: 60)

                //saludo al usuario
                Text("¡Hola Laura!")
                    .foregroundColor(.white)
                    .bold()

                Spacer()

                //imagen de la rueda de confiuración
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.purple)
            }
            .padding()
        }
        .frame(height: 120)
    }

    // sección de las canciones populares
    var popularSection: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack {

                ForEach(vm.songs.prefix(5)) { song in //salen solo 5

                    VStack {

                        AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView() //para mostrar mientras carga la imagen
                        }
                        .frame(width: 120, height: 120)
                        .cornerRadius(10)

                        Text(song.trackName)
                            .font(.caption)
                            .bold()
                            .multilineTextAlignment(.center)

                        Button {

                            guardarFavorita(song)

                        } label: {

                            Image(systemName: esFavorita(song) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal)
        }
    }

    // la sección de novedades
    var novedadesSection: some View {

        VStack {

            ForEach(vm.songs.prefix(3)) { song in //salen solo 3

                HStack {

                    AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)

                    VStack(alignment: .leading) {

                        Text(song.trackName)
                            .bold()

                        Text(song.artistName)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
            }
        }
    }

    // guardar o eliminar favoritas
    func guardarFavorita(_ song: Song) {

        if let favoritaExistente = favoritas.first(where: {
            $0.trackName == song.trackName
        }) {

            context.delete(favoritaExistente)

        } else {

            let nuevaFavorita = SongFavorita(
                trackName: song.trackName,
                artistName: song.artistName,
                artworkUrl100: song.artworkUrl100
            )

            context.insert(nuevaFavorita)
        }
    }

    // comprobar si es favorita
    func esFavorita(_ song: Song) -> Bool {

        favoritas.contains {
            $0.trackName == song.trackName
        }
    }
}

