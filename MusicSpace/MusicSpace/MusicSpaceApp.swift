//
//  MusicSpaceApp.swift
//  MusicSpace
//
//  Created by MasterD on 18/3/26.
//

import SwiftUI

@main
struct MusicSpaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SongFavorita.self)
    }
}
