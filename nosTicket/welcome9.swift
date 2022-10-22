// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome9 = try Welcome9(json)

import Foundation

// MARK: - Welcome9
struct responseModel: Decodable {
    let response: Response
}

// MARK: - Response
struct Response : Decodable {
    let route: [Route]
    let language: String
}

// MARK: - Route
struct Route : Decodable {
    let mode: Mode
    let boatFerry, railFerry: Bool
    let waypoint: [Waypoint]
    let leg: [Leg]
}

// MARK: - Leg
struct Leg : Decodable {
    let length, travelTime: Int
    let link: [Link]
    let trafficTime, baseTime: Int
    let refReplacements: [String: String]
}

// MARK: - Link
struct Link : Decodable {
    let linkID: String
    let length, remainDistance, remainTime: Int
    let shape: [Double]
    let functionalClass, confidence: Int
    let attributes: Attributes
    let segmentRef: String
}

// MARK: - Attributes
struct Attributes : Decodable {
    let speedLimitsFcn: [SpeedLimitsFcn]
}

// MARK: - SpeedLimitsFcn
struct SpeedLimitsFcn : Decodable {
    let fromRefSpeedLimit, toRefSpeedLimit, speedLimitSource, speedLimitUnit: String
}

// MARK: - Mode
struct Mode : Decodable{
    let type: String
    let transportModes: [String]
    let trafficMode: String
}

// MARK: - Summary

// MARK: - Waypoint
struct Waypoint : Decodable {
    let linkID: String
    let mappedPosition, originalPosition: Position
    let spot: Double
    let confidenceValue, elevation, headingDegreeNorthClockwise, headingMatched: Int
    let matchDistance: Double
    let minError, routeLinkSeqNrMatched, speedMps, timestamp: Int
}

// MARK: - Position
struct Position : Decodable {
    let latitude, longitude: Double
}

