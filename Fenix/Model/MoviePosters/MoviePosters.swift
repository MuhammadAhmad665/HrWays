//
//  MoviePosters.swift
//  Fenix
//
//  Created by Ahmed on 02/04/2022.
//

import Foundation
class PaginationPosters{
    
    var page: String = ""
    var moviesPosters: [MoviesPosters] = []
    var totalPages: String = ""
    var totalResults: String = ""
    
    init(json: JSON){
        page = json["page"].stringValue
        json["results"].arrayValue.forEach{
            moviesPosters.append(MoviesPosters(json: $0))
        }
        totalPages = json["total_pages"].stringValue
        totalResults = json["total_results"].stringValue
    }
    
}
class MoviesPosters{
    
    var adult: String = ""
    var backdropPath: String = ""
    var genreIds: [Int] = []
    var id: Int = 0
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var overview: String = ""
    var popularity: String = ""
    var posterPath: String = ""
    var releaseDate: String = ""
    var title: String = ""
    var video: Bool = false
    var voteAverage: String = ""
    var voteCount: String = ""
    
    init(json: JSON){
        adult = json["adult"].stringValue
        backdropPath = json["backdrop_path"].stringValue
        
        json["genre_ids"].arrayObject?.forEach{
            genreIds.append($0 as! Int)
        }
        
        id = json["id"].intValue
        originalLanguage = json["original_language"].stringValue
        originalTitle = json["original_title"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].stringValue
        posterPath = json["poster_path"].stringValue
        releaseDate = json["release_date"].stringValue
        title = json["title"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].stringValue
        voteCount = json["vote_count"].stringValue
    }
}
