//
//  MainViewController+GenreCell.swift
//  Hypeclass
//
//  Created by apple developer academy on 2022/07/18.
//

import UIKit

class MainViewControllerGenreCell: UICollectionViewCell {

    static let id = "GenreCell"
    
    // MARK: UIImageView로 수정
    private var imageView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .gray
        view.axis = .vertical
        view.alignment = .center
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "스트릿 댄스"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
//        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
      
      // MARK: Initializer
      @available(*, unavailable)
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addArrangedSubview(genreLabel)
          
        NSLayoutConstraint.activate([
          imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
          imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
          imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
          imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        ])
      }
      
      override func prepareForReuse() {
        super.prepareForReuse()
        
         self.prepare(image: nil)
      }
      
    // MARK: UIImageView로 수정
    func prepare(image: UIStackView?) {
        self.imageView = image ?? UIStackView(frame: .zero)
    }
}

