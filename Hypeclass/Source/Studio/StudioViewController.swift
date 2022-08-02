//
//  StudioViewController.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/30.
//

import UIKit

class StudioViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.currentUIWindow()?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
  
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.7
        
        return view
    }()
    
    private let backButtonView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.backward.circle.fill")
        view.tintColor = .white
        
        return view
    }()
    
    private let heartView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.tintColor = .white
        
        return view
    }()
    
    private var remoteHeartState = false
    
    private var isHeart = false
    
    var studio: Studio?
    
    private var studioHeaderView: HeaderView?
    
    private let tabCellID = "tab"
    
    private let tabString = ["소개", "클래스", "이벤트"]
    
    private let tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cv.backgroundColor = .background
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    private var selectedTab = 0
    
    private let tabIndicatorView: UIView = UIView()
    
    private var tabIndicator: Separator = {
        let sep = Separator()
        sep.backgroundColor = .white
        return sep
    }()
    
    private var viewControllers: [UIViewController] = []
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let pageViewController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return pageController
    }()
    
    private let sampleContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configurePageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: Device.width, height: contentView.frame.height)
        remoteHeartState = isAlreadySubscribed()
        isHeart = remoteHeartState
    }
    
    //MARK: - Selectors
    
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
        if remoteHeartState != isHeart {
            if isHeart {
                addToSubscription()
                StudioManager.shared.incrementLikes(studioName: studio?.name ?? "")
            } else {
                removeFromSubscription()
                StudioManager.shared.decrementLikes(studioName: studio?.name ?? "")
            }
        }
    }
    
    @objc func heartDidTap() {
        isHeart.toggle()
        if isHeart {
            heartView.image = UIImage(systemName: "heart.fill")
            presentBottomAlert(message: "스튜디오를 구독하였습니다.")
        } else {
            heartView.image = UIImage(systemName: "heart")
            presentBottomAlert(message: "스튜디오 구독이 취소되었습니다.")
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        // scrollView
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // contentView
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        // navigationBar
        view.addSubview(navigationBar)
        navigationBar.frame = CGRect(x: 0, y: 0, width: Device.width, height: 92)

        // backButtonView
        view.addSubview(backButtonView)
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 50).isActive = true
        backButtonView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 25).isActive = true
        backButtonView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        backButtonView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonDidTap)))
        backButtonView.isUserInteractionEnabled = true
        
        // heartView
        view.addSubview(heartView)
        if isAlreadySubscribed() { heartView.image = UIImage(systemName: "heart.fill") }
        heartView.translatesAutoresizingMaskIntoConstraints = false
        heartView.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor).isActive = true
        heartView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -25).isActive = true
        heartView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        heartView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        heartView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(heartDidTap)))
        heartView.isUserInteractionEnabled = true
        
        // studioHeaderView
        studioHeaderView = HeaderView(frame: .zero, coverImageURL: nil, profileImageURL: nil, title: "\(studio?.name ?? "") STUDIO", subtitle: studio?.description, instagramURL: "https://instagram.com/dann.oao")
        contentView.addSubview(studioHeaderView!)
        studioHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        studioHeaderView!.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        studioHeaderView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        studioHeaderView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        // tabCollectionView
        tabCollectionView.register(TabCell.self, forCellWithReuseIdentifier: tabCellID)
        tabCollectionView.dataSource = self
        tabCollectionView.delegate = self
        
        contentView.addSubview(tabCollectionView)
        tabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tabCollectionView.topAnchor.constraint(equalTo: studioHeaderView!.bottomAnchor).isActive = true
        tabCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tabCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tabCollectionView.heightAnchor.constraint(equalToConstant: 48).isActive = true

        // tabIndicatorView
        contentView.addSubview(tabIndicatorView)
        tabIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        tabIndicatorView.topAnchor.constraint(equalTo: tabCollectionView.bottomAnchor).isActive = true
        tabIndicatorView.leadingAnchor.constraint(equalTo: tabCollectionView.leadingAnchor).isActive = true
        tabIndicatorView.trailingAnchor.constraint(equalTo: tabCollectionView.trailingAnchor).isActive = true
        tabIndicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        // Add tabIndicator to tabIndicatorView
        tabIndicatorView.addSubview(tabIndicator)
        tabIndicator.translatesAutoresizingMaskIntoConstraints = false
        tabIndicator.topAnchor.constraint(equalTo: tabIndicatorView.topAnchor).isActive = true
        tabIndicator.leadingAnchor.constraint(equalTo: tabIndicatorView.leadingAnchor).isActive = true
        tabIndicator.bottomAnchor.constraint(equalTo: tabIndicatorView.bottomAnchor).isActive = true
        tabIndicator.widthAnchor.constraint(equalToConstant: Device.width / CGFloat(tabString.count)).isActive = true
        
        // containerView
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: tabIndicatorView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        // pageViewController
        addChild(pageViewController)
        pageViewController.dataSource = self
        pageViewController.delegate = self

        containerView.addArrangedSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        pageViewController.didMove(toParent: self)
    }
    
    func configurePageViewController() {
        // TO DO: 실제 뷰 컨트롤러로 대체
        for idx in 0..<3 {
            let vc = DancerDetailViewController()
            vc.dancerDetailScrollView.isScrollEnabled = false
            vc.view.tag = idx
            pageViewController.view.heightAnchor.constraint(equalToConstant: vc.view.frame.height).isActive = true
            viewControllers.append(vc)
        }
        if let firstVC = viewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func isAlreadySubscribed() -> Bool {
        if let subscriptions = UserDefaults.standard.stringArray(forKey: "SubscribedStudios") {
            if subscriptions.contains(studio!.id) {
                return true
            }
            return false
        } else {
            return false
        }
    }
    
    func addToSubscription() {
        if isAlreadySubscribed() { return }
        
        if var subscriptions = UserDefaults.standard.stringArray(forKey: "SubscribedStudios") {
            if(subscriptions.count >= 10) {
                presentBottomAlert(message: "구독 가능한 스튜디오는 최대 10개입니다.")
                return
            }
            subscriptions.append(studio!.id)
            UserDefaults.standard.set(subscriptions, forKey: "SubscribedStudios")
        } else {
            var newList = [String]()
            newList.append(studio!.id)
            UserDefaults.standard.set(newList, forKey: "SubscribedStudios")
        }
    }
    
    func removeFromSubscription() {
        if !isAlreadySubscribed() { return }
        
        let subscriptions = UserDefaults.standard.stringArray(forKey: "SubscribedStudios")!.filter { $0 != studio!.id }
        UserDefaults.standard.set(subscriptions, forKey: "SubscribedStudios")
        StudioManager.myStudios = StudioManager.myStudios?.filter { $0.id != studio!.id }
    }
    
    func moveIndicator(index: Int) {
        UIView.animate(withDuration: 0.3) {
            self.tabIndicator.frame.origin.x = CGFloat(index) * (Device.width / CGFloat(self.tabString.count))
        }
    }
}

