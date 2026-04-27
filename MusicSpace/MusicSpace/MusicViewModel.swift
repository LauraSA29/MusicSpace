import Foundation

class MusicViewModel: ObservableObject {
    @Published var songs: [Song] = []

    func fetchSongs() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=drake&entity=song") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MusicResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.songs = result.results
                    }
                } catch {
                    print("Error decoding:", error)
                }
            }
        }.resume()
    }
}