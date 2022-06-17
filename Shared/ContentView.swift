//
//  ContentView.swift
//  Shared
//
//  Created by Delta on 24/5/22.
//

import AVFoundation
import SwiftUI

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
        FilterModel(index: 0, isPreview: true),
        FilterModel(index: 1, isPreview: true),
        FilterModel(index: 2, isPreview: true),
        FilterModel(index: 3, isPreview: true)
    ]
    @StateObject var camera = CameraModel()
    @StateObject var viewModel = ViewModel()
    var body: some View{
        VStack{
            ZStack{
                CameraPreview(camera: camera).ignoresSafeArea(.all, edges: .all
                )
                Filter(data: FilterModel(index: viewModel.indexFilter, isPreview: false)).ignoresSafeArea(.all, edges: .all
                )
            }.onAppear {
                camera.Check()
            }.frame(maxHeight: 800).clipped()
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(filtersPreview,id: \.index) { filterPreview in
                    Filter(data: filterPreview).environmentObject(viewModel)
                  Divider()
                }
              }
            }.background(Color.gray)
        }
    }
}

struct TakePictureButton: View {
    var isTaken: Bool
    var body: some View {
        VStack{
            HStack{
                if isTaken {
                    Button(action: {}, label: {
                        //todo
                    })
                }else{
                    Button(action: {
                        //todo
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

struct Filter: View {
    @EnvironmentObject var viewModel : ViewModel
    var data: FilterModel
    let scalePreview = 20
    let scaleCamera = 100
    var body: some View {
            Button {
                if data.isPreview {
                    viewModel.indexFilter = data.index
                }
            } label: {
                switch data.index {
                case 0:
                    Filter1(scale: data.isPreview ? scalePreview : scaleCamera)
                case 1:
                    Filter2(scale: data.isPreview ? scalePreview : scaleCamera)
                case 2:
                    Filter3(scale: data.isPreview ? scalePreview : scaleCamera)
                case 3:
                    Filter4(scale: data.isPreview ? scalePreview : scaleCamera)
                default:
                    Filter1(scale: data.isPreview ? scalePreview : scaleCamera)
                }
            }.frame(width: data.isPreview ? 150 : .infinity, height: data.isPreview ? 150 : .infinity).clipped()
        
    }
}

struct Filter1: View{
    var scale: Int
    var body: some View{
        ZStack {
            ForEach(0..<scale) { i in
                let space = i * 10
                Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: CGFloat(space), height: CGFloat(space), alignment: .center)
                }
        }
    }
}

struct Filter2: View{
    var scale: Int
    var body: some View{
        ZStack {
            ForEach(0..<scale) { i in
                Rectangle()
                    .stroke(Color.white, lineWidth: 2).frame(width: CGFloat(10 * i), height: CGFloat(10 * i), alignment: .center)
            }
        }
    }
}

struct Filter3: View{
    var scale: Int
    var body: some View{
        HStack{
            ForEach(0..<scale) { i in
                    Rectangle()
                    .fill(.white)
                    .frame(width: 1, height: 1000)
                    .edgesIgnoringSafeArea(.vertical)
                }
            
        }
    }
}

struct Filter4: View{
    var scale: Int
    var body: some View{
        ZStack{
            Rectangle()
                .stroke(Color.white, lineWidth: 2).frame(width: .infinity, height: .infinity, alignment: .center)
            ForEach(0..<scale * 5) { i in
                Rectangle()
                    .fill(.white)
                    .frame(width: 2, height: 1000)
                    .rotationEffect(Angle(degrees: Double(90 + (i * 5)) ))
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
            
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
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


