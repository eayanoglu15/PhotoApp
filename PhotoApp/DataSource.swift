//
//  DataSource.swift
//  PhotoApp
//
//  Created by Ege Melis Ayanoğlu on 18.02.2021.
//  Copyright © 2021 horizon. All rights reserved.
//

import Foundation

protocol DataSourceDelegate {
    func reloadTableView ()
}

class DataSource {
    var photoList: [PhotoInfo]?
    var delegate: DataSourceDelegate?
    let baseURL = "https://api.flickr.com/services/rest/?api_key=b58aa44775814c3d2fda2c6951068105&method=flickr.interestingness.getList&extras=url_l&format=json&per_page=100&nojsoncallback=1"
    
    func loadImages() {
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                /*
                print("HERE: \(String.init(data: data!, encoding: .utf8))")
                let decoder = JSONDecoder()
                let data = try! decoder.decode(PhotoData.self, from: data!)
                if let photodata = data.photos, let list = photodata.photo {
                    self.photoList = list
                }
                DispatchQueue.main.async {
                    self.delegate?.reloadTableView()
                }
                */
                guard let data = data else {
                    return
                }
                do {
                    let info = try JSONDecoder().decode(PhotoData.self, from: data)
                    if let photodata = info.photos, let list = photodata.photo {
                        self.photoList = list
                    }
                    DispatchQueue.main.async {
                        self.delegate?.reloadTableView()
                    }
                } catch {
                    return
                }
            }
            dataTask.resume()
        }
    }
    
    func getRowCount() -> Int {
        guard let list = photoList else {
            return 0
        }
        return list.count
    }
    
    func getImageUrl(forIndex: Int) -> URL? {
        guard let list = photoList, let url_l = list[forIndex].url_l, let url = URL(string: url_l) else {
            return nil
        }
        return url
    }
}

struct PhotoData: Decodable {
    var photos: Photo?
}

struct Photo: Decodable {
    var photo: [PhotoInfo]?
}

struct PhotoInfo: Decodable {
    var url_l: String?
}
