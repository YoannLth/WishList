//
//  ItemType+CoreDataProperties.swift
//  WishList
//
//  Created by yoann lathuiliere on 28/11/2016.
//  Copyright © 2016 ylth. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
