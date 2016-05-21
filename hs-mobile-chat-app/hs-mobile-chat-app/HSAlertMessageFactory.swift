//
//  HSAlertMessage.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/20/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

enum MessageType {
    case Alert
    case Error
    case AlertConfirmation
}

class HSAlertMessageFactory {
    
    class func createMessage(messageType:MessageType,msg:String) -> UIAlertController {
        
        var title:String = ""
        
        switch(messageType) {
        case .AlertConfirmation: fallthrough
        case .Alert: title = "Alert"
        case .Error: title = "Error"
        }
        
        let alertControler = UIAlertController(title:title, message: msg, preferredStyle: .Alert)
        
        return alertControler
        
    }

}

extension UIAlertController {
    
    func onCancel(handler:(UIAlertAction)->Void) -> UIAlertController {
        
        self.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: handler))
        
        return self
    }
    
    func onOk(handler:(UIAlertAction)->Void) -> UIAlertController {
        
        self.addAction(UIAlertAction(title: "Ok", style: .Default, handler: handler))
        
        return self
    }
}
