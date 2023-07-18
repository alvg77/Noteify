//
//  Wrapper.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import Foundation

class Wrapper<T> {
    var value: T
    init(_ value: T) {
        self.value = value
    }
}
