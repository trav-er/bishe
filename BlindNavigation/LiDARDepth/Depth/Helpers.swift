//
//  helpers.swift
//  LiDARDepth
//
//  Created by Ton on 2023/5/17.
//  Copyright © 2023 Apple. All rights reserved.
//  ARMeshClassificion

import CoreGraphics
import ARKit
import RealityKit

extension String {
//    public static let _backgroundMusicAnchorName = "io.github.ApolloZhu._BACKGROUND_MUSIC"
    public static let _backgroundMusicAnchorName = ""

}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

//AR点云分类
extension ARMeshClassification {
    init(_ planeAnchorClassification: ARPlaneAnchor.Classification) {
        switch planeAnchorClassification {
        case .none:
            self = .none
        case .wall:
            self = .wall
        case .floor:
            self = .floor
        case .ceiling:
            self = .ceiling
        case .table:
            self = .table
        case .seat:
            self = .seat
        case .window:
            self = .window
        case .door:
            self = .door
        @unknown default:
            self = .none
        }
    }
}

extension ARMeshClassification: CaseIterable {
    public static let allCases: [ARMeshClassification] = [
        .wall,
        .door,
        .window,
        .table,
        .seat,
        .ceiling,
        .floor,
        .none,
    ]
}

//距离各个接触面的距离警报
public func handleDistances(_ distances: [ARMeshClassification: Float]) {
    for (category, distance) in distances.sorted(by: { $0.value < $1.value }) {
        switch category {
        case .wall:
            if distance < 0.3 {
                return say("距离墙\(distance, decimalPlaces: 1)米")
            }
        case .floor:
            if distance < 0.4 {
                return say("快起来快起来")
            } else if distance < 0.7 {
                return say("要倒了，要倒了")
            }
        case .ceiling:
            if distance < 0.25 {
                return say("要撞头了")
            }
        // you can set different range for different types of surfaces
        case .table:
            if distance < 0.4 {
                return say("距离桌子还有\(distance, decimalPlaces: 1)米")
            }
        case .seat:
            if distance < 0.4 {
                return say("距离凳子还有\(distance, decimalPlaces: 1)米")
            }
        case .window:
            if distance < 0.25 {
                return say("距离窗户还有\(distance, decimalPlaces: 1)米")
            }
        case .door:
            if distance < 0.3 {
                return say("距离门还有\(distance, decimalPlaces: 1)米")
            }
        case .none:
            if distance < 0.4 {
                return say("\(distance, decimalPlaces: 1) 米")
            }
        @unknown default:
            break
        }
    }
}
