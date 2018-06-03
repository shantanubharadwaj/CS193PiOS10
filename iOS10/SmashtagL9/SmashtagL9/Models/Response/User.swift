//
//  User.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 31/05/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

struct User: Codable, CustomStringConvertible, Equatable {
    let gender: String
    let userName: Name
    let location: Location
    let email: String
    let dob: String
    let phoneNumber: String
    let cellNumber: String
    let id: String
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
    
    var age: Int {
        let dobDate = dob.components(separatedBy: " ")
        if let date = dobDate.first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let dateString = dateFormatter.date(from: date) {
                let calendar = Calendar(identifier: .gregorian)
                let currentDate = Date()
                let age = calendar.dateComponents([.year], from: dateString, to: currentDate).year ?? 0
                return age
            }
        }
        return 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gender = try container.decode(String.self, forKey: CodingKeys.gender)
        userName = try container.decode(Name.self, forKey: CodingKeys.userName)
        location = try container.decode(Location.self, forKey: CodingKeys.location)
        email = try container.decode(String.self, forKey: CodingKeys.email)
        dob = try container.decode(String.self, forKey: CodingKeys.dob)
        phoneNumber = try container.decode(String.self, forKey: CodingKeys.phoneNumber)
        cellNumber = try container.decode(String.self, forKey: CodingKeys.cellNumber)
        picture = try container.decode(Media.self, forKey: CodingKeys.picture)
        nationality = try container.decode(String.self, forKey: CodingKeys.nationality)
        id = UUID().uuidString
    }
    
    var description: String{
        return "User : Gender : \(gender) , \(userName) , \(location) , Nationality : \(nationality) , Email : \(email) , DOB : \(dob) , Contact : [Phone : \(phoneNumber) , Cell : \(cellNumber) , ID : \(id) , Media : \(picture)]"
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
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
    let postcode: String
    
    enum CodingKeys: String, CodingKey {
        case street, city, state, postcode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        street = try container.decode(String.self, forKey: CodingKeys.street)
        city = try container.decode(String.self, forKey: CodingKeys.city)
        state = try container.decode(String.self, forKey: CodingKeys.state)
        do {
            let pcInt = try container.decode(Int.self, forKey: CodingKeys.state)
            postcode = String(pcInt)
        } catch DecodingError.typeMismatch( _, _) {
            do {
                let pcStr = try container.decode(String.self, forKey: CodingKeys.state)
                postcode = pcStr
            } catch DecodingError.typeMismatch(let key, let context) {
                throw DecodingError.typeMismatch(key, context)
            }
        }
    }
    
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


