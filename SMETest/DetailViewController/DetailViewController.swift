//
//  DetailViewController.swift
//  SMETest
//
//  Created by shiva on 08/09/19.
//  Copyright © 2019 UdayKumar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var SongModel:SongInfoModel?
    private var imageview : UIImageView = {
        var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private var InfoLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        fillUI()

    }
    
    private func fillUI(){
    
        self.navigationItem.title = "Song Info"
        self.view.addSubview(imageview)
        imageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        imageview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
        imageview.dowloadFromServer(link: SongModel?.ImageUrl ?? "https://i7.pngguru.com/preview/297/776/862/musical-note-sheet-music-musical-notation-eighth-note-music-notes-png-thumbnail.jpg")
        
        self.view.addSubview(InfoLabel)
        InfoLabel.topAnchor.constraint(equalTo: imageview.bottomAnchor, constant: 20).isActive = true
        InfoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        InfoLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        let AttText = NSMutableAttributedString.init(attributedString: NSAttributedString.init(string: SongModel?.name ?? "", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18.0),NSAttributedString.Key.foregroundColor:UIColor.black]))
        
        let SubAttText = NSAttributedString.init(string: "\n\(SongModel?.artist ?? "")" , attributes: [NSMutableAttributedString.Key.font:UIFont.systemFont(ofSize: 12.0),NSAttributedString.Key.foregroundColor:UIColor.gray])
        AttText.append(SubAttText)
        
        InfoLabel.attributedText = AttText
        
        
    
    }
    



}
