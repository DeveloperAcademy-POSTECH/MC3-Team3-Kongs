//
//  DancerDetailView.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/17.
//

import UIKit

class DancerDetailViewController: BaseViewController {
    
    //MARK: - Properties
    
    var dancerID: String?
    
    let dancerDetailScrollView: UIScrollView! = UIScrollView()
    let dancerDetailContentView: UIView! = UIView()

    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerCoverImage: UIImage = UIImage(named: "DancerCoverImage")!
        imageView.image = dancerCoverImage
        return imageView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerProfileImage: UIImage = UIImage(named: "DancerProfileImage")!
        imageView.image = dancerProfileImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "WOOTAE"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "코레오, 힙합"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        return label
    }()
    
    private lazy var instagramImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerProfileImage: UIImage = UIImage(systemName: "person")!
        imageView.image = dancerProfileImage
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.instaImageTapped)))
        return imageView
    }()
    
    private lazy var youtubeImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerProfileImage: UIImage = UIImage(systemName: "person")!
        imageView.image = dancerProfileImage
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 0
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.youTubeImageTapped)))
        return imageView
    }()
    
    private lazy var dancerInfoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nameLabel, genreLabel])
        stview.spacing = 1
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .leading
        return stview
    }()

    private lazy var scheduleContentLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서 스케줄"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var scheduleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.2156862745, alpha: 1)
        cv.layer.cornerRadius = 10
