//
//  CoreData.swift
//  iCalc
//
//  Created by Дмитрий Селезнев on 14.07.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import UIKit
import CoreData

class CoreDataMethods {
    
    static let shared = CoreDataMethods()
    
    func saveRoundingValue(roundingValue: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Rounding",
                                                in: context)
        let roundingNum = NSManagedObject(entity: entity!,
                                          insertInto: context) as! Rounding
        roundingNum.roundingValue = Int64(roundingValue)
        
        do {
            try context.save()
            print("Done save")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func fetchReqest() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReqest: NSFetchRequest<Rounding> = Rounding.fetchRequest()
        
        do {
            
            let result = try context.fetch(fetchReqest)
            if !result.isEmpty == true {
                print("\(result.count)")
                roundingValue = Int(result[result.count - 1].roundingValue)
                print("\(result.count)")
            } else {
                roundingValue = 2
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
