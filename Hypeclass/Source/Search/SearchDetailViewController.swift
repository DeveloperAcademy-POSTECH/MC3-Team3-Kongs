//
//  SearchDetailViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit

class SearchDetailViewController: BaseViewController {
    
    //MARK: - Properties
    let searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let separator = Separator()
    
    let cancelButton: UIButton = {
        let img = UIImage(systemName: "xmark.circle.fill")
        let cancelBtn = UIButton()
        cancelBtn.setImage(img, for: .normal)
        cancelBtn.tintColor = .gray
        
        return cancelBtn
    }()
    
    let dancerTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        
        return table
    }()
    
    var searchResult: [Dancer] = []
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarUI()
        configureUI()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchResult = MockDataSet.dancers.filter { dancer in
            dancer.name!.lowercased().contains(searchLabel.text?.lowercased() ?? "")
        }
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        // Separator Layout
        self.view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18).isActive = true
        
        self.view.addSubview(dancerTable)
        dancerTable.translatesAutoresizingMaskIntoConstraints = false
        dancerTable.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 5).isActive = true
        dancerTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dancerTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        dancerTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func configureNavigationBarUI() {
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.topItem?.title = searchLabel.text
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
    func configureTable() {
        dancerTable.delegate = self
        dancerTable.dataSource = self
        dancerTable.register(SearchDetailCell.self, forCellReuseIdentifier: SearchDetailCell.dancerCellID)
    }
}

//MARK: - TableView Extension

extension SearchDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dancerDetailVC = DancerDetailViewController()
        // ☑️ TODO: 댄서 ID 건네주어야함.
        self.navigationController?.pushViewController(dancerDetailVC, animated: true)
    }
}

extension SearchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dancerTable.dequeueReusableCell(withIdentifier: SearchDetailCell.dancerCellID, for:indexPath) as! SearchDetailCell
//        cell.profileImage.load(url: URL(string: searchResult[indexPath.row].profileImageURL)!)
        
        // Mock데이터에 있는 이미지 링크의 이미지를 불러오지 못함 임시 이미지 링크를 첨부합니다.
        cell.profileImage.load(url: URL(string: "https://src.hidoc.co.kr/image/lib/2021/4/28/1619598179113_0.jpg")!)
        
        cell.nameLabel.text = searchResult[indexPath.row].name
        cell.genreLabel.text =  "방송 댄스"
        cell.classdayLabel.text = "화, 수, 목"
        cell.backgroundColor = .clear
        
        return cell
    }
}

//MARK: - Preview

import SwiftUI

struct SearchDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchDetailViewController
    
    func makeUIViewController(context: Context) -> SearchDetailViewController {
        return SearchDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: SearchDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SearchDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchDetailViewControllerRepresentable()
    }
}
