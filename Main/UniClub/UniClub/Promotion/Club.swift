//
//  Club.swift
//  UniClub
//
//  Created by seunghwa on 7/27/25.
//

import Foundation

struct Club: Codable {
    let name: String
    let isRecruiting: Bool
    let room: String
    let leader: String
    let contact: String
    let description: String
    let notice: String
    let recruitPeriod: String
}
