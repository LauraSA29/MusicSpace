import SwiftUI

struct HomeView: View {
    @StateObject var vm = MusicViewModel()

    var body: some View {
        ZStack {
            // 
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // 
                    header

                    // 
                    Text("Canciones populares")
                        .font(.headline)
                        .padding(.horizontal)

                    popularSection

                    // 
                    Text("Novedades")
                        .font(.headline)
                        .padding(.horizontal)

                    novedadesSection
                }
            }
        }
        .onAppear {
            vm.fetchSongs()
        }
    }

    // 
    var header: some View {
        ZStack {
            Color.black
                .frame(height: 120)
                .clipShape(RoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))

            HStack {
                Circle()
                    .stroke(Color.purple, lineWidth: 3)
                    .frame(width: 60, height: 60)

                Text("¡Hola Laura!")
                    .foregroundColor(.white)
                    .bold()

                Spacer()

                Image(systemName: "gearshape.fill")
                    .foregroundColor(.purple)
            }
            .padding()
        }
    }

    // 
    var popularSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.songs.prefix(5)) { song in
                    VStack {
                        AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 120)
                        .cornerRadius(10)

                        Text(song.trackName)
                            .font(.caption)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal)
        }
    }

    // 
    var novedadesSection: some View {
        VStack {
            ForEach(vm.songs.prefix(3)) { song in
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
}