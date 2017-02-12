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
  
  var fetechedResultsController: NSFetchedResultsController<Item>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }

}






// MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
  // table view data source methods
}






// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }
}






// MARK: - UITableViewDataSource
extension MainVC: NSFetchedResultsControllerDelegate {
  func attempFetch(){
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    let dateSort = NSSortDescriptor(key: "creationDate", ascending: false)
    fetchRequest.sortDescriptors = [dateSort]
    
    let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
  }
}
