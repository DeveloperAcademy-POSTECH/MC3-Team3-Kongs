//
//  MainTabController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - Properties
    let divider: CALayer = {
        let topline = CALayer()
        topline.frame = CGRect(x: 0, y: -0.5, width: Device.width, height: 0.5)
        topline.backgroundColor = UIColor(hex: 0xD8D8D8).cgColor
        return topline
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        uiTabBarSetting()
    }
    
    //MARK: - Helpers
    func configureViewControllers() {
        let main = MainViewController()
        main.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        let schedule = ScheduleViewController()
        schedule.tabBarItem = UITabBarItem(title: "스케쥴", image: UIImage(systemName: "calendar"), tag: 1)
        let subscription = SubscriptionViewController()
        subscription.tabBarItem = UITabBarItem(title: "구독", image: UIImage(systemName: "star"), tag: 2)
    
        viewControllers = [main, schedule, subscription]
    }
    
    func uiTabBarSetting() {
        if #available(iOS 15.0, *){
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .background
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        //디바이더 추가
        self.tabBar.layer.addSublayer(divider)
        tabBar.tintColor = UIColor(hex: 0xD2D6D7)
    }
}
