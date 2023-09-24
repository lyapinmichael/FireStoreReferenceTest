//
//  Task.swift
//  FireStoreReferenceTest
//
//  Created by Ляпин Михаил on 23.09.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Codable, Hashable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id  == rhs.id
    }
    
    @DocumentID var id: String?
    
    let title: String
    var playersAssigned: [Player]
    
}

extension Task {
    static var mockTask1 = Task(title: "Mop the floor",
                                playersAssigned: [])
    
    static var mockTask2 = Task(title: "Make the sail",
                                playersAssigned: [])
}
