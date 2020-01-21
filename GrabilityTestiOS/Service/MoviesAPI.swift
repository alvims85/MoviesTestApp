//
//  MoviesAPI.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/15/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import RxSwift
import RxAlamofire
import ObjectMapper
import CachyKit

class MoviesAPI{
    static let apiKey = "d0073900bccb96b0cd6f18b8f40d6e7a"
    static let baseURLString = "https://api.themoviedb.org/3/movie"
    static let baseURLStringSeries = "https://api.themoviedb.org/3/tv"
    static let baseImageURLString = "https://image.tmdb.org/t/p/w154"
    
    static let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    
    static func getMovies(type:String!, page: String) -> Observable<MoviesServiceResponse?> {

        return json(.get, baseURLString + type, parameters: ["page": page, "api_key": apiKey])
            .do(
                onNext:
                {
                    element in print(element)
                })
            .map{
                result in
                toMapper(fromJSON: result)
                
                }
            .subscribeOn(globalScheduler)
    }
    
    static func getSeries(type :String!, page: String) -> Observable<TvServiceResponse?> {

        return json(.get, baseURLStringSeries + type, parameters: ["page": page, "api_key": apiKey])
            .do(
                onNext:
                {
                    element in print(element)
                })
            .map{
                result in
                toSeriesMapper(fromJSON: result)
                }
            .subscribeOn(globalScheduler)
    }
    
    static func getMovieTrailer(id:String!) -> Observable<TrailersServiceResponse?> {
            let completeURL = baseURLString + "/" + id + "/videos" + "?api_key=" + apiKey
            return json(.get, completeURL)
             .do(
                 onNext:
                 {
                     element in print(element)
                 })
             .map{
                 result in
                 toTrailerMapper(fromJSON: result)
                 
                 }
             .subscribeOn(globalScheduler)

    }
    
    static func getSeriesTrailer(id:String!) -> Observable<TrailersServiceResponse?> {
            let completeURL = baseURLStringSeries + "/" + id + "/videos" + "?api_key=" + apiKey
            return json(.get, completeURL)
             .do(
                 onNext:
                 {
                     element in print(element)
                 })
             .map{
                 result in
                 toTrailerMapper(fromJSON: result)
                 
                 }
             .subscribeOn(globalScheduler)

    }

    private static func toMapper(fromJSON jsonResult: Any) -> MoviesServiceResponse? {
   
        let objectResult = CachyObject(value: jsonResult as AnyObject, key: "movies")
        Cachy.shared.add(object: objectResult)
       
        guard let movieResponse = Mapper<MoviesServiceResponse>().map(JSONObject: jsonResult) else {
            return nil
        }
   
        return movieResponse
    }
    
    private static func toTrailerMapper(fromJSON jsonResult: Any) -> TrailersServiceResponse? {
        guard let trailerResponse = Mapper<TrailersServiceResponse>().map(JSONObject: jsonResult) else {
            return nil
        }
        return trailerResponse
    }
    
    private static func toSeriesMapper(fromJSON jsonResult: Any) -> TvServiceResponse? {
        let objectResult = CachyObject(value: jsonResult as AnyObject, key: "series")
        Cachy.shared.add(object: objectResult)
        guard let tvResponse = Mapper<TvServiceResponse>().map(JSONObject: jsonResult) else {
            return nil
        }
        return tvResponse
    }
    
}