// MARK: - UICollectionView Extension

extension StudioViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCellID, for: indexPath) as! TabCell
        cell.tabNameLabel.text = tabString[indexPath.item]
        if selectedTab == indexPath.item {
            cell.tabNameLabel.textColor = .white
        } else {
            cell.tabNameLabel.textColor = .gray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveIndicator(index: indexPath.item)
        let isForward = selectedTab < indexPath.item ? true : false
        selectedTab = indexPath.item
        pageViewController.setViewControllers([viewControllers[selectedTab]], direction: isForward ? .forward : .reverse, animated: true, completion: nil)
        scrollView.contentSize = CGSize(width: Device.width, height: contentView.frame.height)
        collectionView.reloadData()
    }
}

extension StudioViewController: UICollectionViewDelegate {
}

extension StudioViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(tabString.count), height: collectionView.frame.height)
    }
}

// MARK: - UIPageViewController Extension

extension StudioViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return viewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == viewControllers.count {
            return nil
        }
        return viewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if true {
            selectedTab = pageViewController.viewControllers!.first!.view.tag
            moveIndicator(index: selectedTab)
            scrollView.contentSize = CGSize(width: Device.width, height: contentView.frame.height)
            tabCollectionView.reloadData()
        }
    }
}

// MARK: - UIScrollViewDelegate Extension

extension StudioViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y != 0 {
            navigationBar.backgroundColor = .background
        } else {
            navigationBar.backgroundColor = .clear
        }
    }
}

//MARK: - Preview

import SwiftUI

struct StudioViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = StudioViewController

    func makeUIViewController(context: Context) -> StudioViewController {
        return StudioViewController()
    }

    func updateUIViewController(_ uiViewController: StudioViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct StudioViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StudioViewControllerRepresentable()
    }
}
