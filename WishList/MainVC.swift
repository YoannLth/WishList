//
//  ViewController.swift
//  WishList
//
//  Created by yoann lathuiliere on 28/11/2016.
//  Copyright © 2016 ylth. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  var controller: NSFetchedResultsController<Item>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    generateTestData()
    
    attempFetch()
  }

  func generateTestData() {
    let item = Item(context: context)
    item.title = "Macbook Pro"
    item.price = 1800
    item.details = "I fucking want this shit!"
    
    let item2 = Item(context: context)
    item2.title = "Stylo"
    item2.price = 1
    item2.details = "I fucking want this shit!"
    
    let item3 = Item(context: context)
    item3.title = "Ferrari"
    item3.price = 10000000
    item3.details = "I fucking want this shit!"
    
    _appDelegate.saveContext()
  }
}





// MARK: - UITableViewDelegate & UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
    configureCell(cell: cell, indexPath: indexPath)
    
    return cell
  }
  
  func configureCell(cell: ItemCell, indexPath: IndexPath) {
    let item = controller.object(at: indexPath)
    
    cell.configureCell(item: item)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = controller.sections {
      let sectionInfo = sections[section]
      return sectionInfo.numberOfObjects
    }
    
    return 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if let sections = controller.sections {
      return sections.count
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}






// MARK: - NSFetchedResultsControllerDelegate
extension MainVC: NSFetchedResultsControllerDelegate {
  func attempFetch(){
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    let dateSort = NSSortDescriptor(key: "creationDate", ascending: false)
    fetchRequest.sortDescriptors = [dateSort]
    
    let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    self.controller = controller
    
    do {
      try controller.performFetch()
    } catch {
      let error = error as NSError
      print("\(error)")
    }
  }
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      break
    case .move:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
    case .update:
      if let indexPath = indexPath {
        let cell = tableView.cellForRow(at: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
      }
      break
    }
  }
}
