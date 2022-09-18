//
//  Person.swift
//  Project1
//
//  Created by Yunus Emre Bayezit on 4.09.2022.
//  Copyright © 2022 Paul Hudson. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
