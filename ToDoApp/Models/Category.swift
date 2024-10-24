//
//  Category.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 18.10.2024.
//

import Foundation
import SwiftData

@Model
class Category: Identifiable, ObservableObject {
    var title: String
    var imageString: String
    var color: String
    
    init(title: String, imageString: String, color: String) {
        self.title = title
        self.imageString = imageString
        self.color = color
    }
}
