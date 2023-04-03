//
//  HomeScreen.swift
//  CanvasTest
//
//  Created by Azzam Habib on 3/30/23.
//

import SwiftUI
import Foundation

struct HomeScreen: View {

    let rooms: [Room]
    @State var isRoomSelected = false
    @State var selectedRoom: Room = Room(id: 1, title: "Living Room", image: "ic_living_room",devices: [], temperature: 24, maxTemperature:30,minTemperature: 10)
    
    init() {
        let devices1: [Device] = [Device(id: 1,title: "Light", image: "ic_light"),
                   Device(id: 2, title: "Smart TV", image: "ic_tv"),
                   Device(id: 3, title: "Fridge", image: "ic_kitchen")]
        
        let devices2: [Device] = [Device(id: 1,title: "Couch", image: "ic_living_room"),
                   Device(id: 2, title: "Light", image: "ic_light"),
                   Device(id: 3, title: "Smart TV", image: "ic_tv"),
                   Device(id: 4, title: "Fridge", image: "ic_kitchen")]
        
        let devices3: [Device] = [Device(id: 1,title: "Light", image: "ic_light"),
                   Device(id: 2, title: "Smart TV", image: "ic_tv")]
        
        rooms = [
            Room(id: 1, title: "Living Room", image: "ic_living_room",devices: devices2, temperature: 24, maxTemperature:30,minTemperature: 10),
            Room(id: 2, title: "Kitchen", image: "ic_kitchen", devices: devices1, temperature: 14, maxTemperature: 20, minTemperature: 10),
            Room(id: 3, title: "Study Room", image: "ic_study_room",devices: devices3, temperature: 714, maxTemperature: 1000, minTemperature: 120),
            Room(id: 4, title: "Garage", image: "ic_garage",devices: devices1, temperature: 33, maxTemperature: 50, minTemperature: 10),
            Room(id: 5, title: "Bathroom", image: "ic_bathroom", devices: devices2,temperature: 240, maxTemperature: 250, minTemperature: 10),
            Room(id: 6, title: "Dining Room", image: "ic_dining_room",devices: devices1, temperature: 4, maxTemperature: 30, minTemperature: 0)]
    }
    var body: some View {
        
        ZStack {
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
                NavigationLink("", destination: RoomScreen(room: selectedRoom), isActive:$isRoomSelected)
                HStack{
                    Image(uiImage: UIImage(named: "ic_hamburger")!)
                            .resizable()
                        .frame(width: 24, height: 16)
                        .padding(EdgeInsets.init(top: 35, leading: 36, bottom: 0, trailing: 5))
                    
                    Spacer()
                    
                        Circle()
                            .fill(LinearGradient(
                                    gradient: Gradient.init(colors: [
                                                                Color.init("brink_pink"),
                                                                Color.init("mustard")]),
                                    startPoint: UnitPoint.leading,
                                    endPoint: UnitPoint.trailing)
                            )
                        .frame(width: 48, height: 48)
                        .padding(EdgeInsets.init(top: 22, leading: 5, bottom: 0, trailing: 36))
                    
                }
                
                HStack {
                    Text("Hi Dee")
                        .font(.custom("Nunito-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding(EdgeInsets.init(top: 30, leading: 36, bottom: 0, trailing: 5))
                    
                    Spacer()
                }
                
                HStack {
                    Text("Welcome to")
                        .font(.custom("Nunito-Regular", size: 24))
                        .foregroundColor(.white)
                        .padding(EdgeInsets.init(top: 0, leading: 36, bottom: 0, trailing: 5))
                    
                    Text("Dee Home")
                        .font(.custom("Nunito-Bold", size: 24))
                        .foregroundColor(.white)
                        .bold()
                        .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 5))
                    
                    Spacer()
                }
                
                HStack {
                    Text("Your Rooms")
                        .font(.custom("Nunito-Bold", size: 24))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        Text("Add")
                            .font(.custom("Nunito-Bold", size: 13))
                            .foregroundColor(.white)
                            .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 12))
                        
                        Image(uiImage: UIImage(named: "ic_plus")!)
                                .resizable()
                            .frame(width: 17, height: 17)
                    }
                    .padding(EdgeInsets.init(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .background(
                        RoundedRectangle(cornerRadius: 36)
                            .fill( LinearGradient(
                                        gradient: Gradient.init(colors: [
                                                                    Color.init("brink_pink"),
                                                                    Color.init("mustard")]),
                                        startPoint: UnitPoint.leading,
                                        endPoint: UnitPoint.trailing)
                            )
                    )
                    
                }
                .padding(EdgeInsets.init(top: 48, leading: 36, bottom: 0, trailing: 36))
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 20) {
                        ForEach(self.rooms) { item  in
                            Button {
                                self.isRoomSelected = true
                                self.selectedRoom = item
                            } label: {
                                RoomUI(room: item)
                            }

                        }
                    }
                    .padding(EdgeInsets.init(top: 20, leading: 26, bottom: 0, trailing: 26))
                }

            
            
            }
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .top
            )
        .edgesIgnoringSafeArea(.all)

    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
