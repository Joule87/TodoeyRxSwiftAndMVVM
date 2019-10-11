//
//  UIAlertControllerExtension.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import RxSwift

extension UIAlertController {
    
    struct AlertAction {
        var title: String?
        var style: UIAlertAction.Style
        
        static func action(title: String?, style: UIAlertAction.Style = .default) -> AlertAction {
            return AlertAction(title: title, style: style)
        }
    }
    
    static func present(
        in viewController: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [AlertAction])
        -> Observable<String?>
    {
        return Observable.create { observer in
            var textField = UITextField()
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: style)
            alertController.addTextField { (alertTextField) in
                alertTextField.placeholder = message
                textField = alertTextField
            }
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    if index == 1 {
                        observer.onNext(nil)
                    } else {
                        observer.onNext(textField.text)
                    }
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}
