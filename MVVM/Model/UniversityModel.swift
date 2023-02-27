//
//  UniversityModel.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import Foundation

struct UniversityData: Codable {
    let country: String
    let name: String
    let alphaTwoCode: String
    let domains: [String]
    let webPages: [String]
    
//    enum CodingKeys: String, CodingKey {
//        case country, name, domains
//        case webPages = "web_pages"
//        case alphaTwoCode = "alpha_two_code"
//    }  
}
