//
//  AlbumModel.swift
//  Navigation
//
//  Created by Никита Морозов on 04.08.2026.
//

import Foundation

struct AlbumResponse: Decodable {
    let invocationInfo: InvocationInfo
    let result: Album
}

struct InvocationInfo: Decodable {
    let reqId: String
    let hostname: String
    let execDurationMillis: Int
    
    enum CodingKeys: String, CodingKey {
        case reqId = "req-id"
        case hostname
        case execDurationMillis = "exec-duration-millis"
    }
}

struct Album: Decodable {
    let id: Int
    let title: String
    let metaType: String
    let contentWarning: String?
    let year: Int
    let releaseDate: String
    let coverUri: String
    let cover: Cover
    let ogImage: String
    let genre: String
    let metaTagId: String
    let trackCount: Int
    let likesCount: Int
    let recent: Bool
    let veryImportant: Bool
    
    let artists: [Artist]
    let labels: [Label]
    
    let available: Bool
    let availableForPremiumUsers: Bool
    let availableForOptions: [String]
    let availableForMobile: Bool
    let availablePartially: Bool
    
    let bests: [Int]
    let disclaimers: [String]
    let hasTrailer: Bool
    let trailer: Trailer
    
    let derivedColors: DerivedColors
    let customWave: CustomWave
    
    let sortOrder: String
    let volumes: [[Track]]
    let pager: Pager
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case metaType = "metaType"
        case contentWarning = "contentWarning"
        case year
        case releaseDate = "releaseDate"
        case coverUri = "coverUri"
        case cover
        case ogImage = "ogImage"
        case genre
        case metaTagId = "metaTagId"
        case trackCount = "trackCount"
        case likesCount = "likesCount"
        case recent
        case veryImportant = "veryImportant"
        case artists
        case labels
        case available
        case availableForPremiumUsers = "availableForPremiumUsers"
        case availableForOptions = "availableForOptions"
        case availableForMobile = "availableForMobile"
        case availablePartially = "availablePartially"
        case bests
        case disclaimers
        case hasTrailer = "hasTrailer"
        case trailer
        case derivedColors = "derivedColors"
        case customWave = "customWave"
        case sortOrder = "sortOrder"
        case volumes
        case pager
    }
}

struct Cover: Decodable {
    let uri: String
    let color: String
}

struct Artist: Decodable {
    let id: Int
    let name: String
    let various: Bool
    let composer: Bool
    let available: Bool
    let cover: ArtistCover
    let genres: [String]
    let disclaimers: [String]
}

struct ArtistCover: Decodable {
    let type: String
    let uri: String
    let prefix: String
}

struct Label: Decodable {
    let id: Int
    let name: String
}

struct Trailer: Decodable {
    let available: Bool
}

struct DerivedColors: Decodable {
    let average: String
    let waveText: String
    let miniPlayer: String
    let accent: String
}

struct CustomWave: Decodable {
    let title: String
    let animationUrl: String
    let header: String
    let backgroundImageUrl: String
}

struct Pager: Decodable {
    let page: Int
    let perPage: Int
    let total: Int
}

struct Track: Decodable {
    let id: String
    let realId: String
    let title: String
    let contentWarning: String?
    let major: Major
    let available: Bool
    let availableForPremiumUsers: Bool
    let availableFullWithoutPermission: Bool
    let availableForOptions: [String]
    let disclaimers: [String]
    let storageDir: String
    let durationMs: Int
    let fileSize: Int
    let r128: R128
    let fade: Fade
    let previewDurationMs: Int
    let artists: [Artist]
    let albums: [TrackAlbum]
    let coverUri: String
    let derivedColors: DerivedColors
    let ogImage: String
    let lyricsAvailable: Bool
    let best: Bool
    let type: String
    let rememberPosition: Bool
    let trackSharingFlag: String
    let lyricsInfo: LyricsInfo
    let trackSource: String
    let specialAudioResources: [String]?
    
    var formattedDuration: String {
        let minutes = durationMs / 60000
        let seconds = (durationMs % 60000) / 1000
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var trackNumber: Int? {
        return albums.first?.trackPosition?.index
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case realId = "realId"
        case title
        case contentWarning = "contentWarning"
        case major
        case available
        case availableForPremiumUsers = "availableForPremiumUsers"
        case availableFullWithoutPermission = "availableFullWithoutPermission"
        case availableForOptions = "availableForOptions"
        case disclaimers
        case storageDir = "storageDir"
        case durationMs = "durationMs"
        case fileSize = "fileSize"
        case r128
        case fade
        case previewDurationMs = "previewDurationMs"
        case artists
        case albums
        case coverUri = "coverUri"
        case derivedColors = "derivedColors"
        case ogImage = "ogImage"
        case lyricsAvailable = "lyricsAvailable"
        case best
        case type
        case rememberPosition = "rememberPosition"
        case trackSharingFlag = "trackSharingFlag"
        case lyricsInfo = "lyricsInfo"
        case trackSource = "trackSource"
        case specialAudioResources = "specialAudioResources"
    }
}

struct Major: Decodable {
    let id: Int
    let name: String
}

struct R128: Decodable {
    let i: Double
    let tp: Double
}

struct Fade: Decodable {
    let inStart: Double
    let inStop: Double
    let outStart: Double
    let outStop: Double
}

struct TrackAlbum: Decodable {
    let id: Int
    let title: String
    let metaType: String
    let contentWarning: String?
    let year: Int
    let releaseDate: String
    let coverUri: String
    let cover: TrackCover
    let ogImage: String
    let genre: String
    let trackCount: Int
    let likesCount: Int
    let recent: Bool
    let veryImportant: Bool
    let artists: [Artist]
    let labels: [Label]
    let available: Bool
    let availableForPremiumUsers: Bool
    let availableForOptions: [String]
    let availableForMobile: Bool
    let availablePartially: Bool
    let bests: [Int]
    let disclaimers: [String]
    let hasTrailer: Bool
    let trackPosition: TrackPosition?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case metaType = "metaType"
        case contentWarning = "contentWarning"
        case year
        case releaseDate = "releaseDate"
        case coverUri = "coverUri"
        case cover
        case ogImage = "ogImage"
        case genre
        case trackCount = "trackCount"
        case likesCount = "likesCount"
        case recent
        case veryImportant = "veryImportant"
        case artists
        case labels
        case available
        case availableForPremiumUsers = "availableForPremiumUsers"
        case availableForOptions = "availableForOptions"
        case availableForMobile = "availableForMobile"
        case availablePartially = "availablePartially"
        case bests
        case disclaimers
        case hasTrailer = "hasTrailer"
        case trackPosition = "trackPosition"
    }
}

struct TrackCover: Decodable {
    let uri: String
}

struct TrackPosition: Decodable {
    let volume: Int
    let index: Int
}

struct LyricsInfo: Decodable {
    let hasAvailableSyncLyrics: Bool
    let hasAvailableTextLyrics: Bool
}
