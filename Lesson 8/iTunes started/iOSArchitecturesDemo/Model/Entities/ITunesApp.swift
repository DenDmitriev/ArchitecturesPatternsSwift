//
//  ITunesApp.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

public struct ITunesApp: Codable {
    
    public typealias Bytes = Int
    
    public let appName: String
    public let appUrl: String?
    public let company: String?
    public let companyUrl: String?
    public let appDescription: String?
    public let averageRating: Float?
    public let averageRatingForCurrentVersion: Float?
    public let size: Bytes?
    public let iconUrl: String?
    public let screenshotUrls: [String]
    public let version: String
    public let releaseNotes: String
    public var currentReleaseDate: Date
    
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case appName = "trackName"
        case appUrl = "artistViewUrl"
        case company = "sellerName"
        case companyUrl = "sellerUrl"
        case appDescription = "description"
        case averageRating = "averageUserRating"
        case averageRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case size = "fileSizeBytes"
        case iconUrl = "artworkUrl512"
        case screenshotUrls = "screenshotUrls"
        case version = "version"
        case releaseNotes = "releaseNotes"
        case currentReleaseDate = "currentVersionReleaseDate"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appName = try container.decode(String.self, forKey: .appName)
        self.appUrl = try? container.decode(String.self, forKey: .appUrl)
        self.company = try? container.decode(String.self, forKey: .company)
        self.companyUrl = try? container.decode(String.self, forKey: .companyUrl)
        self.appDescription = try? container.decode(String.self, forKey: .appDescription)
        self.averageRating = try? container.decode(Float.self, forKey: .averageRating)
        self.averageRatingForCurrentVersion = try? container.decode(Float.self, forKey: .averageRatingForCurrentVersion)
        self.size = (try? container.decode(String.self, forKey: .size)) >>- { Bytes($0) }
        self.iconUrl = try? container.decode(String.self, forKey: .iconUrl)
        self.screenshotUrls = (try? container.decode([String].self, forKey: .screenshotUrls)) ?? []
        self.version = try container.decode(String.self, forKey: .version)
        self.releaseNotes = try container.decode(String.self, forKey: .releaseNotes)
        let dateString = try container.decode(String.self, forKey: .currentReleaseDate)
        self.currentReleaseDate = ISO8601DateFormatter.standart.date(from: dateString) ?? Date()
    }
    
    // MARK: - Init
    
    internal init(appName: String,
                  appUrl: String?,
                  company: String?,
                  companyUrl: String?,
                  appDescription: String?,
                  averageRating: Float?,
                  averageRatingForCurrentVersion: Float?,
                  size: Bytes?,
                  iconUrl: String?,
                  screenshotUrls: [String],
                  version: String,
                  currentReleaseDate: Date,
                  releaseNotes: String) {
        self.appName = appName
        self.appUrl = appUrl
        self.company = company
        self.companyUrl = companyUrl
        self.appDescription = appDescription
        self.averageRating = averageRating
        self.averageRatingForCurrentVersion = averageRatingForCurrentVersion
        self.size = size
        self.iconUrl = iconUrl
        self.screenshotUrls = screenshotUrls
        self.version = version
        self.currentReleaseDate = currentReleaseDate
        self.releaseNotes = releaseNotes
    }
}