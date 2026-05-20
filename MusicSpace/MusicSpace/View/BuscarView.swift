import SwiftUI

//vista de búsqueda de canciones
struct BuscarView: View {
    @StateObject var vm = MusicViewModel()
    @State private var busqueda = ""

    //filtra las canciones según el texto escrito
    var cancionesFiltradas: [Song] {
        if busqueda.isEmpty {
            return vm.songs
        } else {
            return vm.songs.filter {
                $0.trackName.localizedCaseInsensitiveContains(busqueda) || $0.artistName.localizedCaseInsensitiveContains(busqueda)
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

            VStack(spacing: 0) {

                //encabezado
                ZStack {

                    Color.black
                        .ignoresSafeArea(edges: .top)

                    //header redondeado
                    Color.black
                        .frame(height: 120)
                        .clipShape(
                            RoundedCorner(
                                radius: 40,
                                corners: [.bottomLeft, .bottomRight]
                            )
                        )

                    HStack {

                        Text("Buscar")
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()

                        Spacer()
                    }
                    .padding()
                }
                .frame(height: 120)

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 20) {

                        //barra de búsqueda
                        HStack {

                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.purple)

                            TextField("Buscar canciones o artistas", text: $busqueda)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)

                        // lista de canciones
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
}

#Preview {
    BuscarView()
}

