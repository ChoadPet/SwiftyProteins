//
//  LigandsTableViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class LigandsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var listOfLigands = [String]()
    var filteredLigands = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        filteredLigands = listOfLigands
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLigands.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ligand", for: indexPath) as! LigandTableViewCell
        let ligand = filteredLigands[indexPath.row]
        cell.setLigandName(ligand: ligand)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredLigands = searchText.isEmpty ? listOfLigands : listOfLigands.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
