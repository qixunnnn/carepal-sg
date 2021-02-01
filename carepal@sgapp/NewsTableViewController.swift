//
//  NewsTableViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 30/1/21.
//

import UIKit

class NewsTableViewCell:UITableViewCell {
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    
}

class NewsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var fetchArticles = [Article]()
    var allImages = [UIImage]()
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        getData {
            self.tableView.reloadData()
        }
        print(self.filteredData.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return fetchArticles.count
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        //let cNew = fetchArticles[indexPath.row] //Passing later
        
        cell.titleText?.text = fetchArticles[indexPath.row].title
        
        cell.titleText.numberOfLines = 0
        cell.titleText.sizeToFit()
        
        //Convert URL to image
        if fetchArticles[indexPath.row].urlToImage != nil {
            let url = URL(string: fetchArticles[indexPath.row].urlToImage!)

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil
                    {
                        cell.headerImg.image = UIImage(data: data!)
                    }
                }
            }
        }
        cell.headerImg.layer.cornerRadius = 10
        
        
        //Convert string to date
        //let dateFormatter = DateFormatter()
        let date = fetchArticles[indexPath.row].publishedAt
        cell.dateText.text = date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: fetchArticles[indexPath.row].url) else { return }
        UIApplication.shared.open(url)
    }

    //Retrieve Data
    private func getData(completed: @escaping () -> ())
    {
        let url = "http://newsapi.org/v2/top-headlines?country=sg&category=health&apiKey=049b4f64c5ff4c6a9a4cde43c7300cd9"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            print("have data")
            // have data
            do
            {
                let response = try JSONDecoder().decode(News.self, from: data)
                
                self.fetchArticles = response.articles
                //completionHandler(response)
                //print(self.fetchArticles)
                for x in response.articles
                {
                    self.filteredData.append(x.title)
                }
                DispatchQueue.main.sync {

                    completed()
                }

            }
            catch
            {
                print("failed to convert \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    //Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            for a in fetchArticles {
                filteredData.append(a.title)
            }
        }
        else
        {
            for a in fetchArticles {
                if a.title.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(a.title)
                }
            }
            self.tableView.reloadData()
        }
    }
}

//Convert Date
extension Date
{
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yy"
        return dateFormatter.string(from: self)
    }
}
