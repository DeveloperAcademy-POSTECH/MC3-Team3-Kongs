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
    
    var dancerScheduleArray: [DancerDetailScheduleModel] = []
    var dancerDataManager = DancerDetailSchduleManager()
    
    var networkManager = NetworkManager()
    var thumbnailArrays: [Item] = []
    
    let dancerDetailScrollView: UIScrollView! = UIScrollView()
    let dancerDetailContentView: UIView! = UIView()

    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerCoverImage: UIImage = UIImage(named: "DancerCoverImage")!
        imageView.image = dancerCoverImage
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerProfileImage: UIImage = UIImage(named: "DancerProfileImage")!
        imageView.image = dancerProfileImage
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "WOOTAE"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "코레오, 힙합"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var instagramImageView: UIImageView = {
        let imageView = UIImageView()
        let dancerProfileImage: UIImage = UIImage(systemName: "person")!
        imageView.image = dancerProfileImage
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.instaImageTapped)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dancerInfoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nameLabel, genreLabel])
        stview.spacing = 1
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .leading
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()

    private lazy var scheduleContentLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서 스케줄"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scheduleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.2156862745, alpha: 1)
        cv.layer.cornerRadius = 10
        cv.register(WeeklyScheduleCell.self, forCellWithReuseIdentifier: weekCellID)
        cv.dataSource = self
//        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    private lazy var videoContentLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서 영상"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var thumbNailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 25
        let cellWidth = (Device.width - (25 + layout.minimumLineSpacing)) * 0.8
        layout.estimatedItemSize = CGSize(width: cellWidth, height: cellWidth * 1)
//        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.8)
//        self.thumbNailCollectionView.collectionViewLayout = layout
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 90)
        cv.backgroundColor = .clear
        cv.register(ThumbNailCell.self, forCellWithReuseIdentifier: thumbNailID)
        cv.dataSource = self
//        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
//    private lazy var introduceContentLabel: UILabel = {
//        let label = UILabel()
//        label.text = "댄서 소개"
//        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let ment = """
//        안녕하세요. 10년차 댄서로 활동중인 WOOTAE 입니다!
//    """
//
//    private lazy var introduceContent: UILabel = {
//        let label = UILabel()
//        label.text = ment
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
        
    private let weekCellID = "week"
    private let thumbNailID = "thumNail"
    
    private var selectedDate = Date()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupScheduleDatas()
        setupNetworkDatas()
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
    
    func setupScheduleDatas() {
        dancerDataManager.makeDancerData()
        dancerScheduleArray = dancerDataManager.fetchScheduleData()
    }
    
    func setupNetworkDatas() {
        networkManager.fetchYoutubeData { result in
            switch result {
            case Result.success(let thumbNailData):
                print("데이터를 제대로 받았음")
                self.thumbnailArrays = thumbNailData
                DispatchQueue.main.async {
                    self.thumbNailCollectionView.reloadData()
                }
            case Result.failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.thumbNailCollectionView.isHidden = true
                    self.videoContentLabel.isHidden = true
                }
            }
        }
    }
    
    func configureUI() {
        let contentViewHeight = dancerDetailContentView.heightAnchor.constraint(equalToConstant: 1000)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        // 수직 스크롤을 적용하기 위해 contentView 와 scrollView의 width를 동일하게 잡아주고 height를 동일하게 잡아주되 priority 값을 조정하여 scroll 될 수 있도록 설정했습니다.

        view.addSubview(dancerDetailScrollView)
        dancerDetailScrollView.translatesAutoresizingMaskIntoConstraints = false
        dancerDetailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dancerDetailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dancerDetailScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dancerDetailScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        let contentLayout = dancerDetailScrollView.contentLayoutGuide
        dancerDetailScrollView.addSubview(dancerDetailContentView)
        dancerDetailContentView.translatesAutoresizingMaskIntoConstraints = false
        dancerDetailContentView.widthAnchor.constraint(equalTo: dancerDetailScrollView.frameLayoutGuide.widthAnchor).isActive = true
        dancerDetailContentView.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor).isActive = true
        dancerDetailContentView.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor).isActive = true
        dancerDetailContentView.topAnchor.constraint(equalTo: contentLayout.topAnchor).isActive = true
        dancerDetailContentView.bottomAnchor.constraint(equalTo: contentLayout.bottomAnchor).isActive = true
            
        dancerDetailContentView.addSubview(coverImageView)
        coverImageView.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 0).isActive = true
        coverImageView.trailingAnchor.constraint(equalTo: dancerDetailContentView.trailingAnchor, constant: 0).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: dancerDetailContentView.widthAnchor, multiplier: 9 / 16).isActive = true
        coverImageView.topAnchor.constraint(equalTo: dancerDetailContentView.topAnchor, constant: 0).isActive = true
            
        dancerDetailContentView.addSubview(profileImageView)
        profileImageView.leadingAnchor.constraint(equalTo: dancerDetailContentView.leadingAnchor, constant: 25).isActive = true
        profileImageView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 24).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: dancerDetailContentView.widthAnchor, multiplier: 1 / 4).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1).isActive = true

        dancerDetailContentView.addSubview(dancerInfoStackView)
        dancerInfoStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        dancerInfoStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10).isActive = true
            
        dancerDetailContentView.addSubview(instagramImageView)
        instagramImageView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        instagramImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10).isActive = true
        instagramImageView.widthAnchor.constraint(equalTo: dancerDetailContentView.widthAnchor, multiplier: 1 / 15).isActive = true
        instagramImageView.heightAnchor.constraint(equalTo: instagramImageView.widthAnchor, multiplier: 1).isActive = true

        dancerDetailContentView.addSubview(youtubeImageView)
        youtubeImageView.leadingAnchor.constraint(equalTo: instagramImageView.trailingAnchor, constant: 10).isActive = true
        youtubeImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10).isActive = true
        youtubeImageView.widthAnchor.constraint(equalTo: dancerDetailContentView.widthAnchor, multiplier: 1 / 15).isActive = true
        youtubeImageView.heightAnchor.constraint(equalTo: youtubeImageView.widthAnchor, multiplier: 1).isActive = true
            
        dancerDetailContentView.addSubview(scheduleContentLabel)
        scheduleContentLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 0).isActive = true
        scheduleContentLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25).isActive = true
            
        dancerDetailContentView.addSubview(scheduleCollectionView)
        scheduleCollectionView.leadingAnchor.constraint(equalTo: scheduleContentLabel.leadingAnchor, constant: 0).isActive = true
        scheduleCollectionView.trailingAnchor.constraint(equalTo: dancerDetailContentView.trailingAnchor, constant: -24).isActive = true
        scheduleCollectionView.topAnchor.constraint(equalTo: scheduleContentLabel.bottomAnchor, constant: 10).isActive = true
        scheduleCollectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            
        dancerDetailContentView.addSubview(separatorLine)
        separatorLine.leadingAnchor.constraint(equalTo: scheduleCollectionView.leadingAnchor,constant: 0).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: scheduleCollectionView.trailingAnchor,constant: 0).isActive = true
        separatorLine.topAnchor.constraint(equalTo: scheduleCollectionView.topAnchor,constant: 60).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
        dancerDetailContentView.addSubview(videoContentLabel)
        videoContentLabel.leadingAnchor.constraint(equalTo: scheduleContentLabel.leadingAnchor).isActive = true
        videoContentLabel.topAnchor.constraint(equalTo: scheduleCollectionView.bottomAnchor, constant: 25).isActive = true
            
        dancerDetailContentView.addSubview(thumbNailCollectionView)
        thumbNailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        thumbNailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        thumbNailCollectionView.topAnchor.constraint(equalTo: videoContentLabel.bottomAnchor, constant: 10).isActive = true
        thumbNailCollectionView.heightAnchor.constraint(equalToConstant: 220).isActive = true
            
