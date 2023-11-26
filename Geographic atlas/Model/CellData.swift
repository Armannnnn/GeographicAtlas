//
//  CellData.swift
//  Geographic atlas
//
//  Created by Arman on 26.11.2023.
//

import Foundation
import UIKit

struct CellData{
    var flag: UIImageView!
    var country: String
    var capital: String
    var population: String
    var area: String
    var currencies: String
}

struct CountryVCData{
    var cellTitle: String
    var body: Any
}
