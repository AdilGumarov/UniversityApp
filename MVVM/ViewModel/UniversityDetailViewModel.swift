//
//  UniversityDetailViewModel.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import Foundation

class UniversityDetailViewModel {
    
    private var name: String = ""
    private var domain: String = ""
    private var country: String = ""
    
    init(name: String, domain: String, country: String) {
        self.name = name
        self.domain = domain
        self.country = country
    }
    
    func getName() -> String {
        name
    }
    
    func getDomain() -> String {
        domain
    }
    
    func getCountry() -> String {
        country
    }
}
