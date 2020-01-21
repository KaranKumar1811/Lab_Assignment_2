//
//  TaskTableViewController.swift
//  Lab_Assignment_2
//
//  Created by Sandeep Jangra on 2020-01-21.
//  Copyright © 2020 Karan. All rights reserved.
//



import UIKit
import CoreData

class TaskListTableVC: UITableViewController, UISearchBarDelegate {

    
     var filteredData: [Task]?
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var completed: UIButton!
    
    var isImportant = false
    var tasks : [Task]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       LoadCoreData()
//          filteredData = tasks
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks?.count ?? 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let task = tasks![indexPath.row]
     let cell = tableView.dequeueReusableCell(withIdentifier:"TaskCell")
        cell?.textLabel?.text = task.title
        cell?.detailTextLabel?.text = "\(task.days) days "
        // Configure the cell...

        
//
//        cell.settask(at: indexPath,task: [(tasks?[indexPath.row])!])
       
        return cell!
    }
    
    
   
//    override func viewWillAppear(_ animated: Bool) {
//        self.tableView.reloadData()
//    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
  

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {
        (action, view, success) in self.tasks?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
           
      })
         
        let AddDayAction = UIContextualAction(style: .normal, title: "Add a Day") {
          (action , view, success) in
           
          self.tasks![indexPath.row].days -= 1
          self.tableView.reloadData()
           
           
        }
         
        AddDayAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [deleteAction , AddDayAction])
         
      }
       
      override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         
         
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {
        (action, view, success) in self.tasks?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
              
          })
            
        let AddDayAction = UIContextualAction(style: .normal, title: "Add a Day") {
        (action , view, success) in
        self.tasks![indexPath.row].days -= 1
        self.tableView.reloadData()
        }
         
        AddDayAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [deleteAction , AddDayAction])
            
        }
       
       override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->UITableViewCell.EditingStyle {
        return .none
      }
       
      override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath:IndexPath) -> Bool {
        return false
      }
       
      override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let move = self.tasks![sourceIndexPath.row]
        tasks!.remove(at: sourceIndexPath.row)
        tasks!.insert(move, at: destinationIndexPath.row)
      }





    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detailview = segue.destination as? AddViewController{
            detailview.delegate = self
            detailview.tasks = tasks
        }
    }
    
    
    func updateArray(taskArray:[Task]){
        self.tasks = taskArray
        tableview.reloadData()
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
           print("\(tasks!.count )@@@@@@@@@@@@@")
         
       }
    
    
    
    
    func addDay(){
        
        let alertcontroller = UIAlertController(title: "Add Day", message: "Enter a day for this task", preferredStyle: .alert)
               
               alertcontroller.addTextField { (textField ) in
                               textField.placeholder = "number of days"
                   textField.text = ""
               }
               let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               CancelAction.setValue(UIColor.brown, forKey: "titleTextColor")
               let AddItemAction = UIAlertAction(title: "Add Item", style: .default){
                   (action) in
                
                
                
                
                
                
                
                
        
    }
        AddItemAction.setValue(UIColor.black, forKey: "titleTextColor")
                             alertcontroller.addAction(CancelAction)
                             alertcontroller.addAction(AddItemAction)
                             self.present(alertcontroller, animated: true, completion: nil)
}
    
    
    
    
    
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
        filteredData = searchText.isEmpty ? tasks! : tasks!.filter { (item: Task) -> Bool in
                // If dataItem matches the searchText, return true to include it
    //            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            let task = item.title
                return task.lowercased().contains(searchText.lowercased())
            }
            
            tableView.reloadData()
        }
        
    
    
    
}