import SwiftData

//clase para almacenar las canciones favoritas en la base de datos local utilizando SwiftData
@Model
class SongFavorita {

    var trackName: String
    var artistName: String
    var artworkUrl100: String

    init(trackName: String, artistName: String, artworkUrl100: String) {
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
    }
}