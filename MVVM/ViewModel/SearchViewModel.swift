//
//  SearchViewModel.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import Foundation
import UIKit
import CoreData

class SearchViewModel {
 
    private var list = [UniversityData]()
    private var selectedUniversities: Set<String> = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    private var selectedUniversities1 = [NSManagedObject]()
        
    
//    init(selectedUniversities: Set<String>) {
//        self.selectedUniversities = selectedUniversities
//    }
    
    func getNumberOfUniversities() -> Int {
        list.count
    }
    
    func getNameOfUniversity(at row: Int) -> String {
        list[row].name
    }
    
    func getState(at row: Int) -> Bool {
        selectedUniversities.contains(list[row].name)
    }
    
    func getUniversity(at row: Int) -> UniversityData {
        list[row]
    }
    
    func isContainSelectedUniversity(name: String) -> Bool {
        selectedUniversities.contains(name)
    }
    
    func insertUniversity(name: String) { // ??
        let optionalData = list.first(where: {
            $0.name == name
        })
        if let data = optionalData {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "University", in: context)!
            let university = NSManagedObject(entity: entity, insertInto: context)
            university.setValue(data.country, forKey: "country")
            university.setValue(data.name, forKey: "name")
            university.setValue(data.domains[0], forKey: "domains")
            university.setValue(data.alphaTwoCode, forKey: "alpha_two_code")
            university.setValue(data.webPages[0], forKey: "web_pages")
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
            
        }
        selectedUniversities.insert(name)
    }
    
    func setAddedUniversities() {
        let fetchRequest: NSFetchRequest<University> = University.fetchRequest()
        if let objects = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
            objects.forEach { obj in
                selectedUniversities.insert(obj.name!)
            }
        }
    }
    
    func fetchingData(URL url: String, completion: @escaping ([UniversityData]) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if data != nil && error == nil {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let parsingData = try decoder.decode([UniversityData].self, from: data!)
                        completion(parsingData)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getUniversityByCountry(countryName: String, completion: @escaping () -> Void) {
        let urlString = "http://universities.hipolabs.com/search?&country=\(countryName)"
        fetchingData(URL: urlString) { result in
            self.list = result
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
