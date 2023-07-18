//
//  Realm.swift
//  MessageBoard
//
//  Created by imac-1681 on 2023/7/10.
//

import Foundation
import RealmSwift

class RealmModel: Object {
       @Persisted(primaryKey: true) var _id: ObjectId
       @Persisted var message: String = ""
       @Persisted var people: String = ""
       @Persisted var time:Int
    convenience init(people: String, message: String, time:Int) {
      self.init()
      self.message = message
      self.people = people
      self.time = time
  }
}
struct message123 {
    
    var id:ObjectId
    
    var time:Int
    
    var people:String
    
    var message:String
}

