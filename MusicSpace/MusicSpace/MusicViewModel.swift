import SwiftUI
import Combine

@MainActor
class MusicViewModel: ObservableObject {
    @Published var songs: [Song] = []

    func canciones() {
        // API de Apple (iTunes)
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor&entity=song") else { return }

        // la solicitud de datos en internet
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            //manejo de errores
            if let error = error {
                print("El error:", error)
                return
            }

            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(MusicResponse.self, from: data)
                
                // actualiza songs en el hilo principal
                Task {
                    self.songs = result.results
                }

            } catch {
                print("El error:", error)
            }
        }
        .resume()
    }
}