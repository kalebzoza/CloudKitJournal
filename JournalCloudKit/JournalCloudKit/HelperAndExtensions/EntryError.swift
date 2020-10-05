//
//  EntryError.swift
//  JournalCloudKit
//
//  Created by Kaleb  Carrizoza on 10/5/20.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
}
