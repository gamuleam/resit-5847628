//
//  noteTableViewController.swift
//  Easy Notes
//
//  Created by Laurentiu Gamulea on 01/07/2018.
//  Copyright © 2018 Laurentiu Gamulea. All rights reserved.
//

import UIKit
import CoreData


class noteTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var notes = [Note]()
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        retrieveNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! noteTableViewCell
        
        let note: Note = notes[indexPath.row]
        cell.configureCell(note: note)
        cell.backgroundColor = UIColor.clear
        
        
        


        return cell
    }
 

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            
            let note = notes[indexPath.row]
            context.delete(note)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                notes = try context.fetch(Note.fetchRequest())
            }catch {
                print(error)
            }
        }
        
        tableView.reloadData()  
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
 
    
    func retrieveNotes() {
        managedObjectContext?.perform {
            
            self.fetchedNotesFromCoreData { (notes) in
                if let notes = notes {
                    self.notes = notes
                    self.tableView.reloadData()
                    }
                }
                
        }
    }
    
    func fetchedNotesFromCoreData(completion: @escaping ([Note]?)-> Void) {
        managedObjectContext?.perform {
            var notes = [Note]()
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            
            do {
                notes = try self.managedObjectContext!.fetch(request)
                completion(notes)
            }
            
            catch{
                print ("Could not fetch notes from CoreData: \(error.localizedDescription)")
            }
        }
    }
    
    
    /*func loadData(){
        let noteRequest:NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try managedObjectContext.fetch(noteRequest)
            self.tableView.reloadData()
        }catch {
            print("Could not load data from database \(error.localizedDescription)")
        }
    }*/
    
 
    

}
