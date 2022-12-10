//
//  ViewController.swift
//  Project21
//
//  Created by Yunus Emre Bayezit on 19.10.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            }
            
            else {
                print("D'oh")
            }
        }
    }

    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 12
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
     
    }
    
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
   
        //let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let later = UNNotificationAction(identifier: "later", title: "Remind me 24 hours later", options: .destructive)
        
        //let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        let category = UNNotificationCategory(identifier: "alarm", actions: [later], intentIdentifiers: [])
        
        //center.setNotificationCategories([category])
        center.setNotificationCategories([category])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // gömülü userInfo sözlüğünü çıkar
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // kullanıcı kilidi açmak için kaydırdı
                print("Default identifier")
                
            case "show":
                // kullanıcı "daha fazla bilgi göster..." düğmemize dokundu
                print("Show more information…")
                
            case "later":
                print("Remember after 24 hours")
                   
                //Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(scheduleLocal), userInfo: nil, repeats: true)
                //print("Timer ile 24 saat sonra bildirim gelecektir")

            default:
                break
            }
        }

        // işiniz bittiğinde tamamlama işleyicisini(completion handler) çağırmalısınız
        completionHandler()
    }
}
