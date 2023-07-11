//
//  NoteModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import Foundation

struct NoteModel: Identifiable {
    var id: Int
    var title: String
    var body: String
    var due: Date
    var isCompleted: Bool
    let createdAt = Date()
}
