//
//  ViewController.swift
//  SMETest
//
//  Created by shiva on 08/09/19.
//  Copyright © 2019 UdayKumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    fileprivate var SearchTableView = UITableView()
    fileprivate var viewModel = HViewModel()
    fileprivate var cellIdentifier = "Cell"
    fileprivate var activityIndicator = UIActivityIndicatorView()
    var Songs : [[SongInfoModel]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()
    }
    
    private func fillUI(){
        
        searchBar.placeholder = "Search Albums/Artists/Songs"
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        SearchTableView.frame = self.view.bounds
        SearchTableView.dataSource = self
        SearchTableView.delegate = self
        SearchTableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(SearchTableView)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, color: .gray,  placeInTheCenterOf: view)
        
        viewModel.LoadingDelegate = self
        APIHandler.shared.LoadingDelegate = self
        
    }


}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        let sections = Songs?.count ?? 0
        if sections == 0{
            tableView.setEmptyView(title: "NO RESULTS", message: "search for results")
        }
        else {
            tableView.restore()
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Songs?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        if  let song = Songs?[indexPath.section][indexPath.row]{
            cell.textLabel?.text = song.name
            cell.detailTextLabel?.text = song.artist
            cell.imageView?.dowloadFromServer(link: song.ImageUrl ?? "https://i7.pngguru.com/preview/297/776/862/musical-note-sheet-music-musical-notation-eighth-note-music-notes-png-thumbnail.jpg")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (Songs?[section].count)! > 0 {
            return Songs?[section][0].type
        }
        
        return ""
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DVC = DetailViewController()
        DVC.SongModel = Songs?[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(DVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !SearchTableView.isDecelerating {
            self.searchBar.resignFirstResponder()
        }
    }
    
    
    
}


extension ViewController : UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.GetSongInfoModels(searchBar.text ?? "", CompletionHandler: {
            songs in
            
            self.Songs = songs
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
                self.SearchTableView.reloadData()
            })
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension ViewController:LoadingIndicatorDelegate{
    func DidStartLoading() {
        activityIndicator.startAnimating()
    }
    
    func LoadingFinished() {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    
}

