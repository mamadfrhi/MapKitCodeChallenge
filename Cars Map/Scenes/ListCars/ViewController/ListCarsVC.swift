//
//  ListCarsVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class ListCarsVC: UIViewController {
    
    
    // MARK: Properties
    var viewModel: ListCarsVM! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var tableViewCars: UITableView!
    
    // MARK: UIViewController
    override func loadView() {
        super.loadView()
        viewModel.start()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: Setup
    private func setup() {
        setupDelegeates()
    }
    private func setupDelegeates() {
        tableViewCars.delegate = self
        tableViewCars.dataSource = self
    }

    // MARK: Actions
}

// MARK: - TableView Delegate & DataSource
extension ListCarsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.itemFor(row: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row, from: self)
    }
}

// MARK: - ViewModel Delegate
extension ListCarsVC: ListCarsViewModelViewDelegate {
    func refreshScreen(with annotaions: [Car]) {
        print("ListCarsVC received refreshScreen")
    }
    
    func selected(car: Car) {
        print("ListCarsVC received selected")
    }
    
}
