//
//  LigandsTableViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit
import Alamofire

class LigandsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var ligands = [String]()
    var filteredLigands = [String]()
    var ligand = Ligand()
    
    @IBOutlet weak var searchBar: UISearchBar!
    //    @IBOutlet weak var ligandName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        filteredLigands = ligands
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor(red:0.87, green:0.98, blue:0.80, alpha:1.0)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "molecul"))
        imageView.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(imageView)
        let label = UILabel()
        label.text = "Ligands"
        label.frame = CGRect(x: 45, y: 5, width: 200, height: 35)
        view.addSubview(label)
        
        return view
    }
    
    override    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLigands.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ligand = filteredLigands[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ligand", for: indexPath)
        cell.textLabel?.text = ligand
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredLigands = searchText.isEmpty ? ligands : ligands.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = Request()
        let name = filteredLigands[indexPath.row]
        
        ligand.name = name
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        request.downloadLigandPDB(withName: name) { (data, error) in
            if error {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.displayPopup()
            } else {
                self.ligand.PDBInfo = data
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.performSegue(withIdentifier: "toProteinViewController", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProteinViewController" {
            if let vcProtein = segue.destination as? ProteinViewController {
                vcProtein.ligandModel = ligand
            }
        }
    }
    
    func displayPopup() {
        let alert = UIAlertController(title: "Can't download ligand", message: "Another one please", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            print("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}












