//
//  RoomUI.swift
//  CanvasTest
//
//  Created by Azzam Habib on 3/30/23.
//

import SwiftUI

struct RoomUI: View {
    let room: Room
    var body: some View {
        VStack {
            VStack{
                ZStack{
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .addBorder(Color.white.opacity(0.6), width: 2, cornerRadius: 20)
                        .opacity(0.2)
                        .frame(width: 56, height: 56, alignment: Alignment.center)
                    
                    Image(uiImage: UIImage(named: room.image)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: Alignment.center)
                }
            
                Text(room.title)
                    .font(.custom("Nunito-SemiBold", size: 17))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(TextAlignment.center)
                    .padding(.top, 8)
                
                Text(String(room.devices.count)+" Devices")
                    .font(.custom("Nunito-Regular", size: 13))
                    .multilineTextAlignment(TextAlignment.center)
                    .foregroundColor(Color.white)
            }
            .padding(.all, 20)
            .frame(
                  minWidth: 150,
                  maxWidth: .infinity,
                  minHeight: 150,
                  maxHeight: .infinity,
                  alignment: .center
                )
            .background(
                RoundedRectangle(cornerRadius: 36)
                    .fill(
                        LinearGradient(
                            gradient: Gradient.init(
                                colors: [
                                    Color.init("valentino"),
                                    Color.init("vivid_violet")]
                            ),
                            startPoint: UnitPoint.bottomLeading,
                            endPoint: UnitPoint.topTrailing
                        )
                    )
            )
        }
        .padding(.horizontal, 5)

    }
}

struct RoomUI_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
