//
//  DancerDetailSchduleManager.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/25.
//

import UIKit

class DancerDetailSchduleManager {
    private var dancerScheduleDataArray: [DancerDetailScheduleModel] = []
    
    func makeDancerData() {
        dancerScheduleDataArray = [
            DancerDetailScheduleModel(studioLabel: "왜안되지", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailScheduleModel(studioLabel: "호진스튜디오", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailScheduleModel(studioLabel: "justjerk", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailScheduleModel(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailScheduleModel(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailScheduleModel(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailScheduleModel(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
        ]
    }
    
    func fetchScheduleData() -> [DancerDetailScheduleModel] {
        return dancerScheduleDataArray
    }
}
