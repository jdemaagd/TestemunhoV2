//
//  CategoryViewController+TableDelegate.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

// MARK: - UITableViewDelegate

extension ItemViewController: UISearchBarDelegate {
  
    // MARK: - DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.defaultReuseIdentifier, for: indexPath) as! ItemCell
        
        if let item = items?[indexPath.row] {
            if let createdDate = item.createdDate {
                cell.dateLabel?.text = self.dateFormatter.string(from: createdDate)
            }
            cell.titleLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.titleLabel?.text = "No Items Added"
        }

        return cell
    }
    
    
    // MARK: - Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = items?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                    // realm.delete(item)
                }
            } catch {
                print("Error saving done status, \(error.localizedDescription)")
            }
        }
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - UISearchBarDelegate
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        
//        let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "title", searchBar.text!)
//        
//        loadItems(with: request, predicate: predicate)
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
}
