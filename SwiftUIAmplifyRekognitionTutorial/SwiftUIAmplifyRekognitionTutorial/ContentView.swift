//
//  ContentView.swift
//  SwiftUIAmplifyRekognitionTutorial
//
//  Created by Victor Rolando Sanchez Jara on 12/1/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        ZStack {
            Color.secondary
            VStack {
                Text("Rekognition Demo")
                    .foregroundColor(.primary)
                    .padding()
                Button(action: { self.showingImagePicker.toggle() },
                       label: {
                        Text("Click here to pick image")
                       })
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
