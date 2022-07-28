//
//  MainViewController+DancerCell.swift
//  Hypeclass
//
//  Created by apple developer academy on 2022/07/20.
//

import UIKit

class MainViewControllerDancerCell: UICollectionViewCell {

    static let id = "DancerCell"
      
    // MARK: UIImageView로 수정
    private var dancerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //TODO: - UIImage로 수정
    private var dancerImage: UIView = {
        let image = UIView()
        image.backgroundColor = .gray
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let dancerDescription: UILabel = {
        let label = UILabel()
        let dancerName = "댄서 이름"
        let dancerGenre = "댄서 장르"
        label.text = "\(dancerName) | \(dancerGenre)"
        label.textColor = UIColor(hex: 0x969696)
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let danceIntroductionTitle: UILabel = {
        let label = UILabel()
        label.text = "댄서 수업에 대한 기본적인 소개 타이틀"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dancerProfileViewTransitionButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = .accent
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        let button = UIButton (
            configuration: config, primaryAction: UIAction( handler: { _ in
            print("MainViewController -> DancerDetailViewController")
            // TODO: DancerDetailViewController 연결
 //            let dancerDetailController = DancerDetailViewController()
 //            UINavigationController?.pushViewController(dancerDetailController, animated: true)
            })
        )
        button.setTitle("구경하기", for: .normal)
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
      
      // MARK: Initializer
      @available(*, unavailable)
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          contentView.addSubview(dancerView)
          dancerView.addArrangedSubview(dancerImage)
          dancerView.addArrangedSubview(dancerDescription)
          dancerView.addArrangedSubview(danceIntroductionTitle)
          dancerView.addArrangedSubview(dancerProfileViewTransitionButton)
          
          //MARK: - title margin
          dancerView.setCustomSpacing(15, after: danceIntroductionTitle)
          
          NSLayoutConstraint.activate([
            dancerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            dancerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            dancerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            dancerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            
            dancerImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            dancerImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            dancerImage.heightAnchor.constraint(equalToConstant: 110),
            
            dancerProfileViewTransitionButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            dancerProfileViewTransitionButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            dancerProfileViewTransitionButton.heightAnchor.constraint(equalToConstant: 30),
        ])
      }
      
      override func prepareForReuse() {
        super.prepareForReuse()
         self.prepare(image: nil)
      }
      
    // MARK: UIImageView로 수정
    func prepare(image: UIStackView?) {
        self.dancerView = image ?? UIStackView(frame: .zero)
    }
}

