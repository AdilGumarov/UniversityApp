//
//  MainViewModel.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import UIKit
import CoreData

class MainViewModel {

//    private var list = [UniversityData]()
    private var list = [University]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getSelectedUniversities() -> Set<String> {
        var result: Set<String> = []
        list.forEach { university in
            result.insert(university.name!)
        }
        return result
    }
    
    func setDataFromCoreData() {
        list.removeAll()
        let fetchRequest: NSFetchRequest<University> = University.fetchRequest()
        if let objects = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
//            objects.forEach { university in
//                let data = UniversityData(country: university.country!, name: university.name!, alphaTwoCode: university.alpha_two_code!, domains: [university.domains!], webPages: [university.web_pages!])
//                list = objects
//            }
            list = objects//.reversed()
        }
    }
    
    func getNumberOfUniversities() -> Int {
        list.count
    }
    
    func getNameOfUniversity(at row: Int) -> String {
        list[row].name!
    }
    
    func getPageLinkOfUniversity(at row: Int) -> String {
        list[row].web_pages!
    }
    
    func getUniversityData(at row: Int) -> UniversityData {
        let data = UniversityData(country: list[row].country!,
                                  name: list[row].name!,
                                  alphaTwoCode: list[row].alpha_two_code!,
                                  domains: [list[row].domains!],
                                  webPages: [list[row].web_pages!]
                    )
        return data
    }
    
    func removeUniversity(at row: Int) {
        let context = appDelegate.persistentContainer.viewContext
        context.delete(list[row])
        do {
            try context.save()
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}

