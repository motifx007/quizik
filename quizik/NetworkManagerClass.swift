//
//  NetworkManager.swift
//  quizik
//
//  Created by uvionics on 10/23/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import Foundation

class NetworkManagerClass{
    func fetchQuizBloc(completionHandler: @escaping ([Results]) -> Void) {
      let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!

      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching quiz data: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(response)")
          return
        }

        if let data = data,
          let openTriviaResponse = try? JSONDecoder().decode(OpenTriviaResponse.self, from: data) {
            completionHandler(openTriviaResponse.results ?? [])
        }
      })
      task.resume()
    }
}
