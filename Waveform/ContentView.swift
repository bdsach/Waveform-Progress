//
//  ContentView.swift
//  Waveform
//
//  Created by Bandit Silachai on 16/1/24.
//
import SwiftUI
import DSWaveformImage
import DSWaveformImageViews

struct ContentView: View {
    @State var progress: Double = 0.4
    var audioURL: URL? = Bundle.main.url(forResource: "example_sound", withExtension: "m4a")
    
    var waveBackConfig: Waveform.Configuration = Waveform.Configuration(
        style: .striped(Waveform.Style.StripeConfig(color: .systemRed.withAlphaComponent(0.4), width: 4, lineCap: .round)))
    var waveFrontConfig: Waveform.Configuration = Waveform.Configuration(
        style: .striped(Waveform.Style.StripeConfig(color: .systemRed, width: 4, lineCap: .round)))
    
    var formattedPercent: String {
        let result = Int(progress * 100)
        return "\(result)%"
    }
    
    var body: some View {
        VStack {
            Text(formattedPercent)
                .font(.largeTitle.bold())
            ZStack {
                WaveformView(audioURL: audioURL!,configuration: waveBackConfig, priority: .high)
                WaveformView(audioURL: audioURL!, configuration: waveFrontConfig, priority: .high)
                    .mask(alignment: .leading) {
                        GeometryReader { geometry in
                            Rectangle().frame(width: geometry.size.width * progress)
                        }
                    }
            }
            .frame(height: 80)
            .padding()
            Button(action: {
                withAnimation {
                    self.progress = Double.random(in: 0...1)
                }
            }, label: {
                Text("Random")
            })
        }
        .padding(.vertical, 20)
    }
}

struct SwiftUIExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

