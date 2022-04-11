////
////  CatsViewModel.swift
////  Cat Facts
////
////  Created by iMamad on 4/8/22.
////
//
//import UIKit
//import CoreData
//
//class CatsViewModel {
//    
//    // MARK: Delegates
//    var coordinatorDelegate: CatsCoordinator?
//    var viewDelegate: CatsViewModelViewDelegate?
//    
//    // MARK: Properties
//    private let service: CatsServices // API Call & CoreData
//    
//    var cats: [Cat] = []
//    var catsNSManagedObjects: [NSManagedObject]?
//    
//    // MARK: Init
//    init(service: CatsServices) { self.service = service }
//    
//    func start() {
//        service.fetchSavedCats {
//            [weak self]
//            (catsNSObjectArray, error) in
//            guard let sSelf = self,
//                  let catsNSObjectArray = catsNSObjectArray as? [NSManagedObject] else {
//                return
//            }
//            sSelf.catsNSManagedObjects = catsNSObjectArray
//            let cats = CatCoreDataConvertor().giveMeCats(from: catsNSObjectArray)
//            sSelf.cats = cats
//        }
//    }
//    
//}
//
//// MARK: - Network
//extension CatsViewModel {
//    private func getNewCat() {
//        DispatchQueue.main.async {
//            self.viewDelegate?.hud(show: true)
//        }
//        service.fetchCat {
//            [weak self]
//            (cat, error) in
//            guard let sSelf = self else { return }
//            
//            if let error = error {
//                DispatchQueue.main.async {
//                    sSelf.viewDelegate?.showError(errorMessage: error.localizedDescription)
//                }
//                return
//            }
//            
//            if let cat = cat as? Cat {
//                DispatchQueue.main.async {
//                    sSelf.saveNewCat(cat: cat)
//                    sSelf.viewDelegate?.updateScreen()
//                    sSelf.viewDelegate?.hud(show: false)
//                }
//                return
//            }
//            sSelf.viewDelegate?.showError(errorMessage: "Some Errors when communicating with the server occured!")
//            
//        }
//    }
//}
//
//// MARK: - Core Data
//extension CatsViewModel {
//    
//    func saveNewCat(cat: Cat) {
//        service.save(cat: cat) {
//            [weak self]
//            (error) in
//            guard let sSelf = self else { return }
//            
//            if let error = error {
//                DispatchQueue.main.async {
//                    sSelf.viewDelegate?.showError(errorMessage: error.localizedDescription)
//                }
//                return
//            }
//            
//            sSelf.refreshView()
//        }
//    }
//    
//    func remove(at index: Int?) {
//        
//        guard let row = index,
//              let catNSManagedObj = catsNSManagedObjects?[row] else { return }
//        
//        service.delete(cat: catNSManagedObj) {
//            [weak self]
//            (deleted, error) in
//            guard let sSelf = self else { return }
//            if let error = error {
//                DispatchQueue.main.async {
//                    sSelf.viewDelegate?.showError(errorMessage: error.localizedDescription)
//                }
//                return
//            }
//            
//            if deleted {
//                sSelf.refreshView()
//            }
//        }
//        
//    }
//}
//
//// MARK: - ViewModelType
//extension CatsViewModel: CatsViewModelType {
//    
//    func numberOfItems() -> Int {
//        return cats.count
//    }
//    
//    func itemFor(row: Int) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "catID")
//        let catViewData = CatViewData(cat: cats[row])
//        cell.textLabel?.text = catViewData._id
//        cell.detailTextLabel?.text = catViewData.createdAt
//        return cell
//    }
//    
//    func add() {
//        getNewCat()
//        viewDelegate?.updateScreen()
//    }
//    
//    func delete() {
//        let row = self.viewDelegate?.selectedCatRow()
//        self.remove(at: row)
//    }
//    
//    func didSelectRow(_ row: Int, from controller: UIViewController) {
//        print("Cat in \(row) selected")
//        didSelect(cat: cats[row], from: controller)
//    }
//    
//    func refreshView() {
//        start() // to refresh arrays
//        viewDelegate?.updateScreen()
//    }
//}
//
//// MARK: - ViewModelCoordinator
//extension CatsViewModel: CatsViewModelCoordinatorDelegate {
//    func didSelect(cat: Cat, from controller: UIViewController) {
//        coordinatorDelegate?.didSelect(cat: cat,
//                                       from: controller)
//        // It'll open CatDetail VC
//    }
//}
