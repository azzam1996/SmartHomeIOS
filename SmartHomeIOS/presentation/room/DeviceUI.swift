//
//  DeviceUI.swift
//  SmartHomeIOS
//
//  Created by Azzam Habib on 3/31/23.
//

import SwiftUI

struct DeviceUI: View {
    let device: Device
    
    init(device: Device){
        self.device = device
    }
    var body: some View {
        VStack {
            VStack{
                ZStack{
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .addBorder(Color.white.opacity(0.6), width: 2, cornerRadius: 20)
                        .opacity(0.2)
                        .frame(width: 56, height: 56, alignment: Alignment.center)
                    
                    Image(uiImage: UIImage(named: device.image)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: Alignment.center)
                }
                
                Spacer()
                
            
                Text(device.title)
                    .font(.custom("Nunito-SemiBold", size: 19))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(TextAlignment.center)
                    .padding(EdgeInsets.init(top: 8, leading: 5, bottom: 0, trailing: 5))
            }
            .padding(.vertical, 30)
            .frame(
                  minWidth: 141,
                  maxWidth: 141,
                  minHeight: 199,
                  maxHeight: 199,
                  alignment: .center
                )
            .background(
                RoundedRectangle(cornerRadius: 36)
                    .fill(LinearGradient(gradient: Gradient.init(colors: [Color.init("valentino"),
                                                                          Color.init("vivid_violet")]),
                                         startPoint: UnitPoint.bottomLeading,
                                        endPoint: UnitPoint.topTrailing)
                    )
            )
        }
        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 20, trailing: 10))
    }
}

struct DeviceUI_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
