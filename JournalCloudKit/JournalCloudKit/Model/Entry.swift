//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Kaleb  Carrizoza on 10/5/20.
//

import Foundation
import CloudKit

struct EntryConstant  {
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let RecordTypeKey = "Entry"
}



class Entry {
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}//end of class

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstant.TitleKey] as? String,
              let body = ckRecord[EntryConstant.BodyKey] as? String,
              let timestamp = ckRecord[EntryConstant.TimestampKey] as? Date else { return nil}
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstant.RecordTypeKey, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: EntryConstant.TitleKey)
        self.setValue(entry.body, forKey: EntryConstant.BodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstant.TimestampKey)
        
    }
}
