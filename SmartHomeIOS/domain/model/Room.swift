//
//  Room.swift
//  SmartHomeIOS
//
//  Created by Azzam Habib on 4/2/23.
//

import Foundation

struct Room: Identifiable {
    var id: Int
    var title: String
    var image: String
    var devices:[Device]
    var temperature: Int
    var maxTemperature: Int
    var minTemperature: Int
}
