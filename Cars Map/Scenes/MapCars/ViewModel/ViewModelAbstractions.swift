////
////  ViewModelAbstractions.swift
////  Cat Facts
////
////  Created by iMamad on 4/9/22.
////
//
//import UIKit
//
//// MARK: - ViewModelType
//protocol CatsViewModelType {
//    
//    var viewDelegate: CatsViewModelViewDelegate? { get set }
//    
//    // Data Source
//    func numberOfItems() -> Int
//    
//    func itemFor(row: Int) -> UITableViewCell
//    
//    // Events
//    func add()
//    
//    func delete()
//    
//    func didSelectRow(_ row: Int, from controller: UIViewController)
//    
//    func refreshView()
//}
//
//// MARK: - ViewModelCoordinator(delegate)
//protocol CatsViewModelCoordinatorDelegate: class {
//    func didSelect(cat: Cat, from controller: UIViewController)
//}
//
//// MARK: - ViewModelViewDelegate
//protocol CatsViewModelViewDelegate: class {
//    func updateScreen()
//    func hud(show: Bool)
//    func showError(errorMessage: String)
//    func selectedCatRow() -> Int
//}
