//
//  ItemViewController.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ItemViewController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    var itemViewModel = ItemViewModel()
    let disposeBag = DisposeBag()
    
    //MARK:- View Controller Methods
    
    override func viewDidLoad() {
        setupUIElements()
        setupTableViewBinds()
        
    }
    
    func setupTableViewBinds() {
        let itemCellIdentifier = "ItemTableViewCell"
    
        guard let itemList = itemViewModel.selecteCategory?.items else { return }
        
        Observable.array(from: itemList).observeOn(MainScheduler.instance).bind(to: itemTableView.rx.items(cellIdentifier: itemCellIdentifier)) { (index, item, cell) in
            cell.textLabel?.text = item.name
            cell.accessoryType = item.done ? .checkmark : .none
        }.disposed(by: disposeBag)
        
        itemTableView.rx.modelSelected(Item.self).subscribe(onNext: { [weak self] item in
            guard let saveSelf = self else { return }
            saveSelf.itemViewModel.updateItem {
                item.done = !item.done
            }
        }).disposed(by: disposeBag)
            
    }
    
    func setupUIElements() {
        let viewControllerTitle = "Items"
        title = viewControllerTitle
    }
    
    //MARK:- Action
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let actions: [UIAlertController.AlertAction] = [
            .action(title: "Cancel", style: .destructive),
            .action(title: "Add")
        ]

        UIAlertController.present(in: self, title: "Add", message: "Add Item", style: .alert, actions: actions)
            .subscribe(onNext: { [weak self] textValue in
                if let itemName = textValue {
                    self?.itemViewModel.addItem(itemName: itemName)
                }
            }).disposed(by: disposeBag)
    }
    
}
