//
//  ViewController.swift
//  AFProject
//
//  Created by Emre Durmuş on 27.06.2023.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    // MARK: -PROPERTIES
    @IBOutlet weak var productTableView: UITableView!
    
    var artist = [ArtistResults]()
    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    @objc let refreshControl = UIRefreshControl()
    
    
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInitView()
        loadJsonData()
    }
    
    private func setInitView() {
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        
        
        
    }
    
    @objc func refreshList() {
        self.artist = []
        self.productTableView.reloadData()
        loadJsonData()
        self.refreshControl.endRefreshing()
        
    }
    
    
    private func loadJsonData() {
        AF.request("https://itunes.apple.com/search?media=music&term=bollywood").response { response in
            print("Response Data \(response)")
            
            do {
                switch response.result {
                case .success(let data):
                    let json = try? JSONDecoder().decode(Artist.self, from: data!)
                    self.artist = json!.results
                    
                    for i in json?.results ?? [] {
                        AF.request(i.artworkUrl60).responseImage { response in
                            let image = UIImage(data: response.data!, scale: 1.0)
                            self.imageCache.add(image!, for: URLRequest(url: URL(string: i.artworkUrl60)!))
                            DispatchQueue.main.async {
                                self.productTableView.reloadData()
                            }
                        }
                    }
                    
                    
                case .failure(_): break
                    
                }
            } catch {
                
                
            }
            

        }
       
    }
    
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! ProductTableViewCell
        if artist.count > 0 {
                let artistData = artist[indexPath.row]
                cell.imgNameLbl.image = imageCache.image(for: URLRequest(url: URL(string: artistData.artworkUrl60)!))
                cell.trackNameLabel.text = artistData.trackName as! String
                cell.artistNameLbl.text = artistData.artistName as! String
                cell.countryLbl.text = artistData.country as! String
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
