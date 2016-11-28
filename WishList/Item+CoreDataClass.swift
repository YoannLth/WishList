//
//  Item+CoreDataClass.swift
//  WishList
//
//  Created by yoann lathuiliere on 28/11/2016.
//  Copyright © 2016 ylth. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    self.creationDate = NSDate()
  }
}