//        dancerDetailContentView.addSubview(introduceContentLabel)
//        introduceContentLabel.leadingAnchor.constraint(equalTo: thumbNailCollectionView.leadingAnchor, constant: 0).isActive = true
//        introduceContentLabel.topAnchor.constraint(equalTo: thumbNailCollectionView.bottomAnchor, constant: 25).isActive = true
//            
//        dancerDetailContentView.addSubview(introduceContent)
//        introduceContent.leadingAnchor.constraint(equalTo: introduceContentLabel.leadingAnchor, constant: 0).isActive = true
//        introduceContent.topAnchor.constraint(equalTo: introduceContentLabel.bottomAnchor, constant: 25).isActive = true
    }
}

extension DancerDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.scheduleCollectionView {
            return 7
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.scheduleCollectionView {
            return 1
        } else {
            return thumbnailArrays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.scheduleCollectionView {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellID, for: indexPath) as! WeeklyScheduleCell
                cell.weekdayLabel.text = Weekday.allCases[indexPath.section].rawValue
                cell.dayLabel.text = cell.dayString(date: selectedDate, dayNum: indexPath.section)
                cell.studioLabel.text = dancerScheduleArray[indexPath.row].studioLabel
                cell.startTimeLabel.text = dancerScheduleArray[indexPath.row].startTimeLabel
                cell.endTimeLabel.text = dancerScheduleArray[indexPath.row].endTimeLabel
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellID, for: indexPath) as! WeeklyScheduleCell
                cell.backgroundColor = .purple
                return cell
            }
        } else if collectionView == self.thumbNailCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thumbNailID, for: indexPath) as! ThumbNailCell
            cell.imageUrl = thumbnailArrays[indexPath.row].snippet.thumbnails.high.url
            cell.youtubeTitle.text = thumbnailArrays[indexPath.row].snippet.title
            cell.backgroundColor = .clear
            return cell
        } else {
            return UICollectionViewCell()
        }
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
