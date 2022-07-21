//
//  ViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import UIKit

class MainViewController: BaseViewController {
    // MARK: - Properties
    
    private let headerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "댄서들의 클래스를 확인해보세요"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
        var config = UIButton.Configuration.gray()
        config.buttonSize = .large
        config.titleAlignment = .leading
        config.title = "댄서 또는 장르를 검색해보세요"
        config.background = .listSidebarCell()
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.baseForegroundColor = UIColor(hex: 0x7A7A7A)
        config.baseBackgroundColor = UIColor(hex: 0x2D2C38)
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genreView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private let genreTitle: UILabel = {
        let label = UILabel()
        label.text = "이 장르에 도전해보는건 어때요?"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        //MARK: - TODO: func textRect(라벨 박스 크기 확인)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let genreFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12.0
        layout.minimumInteritemSpacing = 12.0
        
        // TODO: 100, 100 frame으로 조정
        
        layout.itemSize = CGSize(width: 100, height: 100)
        return layout
      }()

    private lazy var genreCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.genreFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(MainViewControllerGenreCell.self, forCellWithReuseIdentifier: MainViewControllerGenreCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        return view
    }()
    
    private let dancerRecommendationView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dancerRecommendationTitle: UILabel = {
        let label = UILabel()
        label.text = "새로운 댄서를 반겨주세요!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dancerRecommendationFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 15.0
        layout.itemSize = CGSize(width: 155, height: 210)
        return layout
      }()
    
    private lazy var dancerRecommendationCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.dancerRecommendationFlowLayout)
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(MainViewControllerDancerCell.self, forCellWithReuseIdentifier: MainViewControllerDancerCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        return view
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    // MARK: - Selectors
    
    @objc func searchButtonDidTap() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.addSubview(headerView)
        headerView.addArrangedSubview(headerTitle)
        headerView.addArrangedSubview(searchButton)
        
        view.addSubview(genreView)
        genreView.addArrangedSubview(genreTitle)
        genreView.addArrangedSubview(genreCollectionView)
        
        view.addSubview(dancerRecommendationView)
        dancerRecommendationView.addArrangedSubview(dancerRecommendationTitle)
        dancerRecommendationView.addArrangedSubview(dancerRecommendationCollectionView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            headerView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 25),
            headerView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -25),
       ])
        NSLayoutConstraint.activate([
            genreView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            genreView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            genreView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 180),
            genreView.heightAnchor.constraint(equalToConstant: 150),
       ])
        // 326 464
        NSLayoutConstraint.activate([
            dancerRecommendationView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            dancerRecommendationView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            dancerRecommendationView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 365),
            dancerRecommendationView.heightAnchor.constraint(equalToConstant: 250),
       ])
    }
    
    private func configureCollectionView() {
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        dancerRecommendationCollectionView.dataSource = self
        dancerRecommendationCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, Delegate

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case genreCollectionView:
                //TODO: - CaseIterable protocol model data에 추가
                return 8
            case dancerRecommendationCollectionView:
                return MockDataSet.dancers.count
            default: return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case genreCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewControllerGenreCell.id, for: indexPath) as! MainViewControllerGenreCell
                    cell.prepare(image: UIStackView(frame: .zero))
                return cell
            case dancerRecommendationCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewControllerDancerCell.id, for: indexPath) as! MainViewControllerDancerCell
                    cell.prepare(image: UIStackView(frame: .zero))
               return cell
            default:
                return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: ViewController 간 이동
        switch collectionView {
        case genreCollectionView:
            let searchDetailVC = SearchDetailViewController()
            // ☑️ TODO: 검색 키워드 건네주어야함
            self.navigationController?.pushViewController(searchDetailVC, animated: true)
        case dancerRecommendationCollectionView:
            let dancerDetailVC = DancerDetailViewController()
            // ☑️ TODO: 댄서 ID 건네주어야함.
            self.navigationController?.pushViewController(dancerDetailVC, animated: true)
        default:
            return
        }
    }
}

// MARK: - Preview

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainViewController

    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }

    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