//        cv.backgroundColor = .blue
        cv.register(WeeklyScheduleCell.self, forCellWithReuseIdentifier: weekCellID)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private lazy var separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        return line
    }()

    private lazy var videoContentLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서 영상"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var mockUpThumNail: UIImageView = {
        let imageView = UIImageView()
        let dancerProfileImage: UIImage = UIImage(systemName: "person")!
        imageView.image = dancerProfileImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var introduceContentLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서 소개"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let ment = """
        안녕하세요. 10년차 댄서로 활동중인 WOOTAE 입니다!
    """
    
    private lazy var introduceContent: UILabel = {
        let label = UILabel()
        label.text = ment
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
        
    private let weekCellID = "week"
    
    private var selectedDate = Date()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    
    @objc func instaImageTapped(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://instagram.com/wootae_______?igshid=YmMyMTA2M2Y=") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc func youTubeImageTapped(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.youtube.com/user/wootae0723") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        dancerDetailScrollView.translatesAutoresizingMaskIntoConstraints = false
        dancerDetailContentView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        instagramImageView.translatesAutoresizingMaskIntoConstraints = false
        youtubeImageView.translatesAutoresizingMaskIntoConstraints = false
        dancerInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        scheduleContentLabel.translatesAutoresizingMaskIntoConstraints = false
        scheduleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        videoContentLabel.translatesAutoresizingMaskIntoConstraints = false
        mockUpThumNail.translatesAutoresizingMaskIntoConstraints = false
        introduceContentLabel.translatesAutoresizingMaskIntoConstraints = false
        introduceContent.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dancerDetailScrollView)
        dancerDetailScrollView.addSubview(dancerDetailContentView)
        dancerDetailContentView.addSubview(coverImageView)
        dancerDetailContentView.addSubview(profileImageView)
        dancerDetailContentView.addSubview(dancerInfoStackView)
        dancerDetailContentView.addSubview(instagramImageView)
        dancerDetailContentView.addSubview(youtubeImageView)
        dancerDetailContentView.addSubview(scheduleContentLabel)
        dancerDetailContentView.addSubview(scheduleCollectionView)
        dancerDetailContentView.addSubview(separatorLine)
        dancerDetailContentView.addSubview(videoContentLabel)
        dancerDetailContentView.addSubview(mockUpThumNail)
        dancerDetailContentView.addSubview(introduceContentLabel)
        dancerDetailContentView.addSubview(introduceContent)

        dancerDetailContentView.widthAnchor.constraint(equalTo: dancerDetailScrollView.widthAnchor).isActive = true

        let contentViewHeight = dancerDetailContentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        // 수직 스크롤을 적용하기 위해 contentView 와 scrollView의 width를 동일하게 잡아주고 height를 동일하게 잡아주되 priority 값을 조정하여 scroll 될 수 있도록 설정했습니다.

        NSLayoutConstraint.activate([
            dancerDetailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dancerDetailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dancerDetailScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            dancerDetailScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dancerDetailContentView.leadingAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.leadingAnchor),
            dancerDetailContentView.trailingAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.trailingAnchor),
            dancerDetailContentView.topAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.topAnchor),
            dancerDetailContentView.bottomAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.bottomAnchor),
            
            coverImageView.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 0),
            coverImageView.trailingAnchor.constraint(equalTo: dancerDetailContentView.trailingAnchor, constant: 0),
            coverImageView.heightAnchor.constraint(equalToConstant: 220),
            coverImageView.topAnchor.constraint(equalTo: dancerDetailContentView.topAnchor, constant: 0),
            
            profileImageView.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25),
            profileImageView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 25),
            profileImageView.heightAnchor.constraint(equalToConstant: 90),
            profileImageView.widthAnchor.constraint(equalToConstant: 90),

            dancerInfoStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            dancerInfoStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10),
            
            instagramImageView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            instagramImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10),
            instagramImageView.heightAnchor.constraint(equalToConstant: 22),
            instagramImageView.widthAnchor.constraint(equalToConstant: 22),

            youtubeImageView.leadingAnchor.constraint(equalTo: instagramImageView.trailingAnchor, constant: 10),
            youtubeImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10),
            youtubeImageView.heightAnchor.constraint(equalToConstant: 22),
            
            scheduleContentLabel.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25),
            scheduleContentLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25),
            
            scheduleCollectionView.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor,constant: 20),
            scheduleCollectionView.trailingAnchor.constraint(equalTo: dancerDetailContentView.trailingAnchor, constant: -20),
            scheduleCollectionView.topAnchor.constraint(equalTo: scheduleContentLabel.bottomAnchor, constant: 10),
            scheduleCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            separatorLine.leadingAnchor.constraint(equalTo: scheduleCollectionView.leadingAnchor,constant: 0),
            separatorLine.trailingAnchor.constraint(equalTo: scheduleCollectionView.trailingAnchor,constant: 0),
            separatorLine.topAnchor.constraint(equalTo: scheduleCollectionView.topAnchor,constant: 60),
            separatorLine.bottomAnchor.constraint(equalTo: scheduleCollectionView.topAnchor,constant: 61),
            
            videoContentLabel.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25),
            videoContentLabel.topAnchor.constraint(equalTo: scheduleCollectionView.bottomAnchor, constant: 25),
            
            mockUpThumNail.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25),
            mockUpThumNail.topAnchor.constraint(equalTo: videoContentLabel.bottomAnchor, constant: 10),
            
            introduceContentLabel.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25),
            introduceContentLabel.topAnchor.constraint(equalTo: mockUpThumNail.bottomAnchor, constant: 25),
            
            introduceContent.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25),
            introduceContent.topAnchor.constraint(equalTo: introduceContentLabel.bottomAnchor, constant: 25)
        ])
    }
}

extension DancerDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellID, for: indexPath) as! WeeklyScheduleCell
            cell.weekdayLabel.text = Weekday.allCases [indexPath.section].rawValue
            cell.dayLabel.text = cell.dayString(date: selectedDate, dayNum: indexPath.section)
//            cell.backgroundColor = .red
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellID, for: indexPath) as! WeeklyScheduleCell
//            cell.backgroundColor = .purple
            return cell
        }
    }
}

extension DancerDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimateHeight = collectionView.frame.height * 0.3
        let estimateWidth = (collectionView.frame.width * 0.15)
        return CGSize(width: estimateWidth, height: estimateHeight)
    }
}

//MARK: - Preview

import SwiftUI

struct DancerDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DancerDetailViewController

    func makeUIViewController(context: Context) -> DancerDetailViewController {
        return DancerDetailViewController()
    }

    func updateUIViewController(_ uiViewController: DancerDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct DancerDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DancerDetailViewControllerRepresentable()
    }
}
