//
//  DailyCaseViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 28/1/21.
//

import UIKit

class DailyCaseViewController: UIViewController {
    @IBOutlet weak var activeLbl: UILabel!
    @IBOutlet weak var communityLbl: UILabel!
    @IBOutlet weak var stableLbl: UILabel!
    @IBOutlet weak var dischargedLbl: UILabel!
    @IBOutlet weak var criticalLbl: UILabel!
    @IBOutlet weak var decessedLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getData {(CovidAPI) in
//            
//        }
    }
    
    private func getData(completionHandler: @escaping (CovidAPI) -> Void)
    {
        let url = "https://api.apify.com/v2/key-value-stores/yaPbKe9e5Et61bl7W/records/LATEST?disableRedirect=true"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            print("have data")
            // have data
            //var response:CovidAPI?
            do
            {
                let response = try JSONDecoder().decode(CovidAPI.self, from: data)
                DispatchQueue.main.async {
                    self.activeLbl.text = String(response.activeCases)
                    self.communityLbl.text = String(response.inCommunityFacilites)
                    self.stableLbl.text = String(response.stableHospitalized)
                    self.dischargedLbl.text = String(response.discharged)
                    self.criticalLbl.text = String(response.criticalHospitalized)
                    self.decessedLbl.text = String(response.deceased)
                }
                completionHandler(response)
            }
            catch
            {
                print("failed to convert \(error.localizedDescription)")
            }
            
        })
        task.resume()
    }
}
