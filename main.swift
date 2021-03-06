// #!/usr/bin/swift
//
//  main.swift
//  PatreonScan
//
//  Created by Le Zeng on 2019/11/13.
//  Copyright © 2019 Le Zeng. All rights reserved.
//
// References:
// 1. HTTP request
// https://dev.to/mishimay/swift-minimum-getpost-request-codes-1085
// 2. Runloop:
// https://alejandromp.com/blog/2019/01/19/a-runloop-for-your-swift-script/

import Foundation

// The Patron Page for Materialize CSS is:
// https://www.patreon.com/bePatron?u=8327028
// Original range from 8327000 to 8327500...

let begin = 8324000
let end = 8329500
print("The Patron Page for Materialize CSS is: https://www.patreon.com/bePatron?u=8327028")
print("Let's scan for valide pages from id \(begin) to \(end)...")
print("")

var count = 0
for i in begin..<end {
    var urlComponents = URLComponents(string: "https://www.patreon.com/bePatron?")!
    urlComponents.queryItems = [
        URLQueryItem(name: "u", value: "\(i)"),
    ]

    let url = urlComponents.url!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("\(url.absoluteString), error: \(error)")
        } else {
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 && data!.count < 100000 {
//                    print("\(url.absoluteString), statusCode: \(response.statusCode), length: \(data!.count)")
                    print("\(url.absoluteString)")
                    count += 1
                }
            }
        }
        
        URLSession.shared.getAllTasks { tasks in
            if tasks.count == 0 {
                print("")
                print("Total count: \(count)")
                exit(EXIT_SUCCESS)
            }
        }
    }
    task.resume()
}

RunLoop.main.run()
