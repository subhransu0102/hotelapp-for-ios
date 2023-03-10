//
//  Models.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 14/02/23.
//

import Foundation

enum CellModel{
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}
struct ListCellModel{
    let title: String
}
struct CollectionTableCellModel{
    let title: String
    let imageName: String
}
