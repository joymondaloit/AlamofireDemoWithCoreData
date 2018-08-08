//
//  DataBaseManager.swift
//  CoreDataFirst
//
//  Created by JOY MONDAL on 9/18/17.
//  Copyright © 2017 OPTLPTP131. All rights reserved.
//


import CoreData
import UIKit


enum Result
{
    case success(Any)
    case failure(String)
}

typealias DBResult = (Result) -> ()

class DataBaseManager: NSObject {
    
    
    private static var privateShared : DataBaseManager?
    
    
    let managedContext: NSManagedObjectContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var allDetails = [Log]()
    
    class func shared() -> DataBaseManager {
        guard let uwShared = privateShared
            else
        {
            privateShared = DataBaseManager()
            return privateShared!
        }
        return uwShared
    }
    
    class func dispose() {
        privateShared = nil
    }
    
    private override init()
    {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    
    
    func save(withCompletion c : DBResult)  {
        do {
            try managedContext.save()
            //print("saved!")
            c(.success("Saved"))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            c(.failure("Could not save"))
            //self.delegate?.operationDidFail(errorMsg: "Could not save")
        }
    }
    
    func fetch(withCompletion c : DBResult)  {
        
        let fetchRequest = Log.fetchRequest() as NSFetchRequest
        do {
            allDetails = try managedContext.fetch(fetchRequest) as [Log]
            
            
            c(.success(allDetails))

            //self.delegate?.operationOnFetchSuccess(result: allDetails)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            c(.failure("Could not fetch"))

            //self.delegate?.operationDidFail(errorMsg: "Could not fetch")
        }
        
    }
    
    
    
    func deleteAllRecords()
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = Log.fetchRequest() as NSFetchRequest
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
    func delete(empID: String, name: String,withCompletion c : DBResult)  {
        
        let fetchRequest = Log.fetchRequest() as NSFetchRequest
        let predicate = NSPredicate(format: "empID == %@", empID)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest) as [Log]
            for item in result
            {
                managedContext.delete(item)
            }
            
            try managedContext.save()
            if result.count > 0
            {
                print("Deleted!")
            }
            c(.success("Deleted"))
            //self.delegate?.operationDidSuccess()
            
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            c(.failure("Could not delete"))

            //self.delegate?.operationDidFail(errorMsg: "Could not delete")
        }
        
    }
    
    
   // func update(empID: String, age: String, name: String, dept: String, withCompletion c : DBResult)
//    {
//
//        let fetchRequest = Log.fetchRequest() as NSFetchRequest
//        let predicate = NSPredicate(format: "empID == %@", empID)
//        fetchRequest.predicate = predicate
//
//        do {
//            let result = try managedContext.fetch(fetchRequest) as [Log]
//            if result.count > 0
//            {
//            for item in result
//            {
//                item.name = name
//                item.age = age
//                item.dept = dept
//
//            }
//
//            try managedContext.save()
//            print("Updated!")
//            c(.success("Updated"))
//
//            //self.delegate?.operationDidSuccess()
//            }
//            else
//            {
//                 //self.delegate?.operationDidFail(errorMsg: "Please Enter Existing ID")
//                c(.failure("Please Enter Existing ID"))
//
//            }
//
//
//        } catch let error as NSError {
//            print("Could not update. \(error), \(error.userInfo)")
//            c(.failure("Could not update"))
//
//           // self.delegate?.operationDidFail(errorMsg: "Could not update")
//        }
//
//    }
    
}
