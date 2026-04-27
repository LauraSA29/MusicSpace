import Foundation

struct MusicResponse: Codable {
    let results: [Song]
}

struct Song: Codable, Identifiable {
    let id = UUID()
    let trackName: String
    let artistName: String
    let artworkUrl100: String
}