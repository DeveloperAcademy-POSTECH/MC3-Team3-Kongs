//
//  ScheduleViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class ScheduleViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let monthNumberLabel: UILabel = {
        let label = UILabel()
        label.text = String(Date().get(.month))
        label.textColor = .white
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        
        return label
    }()
    
    private var selectedDate = Date()
    
    private let weekCellID = "week"
    
    private let weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 11
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .background
        
        return cv
    }()
    
    private let separator = Separator()
    
    private let previousButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "chevron.backward")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(fetchLastWeek), for: .touchUpInside)
        
        return btn
    }()
    
    private let nextButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "chevron.forward")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(fetchNextWeek), for: .touchUpInside)
        
        return btn
    }()
    
    private var stackViews: [UIStackView] = [
        UIStackView(), UIStackView(), UIStackView(), UIStackView(), UIStackView(), UIStackView(), UIStackView()
    ]
    
    private let scheduleCellID = "schedule"
    
    private let scheduleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .background
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
//    private let subscriptionIDs = UserDefaults.standard.stringArray(forKey: "SubscribedDancers") ?? ["CDF787F4-5AD7-4138-AE13-F96DEF538E0D", "2EB613FC-956E-482F-80C1-DAC47C543729", "F77D3855-2CE5-468D-B702-8C9AA521461B"]
    private let subscriptionIDs: [String] = []
    
    private var weekSchedules: [[DanceClass]] = [
        [], [], [], [], [], [], []
    ]
    
    private var scheduleViewWidth: CGFloat = 0
    
    private let goToSubscribeView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = true
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let noSubscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "앗! 구독한 댄서가 없어요 😢"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        return label
    }()
    
    private let goSubscribeLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString.init(string: "첫 댄서 구독하러 가기")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        label.textColor = .white
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        reloadViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Selectors
    
    /// 지난 주 날짜의 weekdayView로 변경합니다.
    @objc func fetchLastWeek() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!
        reloadViews()
    }
    
    /// 다음 주 날짜의 weekdayView로 변경합니다.
    @objc func fetchNextWeek() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!
        reloadViews()
    }
    
    /// 댄서 디테일 뷰 페이지로 이동합니다.
    @objc func pushDetailView(_ sender: UITapGestureRecognizer) {
        print("pushDetailView(): \(sender.view!.accessibilityLabel!)")
        let dancerDetailVC = DancerDetailViewController()
        guard let dancerID = sender.view?.accessibilityLabel else { return }
        dancerDetailVC.dancerID = dancerID
        self.navigationController?.pushViewController(dancerDetailVC, animated: true)
    }
    
    @objc func pushMainView() {
        // TODO: 어느 뷰로 갈지 정하기
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        // 상단 month 레이블
        monthNumberLabel.text = String(selectedDate.get(.month))
        view.addSubview(monthNumberLabel)
        monthNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        monthNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        monthNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        view.addSubview(monthLabel)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: monthNumberLabel.topAnchor, constant: 8).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: monthNumberLabel.trailingAnchor).isActive = true
        
        // < > 버튼
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: monthNumberLabel.topAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        view.addSubview(previousButton)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.topAnchor.constraint(equalTo: nextButton.topAnchor).isActive = true
        previousButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -5).isActive = true
        
        // weekCollectionView
        weekCollectionView.register(WeekdayCell.self, forCellWithReuseIdentifier: weekCellID)
        weekCollectionView.dataSource = self
        weekCollectionView.delegate = self
        
        view.addSubview(weekCollectionView)
        weekCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weekCollectionView.topAnchor.constraint(equalTo: monthNumberLabel.bottomAnchor, constant: 45).isActive = true
        weekCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weekCollectionView.trailingAnchor.constraint(equalTo: weekCollectionView.leadingAnchor, constant: 65).isActive = true
        weekCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130).isActive = true
        
        // 세로 구분선
        view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: weekCollectionView.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: weekCollectionView.topAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: weekCollectionView.bottomAnchor).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        // scheduleCollectionView
        scheduleCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: scheduleCellID)
        scheduleCollectionView.dataSource = self
        scheduleCollectionView.delegate = self
        
        view.addSubview(scheduleCollectionView)
        scheduleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        scheduleCollectionView.contentInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 0)
        scheduleCollectionView.topAnchor.constraint(equalTo: monthNumberLabel.bottomAnchor, constant: 45).isActive = true
        scheduleCollectionView.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 1).isActive = true
        scheduleCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130).isActive = true
        scheduleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        // goToSubscribeView(구독한 댄서가 없을 때)
        if subscriptionIDs.count <= 0 {
            goToSubscribeView.addArrangedSubview(noSubscriptionLabel)
            goToSubscribeView.addArrangedSubview(goSubscribeLabel)
            
            view.addSubview(goToSubscribeView)
            goToSubscribeView.translatesAutoresizingMaskIntoConstraints = false
            goToSubscribeView.centerXAnchor.constraint(equalTo: scheduleCollectionView.centerXAnchor).isActive = true
            goToSubscribeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            goToSubscribeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushMainView)))
        }
    }
    
    /// 클래스 데이터를 이용해 StackView에 각각 해당하는 ScheduleView를 추가합니다.
    private func addScheduleToStackView() async {
        await fetchSchedules()
        
        stackViews.enumerated().forEach{
            $0.1.subviews.forEach{ subView in
                subView.removeFromSuperview()
            }
            
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 15
            stackView.distribution = .equalSpacing
            stackViews[$0.0] = stackView
            
            weekSchedules[$0.0].forEach { schedule in
                let dancerName = schedule.dancerName
                let studioName = schedule.studioName
                let startTime = "\(schedule.startTime!.get(.hour)):\(schedule.startTime!.get(.minute))"
                let endTime = "\(schedule.endTime!.get(.hour)):\(schedule.endTime!.get(.minute))"
                
                scheduleViewWidth = (scheduleCollectionView.frame.width - 15) / 2
                let scheduleView = ScheduleView(frame: .zero, dancerName: dancerName ?? "", studioName: studioName ?? "", startTime: startTime, endTime: endTime, viewWidth: scheduleViewWidth)
                scheduleView.translatesAutoresizingMaskIntoConstraints = false
                scheduleView.widthAnchor.constraint(equalToConstant: scheduleViewWidth).isActive = true
                scheduleView.heightAnchor.constraint(equalToConstant: scheduleCollectionView.frame.height / 8).isActive = true
                
                scheduleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.pushDetailView(_:))))
                scheduleView.accessibilityLabel = schedule.dancerID ?? ""
                
                stackView.addArrangedSubview(scheduleView)
            }
        }
    }
    
    /// ScheduleViewController에서 변경되는 뷰를 다시 로드합니다.
    private func reloadViews() {
        monthNumberLabel.text = selectedDate.monthString()
        weekCollectionView.reloadData()
        Task {
            await addScheduleToStackView()
            scheduleCollectionView.reloadData()
        }
    }
    
    /// 날짜에 맞는 DanceClass를 각각 배열에 넣어줍니다.
    private func fetchSchedules() async {
        if subscriptionIDs.count <= 0 {
            return
        }
        let monday = selectedDate.mondayInWeek(at: selectedDate.get(.weekday))
        let cal = Calendar.current
        
        for idx in 0...6 {
            let date = cal.date(byAdding: .day, value: idx, to: monday)
            weekSchedules[idx] = []
            
            do {
                if DanceClassManager.myClasses == nil {
                    IndicatorView.shared.show()
                    IndicatorView.shared.showIndicator()
                    DanceClassManager.myClasses = try await DanceClassManager.shared.requestDanceClassesBy(dancerIDs: subscriptionIDs)
                    IndicatorView.shared.dismiss()
                }
                let dancerSchedules = DanceClassManager.myClasses!.filter { cal.isDate(date!, inSameDayAs: $0.startTime!) }
                dancerSchedules.forEach { schedule in
                    weekSchedules[idx].append(schedule)
                }
                weekSchedules[idx] = weekSchedules[idx].sorted(by: { $0.startTime! < $1.startTime! })
            }
            catch {
                print(error)
            }
        }
    }
}

// MARK: - UICollectionView Extension

extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.scheduleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellID, for: indexPath)
            cell.contentView.addSubview(stackViews[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellID, for: indexPath) as! WeekdayCell
            cell.weekdayLabel.text = Weekday.allCases[indexPath.item].rawValue
            cell.dayLabel.text = cell.dayString(date: selectedDate, dayNum: indexPath.item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}

extension ScheduleViewController: UICollectionViewDelegate {
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.scheduleCollectionView {
            let maxNum = weekSchedules.max { $0.count < $1.count }
            return CGSize(width: (scheduleViewWidth + 15) * CGFloat(maxNum!.count), height: (collectionView.frame.height / 8))
        } else {
            return CGSize(width: 30, height: (collectionView.frame.height / 8))
        }
    }
}

// MARK: - Preview

import SwiftUI

struct ScheduleViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScheduleViewController
    
    func makeUIViewController(context: Context) -> ScheduleViewController {
        return ScheduleViewController()
    }
    
    func updateUIViewController(_ uiViewController: ScheduleViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct ScheduleViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ScheduleViewControllerRepresentable()
    }
}
