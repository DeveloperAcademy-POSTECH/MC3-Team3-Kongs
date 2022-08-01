//
//  ThumbnailCell.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/28.
//

import UIKit

class ThumbNailCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private lazy var youtubeThumbNail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var youtubeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.numberOfLines = 1
        label.preferredMaxLayoutWidth = CGFloat((Device.width - (50)) * 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var playButtonIamge: UIImageView = {
//        let imageView = UIImageView()
//        let dancerProfileImage: UIImage = UIImage(named: "playButton")!
//        imageView.image = dancerProfileImage
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.youtubeThumbNail.image = nil
    }
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        youtubeThumbNail.contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard urlString == url.absoluteString else { return }
            DispatchQueue.main.async {
                self.youtubeThumbNail.image = UIImage(data: data)
            }
        }
    }
    
    private func setLayout() {
        contentView.addSubview(youtubeThumbNail)
        youtubeThumbNail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        youtubeThumbNail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        youtubeThumbNail.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        youtubeThumbNail.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        contentView.addSubview(youtubeTitle)
        youtubeTitle.topAnchor.constraint(equalTo: youtubeThumbNail.bottomAnchor, constant: 10).isActive = true
        youtubeTitle.leadingAnchor.constraint(equalTo: youtubeThumbNail.leadingAnchor).isActive = true
        youtubeTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
//        contentView.addSubview(playButtonIamge)
//        playButtonIamge.trailingAnchor.constraint(equalTo: youtubeThumbNail.trailingAnchor, constant: -10).isActive = true
//        playButtonIamge.topAnchor.constraint(equalTo: youtubeThumbNail.topAnchor, constant: 30).isActive = true
//        playButtonIamge.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
