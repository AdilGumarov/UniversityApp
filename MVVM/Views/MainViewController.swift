//
//  ViewController.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        navigationItem.title = "List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        createTable()
        addObservers()
        viewModel.setDataFromCoreData()
    }
    
    func createTable() {
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: nil, queue: nil) { [weak self] _ in
            print("Core data changed")
            self?.viewModel.setDataFromCoreData()
            self?.tableView.reloadData()
        }
    }
        
    @objc func addTapped() {
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen

        navigationController?.pushViewController(searchVC, animated: true)
    }
        
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfUniversities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.universityName.text = viewModel.getNameOfUniversity(at: indexPath.row)
        cell.pageLink.text = viewModel.getPageLinkOfUniversity(at: indexPath.row)
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = viewModel.getUniversityData(at: indexPath.row)
        
        let detailVC = UniversityDetailViewController(name: data.name,
                                                      domain: data.domains[0],
                                                      country: data.country)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
         let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complectionHandler) in
             
             self.viewModel.removeUniversity(at: indexPath.row)
//             self.tableView.deleteRows(at: [indexPath], with: .automatic)
             
             complectionHandler(true)
        }
        
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

