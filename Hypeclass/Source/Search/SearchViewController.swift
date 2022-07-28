//
//  SearchViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit

class SearchViewController: BaseViewController {
    
    //MARK: - Properties
    
    let searchBar = SearchBar()
    let separator = Separator()
    let historyTitle: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    let historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let recommendTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        
        return table
    }()
    
    let historyCellID = "history"
    
    var historyList = [String]()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarUI()
        configureUI()
        configureSearchBar()
        configureHistoryCollection()
    }
    
    let recommandTitle: UILabel = {
        let label = UILabel()
        label.text = "이런 댄서는 어때요?"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadCollectionView()
    }
    
    //MARK: - Selectors
    
    @objc func removeHistory(_ sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: historyCollectionView)
        if let indexPath = historyCollectionView.indexPathForItem(at: buttonPostion) {
            let rowIndex = indexPath.row
            if var searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory"){
                searchHistory.remove(at: rowIndex)
                UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
            }
            reloadCollectionView()
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        // Separator Layout
        self.view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18).isActive = true
        
        self.view.addSubview(historyTitle)
        historyTitle.translatesAutoresizingMaskIntoConstraints = false
        historyTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 26).isActive = true
        historyTitle.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 26).isActive = true
        
        self.view.addSubview(historyCollectionView)
        historyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        historyCollectionView.topAnchor.constraint(equalTo: historyTitle.bottomAnchor, constant: 13).isActive = true
        historyCollectionView.leadingAnchor.constraint(equalTo: historyTitle.leadingAnchor).isActive = true
        historyCollectionView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        historyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -13).isActive = true
        
        self.view.addSubview(recommandTitle)
        recommandTitle.translatesAutoresizingMaskIntoConstraints = false
        recommandTitle.topAnchor.constraint(equalTo: historyCollectionView.bottomAnchor, constant: 38).isActive = true
        recommandTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        

        self.view.addSubview(recommendTable)
        recommendTable.translatesAutoresizingMaskIntoConstraints = false
        recommendTable.topAnchor.constraint(equalTo: recommandTitle.bottomAnchor, constant: 13).isActive = true
        recommendTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        recommendTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        recommendTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func configureNavigationBarUI() {
        self.navigationItem.titleView = searchBar
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "찾고자 하는 댄서나 장르를 검색하세요."
        searchBar.becomeFirstResponder()
    }
    
    // Navigation 화면 전환
    func pushSearchDetailView(_ searchText: String) {
        // async - await 함수 호출 방법 ( 추후 View 작업시 삭제할 내용 )
//        async {
//            print(try await SearchManager.shared.requestSearchStudio(studioSearch: "Aca"))
//        }
        
        let searchDetailVC = SearchDetailViewController()
        searchDetailVC.searchLabel.text = searchText
        self.navigationController?.pushViewController(searchDetailVC, animated: true)
    }
    
    // SearchHistory를 UserDefault에 저장
    func storeSearchHistory(_ searchText: String) {
        if var searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") {
            if !searchHistory.contains(searchText) {
                searchHistory.insert(searchText, at: 0)
            }
            
            if(searchHistory.count > 10) {
                searchHistory.remove(at: 10)
            }
            
            UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
        } else {
            var newHistory = [String]()
            newHistory.append(searchText)
            UserDefaults.standard.set(newHistory, forKey: "SearchHistory")
        }
    }
    
    func configureHistoryCollection() {
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: historyCellID)
        historyCollectionView.dataSource = self
        historyCollectionView.delegate = self
    }
    
    func reloadCollectionView() {
        historyList = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
        historyCollectionView.reloadData()
    }
}

//MARK: - SearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    // SearchButton Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        storeSearchHistory(searchText)
        pushSearchDetailView(searchText)
    }
}

//MARK: - CollectionView Extension

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: historyCellID, for: indexPath) as! HistoryCell
        cell.logLabel.text = "\(historyList[indexPath.row])"
        cell.cancelButton.addTarget(self, action: #selector(removeHistory(_:)), for: .touchUpInside)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushSearchDetailView(historyList[indexPath.row])
    }
}

//MARK: - TableView Extension

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dancerDetailVC = DancerDetailViewController()
        // ☑️ TODO: 댄서 ID 건네주어야함.
        self.navigationController?.pushViewController(dancerDetailVC, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 추천 알고리즘에 따른 추천 데이터 갯수 반환
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell 반환 추천 데이터 -> 추천 알고리즘 논의
        return UITableViewCell()
    }
}

//MARK: - Preview

import SwiftUI

struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchViewController
    
    func makeUIViewController(context: Context) -> SearchViewController {
        return SearchViewController()
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SearchViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchViewControllerRepresentable()
    }
}
