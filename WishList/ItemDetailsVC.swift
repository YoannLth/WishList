//
//  ItemDetailsVC.swift
//  WishList
//
//  Created by yoann lathuiliere on 15/03/2017.
//  Copyright © 2017 ylth. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var storePickerView: UIPickerView!
  @IBOutlet weak var titleTextField: CustomTextField!
  @IBOutlet weak var priceTextField: CustomTextField!
  @IBOutlet weak var detailsTextField: CustomTextField!
  @IBOutlet weak var itemImage: UIImageView!
  
  var stores = [Store]()
  var itemToEdit: Item?
  var imagePicker: UIImagePickerController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let topItem = self.navigationController?.navigationBar.topItem {
      topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    storePickerView.dataSource = self
    storePickerView.delegate = self
    titleTextField.delegate = self
    priceTextField.delegate = self
    detailsTextField.delegate = self
    imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    
    getStores()
    
    if itemToEdit != nil {
      loadItemData()
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      itemImage.image = image
    }
    
    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let store = stores[row]
    
    return store.name
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return stores.count
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
  }
  
  func getStores() {
    let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
    
    do {
      self.stores = try context.fetch(fetchRequest)
      self.storePickerView.reloadAllComponents()
    } catch {
      print("Error")
    }
  }
  
  @IBAction func saveButtonPressed(_ sender: Any) {
    var item: Item!
    let picture = Image(context: context)
    picture.image = itemImage.image
    
    if itemToEdit == nil {
      item = Item(context: context)
    } else {
      item = itemToEdit
    }
    
    if let title = titleTextField.text {
      item.title = title
    }
    
    if let price = priceTextField.text {
      item.price = (price as NSString).doubleValue
    }
    
    if let details = detailsTextField.text {
      item.details = details
    }
    
    item.toImage = picture
    item.toStore = stores[storePickerView.selectedRow(inComponent: 0)]
    
    _appDelegate.saveContext()
    
    navigationController?.popViewController(animated: true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  func loadItemData() {
    if let item = itemToEdit {
      titleTextField.text = item.title
      priceTextField.text = "\(item.price)"
      detailsTextField.text = item.details
      itemImage.image = item.toImage?.image as? UIImage
      
      if let store = item.toStore {
        var index = 0
        repeat {
          let s = stores[index]
          if s.name == store.name {
            storePickerView.selectRow(index, inComponent: 0, animated: true)
            break
          }
          index += 1
        } while (index < stores.count)
      }
    }
  }
  
  @IBAction func imgPickerButtonPressed(_ sender: Any) {
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func deleteButtonPressed(_ sender: Any) {
    if itemToEdit != nil {
      context.delete(itemToEdit!)
      _appDelegate.saveContext()
      
      navigationController?.popViewController(animated: true)
    }
  }

}
