//
//  FirestoreService.swift
//  FireStoreReferenceTest
//
//  Created by Ляпин Михаил on 23.09.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreService {
 
    static let shared = FirestoreService()
    
    private var dataBase: Firestore
    private var collectionReference: CollectionReference!
    private var documentReference: DocumentReference!
    
    private init() {
        
        dataBase = Firestore.firestore()
        
    }
    
    func writeTaskData(_ newTask: Task) -> String? {
        
        // 1. Подключимся к коллекции задач
        collectionReference = dataBase.collection("task")
        
        do {
            // 2. Попробуем добавить в коллекцию задач новый документ
            let newTaskReference = try collectionReference.addDocument(from: newTask)
    
            // 3. Мы великолепны
            print("New task sucessfully saved to Firestore")
            return newTaskReference.documentID
        } catch {
            print(error)
            return nil
        }
    }
    
    func fetchAllPlayers(_ completionHandler: @escaping ([Player]) -> Void) {
        
        // 1. Подключимся к коллекции игроков
        collectionReference = dataBase.collection("player")
        
        // 2. Сделаем запрос на получение всех документов
        var players: [Player] = []
        collectionReference.getDocuments { querySnapshot, error in
            
            if let error {
                print(error)
            } else {
                for document in querySnapshot!.documents {
                    // 3. Попробуем привести каждый из полученных документов к
                    // Codable модели
                    guard let player = try? document.data(as: Player.self) else { return }
                    players.append(player)
                }
                
                // 4. Мы великолепны
                completionHandler(players)
            }
            
        }
     
        
    }
    
    func fetchPlayerData(id: String, _ completionHandler: @escaping (Player) -> Void) {
        
        // 1. Подключимся к документу из коллекции игроков
        documentReference = dataBase.collection("player").document(id)
        
        //2. Попробуем получить документ игрока и спарсить его до Codable модели
        documentReference.getDocument(as: Player.self) { result in
            switch result {
            case .success(let player):
                
                //3. Мы великолепны
                completionHandler(player)
            case.failure(let error):
                print(error)
            }
        }
        
       
        
    }
    
    func writePlayerData(_ newPlayer: Player) -> String? {
        
        // 1. Подключимся к коллеции игроков
        collectionReference = dataBase.collection("player")
        
        do {
            // 2. Попробуем добавить  в коллекцию игроков новуый документ
            let newPlayerReference = try collectionReference.addDocument(from: newPlayer)
            
            // 3. Мы великолепны
            print("New player successfully saved to Firestore")
            return(newPlayerReference.documentID)
        } catch {
            print(error)
            return nil
        }
    }
    
    func updatePlayerData(_ player: Player) {
        
        // 0. Проверим, есть ли у игрока ID, который создается при его добавлении
        // в Firestore
        guard let id = player.id else { return }
        
        // 1. Подключимся к документу из коллекции игроков
        documentReference = dataBase.collection("player").document(id)
        
        do {
            // 2. Попробуем сохранить новую дату
            try documentReference.setData(from: player)
            
            //3. Мы великолепны
            print("Player data updated successfully")
        } catch {
            print(error)
        }
        
    }
}
