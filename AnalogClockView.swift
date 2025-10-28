import SwiftUI

struct AnalogClockView: View {
    @Binding var timeSpeed: Double
    @Environment(\.colorScheme) var colorScheme
    
    private var currentTime: Date {
        return Date().addingTimeInterval((timeSpeed - 1.0) * Date().timeIntervalSinceReferenceDate)
    }

    var body: some View {
        ZStack {
            // 盤面
            Circle()
                .stroke(lineWidth: 8)
                .foregroundColor(colorScheme == .dark ? .white : .black)

            // インデックス（12,3,6,9）
            ForEach([0, 3, 6, 9], id: \.self) { hour in
                let angle = Angle.degrees(Double(hour) / 12.0 * 360)
                VStack {
                    Text(hour == 0 ? "12" : "\(hour)")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .rotationEffect(-angle)
                    Spacer()
                }
                .rotationEffect(angle)
            }

            // 秒針
            ClockHandView(length: 100, width: 2, color: .red, angle: getAngle(Calendar.Component.second))

            // 分針
            ClockHandView(length: 90, width: 4, color: colorScheme == .dark ? .white : .black,
                          angle: getMinuteAngle())

            // 時針
            ClockHandView(length: 70, width: 6, color: colorScheme == .dark ? .white : .black,
                          angle: getHourAngle())

            // 中心のNロゴ
            Text("N")
                .font(.system(size: 28, weight: .black))
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        .padding(20)
    }

    private func getAngle(_ component: Calendar.Component) -> Angle {
        let value = Calendar.current.component(component, from: currentTime)
        let degrees = component == .second ?
            Double(value) * 6 :
            Double(value) * 6
        return Angle.degrees(degrees)
    }

    private func getMinuteAngle() -> Angle {
        let minutes = Calendar.current.component(.minute, from: currentTime)
        let seconds = Calendar.current.component(.second, from: currentTime)
        return Angle.degrees(Double(minutes) * 6 + Double(seconds) * 0.1)
    }

    private func getHourAngle() -> Angle {
        let hour = Calendar.current.component(.hour, from: currentTime) % 12
        let minute = Calendar.current.component(.minute, from: currentTime)
        return Angle.degrees(Double(hour) * 30 + Double(minute) * 0.5)
    }
}

struct ClockHandView: View {
    var length: CGFloat
    var width: CGFloat
    var color: Color
    var angle: Angle

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: length)
            .offset(y: -length / 2)
            .rotationEffect(angle)
    }
}
