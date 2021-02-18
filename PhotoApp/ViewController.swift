//
//  ViewController.swift
//  PhotoApp
//
//  Created by Ege Melis Ayanoğlu on 29.01.2021.
//  Copyright © 2021 horizon. All rights reserved.
//

import UIKit
import Kingfisher

extension ViewController: DataSourceDelegate {
    func reloadTableView () {
        tableView.reloadData()
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataSource.loadImages()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as? ImageTableViewCell else {
            return UITableViewCell()
        }
        
        if let url = dataSource.getImageUrl(forIndex: indexPath.row) {
            cell.cellImageView.kf.setImage(with: url)
        }
        
        /*
        let photoInfo = Photos[indexPath.row]
        if let photoUrl = photoInfo["url"], let url = URL(string: photoUrl) {
            cell.cellImageView.kf.indicatorType = .activity
            cell.cellImageView.kf.setImage(with: url)
            /*
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.cellImageView.image = UIImage(data: data)
                    }
                }
            }
 */
        }
 */
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
