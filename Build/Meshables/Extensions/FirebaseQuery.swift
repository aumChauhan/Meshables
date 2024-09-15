//
//  FirebaseQuery.swift
//  Meshables
//
//  Created by Aum Chauhan on 07/09/24.
//

import FirebaseFirestore

/// Provide asynchronous methods for retrieving and manipulating Firestore documents
extension Query {
    
    /// Retrieves a single document from the Firebase and decodes it
    func getDocument<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        // Retrieve the document snapshot
        let snapShot = try await self.getDocuments()
        
        // Decode each document into the specified type
        var genericArray: [T] = []
        
        for document in snapShot.documents {
            let element = try document.data(as: T.self)
            genericArray.append(element)
        }
        
        return genericArray
    }
    
    /// Retrieves multiple documents from the Firebase and decodes it
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        // Retrieve the document snapshot
        let snapShot = try await self.getDocuments()
        
        // Decode each document into the specified type
        var genericArray: [T] = []
        
        for document in snapShot.documents {
            let element = try document.data(as: T.self)
            genericArray.append(element)
        }
        return genericArray
    }
    
    /// Retrieves documents from the Firebase along with the last document in the snapshot
    func getDocumentWithLastDocuments<T>(as type: T.Type) async throws -> ([T], DocumentSnapshot?) where T : Decodable {
        let snapShot = try await self.getDocuments()
        
        // Decode each document into the specified type
        var genericArray: [T] = []
        
        for document in snapShot.documents {
            let element = try document.data(as: T.self)
            genericArray.append(element)
        }
        
        return (genericArray, snapShot.documents.last)
    }
    
    /// Returns the count of documents returned by the query
    func aggregateCount() async throws -> Int {
        let snapShot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapShot.count)
    }
    
    /// Sets up a snapshot listener on the query and retrieves documents whenever the data changes
    func snapShotlistner<T>(as type: T.Type, completionHandler: @escaping (([T]?, DocumentSnapshot?)) -> ()) where T : Decodable {
        self
            .addSnapshotListener { querySnapShot, error in
                // Handle the query snapshot and error, if any
                guard let documents = querySnapShot?.documents else {
                    return
                }
                
                // Decode each document into the specified type
                let genericArray: [T] = documents.compactMap({ try? $0.data(as: T.self) })
                
                // Retrieve the last document in the snapshot
                guard let lastSnapDoc = querySnapShot?.documents.last else { return }
                
                // Call the completion handler with the retrieved documents and the last document in the snapshot
                completionHandler((genericArray, lastSnapDoc))
            }
    }
}
