//
//  HomeViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 12/1/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = "http://newsapi.org/v2/top-headlines?country=sg&apiKey=049b4f64c5ff4c6a9a4cde43c7300cd9"
        getData(from: url)
        
    }
    
    private func getData(from url: String)
    {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            print("have data")
            // have data
            var welcome:Welcome?
            do
            {
                welcome = try JSONDecoder().decode(Welcome.self, from: data)
            }
            catch
            {
                print("failed to convert \(error.localizedDescription)")
            }

            guard let json = welcome else {
                return
            }

            for i in json.articles
            {
                print(i)
            }
        })
        task.resume()
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
