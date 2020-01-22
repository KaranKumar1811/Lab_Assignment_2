//
//  AddViewController.swift
//  Lab_Assignment_2
//
//  Created by Sandeep Jangra on 2020-01-21.
//  Copyright © 2020 Karan. All rights reserved.
//

import UIKit
import CoreData
class AddViewController: UIViewController {

     @IBOutlet var textfields : [UITextField]!

        
        var tasks : [Task]?
        weak var delegate : TaskListTableVC?
        
        override func viewDidLoad() {
            super.viewDidLoad()
    //        tasks = [Task]()
            
            SaveCoreData()

    //               NotificationCenter.default.addObserver(self, selector: #selector(saveCoreData),name: UIApplication.willResignActiveNotification,object: nil)
                   // Do any additional setup after loading the view.
            NotificationCenter.default.addObserver(self, selector: #selector(SaveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
            
        }
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

        
        
        @IBAction func addTask(_ sender: UIBarButtonItem) {
            let title1 = textfields[0].text ?? ""
            let days1 = Int(textfields[1].text ?? "0") ?? 0
                       
                    
            let task = Task(title: title1, days: days1)
            tasks?.append(task)
            
                       for textField in textfields {
                            textField.text = ""
                           textField.resignFirstResponder()
                       }
            
            
                   }
        
        
        override func viewWillDisappear(_ animated: Bool) {
                //delegate?.tableView.reloadData()
            delegate?.updateArray(taskArray: tasks!)
            
        //        print(tasks!.count)
            }
            
    //               override func prepare(for segue:UIStoryboardSegue, sender : Any?){
    //                   if let TaskTable = segue.destination as? TaskListTableVC {
    //                    TaskTable.tasks = self.tasks
    ////                    print(TaskTable.tasks!)
    //                   }
    //                }

        
        @objc func SaveCoreData(){
            //call clear core data
          
                clearCoreData()
            //create an instance of app delegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            // context
            let ManagedContext = appDelegate.persistentContainer.viewContext

            for task in tasks!{
                let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: ManagedContext)
               taskEntity.setValue(task.title, forKey: "title")
               taskEntity.setValue(task.days, forKey: "days")


                //save  context
                do{
                    try ManagedContext.save()
                }catch{
                    print(error)
                }


                print("\(task.days)&&&&")
            }
             LoadCoreData()
        }

        func LoadCoreData(){

            tasks = [Task]()
            //create an instance of app delegate
                   let appDelegate = UIApplication.shared.delegate as! AppDelegate

                   // context
                   let ManagedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")

            do{
                let results = try ManagedContext.fetch(fetchRequest)
                if results is [NSManagedObject]{
                    for result in results as! [NSManagedObject]{
                        let title = result.value(forKey:"title") as! String

                        let days = result.value(forKey: "days") as! Int


                        tasks?.append(Task(title: title, days: days))

                    }
                }
            } catch{
                print(error)
            }
            
          
        }


        func clearCoreData(){
         //create an instance of app delegate
         let appDelegate = UIApplication.shared.delegate as! AppDelegate

         // context
         let ManagedContext = appDelegate.persistentContainer.viewContext

            //create fetch request
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")

            fetchRequest.returnsObjectsAsFaults = false
            do{

                let results = try ManagedContext.fetch(fetchRequest)
                for managedObjects in results{
                    if let managedObjectsData = managedObjects as? NSManagedObject{

                        ManagedContext.delete(managedObjectsData)
                    }
                }
            }
                catch{
                    print(error)
                }

        }

        
        
        
        
        //files
        
    //    func getFilepath() -> String{
    //               let documantPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    //               if documantPath.count > 0 {
    //                   let documentDirectory = documantPath[0]
    //                   let filepath = documentDirectory.appending("/taskdata.txt")
    //                   return filepath
    //               }
    //               return ""
    //
    //           }
    //
    //           func loadData(){
    //               let filepath = getFilepath()
    //
    //            tasks = [Task]()
    //               if FileManager.default.fileExists(atPath : filepath){
    //                   do{
    //                       //extract data
    //                       let fileContents = try String(contentsOfFile:filepath)
    //                       let conentArray = fileContents.components(separatedBy:"\n")
    //                       for content in conentArray{
    //                           let  taskcontent = content.components(separatedBy:",")
    //                           if taskcontent.count == 4 {
    ////                               let book = Book(title:bookcontent[0],author: bookcontent[1],pages:Int(bookcontent[2])!,year:Int(bookcontent[3])!)
    ////                               books?.append(book)
    //
    //
    //                            let task = Task(title: taskcontent[0], days: Int(taskcontent[1])!)
    //                            tasks?.append(task)
    //                           }
    //                       }
    //                   }catch{
    //                       print(error)
    //                   }
    //               }
    //
    //           }
    //
    //
    //
    //
    //    @objc func saveData(){
    //            let filepath = getFilepath()
    //            var saveString = ""
    //            for task in tasks!{
    //                saveString = "\(saveString)\(task.title),\(task.days)"
    //            }
    //            //write to path
    //
    //            do{
    //
    //        try saveString.write(toFile:filepath, atomically : true , encoding : .utf8)
    //            }
    //            catch{
    //                print(error)
    //            }
    //        }
    //
    //
    //
    //
    //
        
        
        
        
    }
