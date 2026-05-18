import SwiftUI

struct BuscarView: View {
    @StateObject var vm = MusicViewModel()
    @State private var busqueda = ""

    var cancionesFiltradas: [Song] {
        if busqueda.isEmpty {
            return vm.songs
        } else {
            return vm.songs.filter {
                $0.trackName.localizedCaseInsensitiveContains(busqueda) ||
                $0.artistName.localizedCaseInsensitiveContains(busqueda)
            }
        }
    }

    var body: some View {
        ZStack {
            //fondo degradado
            LinearGradient(
                colors: [Color.purple, Color.pink],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {

                //encabezado
                ZStack {
                    Color.black
                        .frame(height: 120)
                        .ignoresSafeArea(edges: .top)
                        .clipShape(RoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))

                    HStack {
                        Text("Buscar")
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()

                        Spacer()
                    }
                    .padding()
                }

                //barra de búsqueda
                HStack {
                    Image(systemName: "magnifyingglass")
                            .foregroundColor(.purple)
                            
                    TextField("Buscar canciones o artistas", text: $busqueda)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)

                // lista de canciones
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(cancionesFiltradas) { song in
                            HStack(spacing: 15) {

                                AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 70, height: 70)
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
            }
        }
        .onAppear {
            vm.canciones()
        }
    }
}

#Preview {
    BuscarView()
}