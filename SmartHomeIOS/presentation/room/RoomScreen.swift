//
//  RoomScreen.swift
//  CanvasTest
//
//  Created by Azzam Habib on 3/30/23.
//

import SwiftUI
import Foundation


struct RoomScreen: View {
    let room: Room
    @State var selectedIndex: Int = 0
    @State var isOn: Bool = false
    let switchItems = [
        SwitchModel(id: 1, title: "TEMP", image: "ic_weather"),
        SwitchModel(id: 2, title: "FAN", image: "ic_fan"),
        SwitchModel(id: 3, title: "MODE", image: "ic_settings")
    ]
    
    @Environment(\.presentationMode) var presentation
    
    init(room: Room){
        self.room = room
    }
    var body: some View {
        ZStack{
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient.init(colors: [
                                                    Color.init("eminence"),
                                                    Color.init("valentino"),
                                                    Color.init("valentino_1")]
                        ),
                        startPoint: UnitPoint.bottom,
                        endPoint: UnitPoint.top)
                )
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        VStack {
            ZStack{
                HStack {
                    
                    Button {
                        self.presentation.wrappedValue.dismiss()
                    } label: {
                        Image(uiImage: UIImage(named: "ic_back")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 27,height: 17)
                    }
                    
                    Spacer()
                }
                .padding(EdgeInsets.init(top: 58, leading: 36, bottom: 0, trailing: 0))
                
                HStack {
                    Text(room.title)
                        .font(.custom("Nunito-Bold",size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                }
                .padding(EdgeInsets.init(top: 58, leading: 65, bottom: 0, trailing: 65))
            }
            
            ScrollView {
                ZStack{
                    TemperatureProgressBar(percentage: Double(room.temperature) / Double(room.maxTemperature), temperature: room.temperature, maxTemperature: room.maxTemperature)
                        .frame(height: 300,alignment: .center)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Toggle(isOn: $isOn){
                            }
                            .toggleStyle(SpinnerStyle())
                        }
                        Spacer()
                    }
                    .frame(width: 300,height: 300,alignment: .center)

                    VStack {
                        Spacer()
                        
                        HStack {
                            Text(NSString(format:"%@%@",String(room.minTemperature), "\u{00B0}") as String)
                                .font(.custom("Nunito-Bold",size: 20))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color.white)
                                .frame(maxHeight: 80)
                            
                            Spacer(minLength: 150)
                            
                            Text(NSString(format:"%@%@",String(room.maxTemperature), "\u{00B0}") as String)
                                .font(.custom("Nunito-Bold",size: 20))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color.white)
                                .frame(maxHeight: 80)
                        }
                    }
                    .frame(width: 300,alignment: .center)
                }
                .frame(height: 380)
                
                
                ZStack {
                    SegmentedPicker(
                        switchItems,
                        selectedIndex: Binding(
                            get: { selectedIndex },
                            set: { selectedIndex = $0 ?? 0 }),
                        content: { item, isSelected in
                            
                            VStack{
                                Image(uiImage: UIImage(named: item.image)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18, alignment: Alignment.center)
                                    .padding(.top, 7)
                                Text(item.title)
                                    .foregroundColor(Color.white)
                                    .font(.custom("Nunito-SemiBold", size: 12))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  alignment: .center
                                )
                            .padding(.bottom, 5)
                        },
                        selection: {
                            Capsule()
                                .fill(LinearGradient(
                                        gradient: Gradient.init(colors: [
                                                                    Color.init("brink_pink"),
                                                                    Color.init("mustard")]),
                                        startPoint: UnitPoint.leading,
                                        endPoint: UnitPoint.trailing)
                                )
                        })
                        .animation(.easeInOut(duration: 0.3))
                        .frame(
                              minWidth: 0,
                              maxWidth: .infinity,
                              alignment: .center
                            )
                        .padding(2)
                        .background(
                            RoundedRectangle(cornerRadius: 36)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient.init(colors: [
                                                                    Color.init("eminence"),
                                                                    Color.init("valentino"),
                                                                    Color.init("valentino_1")]
                                        ),
                                        startPoint: UnitPoint.bottomLeading,
                                        endPoint: UnitPoint.topTrailing)
                                )
                        )
                }
                .padding(.horizontal, 40)
                
                HStack {
                    Text("Devices")
                        .foregroundColor(Color.white)
                        .font(.custom("Nunito-Bold", size: 20))
                        .padding(EdgeInsets.init(top: 30, leading: 36, bottom: 0, trailing: 0))

                    Spacer()
                }
                
                ScrollView(.horizontal){
                    LazyHStack {
                        ForEach(room.devices) {device in
                            DeviceUI(device: device)
                        }
                    }
                    .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 220,
                          maxHeight: 220,
                          alignment: .topLeading
                        )
                }
                .padding(EdgeInsets.init(top: 20, leading: 26, bottom: 0, trailing: 0))
            }
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .top
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SpinnerStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            if(configuration.isOn){
                Spacer()
                Circle()
                    .fill(LinearGradient(gradient: Gradient.init(colors: [ Color.init("brink_pink"),
                                                                           Color.init("mustard")]),
                                         startPoint: UnitPoint.leading,
                                         endPoint: UnitPoint.trailing))
                .frame(width: 22, height: 22)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            configuration.isOn.toggle()
                        }
                    }
            }
            else{
                Circle()
                    .fill(Color.white)
                .frame(width: 22, height: 22)
                    .onTapGesture {
                        withAnimation(.linear){
                            configuration.isOn.toggle()
                        }
                    }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .padding(.all, 2)
        .frame(width: 45, height: 25, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 36)
                .fill(
                    LinearGradient(gradient: Gradient.init(colors: [
                                                                    Color.init("valentino"),
                                                                    Color.init("vivid_violet")]
                                        ),
                    startPoint: UnitPoint.bottomLeading,
                    endPoint: UnitPoint.topTrailing)
                )
        )
    }
    
}


struct RoomScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
