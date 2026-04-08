//
//  ContentView.swift
//  BipTheGuy
//
//  Created by BARRALES, ROXY on 4/8/26.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var auidoPlayer: AVAudioPlayer!
    var body: some View {
        VStack {
            
            Spacer()
            Image("clown")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    playSound(soundName: "punchSound")
                }
            Spacer()
           
            Button {
                //TODO: Button action here :3
            } label: {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }
            .buttonStyle(.borderedProminent)


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

struct ContentView_Previews:PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
