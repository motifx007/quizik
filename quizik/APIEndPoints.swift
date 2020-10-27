//
//  APIEndPoints.swift
//  quizik
//
//  Created by uvionics on 10/26/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import Foundation

let url = "https://opentdb.com/api.php?"
let correct_url = "https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple"

//Using a Session Token:
let using_ssession_token = "https://opentdb.com/api.php?amount=10&token=YOURTOKENHERE"

//Retrieve a Session Token:
let retrieve_session_token = "https://opentdb.com/api_token.php?command=request"

//Reset a Session Token:
let reset_session_toke = "https://opentdb.com/api_token.php?command=reset&token=YOURTOKENHERE"
