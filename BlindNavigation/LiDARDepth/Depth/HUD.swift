//
//  HUD.swift
//  LiDARDepth
//
//  Created by Ton on 2023/5/17.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit
import SwiftUI
import ARKit
import RealityKit

struct VoiceChanger: View {
    @ObservedObject
    var voicing: Speaker = .inCharge
    @State
    private var showingVoiceChanger: Bool = false
    var body: some View {
        Button {
            showingVoiceChanger = true
        } label: {
            Text("更改语音样式")
                .padding()
        }
        .actionSheet(isPresented: $showingVoiceChanger) {
            ActionSheet(title: Text("选择声音"), message: nil,
                        buttons: voicing.voices.map { voice in
                            return .default(Text(voice.name)) {
                                voicing.currentVoice = voice
                            }
                        })
        }
    }
}

//HUD显示框
struct HUD: View {
    @ObservedObject
    var dataSource: RealityViewController

    private let formatter = NumberFormatter.withDecimalPlaces(exactly: 2)

    //检测列表
    var distanceList: some View {
        ForEach(ARMeshClassification.allCases, id: \.rawValue) { classification in
            if let pair = dataSource._anchorSummary?.minDistanceToCamera[classification] {
                HStack {
                    Text(classification.description)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(NSNumber(value: pair.inMeters), formatter: formatter) m")
                        .font(.system(.body, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(dataSource.state.colorForDistance(pair.inMeters)))
                }
            }
        }
    }


    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    VoiceChanger()
                    Divider()
                    Button {
                        dataSource.resetARSession()
                    } label: {
                        Text("重置追踪")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .foregroundColor(.primary)
                .fixedSize()
                .background(VisualEffectBlur())
                .cornerRadius(10)
                .padding()
            }
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("附近距离")
                        .font(.title)
                        .padding(.bottom)

                    if dataSource._anchorSummary?.minDistanceToCamera.isEmpty == false {
                        distanceList
                    } else {
                        Text("检测中...")
                    }
                }
                .fixedSize()
                .padding()
                .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
                .cornerRadius(10)
                .padding()
            }
        }
    }
}

