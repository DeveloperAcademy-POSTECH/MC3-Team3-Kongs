//
//  SubscriptionViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class SubscriptionViewController: BaseViewController{
   
    // MARK: - Properties
    
    let table = UITableView()
    
    // TODO: 추후에 profileImageURL 사용 예정
    let dancerInfo: [DancerInfo] = [
        DancerInfo(profileImage: UIView(), nameLabel: "이병헌", genreLabel: "방송댄스", classdayLabel: "화, 수, 목"),
        DancerInfo(profileImage: UIView(), nameLabel: "이병헌", genreLabel: "방송댄스", classdayLabel: "화, 수, 목"),
        DancerInfo(profileImage: UIView(), nameLabel: "이병헌", genreLabel: "방송댄스", classdayLabel: "화, 수, 목"),
        DancerInfo(profileImage: UIView(), nameLabel: "이병헌", genreLabel: "방송댄스", classdayLabel: "화, 수, 목"),
        DancerInfo(profileImage: UIView(), nameLabel: "이병헌", genreLabel: "방송댄스", classdayLabel: "화, 수, 목")
    ]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        table.backgroundColor = UIColor.background
    }
    
    func configureTableView(){
        table.register(DancerCell.self, forCellReuseIdentifier: DancerCell.dancerCellID)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
    }
}

// MARK: - UICollectionView Extension

extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dancerInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: DancerCell.dancerCellID, for:indexPath) as! DancerCell
        cell.nameLabel.text = dancerInfo[indexPath.row].nameLabel
        cell.genreLabel.text =  dancerInfo[indexPath.row].genreLabel
        cell.classdayLabel.text = dancerInfo[indexPath.row].classdayLabel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dancerDetailVC = DancerDetailViewController()
        // ☑️ TODO: 댄서 ID 건네주어야함.
        self.navigationController?.pushViewController(dancerDetailVC, animated: true)
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
