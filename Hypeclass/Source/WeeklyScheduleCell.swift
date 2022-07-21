//
//  WeeklyScheduleCell.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/20.
//

import UIKit

class WeeklyScheduleCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func setLayout() {
        // 요일 label
        contentView.addSubview(weekdayLabel)
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        weekdayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        weekdayLabel.backgroundColor = .systemPink
        weekdayLabel.textAlignment = .center

//         날짜 label
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor, constant: 1).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: weekdayLabel.centerXAnchor).isActive = true
        
//        contentView.addSubview(labelStack)
//        labelStack.translatesAutoresizingMaskIntoConstraints = false
//        labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        labelStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
//        labelStack.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    /// date가 속해 있는 주의 날짜를 반환합니다.
    func dayString(date: Date, dayNum: Int) -> String {
        var myDate = date
        if dayNum == 6 {
            myDate = Calendar.current.date(byAdding: .day, value: 7, to: date)!
        }
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        comps.weekday = 7 * ((dayNum + 2) / 7) + (dayNum + 2) % 7
        return String(cal.date(from: comps)!.get(.day))
    }
}
