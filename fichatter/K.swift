//
//  Constants.swift
//  fichatter
//
//  Created by Paulina Vara on 25/08/21.
//

struct K {
    //Segues
    static let registerToChatSegue = "RegisterSuccessSegue"
    static let loginToChatSegue = "LoginSuccessSegue"
    
    //App
    static let appTitle = "Fi Chat"
    
    //Elements Names
    static let cellIdentifier = "MessageReusableCell"
    static let cellNibName = "MessageCell"
    
    //Displayed Messages
    static let logoutError = "Error signing out"
    static let emptyFieldError = "Fill the empty fields"
    
    struct FireStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
