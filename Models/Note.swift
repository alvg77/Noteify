//
//  NoteModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import Foundation

struct Note: Identifiable {
    var id: String
    var title: String
    var body: String
    var due: Date
    var isCompleted = false
    var createdAt = Date()
}
