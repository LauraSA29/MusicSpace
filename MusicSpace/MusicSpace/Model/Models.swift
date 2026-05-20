import Foundation

//modelo para mapear la respuesta de la API de iTunes
struct MusicResponse: Codable {
    let results: [Song]
}

struct Song: Codable, Identifiable {
    let id = UUID()
    let trackName: String
    let artistName: String
    let artworkUrl100: String

// para mapear las claves del JSON porque me daba errores
    enum CodingKeys: String, CodingKey {
        case trackName, artistName, artworkUrl100
    }
}