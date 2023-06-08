/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app's main user interface.
*/

import SwiftUI

enum FunctionMode {
    case DepthMode
    case DetectorMode
}

struct ContentView: View {
    
//    var speakMode: String {
//        switch FunctionMode {
//        case .DepthMode:
//            return "距离检测模块"
//        case .DetectorMode:
//            return "目标检测模块"
//        }
//    }
    @State var isDetectorMode: Bool = false
    
    var body: some View {
        if !isDetectorMode {
            DepthView()
                .overlay {
                    VStack {
                        Spacer()
                        Button {
                            isDetectorMode.toggle()
                            say("更改为目标检测模式")
                        } label: {
                            Text("目标检测模式")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .foregroundColor(.primary)
                        .background(VisualEffectBlur())
                        .cornerRadius(10)
                        .padding()
                    }
                    
                }
        } else {
            DetectorView()
                .overlay {
                    VStack {
                        Spacer()
                        Button {
                            isDetectorMode.toggle()
                            say("更改为距离检测模式")
                        } label: {
                            Text("距离检测模式")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .foregroundColor(.primary)
                        .background(VisualEffectBlur())
                        .cornerRadius(10)
                        .padding()
                    }
                }
        }
    }
}

