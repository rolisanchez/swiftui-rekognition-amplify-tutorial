//
//  ContentView.swift
//  SwiftUIAmplifyRekognitionTutorial
//
//  Created by Victor Rolando Sanchez Jara on 12/1/20.
//

import SwiftUI
import Amplify

struct ContentView: View {
    // MARK: Properties
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var chosenImage: Image?
    @State var labels: [String]?

    var body: some View {
        VStack {
            Text("Rekognition Demo")
                .padding()
            Button(action: { self.showingImagePicker.toggle() },
                   label: {
                    Text("Click here to pick image")
                   }
            )
            chosenImage?
                .resizable()
                .frame(width: 250, height: 200)
                .scaledToFit()
            if labels != nil {
                Text("Recognized labels list:")
                List(labels!, id: \.self) { label in
                    Text(label)
                }
                .frame(height: 200)
            }

        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.bottom)
                ImagePicker(image: self.$inputImage)
            }
        }
    }

    // MARK: Methods
    func loadImage() {
        print("Loading image..")
        labels = nil
        guard let inputImage = inputImage else { return }
        chosenImage = Image(uiImage: inputImage)
        // Compress image for faster upload to cloud
        let imageData = inputImage.jpegData(compressionQuality: 0.1)!
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename =  paths[0].appendingPathComponent("unlabeled.jpeg")
        try? imageData.write(to: filename)
        detectLabels(filename)
    }

    func detectLabels(_ image: URL) {
        Amplify.Predictions.identify(type: .detectLabels(.labels), image: image) { event in
            switch event {
            case let .success(result):
                if let data = result as? IdentifyLabelsResult {
                    let sortedLabels = data.labels.sorted { $0.metadata!.confidence > $1.metadata!.confidence }
                    let labels: [String] = sortedLabels.map {
                        $0.name + " (confidence: " + String($0.metadata!.confidence) + ")"
                    }
                    self.labels = labels
                }

            case let .failure(error):
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
