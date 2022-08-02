//
//  ViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        
        return image
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "춤추러 가는 길, \n어려울 필요 없으니까."
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let searchButton: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(hex: 0x7A7A7A)
        config.baseBackgroundColor = UIColor(hex: 0x2D2C38)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .large)
        config.image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
        config.imagePadding = 13
        config.imagePlacement = .leading
        
        var titleAttr = AttributedString.init("댄서, 스튜디오 무엇이든지")
        titleAttr.font = .systemFont(ofSize: 12, weight: .regular)
        config.attributedTitle = titleAttr
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.layer.cornerRadius = 10
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        
        return control
    }()
    
    private let scrollImageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    private let scrollImageSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 바로 춤추러 가기 >"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageDidTap)))
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let studioCellID = "studio"
    
    private let studioLabel: UILabel = {
        let label = UILabel()
        label.text = "함께하는 스튜디오들"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    private let studioCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .background
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        return cv
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await requestStudios()
            addContentToScrollView()
        }
    }
    
    // MARK: - Selectors
    
    @objc func searchButtonDidTap() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func pageDidTap() {
        // TODO: 어딘가의 페이지로 넘어가기
        print("Selected Page: \(pageControl.currentPage)")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        // logoImageView
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        // headerTitle
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor).isActive = true
        headerTitle.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 15).isActive = true
        
        // searchButton
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 30).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
        
        // imageScrollView
        view.addSubview(imageScrollView)
        imageScrollView.delegate = self
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 28).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor).isActive = true
        imageScrollView.heightAnchor.constraint(equalToConstant: (Device.width - 40) * 0.6).isActive = true
        
        // pageControl
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 10).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 6).isActive = true
        
        // scrollImageTitleLabel
        view.addSubview(scrollImageTitleLabel)
        scrollImageTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageDidTap)))
        scrollImageTitleLabel.isUserInteractionEnabled = true
        scrollImageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollImageTitleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor).isActive = true
        scrollImageTitleLabel.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor).isActive = true
        scrollImageTitleLabel.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor).isActive = true
        
        // scrollImageSubtitleLabel
        view.addSubview(scrollImageSubtitleLabel)
        scrollImageSubtitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageDidTap)))
        scrollImageSubtitleLabel.isUserInteractionEnabled = true
        scrollImageSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollImageSubtitleLabel.topAnchor.constraint(equalTo: scrollImageTitleLabel.bottomAnchor, constant: 5).isActive = true
        scrollImageSubtitleLabel.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor).isActive = true
        scrollImageSubtitleLabel.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor).isActive = true
        
        // studioLabel
        view.addSubview(studioLabel)
        studioLabel.translatesAutoresizingMaskIntoConstraints = false
        studioLabel.topAnchor.constraint(equalTo: scrollImageSubtitleLabel.bottomAnchor, constant: 40).isActive = true
        studioLabel.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor).isActive = true
        
        // studioCollectionView
        studioCollectionView.register(MainStudioCell.self, forCellWithReuseIdentifier: studioCellID)
        studioCollectionView.dataSource = self
        studioCollectionView.delegate = self
        
        view.addSubview(studioCollectionView)
        studioCollectionView.translatesAutoresizingMaskIntoConstraints = false
        studioCollectionView.topAnchor.constraint(equalTo: studioLabel.bottomAnchor, constant: 8).isActive = true
        studioCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        studioCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        studioCollectionView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    // 스크롤뷰에 컨텐츠를 추가합니다.
    private func addContentToScrollView() {
        scrollImageTitleLabel.text = "\(StudioManager.allStudios?[pageControl.currentPage].name ?? "") Studio 합류"
        
        for idx in 0..<(StudioManager.allStudios?.count ?? 0) {
            let imageView = UIImageView()
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageDidTap)))
            imageView.isUserInteractionEnabled = true
            imageView.image = UIImage(named: "DancerCoverImage")
            let xPos = (Device.width - 44) * CGFloat(idx)
            imageView.frame = CGRect(x: xPos, y: imageScrollView.bounds.minY, width: imageScrollView.bounds.width, height: imageScrollView.bounds.height)
            imageScrollView.addSubview(imageView)
            imageScrollView.contentSize.width = imageView.frame.width * CGFloat(idx + 1)
        }
    }
    
    // StudioManager.allStudios가 nil이면 firebase에서 스튜디오 정보를 가져옵니다.
    private func requestStudios() async {
        do {
            if StudioManager.allStudios == nil {
                IndicatorView.shared.show()
                IndicatorView.shared.showIndicator()
                StudioManager.allStudios = try await StudioManager.shared.requestAllStudios()
                IndicatorView.shared.dismiss()
                pageControl.numberOfPages = StudioManager.allStudios?.count ?? 0
            }
            studioCollectionView.reloadData()
        }
        catch {
            print(error)
        }
    }
}

// MARK: - UICollectionViewDataSource, Delegate

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StudioManager.allStudios?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: studioCellID, for: indexPath) as! MainStudioCell
        // TODO: url Image
        cell.studioImage = UIImageView()
        cell.studioNameLabel.text = StudioManager.allStudios?[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: StudioViewController 이동
        print("StudioViewController 이동")
    }
}

extension MainViewController: UICollectionViewDelegate {
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 70)
    }
}

// MARK: - UIScrollViewDelegate Extension

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == imageScrollView {
            let value = scrollView.contentOffset.x / scrollView.frame.size.width
            if value > CGFloat(pageControl.numberOfPages - 1) {
                imageScrollView.setContentOffset(CGPoint(x: 0, y: .zero), animated: true)
            } else if value < 0 {
                imageScrollView.setContentOffset(CGPoint(x: imageScrollView.contentSize.width - (Device.width - 44) , y: .zero), animated: true)
            } else {
                pageControl.currentPage = Int(round(value))
            }
            scrollImageTitleLabel.text = "\(StudioManager.allStudios?[pageControl.currentPage].name ?? "") Studio 합류"
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
