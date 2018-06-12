//
//  LocalUser.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 12/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit
import CoreData

class LocalUser: NSManagedObject {
    class func findOrCreateUser(matching userInfo: User, in context: NSManagedObjectContext) throws -> LocalUser {
        let request: NSFetchRequest<LocalUser> = LocalUser.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", userInfo.id)
        do {
            let matches = try context.fetch(request)
            if !matches.isEmpty {
                assert(matches.count == 1, "LocalUser.findOrCreateUser -- database inconsisitency")
                return matches[0]
            }
        } catch let error {
            throw error
        }
        
        let user = LocalUser(context: context)
        let name = userInfo.userName.firstName.localizedCapitalized + " " + userInfo.userName.lastName.localizedCapitalized
        user.name = name
        user.age = Int32(userInfo.age)
        user.unique = userInfo.id
        user.image = userInfo.picture.mediumImageURL
        user.gender = userInfo.gender.rawValue
        user.country = userInfo.nationality
        return user
    }
}
