//
//  TvSeriesViewController.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/21/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class TvSeriesViewController: UIViewController {

    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    private let behaviorRelay = BehaviorRelay<String>(value: "/top_rated")
    private let dataManager = DataManager()
    private let disposeBag = DisposeBag()
    private var type:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Segmented Controller
        segmentedController.setTitle("Popular", forSegmentAt: 0)
        segmentedController.setTitle("Top Rated", forSegmentAt: 1)
        
        segmentedController.rx.selectedSegmentIndex.subscribe (
                onNext: { index in
                    self.openSection(index: index)
            })
            .disposed(by: disposeBag)
        
        let results = behaviorRelay
             .flatMapLatest({ [unowned self] type -> Observable<TvServiceResponse?> in
                     self.dataManager.getSeries(type: self.type , page: "1")
                 })
            .asDriver(onErrorJustReturn: dataManager.getLocalSeries())
            
        results.map{
            return ($0 != nil ? ($0?.results)! : [TvSerie]())
                  }
                  .drive(
                   seriesCollectionView.rx.items(cellIdentifier: "seriesCell", cellType: TvCollectionViewCell.self))
                   { (row, tv, cell) in
                       self.removeLoading()
                       cell.configure(for: tv)
               }
           .disposed(by: disposeBag)
        
        
        seriesCollectionView
        .rx
        .itemSelected
        .subscribe(onNext:{ indexPath in
                let cell = self.seriesCollectionView.cellForItem(at: indexPath) as! TvCollectionViewCell
                let detailVC = TvSeriesDetailViewController()
                detailVC.tvSerie = cell.tvSerie
                self.navigationController?.pushViewController(detailVC, animated: true)
            }).disposed(by: disposeBag)

        // Do any additional setup after loading the view.
    }
    
    private func openSection(index:Int)
    {
        self.showLoading()
        switch index {
            case 0:
                self.type = "/top_rated"
            case 1:
                self.type = "/popular"
            
        default:
             print("Fallback option")
        }
        self.loadSeries(type: self.type ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Tv Series"
    }
    
    private func loadSeries(type:String) {
            behaviorRelay.accept(type)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
