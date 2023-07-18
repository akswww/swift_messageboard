//
//  alert.swift
//  MessageBoard
//
//  Created by imac-1681 on 2023/7/14.
//

import Foundation
import UIKit
import RealmSwift

class alert {
   static func showA(title:String,message:String,title2:String,title3:String, action: (() -> Void)? = nil, view: UIViewController) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(
            title: title2,
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(
            title: title3,
            style: .default) { _ in
                action?()
            }
        alertController.addAction(okAction)
        view.present(alertController, animated: true)
    }
    static func showA(title:String, title1:String,message:String ,view: UIViewController){
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(
            title: title1,
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        view.present(alertController, animated: true)
    }
}
