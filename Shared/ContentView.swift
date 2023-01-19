//
//  ContentView.swift
//  Shared
//
//  Created by Delta on 24/5/22.
//  Edited by Astra on 1/8/23.
//

import AVFoundation
import SwiftUI

var swipePreview = true;
var chosenColor = 1.0;

struct ContentView: View {
    var body: some View {
        CameraView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CameraView: View{
    @State private var filtersPreview = [
        FilterModel(filter: .circle, isPreview: true, color: chosenColor),
        FilterModel(filter: .rectangle, isPreview: true, color: abs(chosenColor - 1.0)),
        FilterModel(filter: .lines, isPreview: true, color: abs(chosenColor - 1.0)),
        FilterModel(filter: .start, isPreview: true, color: chosenColor),
        FilterModel(filter: .horizontal, isPreview: true, color: abs(chosenColor - 1.0))
    ]
    @StateObject var camera = CameraModel()
    @StateObject var viewModel = ViewModel()
    var body: some View{
        let _ = print("test")
        GeometryReader { geometry in
            VStack{
                ZStack(alignment: .center){
                    CameraPreview(camera: camera).ignoresSafeArea(.all, edges: .all
                    ).frame(width: geometry.size.width, alignment: .center)
                    // this code adds the filter
                    if (swipePreview) {
                        Filter(data: FilterModel(filter: viewModel.indexFilter, isPreview: false, color: chosenColor))
                            .clipped()
                    }
                }.onAppear {
                    camera.Check()
                }.frame(width: geometry.size.width, height: geometry.size.height / 1.4, alignment: .center).clipped()
                ScrollView(.horizontal, showsIndicators: false) {
                  HStack {
                      ForEach(filtersPreview,id: \.filter) { filterPreview in
                        Filter(data: filterPreview).environmentObject(viewModel).frame(width: Constant.sizeWidthPreview, alignment: .center)
                            .clipped()
                      Divider()
                    }
                  }
                }.frame(height: Constant.sizeWidthPreview)
                .background(Color.gray)
                HStack(alignment: .center) {
                    Button(action: {
                        if chosenColor == 1.0 {
                            chosenColor = 0.0
                        } else {
                            chosenColor = 1.0
                        }
                    }) {
                        Text("Color Toggle")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.pink)
                    }
                    Button(action: {
                        swipePreview.toggle()
                    }) {
                        Text("Show/Hide Toggle")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.pink)
                    }
                }
            }
        }
    }
}

struct TakePictureButton: View {
    var isTaken: Bool
    var body: some View {
        VStack{
            HStack{
                if isTaken {
                    Button(action: {
                        playSound(sound: "mixkit-camera-shutter-click-1133", type: "wav")
                    }, label: {
                    
                    })
                }else{
                    Button(action: {
                        playSound(sound: "mixkit-camera-shutter-click-1133", type: "wav")
                    }, label:
                        {
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65, alignment: .center)
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75, alignment: .center)
                            }
                    })
                }
            }
        }
    }
}

//camera model

class CameraModel: ObservableObject{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp(){
        do{
            self.session.beginConfiguration()
            
            //let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            
            guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            //checking and adding to session
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            //same for output
            
            if self.session.canAddOutput(output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
        }catch{
            print(error.localizedDescription)
        }
    }
}

// setting view for preview

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
    
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        DispatchQueue.main.async {
            camera.session.startRunning()
        }
        //starting session
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

func playSound(sound: String, type: String) {
    var audioPlayer: AVAudioPlayer?
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: path) as URL)
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}
