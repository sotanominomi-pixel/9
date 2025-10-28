import SwiftUI

struct ContentView: View {
    @State private var timeSpeed: Double = 1.0
    @State private var selectedTab: Int = 0 
    
    var body: some View {
        VStack(spacing: 24) {
            
            Picker("Mode", selection: $selectedTab) {
                Text("時計").tag(0)
                Text("ストップウォッチ").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            if selectedTab == 0 {
                AnalogClockView(timeSpeed: $timeSpeed)
                    .frame(width: 300, height: 300)
            } else {
                StopwatchView(timeSpeed: $timeSpeed)
            }

            // 速度変更スライダー
            VStack {
                Text("1日の時間: \(Int(24 / timeSpeed)) 時間")
                    .font(.system(size: 18))

                Slider(value: $timeSpeed, in: 0.5...2.0, step: 0.05)
                    .padding(.horizontal, 50)
            }
            .padding(.bottom, 40)
        }
    }
}
