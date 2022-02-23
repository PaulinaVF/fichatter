//
//  ChatViewController.swift
//  fichatter
//
//  Created by Paulina Vara on 25/08/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var textsTableView: UITableView!
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = K.appTitle
        navigationItem.hidesBackButton = true
        
        //When the table view loads it's going to request info to fill it... In order to be able to fill it we must adopt the UITableViewDataSource protocol then we set ourselves as data source:
        textsTableView.dataSource = self
        
        //To use an external cell design from a xib
        textsTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        readMessages()
    }
    
    func readMessages () {
        db.collection(K.FireStore.collectionName)
            .order(by: K.FireStore.dateField)
            .addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                self.alertError(message: "Error getting documents: \(err)")
            } else {
                if let queryDocuments = querySnapshot?.documents {
                    var messages2: [Message] = []
                    for document in queryDocuments {
                        print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        if let sender = data[K.FireStore.senderField] as? String, let messageBody = data[K.FireStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            messages2.append(newMessage)
                            
                            //When we are trying to modify our interface in a closer we must always place it in a DispatchQueue
                            DispatchQueue.main.async {
                                self.textsTableView.reloadData()
                            }
                            
                        }
                    }
                    if messages2.count != 0 {
                        self.messages = messages2
                    }
                }
                
            }
        }
    }
    
    @IBAction func sendText(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FireStore.collectionName).addDocument(data:
                                                                    [K.FireStore.senderField : messageSender,
                                                                     K.FireStore.bodyField : messageBody,
                                                                     K.FireStore.dateField: Date().timeIntervalSince1970]) { error in
                if let e = error {
                    let stringError = "\(e)"
                    self.alertError(message: stringError)
                } else {
                    print("Success")
                }
            }
        }
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            let error = "\(K.logoutError): \(signOutError)"
            alertError(message: error)
        }
        
    }
    
}


extension ChatViewController: UITableViewDataSource {
    //This protocol allows us to fill the table with data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //In this function you set how many cells you have in the table view
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //This method is asking us for a UITableViewCell that it should display at each row of our table view
        //IndexPath is the position (number / index) of the cell
        
        //We create a cell... the Identifier must have been set on main.storyboard to a tableviewcell
            //We cat it to our customed MessageCell design
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        // We can set its customed content:
        cell.messageLabel.text = messages[indexPath.row].body
        //We return the cell
        return cell
    }
}
