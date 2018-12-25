//
//  Alert.swift
//  DemoGoogleMap
//
//  Created by Thang Hoa on 12/19/18.
//  Copyright © 2018 Thang Hoa. All rights reserved.
//

import UIKit


func showAlertToDeleteApp(title:String, message: String) {
    showAlertCompelete(title: title, message: message, settingsUrl: "App-prefs:root=General&path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE")
}

func showAlertToOpenSetting( title:String, message: String) {
    showAlertCompelete(title: title, message: message, settingsUrl: UIApplication.openSettingsURLString)
    
}

func showAlert(title:String, message: String, completeHandler: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
        completeHandler?()
    }
    alertController.addAction(okAction)
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
}

func showAlertCompelete(title:String, message: String, settingsUrl: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let settingAction = UIAlertAction(title: "Setting", style: .cancel) { (_) -> Void in
        guard let settingsUrl = URL(string: settingsUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.openURL(settingsUrl)
            } else {
                
            }
        }
    }
    let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
    }
    alertController.addAction(okAction)
    alertController.addAction(settingAction)
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
}


