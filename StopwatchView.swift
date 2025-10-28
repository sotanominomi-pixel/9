import SwiftUI

struct StopwatchView: View {
    @Binding var timeSpeed: Double
    @State private var elapsedTime: Double = 0
    @State private var isRunning = false
    @Environment(\.colorScheme) var colorScheme

    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 32) {
            Text(timeString(elapsedTime))
                .font(.system(size: 75, weight: .bold, design: .rounded))
                .foregroundColor(colorScheme == .dark ? .white : .black)

            HStack(spacing: 40) {
                Button(isRunning ? "STOP" : "START") {
                    isRunning.toggle()
                }
                .font(.system(size: 26, weight: .bold))
                .padding(.horizontal, 28)
                .padding(.vertical, 16)
                .background(isRunning ? .red : .green)
                .foregroundColor(.white)
                .cornerRadius(16)

                Button("RESET") {
                    elapsedTime = 0
                }
                .font(.system(size: 26, weight: .bold))
                .padding(.horizontal, 28)
                .padding(.vertical, 16)
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(16)
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                elapsedTime += 0.05 * timeSpeed
            }
        }
    }

    private func timeString(_ time: Double) -> String {
        let sec = Int(time) % 60
        let min = Int(time) / 60 % 60
        let hr = Int(time) / 3600
        return String(format: "%02d:%02d:%02d", hr, min, sec)
    }
}
