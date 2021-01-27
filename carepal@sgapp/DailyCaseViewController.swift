//
//  DailyCaseViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 28/1/21.
//

import UIKit

class DailyCaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.apify.com/v2/key-value-stores/yaPbKe9e5Et61bl7W/records/LATEST?disableRedirect=true"
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
            var response:CovidAPI?
            do
            {
                response = try JSONDecoder().decode(CovidAPI.self, from: data)
            }
            catch
            {
                print("failed to convert \(error.localizedDescription)")
            }

            guard let json = response else {
                return
            }
            //print(json.sourceURL)
            print(json.criticalHospitalized)
            print(json.inCommunityFacilites)
            print(json.recovered)
            print(json.lastUpdatedAtApify)
            print(json.activeCases)
        })
        task.resume()
    }
}
