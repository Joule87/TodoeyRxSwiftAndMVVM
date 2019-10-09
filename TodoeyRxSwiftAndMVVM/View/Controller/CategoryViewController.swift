//
//  ViewController.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRealm

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    let categoryViewModel = CategoryViewModel()
    let disposedBag = DisposeBag()
    
    //MARK:- View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
        setupTableViewBinds()
    }
    
    func setupUIElements() {
        let viewControllerTitle = "Category"
        title = viewControllerTitle
    }
    
    func setupTableViewBinds() {
        let categoryCellIdentifier = "CategoryTableViewCell"
        
        Observable.collection(from: categoryViewModel.categoryList)
            .observeOn(MainScheduler.instance)
            .bind(to: categoryTableView.rx.items(cellIdentifier: categoryCellIdentifier)) { (index, category, cell) in
                cell.textLabel?.text = category.title
        }.disposed(by: disposedBag)
        
        categoryTableView.rx.modelSelected(Category.self).subscribe(onNext: {
            self.performSegue(withIdentifier: "goToItems", sender: $0)
            }).disposed(by: disposedBag)
   
    }
    
    //MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ItemViewController else {
            return
        }
        if let category = sender as? Category {
            destinationVC.itemViewModel.selecteCategory = category
        }
    }
    
    //MARK:- Action
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        let actions: [UIAlertController.AlertAction] = [
            .action(title: "Cancel", style: .destructive),
            .action(title: "Add")
        ]

        UIAlertController.present(in: self, title: "Add", message: "Add Category", style: .alert, actions: actions)
            .subscribe(onNext: { [weak self] textValue in
                if let text = textValue {
                    self?.categoryViewModel.addCategory(categoryTitle: text)
                }
            }).disposed(by: disposedBag)
    }
    

}

