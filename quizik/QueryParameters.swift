//
//  QueryParameters.swift
//  quizik
//
//  Created by uvionics on 10/26/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import Foundation

enum Difficulty : String {
    case AnyDifficulty = ""
    case Easy = "easy"
    case Medium = "medium"
    case Hard = "hard"
}

enum Category : String {
    case AnyCategory = ""
    case General_Knowledge = "9"
    case Books = "10"
    case Film = "11"
    case Music = "12"
    case Video_Games = "15"
    case Computer = "18"
    case Sports = "21"
    case Mythology = "20"
    case Animals = "27"
    case Cartoon_and_Animation = "32"
    case Vehicles = "28"
    case Celebrities = "26"
    case History = "23"
    case Geography = "22"
}

enum Type : String {
    case AnyType = ""
    case Multiple_Choice = "multiple"
    case TrueOrFalse = "boolean"
}

