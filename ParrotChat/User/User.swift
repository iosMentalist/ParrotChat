//
//  Created by Shady
//  All rights reserved.
//

import Foundation

struct User {
    var name : String
    var imageName : String
    var lastMessage : Message
}

//extension User : Codable{
//enum CodingKeys: String, CodingKey {
//      case name
//  }
//
//  init(from decoder:Decoder) throws {
//      let values = try decoder.container(keyedBy: CodingKeys.self)
//      name = try values.decode(String.self, forKey: .name)
//  }
//
//  public func encode(to encoder: Encoder) throws {
//      var container = encoder.container(keyedBy: CodingKeys.self)
//      try container.encode(name, forKey: .name)
//  }
//}
