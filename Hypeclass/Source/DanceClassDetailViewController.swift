//
//  DanceClassDetailViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class DanceClassDetailViewController: BaseViewController {
    
    //MARK: - Properties
    
    var model: DanceClass?
    let headerTitles = ["강사", "스튜디오"]
    private var coverImageTopAnchor: NSLayoutConstraint?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 400, height: 1000)
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아프로 스타일 하우스 클래스"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "6월 29일 수요일 18:20 ~ 21:40"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let aboutTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textAlignment = .left
        textView.isEditable = false
        textView.text = """
        춤추고 싶은 사람 누구나 참여 가능한
        힉스 비디오 클래스!
        
        *다채로운 영상을 남기고 싶은 각양각색의
        댄서나 일반인을 모집합니다.
        
        - 진행기간 :
        8월 1일 첫째주 부터 9월 9일까지 (6주간)
        
        - 정원 : 각 레슨마다 10명씩
        
        - 촬영 날짜: 9월 18일 일요일 오후 12시 이후
        """
        textView.sizeToFit()
        
        return textView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        return tableView
    }()
    
    private let ctaButton: CTAButton = {
        let button = CTAButton(title: "신청하기")
        button.addTarget(self, action: #selector(ctaButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        scrollView.delegate = self
    }
    
    //MARK: - Selectors
    
    @objc func ctaButtonTap() {
        if AuthManager.shared.isLogin {
            // 로그인 되어 있을 시 신청 메서드 작동
            presentAlert(title: "신청하기", message: "신청 후에는 취소, 수강관련안내 문자가 회원님의 핸드폰 번호로 전송됩니다", isCancelActionIncluded: true, preferredStyle: .alert) { action in
                print("DEUBG: 신청하기 로직 연결 필요")
                self.presentBottomAlert(message: "신청이 완료되었습니다.")
            }
        } else {
            let vc = UINavigationController(rootViewController: AuthOnboardViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "DanceClassDetailCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureUI() {
        //레이아웃 구성
        let safeArea = view.safeAreaLayoutGuide
        let contentLayout = scrollView.contentLayoutGuide
        let frameLayout = scrollView.frameLayoutGuide
        
        view.addSubview(ctaButton)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ctaButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: ctaButton.topAnchor, constant: -20)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: contentLayout.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentLayout.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: frameLayout.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
        
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageTopAnchor = NSLayoutConstraint(item: coverImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        contentView.addConstraint(coverImageTopAnchor!)
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
        
        contentView.addSubview(secondaryLabel)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            secondaryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        contentView.addSubview(aboutLabel)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 20),
            aboutLabel.leadingAnchor.constraint(equalTo: secondaryLabel.leadingAnchor)
        ])
        
        contentView.addSubview(aboutTextView)
        aboutTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutTextView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),
            aboutTextView.leadingAnchor.constraint(equalTo: aboutLabel.leadingAnchor),
            aboutTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25)
        ])
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}

//MARK: - UITableViewDataSource

extension DanceClassDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = headerTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        return view
    }
    
    //MARK: - ROW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DanceClassDetailCell") as? ItemCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.profileImage.backgroundColor = .systemPink
        
        return cell
    }
}

extension DanceClassDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //MARK: 커버 이미지 stick to top 애니메이션
        let offset = scrollView.contentOffset.y
        if offset < 0 {
            coverImageTopAnchor?.constant = offset
            coverImageView.heightConstraint?.constant = 210 - offset
        } else {
            coverImageView.heightConstraint?.constant = 210
        }
    }
}

//MARK: - Preview
import SwiftUI

struct DanceClassDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DanceClassDetailViewController

    func makeUIViewController(context: Context) -> DanceClassDetailViewController {
        return DanceClassDetailViewController()
    }

    func updateUIViewController(_ uiViewController: DanceClassDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct DanceClassDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DanceClassDetailViewControllerRepresentable()
    }
}
