//
//  ViewController.swift
//  FireStoreReferenceTest
//
//  Created by Ляпин Михаил on 23.09.2023.
//

import UIKit

class ViewController: UIViewController {

    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        guard let newPlayerID = FirestoreService.shared.writePlayerData(Player.mockPlayer1) else {
            return
        }
        print("New player document ID: ", newPlayerID)
        
        print("Wainting for 5 sec for server to update...")
        sleep(5)
        
        
        FirestoreService.shared.fetchPlayerData(id: newPlayerID) { [weak self] player in
            
            var newPlayer = player
            
            self?.assign(task: &Task.mockTask1, to: &newPlayer)
            self?.assign(task: &Task.mockTask2, to: &newPlayer)
        }
        
        print("Wainting for 5 sec for server to update...")
        sleep(5)
     
        FirestoreService.shared.fetchAllPlayers() { players in
            for player in players {
                print("===+++===\n", player, "===---===\n")
            }
        }

    }

    func assign(task: inout Task, to player: inout Player) {
        player.tasksAssigned.append(task)
        task.playersAssigned.append(player)
        
        FirestoreService.shared.updatePlayerData(player)
        let _ = FirestoreService.shared.writeTaskData(task)
    }
    
    

}

