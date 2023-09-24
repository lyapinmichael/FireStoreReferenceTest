//
//  Player.swift
//  FireStoreReferenceTest
//
//  Created by Ляпин Михаил on 23.09.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Player: Codable, Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id  == rhs.id
    }
    
    @DocumentID var id: String?
    
    let firstName: String
    let lastName: String
    let userType: UserType
    var tasksAssigned: [Task]
    
}

extension Player {
    
    static var mockPlayer1 = Player(firstName: "Jack",
                                    lastName: "Sparrow",
                                    userType: .captain,
                                    tasksAssigned: [])
    
    
    static var mockPlayer2 = Player(firstName: "Will",
                                    lastName: "Turner",
                                    userType: .blacksmith,
                                    tasksAssigned: [])
}
