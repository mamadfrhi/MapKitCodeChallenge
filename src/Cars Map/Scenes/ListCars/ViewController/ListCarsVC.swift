//
//  ListCarsVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class ListCarsVC: UIViewController {
    
    // MARK: Factory
    class func `init`(listCarsVM: ListCarsVM) -> ListCarsVC {
        let storyboard = UIStoryboard(name: "ListCars", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListCarsVC") as! ListCarsVC
        // take care of force unwrap above
        vc.viewModel = listCarsVM
        return vc
    }
    
    // MARK: Properties
    private var viewModel: ListCarsVM!
    private let cellIndentifier = "CarCell"
    
    // MARK: Outlets
    @IBOutlet weak var tableViewCars: UITableView!
    
    // MARK: UIViewController
    
    // MARK: Setup
}

// MARK: - TableView Delegate & DataSource
extension ListCarsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carViewDataAny = viewModel.itemFor(row: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier),
              let carViewData = carViewDataAny as? CarViewData  else {
            return UITableViewCell()
        }
        cell.textLabel?.text = carViewData.modelName
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row, from: self)
    }
}
