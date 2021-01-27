//
//  CovidAPI.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 28/1/21.
//

import Foundation

struct CovidAPI: Codable {
    let infected: Int
    let discharged: Int
    let inCommunityFacilites: Int
    let stableHospitalized: Int
    let criticalHospitalized: Int
    let activeCases: Int
    let deceased: Int
    let recovered: Int
    //let sourceURL: String?
    let lastUpdatedAtApify: String
    let readMe: String

//    {
//        "infected": 59391,
//        "discharged": 59104,
//        "inCommunityFacilites": 220,
//        "stableHospitalized": 38,
//        "criticalHospitalized": 0,
//        "activeCases": 258,
//        "deceased": 29,
//        "recovered": 59104,
//        "sourceUrl": "https://www.moh.gov.sg/covid-19",
//        "lastUpdatedAtApify": "2021-01-27T19:35:00.000Z",
//        "readMe": "https://apify.com/tugkan/covid-sg"
//    }
}

