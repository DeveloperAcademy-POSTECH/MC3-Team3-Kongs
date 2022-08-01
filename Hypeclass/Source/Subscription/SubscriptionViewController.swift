//
//  SubscriptionViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class SubscriptionViewController: BaseViewController{
   
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .background
        return tv
    }()
    
    private let dancerTabButton: UIButton = {
        var button = UIButton()
        button.setTitle("댄서", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let studioTabButton: UIButton = {
        var button = UIButton()
        button.setTitle("스튜디오", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let tabIndicatorView: UIView = UIView()
    
    private var tabIndicator: Separator = {
        let sep = Separator()
        sep.backgroundColor = .white
        return sep
    }()

    private var selectedTab = 0
    
    private let cellID = "subscription"
    
    private var dancerIDs = UserDefaults.standard.stringArray(forKey: "SubscribedDancers") ?? ["958DDBD8-689E-49D0-AC60-F7C0EC2611BC", "ADC4A0E1-50DF-4784-9228-EE4622C226E8", "0E36AA46-941C-40B0-9B18-818745EE1FD0"]
    
//    private var studioIDs = UserDefaults.standard.stringArray(forKey: "SubscribedStudios") ?? ["81DB67B8-9CAC-4AFE-B261-75BF7EE54534", "E23BD12A-ACDB-4BF6-B7C8-CFFC6BA4D1D4"]
    private var studioIDs = ["81DB67B8-9CAC-4AFE-B261-75BF7EE54534", "E23BD12A-ACDB-4BF6-B7C8-CFFC6BA4D1D4"]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(["81DB67B8-9CAC-4AFE-B261-75BF7EE54534", "E23BD12A-ACDB-4BF6-B7C8-CFFC6BA4D1D4"], forKey: "SubscribedStudios")
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studioIDs = UserDefaults.standard.stringArray(forKey: "SubscribedStudios") ?? []
        tableView.reloadData()
        Task {
            await requestMyDancers()
            await requestMyStudios()
        }
    }
    
    // MARK: - Selectors
    
    @objc func buttonTapped(_ sender: UIButton) {
        if selectedTab != sender.tag {
            switch sender.tag {
            case 0:
                UIView.animate(withDuration: 0.3) {
                    self.tabIndicator.frame.origin.x = 0
                }
                dancerTabButton.setTitleColor(UIColor.white, for: .normal)
                studioTabButton.setTitleColor(UIColor.gray, for: .normal)
                selectedTab = sender.tag
                tableView.reloadData()
            case 1:
                UIView.animate(withDuration: 0.3) {
                    self.tabIndicator.frame.origin.x = Device.width / 2
                }
                studioTabButton.setTitleColor(UIColor.white, for: .normal)
                dancerTabButton.setTitleColor(UIColor.gray, for: .normal)
                selectedTab = sender.tag
                tableView.reloadData()
            default:
                return
            }
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        // dancerTabButton
        view.addSubview(dancerTabButton)
        dancerTabButton.translatesAutoresizingMaskIntoConstraints = false
        dancerTabButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dancerTabButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dancerTabButton.widthAnchor.constraint(equalToConstant: Device.width / 2).isActive = true
        dancerTabButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        // studioTabButton
        view.addSubview(studioTabButton)
        studioTabButton.translatesAutoresizingMaskIntoConstraints = false
        studioTabButton.topAnchor.constraint(equalTo: dancerTabButton.topAnchor).isActive = true
        studioTabButton.leadingAnchor.constraint(equalTo: dancerTabButton.trailingAnchor).isActive = true
        studioTabButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        studioTabButton.bottomAnchor.constraint(equalTo: dancerTabButton.bottomAnchor).isActive = true
        
        // tabIndicatorView
        view.addSubview(tabIndicatorView)
        tabIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        tabIndicatorView.topAnchor.constraint(equalTo: dancerTabButton.bottomAnchor).isActive = true
        tabIndicatorView.leadingAnchor.constraint(equalTo: dancerTabButton.leadingAnchor).isActive = true
        tabIndicatorView.trailingAnchor.constraint(equalTo: studioTabButton.trailingAnchor).isActive = true
        tabIndicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        // Add tabIndicator to tabIndicatorView
        tabIndicatorView.addSubview(tabIndicator)
        tabIndicator.translatesAutoresizingMaskIntoConstraints = false
        tabIndicator.topAnchor.constraint(equalTo: tabIndicatorView.topAnchor).isActive = true
        tabIndicator.leadingAnchor.constraint(equalTo: tabIndicatorView.leadingAnchor).isActive = true
        tabIndicator.trailingAnchor.constraint(equalTo: tabIndicatorView.trailingAnchor, constant: -Device.width / 2).isActive = true
        tabIndicator.bottomAnchor.constraint(equalTo: tabIndicatorView.bottomAnchor).isActive = true
        
        // tableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: tabIndicator.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.backgroundColor = .clear
    }
    
    private func configureTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
    }
    
    // DancerManager.myDancers가 nil이면 Userdefault에 저장된 구독한 댄서 아이디 배열로 firebase에서 댄서 정보를 가져옵니다.
    private func requestMyDancers() async {
        if dancerIDs.count <= 0 { return }
        do {
            if DancerManager.myDancers == nil {
                IndicatorView.shared.show()
                IndicatorView.shared.showIndicator()
                DancerManager.myDancers = try await DancerManager.shared.requestDancersBy(dancerIDs: dancerIDs)
                IndicatorView.shared.dismiss()
            }
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    // StudioManager.myStudios가 nil이면 Userdefault에 저장된 구독한 스튜디오 아이디 배열로 firebase에서 스튜디오 정보를 가져옵니다.
    private func requestMyStudios() async {
        if studioIDs.count <= 0 { return }
        do {
            if StudioManager.myStudios == nil {
                IndicatorView.shared.show()
                IndicatorView.shared.showIndicator()
                StudioManager.myStudios = try await StudioManager.shared.requestStudiosBy(studioIDs: studioIDs)
                IndicatorView.shared.dismiss()
            }
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
}

// MARK: - UICollectionView Extension

extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedTab {
        case 0:
            return dancerIDs.count
        case 1:
            return studioIDs.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedTab {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemCell
            cell.titleLabel.text = DancerManager.myDancers?[indexPath.row].name
            cell.subtitleLabel.text =  "장르"
            cell.detailLabel.text = DancerManager.myDancers?[indexPath.row].id
            // TODO: 댄서 이미지 url로 교체
            cell.profileImage.load(url: URL(string: "https://src.hidoc.co.kr/image/lib/2021/4/28/1619598179113_0.jpg")!)
            cell.backgroundColor = .clear
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemCell
            cell.titleLabel.text = StudioManager.myStudios?[indexPath.row].name
            cell.subtitleLabel.text = StudioManager.myStudios?[indexPath.row].description
            cell.detailLabel.text = StudioManager.myStudios?[indexPath.row].id
            // TODO: 스튜디오 이미지 url로 교체
            //cell.profileImage.load(url: URL(string: "https://src.hidoc.co.kr/image/lib/2021/4/28/1619598179113_0.jpg")!)
            cell.profileImage.image = UIImage()
            cell.backgroundColor = .clear
            cell.accessibilityLabel = StudioManager.myStudios?[indexPath.row].id
            
            return cell
        default:
            return ItemCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedTab {
        case 0:
            let dancerDetailVC = DancerDetailViewController()
            dancerDetailVC.dancerID = DancerManager.myDancers?[indexPath.row].id
            self.navigationController?.pushViewController(dancerDetailVC, animated: true)
        case 1:
            let studioDetailVC = StudioViewController()
            studioDetailVC.studio = StudioManager.myStudios?[indexPath.row]
            self.navigationController?.pushViewController(studioDetailVC, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch selectedTab {
            case 0:
                DancerManager.myDancers?.remove(at: indexPath.row)
                dancerIDs.remove(at: indexPath.row)
                // TODO: UserDefault에 변경사항 반영
                tableView.deleteRows(at: [indexPath], with: .fade)
            case 1:
                let subscriptions = UserDefaults.standard.stringArray(forKey: "SubscribedStudios")!.filter { $0 != StudioManager.myStudios?[indexPath.row].id }
                UserDefaults.standard.set(subscriptions, forKey: "SubscribedStudios")
                StudioManager.myStudios?.remove(at: indexPath.row)
                studioIDs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            default:
                return
            }
        }
    }
}

// MARK: - Preview

import SwiftUI

struct SubscriptionViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SubscriptionViewController

    func makeUIViewController(context: Context) -> SubscriptionViewController {
        return SubscriptionViewController()
    }

    func updateUIViewController(_ uiViewController: SubscriptionViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SubscriptionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SubscriptionViewControllerRepresentable()
    }
}
