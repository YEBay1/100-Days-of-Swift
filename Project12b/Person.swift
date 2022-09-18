//
//  Person.swift
//  Project10
//
//  Created by Yunus Emre Bayezit on 16.08.2022.
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
