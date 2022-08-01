//
//  AuthOnboardViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthOnboardViewController: BaseViewController {

    //MARK: - Properties
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서들의 클래스 수강신청\n디라이트에서 간편하게"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "한번 회원가입하고,\n버튼하나로 간단하게 수업을 신청하세요."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let ctaButton: CTAButton = {
        let button = CTAButton(title: "시작하기")
        button.addTarget(self, action: #selector(ctaButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func ctaButtonTap() {
        let vc = AuthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        //레이아웃 구성
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(primaryLabel)
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            primaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ])
        
        view.addSubview(secondaryLabel)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 20),
            secondaryLabel.leadingAnchor.constraint(equalTo: primaryLabel.leadingAnchor)
        ])
        
        view.addSubview(ctaButton)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ctaButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - Preview
import SwiftUI

struct AuthOnboardViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthOnboardViewController

    func makeUIViewController(context: Context) -> AuthOnboardViewController {
        return AuthOnboardViewController()
    }

    func updateUIViewController(_ uiViewController: AuthOnboardViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct AuthOnboardViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthOnboardViewControllerRepresentable()
            .preferredColorScheme(.dark)
    }
}
