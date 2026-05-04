import SwiftUI

@MainActor
class MusicViewModel: ObservableObject {
    @Published var songs: [Song] = []

    func fetchSongs() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=drake&entity=song") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                print("Error:", error)
                return
            }

            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(MusicResponse.self, from: data)
                
                Task {
                    self.songs = result.results
                }

            } catch {
                print("Error:", error)
            }
        }
        .resume()
    }
}