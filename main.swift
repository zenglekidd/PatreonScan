// #!/usr/bin/swift
//
//  main.swift
//  PatreonScan
//
//  Created by Le Zeng on 2019/11/13.
//  Copyright © 2019 Le Zeng. All rights reserved.
//

import Foundation

// The Patron Page for Materialize CSS is:
// https://www.patreon.com/bePatron?u=8327028

print("The Patron Page for Materialize CSS is: https://www.patreon.com/bePatron?u=8327028")
print("Let's scan for valide pages from id 8327000 to 8327500...")
print("")

var count = 0
for i in 8327000..<8327500 {
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
                    print("\(url.absoluteString), statusCode: \(response.statusCode), length: \(data!.count)")
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
