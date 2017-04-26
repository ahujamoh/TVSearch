//
//  ViewController.swift
//  tvsearch
//
//  Created by Mohit on 24/04/17.
//  Copyright © 2017 ahujamoh. All rights reserved.
//

import UIKit
import AlamofireImage


class ViewController: UIViewController{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tvseries = [TVSeries]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

let reuseIdentifier = "TVSeriesCell"
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TVSeriesCollectionViewCell
        if (tvseries[indexPath.row].image != nil){
            var link = URLComponents.init(string: tvseries[indexPath.row].image!)
            link?.scheme = "https"
            let imageURL = link?.url
            cell.tvSeriesImage.af_setImage(withURL: imageURL!)
        }
        else{
            cell.tvSeriesImage.image = UIImage(named: "default")
        }
        cell.tvSeriesName.text = tvseries[indexPath.row].name
        cell.tvSeriesName.numberOfLines = 0
        cell.tvSeriesName.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.tvSeriesName.sizeToFit()

        return cell
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvseries.count
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearchWithText(searchText: searchBar.text!)
    }
    
    private func performSearchWithText(searchText: String!){
        print(searchText)
        TVSeriesInfo.search(searchText: searchText) { (error, responseArray) in
            print(error, responseArray)
            if (error == nil){
                self.tvseries = responseArray!
                self.collectionView.reloadData()
            }
        }
    }
}
