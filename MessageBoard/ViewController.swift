//
//  ViewController.swift
//  MessageBoard
//
//  Created by imac-1681 on 2023/7/10.
//
import RealmSwift
import UIKit
import SwiftUI
class ViewController : UIViewController {
    
    @IBOutlet weak var sortButtom: UIButton!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var strTextview: UITextView!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var messageTableview: UITableView!
    
    var f:[message123] = []
    var add111:Int = 0
    var tempTime:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
 
    }
   
    func setupUI() {
        setupLabel()
        setupButton()
        setupTextView()
        setupTableView()
        setupDB()
        disKey()
    }
    @objc func dismissKeyBoard() {
            self.view.endEditing(true)
        }
    func disKey(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
                self.view.addGestureRecognizer(tap)
    }
    func setupLabel() {
        peopleLabel.text = "你的名字"
        messageLabel.text = "內容"
    }
    
    func setupButton() {
        enter.setTitle("送出", for:.normal)
        time.setTitle("清除", for: .normal)
//        sortButtom.setTitle("排序", for: .normal)
        sortButtom.setImage(UIImage(systemName: "trash.square"), for: .normal)
    }
    
    func setupTextView() {
        strTextview.layer.backgroundColor = UIColor.red.cgColor
    }
    
    func setupTableView() {
        messageTableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.idfile)
        messageTableview.delegate = self
        messageTableview.dataSource = self
    }
    
    func setupDB() {
        fetchFromDB()
        printDBUrl()
    }
    
    func fetchFromDB(){
        f = []
        let realm = try! Realm()
        let peoples = realm.objects(RealmModel.self)
        if peoples.count >= 0{
            for i in peoples {
                let ff = message123(id: i._id, time: i.time, people: i.people, message:i.message
                )
                f.append(ff)
            }
            messageTableview.reloadData()
        }
    }
    
    func printDBUrl(){
        let realm = try! Realm()
        print("file url\(realm.configuration.fileURL!)")
    }
    
    func addMessage(){
        let realm = try! Realm()
        let todo = RealmModel(people: nameTextfield.text!, message: strTextview.text!,time: setTime())
        try! realm.write {
            realm.add(todo)
        }
    }
    
    
    func deleteMessage(time: Int) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "time == \(time)")
        let del = realm.objects(RealmModel.self).filter(predicate)
        try! realm.write {
            realm.delete(del)
        }
    }
    func setTime() -> Int {
        let now = Date()
        let timeInterval = now.timeIntervalSince1970
        return Int(timeInterval)
    }
    func showAlert(){
        let alertController = UIAlertController(title: "時間排序", message:"",
                                                preferredStyle: .actionSheet)
        // 建立取消按鈕
        let cancelBtn = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelBtn)
        
        // 建立送出按鈕
        let sendBtn1 = UIAlertAction(
            title: "時間由新到舊",
            style: UIAlertAction.Style.default,
            handler: { [self] _ in
                fetchFromDB()
                f.sort { a, b in
                    return a.time > b.time
                }

                
            })
        alertController.addAction(sendBtn1)
        
        let sendBtn2 = UIAlertAction(
            title: "時間由舊到新",
            style: UIAlertAction.Style.default,
            handler: {_ in
                self.fetchFromDB()
                self.f.sort { a, b in
                    a.time < b.time
                }
            })
        alertController.addAction(sendBtn2)
        self.present(alertController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sorT(_ sender: UIButton) {
        showAlert()
    }
    @IBAction func clear(_ sender: Any) {
        let alertController = UIAlertController(
            title: "警告",
            message: "已把內容清空",
            preferredStyle: .alert)
        // 建立[取消]按鈕
        let cancelAction = UIAlertAction(
          title: "確定",
          style: .cancel,
          handler: nil)
        alertController.addAction(cancelAction)
        self.present(
              alertController,
              animated: true,
              completion: nil)
        nameTextfield.text = ""
        strTextview.text = ""
    }
    @IBAction func sendButton(_ sender: UIButton) {
        switch add111{
        case 0:
            if nameTextfield.text == "" && strTextview.text == "" {
                // 建立一個提示框
                    let alertController = UIAlertController(
                        title: "錯誤",
                        message: "請輸入名字跟訊息",
                        preferredStyle: .alert)
                    // 建立[取消]按鈕
                    let cancelAction = UIAlertAction(
                      title: "確定",
                      style: .cancel,
                      handler: nil)
                    alertController.addAction(cancelAction)
                    // 顯示提示框
                self.present(
                      alertController,
                      animated: true,
                      completion: nil)
                break
            }
            if strTextview.text == "" {
                // 建立一個提示框
                    let alertController = UIAlertController(
                        title: "錯誤",
                        message: "請輸入訊息",
                        preferredStyle: .alert)
                    // 建立[取消]按鈕
                    let cancelAction = UIAlertAction(
                      title: "確定",
                      style: .cancel,
                      handler: nil)
                    alertController.addAction(cancelAction)
                    // 顯示提示框
                self.present(
                      alertController,
                      animated: true,
                      completion: nil)
                break
            }
            if nameTextfield.text == "" {
                // 建立一個提示框
                    let alertController = UIAlertController(
                        title: "錯誤",
                        message: "請輸入名字",
                        preferredStyle: .alert)
                    // 建立[取消]按鈕
                    let cancelAction = UIAlertAction(
                      title: "確定",
                      style: .cancel,
                      handler: nil)
                    alertController.addAction(cancelAction)
                    // 顯示提示框
                self.present(
                      alertController,
                      animated: true,
                      completion: nil)
                break
            }
            addMessage()
            fetchFromDB()
            clear((Any).self)
            let alertController = UIAlertController(
                title: "成功",
                message: "成功發送訊息",
                preferredStyle: .alert)
            // 建立[取消]按鈕
            let cancelAction = UIAlertAction(
              title: "確定",
              style: .cancel,
              handler: nil)
            alertController.addAction(cancelAction)
            self.present(
                  alertController,
                  animated: true,
                  completion: nil)
        case 1:
            let alertController = UIAlertController(
                title: "成功",
                message: "成功編輯訊息",
                preferredStyle: .alert)
            // 建立[取消]按鈕
            let cancelAction = UIAlertAction(
              title: "確定",
              style: .cancel,
              handler: nil)
            alertController.addAction(cancelAction)
            self.present(
                  alertController,
                  animated: true,
                  completion: nil)
            let realm = try! Realm()
            let predicate = NSPredicate(format: "time == \(tempTime)")
            let dog = realm.objects(RealmModel.self).filter(predicate)
            try! realm.write {
                dog[0].people = nameTextfield.text!
                dog[0].message = strTextview.text!
                fetchFromDB()
            }
            clear((Any).self)
            add111 = 0
        default:
            print("")
        }
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return f.count
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let likeAction = UIContextualAction(style: .normal, title: "刪除") {
            [self] (action, view, completionHandler) in
                let alertController = UIAlertController(
                    title: "送出",
                    message: "確認要送出了嗎？",
                    preferredStyle: .alert)
                let cancelAction = UIAlertAction(
                  title: "取消",
                  style: .cancel,
                  handler: nil)
                alertController.addAction(cancelAction)
                let okAction = UIAlertAction(
                  title: "刪除",
                  style: .default) { _ in
                      deleteMessage(time: f[indexPath.row].time)
                     self.fetchFromDB()
                  }
                alertController.addAction(okAction)
            self.present(
                  alertController,
                  animated: true,
                  completion: nil)
            
//            deleteMessage(time: f[indexPath.row].time)
//            self.fetchFromDB()
            completionHandler(true)
        }
        likeAction.backgroundColor = UIColor.red
        
        //         f.remove(at: indexPath.row)
        return UISwipeActionsConfiguration(actions: [likeAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let notLikeAction = UIContextualAction(style: .normal, title: "編輯") { (action, view, completionHandler) in
            
            self.tempTime = self.f[indexPath.row].time
            self.nameTextfield.text = self.f[indexPath.row].people
            self.strTextview.text = self.f[indexPath.row].message
            self.add111 = 1
            completionHandler(true)
        }
        notLikeAction.backgroundColor = UIColor.blue
        return UISwipeActionsConfiguration(actions: [notLikeAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //使用dequeueReusableCell來重複使用cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idfile, for: indexPath) as? TableViewCell else{ return UITableViewCell() }
        cell.nameCell.text = f[indexPath.row].people
        cell.textCell.text =  f[indexPath.row].message
        return cell
    }
    
}
