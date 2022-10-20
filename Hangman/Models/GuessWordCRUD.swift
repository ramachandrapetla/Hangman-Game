//
//  GuessWordCRUD.swift
//  Hangman
//
//  Created by Ramachandra petla on 10/5/22.
//

import UIKit
import CoreData

class GuessWordCRUD: NSObject {
    static func create(newWord:String, newCategory:String) {
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            //Create a new empty record.
            let guessWordEntity = NSEntityDescription.entity(forEntityName: "Guessword", in: managedContext)!
            //Fill the new record with values
            let guessword = NSManagedObject(entity: guessWordEntity, insertInto: managedContext)
            guessword.setValue(newWord, forKeyPath: "word")
            guessword.setValue(newCategory, forKey: "category")
            do {
                //Save the managed object context
                try managedContext.save()
            } catch let error as NSError {
                print("Could not create the new record! \(error), \(error.userInfo)")
            }
        }
    }
    
    
    static func read(category:String) -> String? {
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity (SELECT * FROM)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Guessword")
            //Add a contition to the fetch request (WHERE)
            fetchRequest.predicate = NSPredicate(format: "category = %@", category)
            //Add a sorting preference (ORDER BY)
            fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "word", ascending: false)]
            do {
                //Execute the fetch request
                let result = try managedContext.fetch(fetchRequest)
                if result.count > 0 {
                    let randNum = Int.random(in: 0 ..< result.count)
                    let record = result[randNum] as! NSManagedObject
                    let word = record.value(forKey: "word") as! String
                    return word
                }
            } catch let error as NSError {
                print("Could not fetch the record! \(error), \(error.userInfo)")
            }
        }
        return nil
    }
    
    
    static func delete(oldWord:String) {
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare a fetch request for the record to delete
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Guessword")
            fetchRequest.predicate = NSPredicate(format: "word = %@", oldWord)
            
            do {
                //Fetch the record to delete
                let test = try managedContext.fetch(fetchRequest)
                
                //Delete the record
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    //Save the managed object context
                    try managedContext.save()
                }
                catch let error as NSError {
                    print("Could not delete the record! \(error), \(error.userInfo)")
                }
            }
            catch let error as NSError {
                print("Could not find the record to delete! \(error), \(error.userInfo)")
            }
        }
    }
    
    
    static func update(oldWord:String, newWord:String) {
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare a fetch request for the record to update
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Guessword")
            fetchRequest.predicate = NSPredicate(format: "word = %@", oldWord)
            
            do{
                //Fetch the record to update
                let test = try managedContext.fetch(fetchRequest)
                //Update the record
                let objectToUpdate = test[0] as! NSManagedObject
                objectToUpdate.setValue(newWord, forKey: "word")
                do{
                    //Save the managed object context
                    try managedContext.save()
                }
                catch let error as NSError {
                    print("Could not update the record! \(error), \(error.userInfo)")
                }
            }
            catch let error as NSError {
                print("Could not find the record to update! \(error), \(error.userInfo)")
            }
        }
    }
}
