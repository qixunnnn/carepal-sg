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

class NewsTableViewController: UITableViewController {
    
    var fetchArticles = [Article]()
    var allImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        getData {
            self.tableView.reloadData()
        }
//        tableView.delegate = self
//        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchArticles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let cNew = fetchArticles[indexPath.row] //Passing later
        
        cell.titleText?.text = fetchArticles[indexPath.row].title
        cell.titleText.numberOfLines = 0
        
        //Convert URL to image
        if fetchArticles[indexPath.row].urlToImage != nil {
            let url = URL(string: fetchArticles[indexPath.row].urlToImage!)

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.headerImg.image = UIImage(data: data!)
                }
            }
        }
        
        //Convert string to date
        let dateFormatter = DateFormatter()
        let date = fetchArticles[indexPath.row].publishedAt
        let x = dateFormatter.date(from: date)
        cell.dateText.text = x?.asString()
        return cell
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
}
extension Date
{
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yy"
        return dateFormatter.string(from: self)
    }
}
