//
//  DataFetching.swift
//  quizik
//
//  Created by uvionics on 10/4/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import Foundation

class NetworkManager{
    func networkFunction(){
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: "https://opentdb.com/api.php?amount=10")!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
        })
        task.resume()
        
    }
    
}
