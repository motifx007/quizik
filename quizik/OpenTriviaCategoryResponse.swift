//
//  OpenTriviaCategoryResponse.swift
//  quizik
//
//  Created by uvionics on 10/29/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import Foundation
struct OpenTriviaCategoryResponse : Codable {
    let trivia_categories : [Trivia_categories]?

    enum CodingKeys: String, CodingKey {

        case trivia_categories = "trivia_categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trivia_categories = try values.decodeIfPresent([Trivia_categories].self, forKey: .trivia_categories)
    }

}

struct Trivia_categories : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
