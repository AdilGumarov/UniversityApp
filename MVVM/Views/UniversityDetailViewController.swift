//
//  UniversityDetailViewController.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import UIKit
import SnapKit

class UniversityDetailViewController: UIViewController {
    
    var viewModel: UniversityDetailViewModel
    
    init(name: String, domain: String, country: String) {
        viewModel = UniversityDetailViewModel(name: name, domain: domain, country: country)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.getName()
        initialize()
    }
    
    func initialize() {
        
        let domainLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "Домен: \(viewModel.getDomain())"
            return label
        }()
        
        let countryLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "Страна: \(viewModel.getCountry())"
            return label
        }()
        
        view.addSubview(domainLabel)
        domainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            make.leading.trailing.equalToSuperview().inset(50)
            
        }
        
        view.addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(80)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
    }
    
}

