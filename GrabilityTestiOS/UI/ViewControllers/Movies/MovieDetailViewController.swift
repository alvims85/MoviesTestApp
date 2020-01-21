//
//  DetailViewController.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/15/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import YoutubeKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController,YTSwiftyPlayerDelegate {

    public var movie:Movie!
    private var player: YTSwiftyPlayer!
    private var behaviorRelay = BehaviorRelay<String>(value: "")
    private let dataManager = DataManager()
    private let disposeBag = DisposeBag()
    
    let titleLabel = UILabel()
    let descriptionTextView = UITextView()
    let releaseDateLabel = UILabel()
    let posterImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = movie.title
        
        ///
        self.titleLabel.text = movie.title
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.numberOfLines = 2
        self.view.addSubview(titleLabel)
        
        self.descriptionTextView.text = movie.overview
        self.descriptionTextView.isSelectable = false
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.flashScrollIndicators()
        self.view.addSubview(descriptionTextView)
        
        self.releaseDateLabel.text = "Release Date: " + movie.release_date!
        self.releaseDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.view.addSubview(self.releaseDateLabel)
        
        if movie.poster_path != nil {
                   let url = URL(string: MoviesAPI.baseImageURLString + movie.poster_path!)!
                   self.posterImage.af_setImage(withURL: url)
               }
        self.posterImage.contentMode = .scaleAspectFit
        self.view.addSubview(self.posterImage)
        ///
        
        let results = behaviorRelay
              .flatMapLatest({ [unowned self] type -> Observable<TrailersServiceResponse?> in
                self.dataManager.getMovieTrailer(id: "\(self.movie.id ?? 0)")
                  })
              .asDriver(onErrorJustReturn: nil)
          results.map{
                if  ($0 != nil)
                {
                    self.loadVideo(id: ($0?.results![0].key)!)
                }
          }
          .drive()
          .disposed(by: disposeBag)
        }

    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
    }
    
    @objc func loadVideo(id:String)
    {
            player = YTSwiftyPlayer(
                       frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300),
                                  playerVars: [.videoID(id)])
            player.autoplay = false
            player.delegate = self
            player.loadPlayer()
            player.backgroundColor = .gray
            self.view.addSubview(player)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.posterImage.frame = CGRect(x: 10, y: 300, width: 120, height: 200)
        self.titleLabel.frame = CGRect(x: self.posterImage.frame.maxX+5, y: 310, width: self.view.frame.size.width - self.posterImage.frame.maxX-10, height: 35)
        self.descriptionTextView.frame = CGRect(x: self.posterImage.frame.maxX+5, y: self.titleLabel.frame.maxY+5, width: self.view.frame.size.width - self.posterImage.frame.maxX-10, height:120)
        self.releaseDateLabel.frame =  CGRect(x: self.posterImage.frame.maxX+5, y: self.descriptionTextView.frame.maxY+5, width: self.view.frame.size.width - self.posterImage.frame.maxX-10, height:15)
        
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
