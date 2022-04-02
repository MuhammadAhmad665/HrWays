//
//  Constants.swift
//  Fenix
//
//  Created by Ahmed on 02/04/2022.
//

import Foundation
import UIKit
//MARK:- Typealias
typealias TableViewMethods = UITableViewDelegate & UITableViewDataSource
typealias CollectionViewMethods = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

//MARK:- Apis
struct Apis {
    static let baseURL = "https://api.themoviedb.org/3/search/movie?api_key"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w220_and_h330_face"
    static let api_key = "ae304e3f4d3830d95075ae6914b55ddf"
}
//MARK: Loading Message
struct WaitingMessage{
    static let processing = "Processing..."
}
// MARK: UserDefault Key
struct UserDefaultKey {
    static let loginStatus = "Login Status"
    static let savedUser = "Saved User"
}
struct dateFormate {
    static let yaerMonthDay = "yyyy-MM-dd"
    static let MonthNameYear = "MMMM yyyy"
}
