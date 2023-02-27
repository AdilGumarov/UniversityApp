//
//  SearchViewController.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import UIKit
import SnapKit
import CoreData

class SearchViewController: UIViewController {
    
    let textField = UITextField()
    let searchButton = UIButton()
    let tableView = UITableView()
//    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel: SearchViewModel
    
    init() {
        viewModel = SearchViewModel()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.setAddedUniversities()
        
        textField.delegate = self
        intialize()
    }
    
    func intialize() {

        textField.placeholder = "  Search"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.borderStyle = .line
        textField.backgroundColor = .systemFill
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(60)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        setUpTable()

    }
    func setUpTable() {
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.trailing.leading.bottom.equalToSuperview()
        }
        
    }
    
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfUniversities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell

        cell.setText(viewModel.getNameOfUniversity(at: indexPath.row))
        let state = viewModel.getState(at: indexPath.row)
        cell.setAddedState(state)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedUnviersity = viewModel.getUniversity(at: indexPath.row)
        
        if !viewModel.isContainSelectedUniversity(name: selectedUnviersity.name) {
            viewModel.insertUniversity(name: selectedUnviersity.name) // здесь должен поменять 
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    @objc func searchTapped() {
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let name = textField.text {
            viewModel.getUniversityByCountry(countryName: name) {
                self.tableView.reloadData()
            }
        }
        
        textField.text = ""
    }
}

