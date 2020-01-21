//
//  ViewController.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/15/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import CachyKit

class MoviesViewController: UIViewController {

    
    @IBOutlet var segmentedController: UISegmentedControl!
    @IBOutlet var moviesCollectionView: UICollectionView!
    
    private let dataManager = DataManager()
    private let disposeBag = DisposeBag()
    private let behaviorRelay = BehaviorRelay<String>(value: "/top_rated")
    private var type:String!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Segmented Controller
        segmentedController.setTitle("Popular", forSegmentAt: 0)
        segmentedController.setTitle("Top Rated", forSegmentAt: 1)
        segmentedController.setTitle("Upcoming", forSegmentAt: 2)
        
        segmentedController.rx.selectedSegmentIndex.subscribe (
            onNext: { index in
                self.openSection(index: index)
        })
        .disposed(by: disposeBag)
        

        let results = behaviorRelay
            .flatMapLatest({ [unowned self] type -> Observable<MoviesServiceResponse?> in
                    self.dataManager.getMovies(type: self.type , page: "1")
                })
            .asDriver(onErrorJustReturn: dataManager.getLocalMovies())
            
        //Update CollectionView
        results.map{
                    return ($0 != nil ? $0?.results :[Movie]()
                )!
            }
               .drive(
                moviesCollectionView.rx.items(cellIdentifier: "movieCell", cellType: MovieCollectionViewCell.self))
                {  (row, movie, cell) in
                    self.removeLoading()
                    cell.configure(for: movie)
                
            }
        .disposed(by: disposeBag)
        
        //Detect/Open Movie tapped
        moviesCollectionView
        .rx
        .itemSelected
        .subscribe(onNext:{ indexPath in
                let cell = self.moviesCollectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
                let detailVC = MovieDetailViewController()
                detailVC.movie = cell.movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            }).disposed(by: disposeBag)



    }
    
    private func openSection(index:Int)
    {
        self.showLoading()
        switch index {
            case 0:
                self.type = "/top_rated"
            case 1:
                self.type = "/popular"
            case 2:
                self.type = "/upcoming"
            
        default:
             print("Fallback option")
        }
        self.loadMovies(type: self.type ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Movies"
    }
    
    
    private func loadMovies(type:String) {
            behaviorRelay.accept(type)
    }
    
    

}


var loadingView = LoadingView()
extension UIViewController {

    func showLoading() {
         DispatchQueue.main.async {
            loadingView.frame = self.view.frame
            loadingView.showLoading()
            self.view.addSubview(loadingView)
        }

    }
    
    @objc func removeLoading() {
         DispatchQueue.main.async {
            loadingView.removeLoadingView()
         }
    }
}

