//
//  ApiManager.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/15/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import RxSwift
import ObjectMapper
import CachyKit

class DataManager {

    func getMovies(type:String, page: String) -> Observable<MoviesServiceResponse?> {
        return MoviesAPI.getMovies(type: type , page: page)
    }
    func getMovieTrailer(id:String) -> Observable<TrailersServiceResponse?> {
        return MoviesAPI.getMovieTrailer(id: id)
    }
    func getSeries(type:String, page: String) -> Observable<TvServiceResponse?> {
        return MoviesAPI.getSeries(type: type , page: page)
    }
    
    func getSeriesTrailer(id:String) -> Observable<TrailersServiceResponse?> {
        return MoviesAPI.getSeriesTrailer(id: id)
    }
    
    func getLocalMovies() -> MoviesServiceResponse?{
        let result: AnyObject? = Cachy.shared.get(forKey: "movies")
        guard let movieResponse = Mapper<MoviesServiceResponse>().map(JSONObject: result as Any) else {
            return nil
        }
        return movieResponse

    }

    func getLocalSeries() -> TvServiceResponse?{
        let result: Any? = Cachy.shared.get(forKey: "series")
        guard let seriesResponse = Mapper<TvServiceResponse>().map(JSONObject: result) else {
            return nil
        }
        return seriesResponse

    }
    
    

}
