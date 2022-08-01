//
//  YoutubeModelAPI.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/28.
//

import Foundation

struct YoutubeModelAPI: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
}

struct Item: Codable {
    let kind: String
    let etag: String
    let id: ID
    let snippet: Snippet
}

struct ID: Codable {
    let kind: String
    let videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct Snippet: Codable {
    let publishedAt: Date
    let channelID: String
    let title: String
    let snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle, liveBroadcastContent: String
    let publishTime: Date

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault: Default
    let medium: Default
    let high: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

struct Default: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}
