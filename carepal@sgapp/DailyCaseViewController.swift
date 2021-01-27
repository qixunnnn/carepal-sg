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
        let url = "https://api.apify.com/v2/key-value-stores/yaPbKe9e5Et61bl7W/records/LATEST?disableRedirect=true"
        let APIInfo = getData(from: url)
        
//        activeLbl.text = String(APIInfo.activeCases)
//        communityLbl.text = String(APIInfo.inCommunityFacilites)
//        stableLbl.text = String(APIInfo.stableHospitalized)
//        dischargedLbl.text = String(APIInfo.discharged)
//        criticalLbl.text = String(APIInfo.criticalHospitalized)
//        decessedLbl.text = String(APIInfo.deceased)
        
    }
    
    private func getData(from url: String)
    {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
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
            
            guard let json = response else
            {
                return
            }
        })
        task.resume()
    }
}
