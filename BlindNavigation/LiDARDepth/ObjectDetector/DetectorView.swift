//
//  DetectorView.swift
//  LiDARDepth
//
//  Created by Ton on 2023/5/20.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit
import SwiftUI

struct DetectorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ViewController {
        let view = ViewController()
        view.setupAVCapture()
        view.setupLayers()
        view.updateLayerGeometry()
        view.setupVision()
        view.startCaptureSession()
        return view
    }
    
    func updateUIView(_ uiView: ViewController, context: Context) {
        
    }
}
