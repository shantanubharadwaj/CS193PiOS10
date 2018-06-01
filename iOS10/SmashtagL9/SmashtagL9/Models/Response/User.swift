//
//  User.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 31/05/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

struct User: Codable, CustomStringConvertible {
    let gender: String
    let userName: Name
    let location: Location
    let email: String
    let dob: String
    let phoneNumber: String
    let cellNumber: String
    let picture: Media
    let nationality: String
    
    enum CodingKeys: String, CodingKey {
        case gender
        case userName = "name"
        case location
        case email
        case dob
        case phoneNumber = "phone"
        case cellNumber = "cell"
        case picture
        case nationality = "nat"
    }
    
    var description: String{
        return "User : Gender : \(gender) , \(userName) , \(location) , Nationality : \(nationality) , Email : \(email) , DOB : \(dob) , Contact : [Phone : \(phoneNumber) , Cell : \(cellNumber) , Media : \(picture)]"
    }
}

struct Name: Codable, CustomStringConvertible {
    let title: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case firstName = "first"
        case lastName = "last"
    }
    
    var description: String{
        return "[Name : \(title) \(firstName) \(lastName)]"
    }
}

struct Location: Codable, CustomStringConvertible {
    let street: String
    let city: String
    let state: String
    let postcode: Int
    
    var description: String{
        return "[Address > Street : \(street), City : \(city), State : \(state), PostCode : \(postcode)]"
    }
}

struct Media: Codable, CustomStringConvertible {
    let largeImageURL: URL
    let mediumImageURL: URL
    let thumbnailURL: URL
    
    enum CodingKeys: String, CodingKey {
        case largeImageURL = "large"
        case mediumImageURL = "medium"
        case thumbnailURL = "thumbnail"
    }
    
    var description: String{
        return "[Media :: Large : \(self.largeImageURL.absoluteString) | Medium : \(self.mediumImageURL.absoluteString) | Thumbnail : \(self.thumbnailURL.absoluteString) ]"
    }
}


