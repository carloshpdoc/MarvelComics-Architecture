//
//  ViewController.swift
//  MarvelMVCExample
//
//  Created by carloshenrique.carmo on 19/04/19.
//  Copyright © 2019 carloshpdoc. All rights reserved.
//

import UIKit
import Kingfisher

class MarvelHeroesViewController: UIViewController {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var CollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var comics = [Comics]()
    var index: Int?
    var loadingComics = false
    var currentPage = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMarvelAPI()
        
    }
    
    func loadMarvelAPI() {
        loadingComics = true
        MarvelAPI.loadComics(page: currentPage) { [weak self] (result) in
            
            if let result = result {
                self?.comics += result.data.results
                self?.total = result.data.total

                DispatchQueue.main.async {
                    self?.loadingComics = false
                    self?.CollectionView.reloadData()
                }
            }
        }
    }
}

extension MarvelHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MarvelComicsCollectionViewCell
        
        if let url = URL(string: comics[indexPath.row].thumbnail.url) {
            cell.comicsImage.kf.setImage(with: url)
        } else {
            cell.comicsImage.image = nil
        }
        
        cell.comicsImage.layer.cornerRadius = cell.comicsImage.frame.size.height/2
        cell.comicsImage.layer.borderColor = UIColor.red.cgColor
        cell.comicsImage.layer.borderWidth = 2
        cell.titleLabel.text = comics[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let  vc = self.storyboard?.instantiateViewController(withIdentifier: "ComicsViewController") as! ComicsViewController
        vc.comics = comics[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == comics.count - 10 && !loadingComics && comics.count != total {
            currentPage += 1
            loadMarvelAPI()
            print("load more comics!!!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size+44)
    }
}

