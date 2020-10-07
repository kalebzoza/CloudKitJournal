//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Kaleb  Carrizoza on 10/5/20.
//

import Foundation
import CloudKit

class EntryController {
    //MARK: - Properties
    var entries: [Entry] = []
    static var shared = EntryController()
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //MARK: - CRUD
    func createEntryWith(title: String, body: String, completion: @escaping(Result<Entry?, EntryError>) -> Void){
        
        let newEntry = Entry(title: title, body: body)
        save(entry: newEntry, completion: completion)
        
        
    }
    
    func save(entry: Entry, completion: @escaping(Result<Entry?, EntryError>) -> Void) {
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedEntry = Entry(ckRecord: record) else  { return completion(.failure(.couldNotUnwrap)) }
            print("Save successful")
            self.entries.append(savedEntry)
            completion(.success(savedEntry))
        }
    }
    
    //this is the read part of crud
    func fetchEntriesWith(completion: @escaping(Result<[Entry]?, EntryError>)-> Void) {
    
        let fetchAllPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstant.RecordTypeKey, predicate: fetchAllPredicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(.failure(.ckError(error)))
            }
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            print("successful")
            let fetchEntries = records.compactMap({Entry(ckRecord: $0) })
            completion(.success(fetchEntries))
        }
    }
    
    
    
    
    
    
    
}//end of class
