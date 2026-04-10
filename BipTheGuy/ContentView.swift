//
//  ContentView.swift
//  BipTheGuy
//
//  Created by BARRALES, ROXY on 4/8/26.
//

import SwiftUI
import AVFAudio
import PhotosUI

struct ContentView: View {
    
    @State private var auidoPlayer: AVAudioPlayer!
    @State private var scale = 1.0 //100% scale / og size
    @State private var isFullSize = true
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var bipImage = Image("clown")
    
    var body: some View {
        VStack {
            
            Spacer()
            
            bipImage
                .resizable()
                .scaledToFit()
                .scaleEffect(isFullSize ? 1.0 : 0.9)//scale
            //plays the sound effect
                .onTapGesture {
                    playSound(soundName: "punchSound")
                  //  scale = scale + 0.1
                    isFullSize = false
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                        isFullSize = true
                    }
                }
                //.animation(.spring(response: 0.3, dampingFraction: 0.15), value: scale)
            
            Spacer()
           
            PhotosPicker(selection: $selectedPhoto, matching:.images, preferredItemEncoding: .automatic) {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }
            .buttonStyle(.borderedProminent)
            .onChange(of: selectedPhoto) {
                Task{
                    guard let selectedImage = try? await selectedPhoto?.loadTransferable(type: Image.self) else {
                        print("ERROR: COULD NOT GET IMAGE FROM LOADTRANSDERRABLE")
                        return
                    }
                    bipImage = selectedImage
                }
            }


        }
        .padding()
    }
    
    func playSound(soundName: String){
        
        if auidoPlayer != nil && auidoPlayer.isPlaying{
            auidoPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print (" ={ Could not read file \(soundName) ")
            return
        }
                        
        do{
            auidoPlayer = try AVAudioPlayer(data: soundFile.data)
            auidoPlayer.play()
        }catch{
            print (" ={ Error: \(error.localizedDescription) creating audioPlayer")                }
    }
    
}

#Preview {
    ContentView()
}

/*struct ContentView_Previews:PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
*/
