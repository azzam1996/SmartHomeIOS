//
//  TemperatureProgressBar.swift
//  CanvasTest
//
//  Created by Azzam Habib on 3/30/23.
//

import SwiftUI

struct TemperatureProgressBar: View {
    @State var angle: Double = 0.0
    var percentage: Double = 0
    @State var temperatureState: Int = 0
    var temperature: Int = 0
    let maxTemperature: Int
    @State private var busy: Bool = false
    
    init(percentage: Double , temperature: Int, maxTemperature: Int) {
        self.percentage = percentage
        self.temperature = temperature
        self.maxTemperature = maxTemperature
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .stroke(AngularGradient(
                            gradient: Gradient(colors:[ Color.init("yellow"),
                                                        Color.init("Wild"),
                                                        Color.init("Pink"),
                                                        Color.init("Pink"),
                                                        Color.init("Turbo"),
                                                        Color.init("yellow")
                            ]),
                        center: .center
                    ),lineWidth: 20)
                .zIndex(1)
                
            }
            .frame(width: 240,height: 240)
            
            Image(uiImage: UIImage(named: "blur")!)
                .resizable()
                .frame(width: 350,height: 350)
            
            ZStack {
                VStack(alignment: .center) {
                    Text("Temp")
                        .lineLimit(1)
                        .font(.custom("Nunito-SemiBold", size: 17))
                        .foregroundColor(.white)
                    
                   Text(NSString(format:"%@%@",String(temperatureState) , "\u{00B0}") as String)
                    .lineLimit(1)
                    .font(.custom("Nunito-Bold", size: 46))
                    .foregroundColor(.white)
                    
                    Text("celsius")
                        .lineLimit(1)
                        .font(.custom("Nunito-SemiBold", size: 17))
                        .foregroundColor(.white)
                }
                .padding()
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(angle / 360))
                    .stroke(Color.white,style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .zIndex(1)
                    .rotationEffect(Angle(degrees:90))
                
                ProgressBarIndicatorOuterCircle(angle: angle + 90)
                    .fill(Color.init(getOuterCircleColor(angle: (Double(temperatureState) * 360.0 / Double(maxTemperature)))))
                    .zIndex(2)
                    .onAppear() {
                        let animation = Animation.linear(duration: 0.8).delay(0.5)
                        withAnimation(animation){
                            angle = percentage * 360
                        }
                        
                        Timer.animateNumber(number: $temperatureState, busy: $busy, start: 0, end: temperature, duration: 0.8)
                    }
                
                ProgressBarIndicatorInnerCircle(angle: angle + 90)
                    .fill(Color.white)
                    .zIndex(3)
            }
            .frame(width: 240,height: 240)
            
        }
    }
}

struct ProgressBarIndicatorOuterCircle: Shape {
    var angle: Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let endX = cos((angle) * 3.14 / 180) * (120) + 120
        let endy = sin((angle) * 3.14 / 180) * (120) + 120
        var path = Path()
        path.addArc(
            center: CGPoint(x: endX, y: endy),
            radius: 18,
            startAngle: Angle(degrees: 0.0),
            endAngle: Angle(degrees: 360),
            clockwise: false
        )
    
        return path
    }
}

struct ProgressBarIndicatorInnerCircle: Shape {
    var angle: Double
    
    var animatableData: Double{
        get { angle }
        set { angle = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let endX = cos((angle) * 3.14 / 180) * (120) + 120
        let endy = sin((angle) * 3.14 / 180) * (120) + 120
        var path = Path()
        path.addArc(
            center: CGPoint(x: endX, y: endy),
            radius: 12,
            startAngle: Angle(degrees: 0.0),
            endAngle: Angle(degrees: 360),
            clockwise: false
        )
    
        return path
        
    }
}


func getOuterCircleColor(angle: Double) -> String {
    switch angle.truncatingRemainder(dividingBy: 360.0) {
    case 0.0...25.0:  return "pomegranate"
    case 25.0...150.0:  return "brilliant_rose"
    case 150.0...190.0: return "pizazz"
    case 340.0...360.0: return "pomegranate"
    default: return "koromiko"
        }
    }


extension Timer {
    static func animateNumber(number: Binding<Int>, busy: Binding<Bool>, start: Int, end: Int, duration: Double = 1.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            busy.wrappedValue = true
            let startTime = Date()
            Timer.scheduledTimer(withTimeInterval: 1/120, repeats: true) { timer in
                let now = Date()
                let interval = now.timeIntervalSince(startTime)
                if !busy.wrappedValue {
                    timer.invalidate()
                }
                if interval >= duration {
                    number.wrappedValue = end
                    timer.invalidate()
                    busy.wrappedValue = false
                } else {
                    number.wrappedValue = start + Int(Double(end - start)*(interval/duration))
                }
            }
            
        }
    }
}

struct TemperatureProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
