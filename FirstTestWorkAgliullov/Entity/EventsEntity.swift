//
//  EventsEntity.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 27.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

struct PhoneNumberCollection: Codable {
    let number: [String]
}

struct ImageEventCollection: Codable {
    let imageName: [String]
}

struct LikesImageNames: Codable {
    let imageName: [String]
}

struct DetailsInfo: Codable {
    let organizationName: String
    let eventAddress: String
    let eventPhoneNumber: PhoneNumberCollection
    let serviceLabel: String
    let topLinkLabel: String
    let imageCollection: ImageEventCollection
    let centerDescriptionLabel: String
    let bottomDescriptionLabel: String
    let bottomLinkLabel: String
    let likesImagesNames: LikesImageNames
    let likesCountLabel: String
}

struct EventsEntity: Codable {
    let id: Int64
    
    let eventTitle: String
    let eventImageView: String
    let topDescriptionLabel: String
    let timeLabel: String
    let detailsInfo: DetailsInfo
}
