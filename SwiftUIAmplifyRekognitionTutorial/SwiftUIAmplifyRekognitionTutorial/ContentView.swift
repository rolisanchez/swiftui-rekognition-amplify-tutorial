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
    @State var chosenImage: Image?

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
                .frame(width: 375, height: 500)
                .scaledToFit()
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
        guard let inputImage = inputImage else { return }
        chosenImage = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
