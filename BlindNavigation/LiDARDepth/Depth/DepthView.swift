//
//  LiveViewSupport.swift
//  LiDARDepth
//
//  Created by Ton on 2023/5/17.
//  Copyright © 2023 Apple. All rights reserved.
//

import ARKit
import UIKit
import SwiftUI
import RealityKit


public func _getRealWorldView(
    withDistanceMap showMesh: Bool = true,
    withDistanceMeasurement showDistance: Bool = true,
    onReceiveDistanceUpdate processDistance: ((Float) -> Void)? = nil,
    onReceiveCategorizedDistanceUpdate processCategorizedDistances: (([ARMeshClassification: Float]) -> Void)? = nil,
    markerForNearestPoint: @escaping () -> AnchorEntity = { AnchorEntity() }
) -> RealityViewController {
    let viewController = RealityViewController()
    viewController.state = .init(
        showMesh: showMesh,
        showDistance: showDistance,
        didReceiveDistanceFromCameraToPointInWorldAtCenterOfView: processDistance,
        didReceiveMinDistanceFromCamera: processCategorizedDistances,
        anchorEntityForMinDistanceFromCamera: markerForNearestPoint
    )
    return viewController
}

//将ViewController封装为swiftUI中的view
struct DepthView: UIViewControllerRepresentable {
    let processDIstance: ((Float) -> Void)? = nil
    let processCategorizedDistance: (([ARMeshClassification: Float]) -> Void)? = nil
    
    func makeUIViewController(context: Context) -> RealityViewController {
        //case 1：检查周围环境中的所有表面并对其进行分类，检测中间点，并播报距离信息
        _getRealWorldView(
            withDistanceMap: true,
            withDistanceMeasurement: true,
            onReceiveCategorizedDistanceUpdate: handleDistances
        )
        
        //case 2：锚定到最近的点并持续追踪这个点的位置，并通过空间音频播放
//        _getRealWorldView(
//            withDistanceMap: false,
//            withDistanceMeasurement: true,
//            onReceiveCategorizedDistanceUpdate: handleDistances,
//            markerForNearestPoint: {
//                let marker = AnchorEntity()
//                let model = try! Experience.loadPin().pin!
//                marker.addChild(model)
//                let audio = try! AudioFileResource
//                    .load(named: "Clock Cartoon.caf",
//                          inputMode: .spatial,
//                          shouldLoop: true)
//                marker.playAudio(audio)
//                return marker
//            }
//        )
        
        //case 3：空间音频
//        _getRealWorldView(
//            withDistanceMap: false,
//            withDistanceMeasurement: true,
//            markerForNearestPoint: {
//                let marker = AnchorEntity()
//                marker.name = ._backgroundMusicAnchorName
//                let audio = try! AudioFileResource
//                    .load(named: "Afloat Pad.caf",
//                          inputMode: .nonSpatial,
//                          shouldLoop: true)
//                marker.playAudio(audio)
//                return marker
//            }
//        )
        
        //case 4：仅测距，根据距离值提示相关信息
//        _getRealWorldView(
//            withDistanceMap: false,
//            withDistanceMeasurement: true,
//            onReceiveDistanceUpdate: { distance in
//                switch distance {
//                case ..<0.5:
//                    say("小心")
//                case ..<2:
//                    say("\(distance, decimalPlaces: 1) 米")
//                default:
//                    say("\(distance, decimalPlaces: 1) 米")
//                }
//            }
//        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
