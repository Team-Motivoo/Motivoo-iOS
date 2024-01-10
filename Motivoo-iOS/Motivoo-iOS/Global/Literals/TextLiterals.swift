//
//  Text.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

enum TextLiterals {
    
    enum Onboarding {
        static var name = "다음"
        static var yes = "네"
        static var no = "아니요"

        enum Q1 {
            static var patent = "부모"
            static var child = "자녀"
            static var parentOrChild = "부모 or 자녀"
            static var age = "나이"
            static var textArea = "텍스트 영역"

            static var ageInput = "14세부터 99세까지 사용 가능해요."

            static var parentTitle = "당신은\n부모인가요 자녀인가요?"
            static var parentSubtitle = "맞춤 운동을 제공해드려요!"
            static var ageTitle = "나이를 알려주세요"
            static var ageSubtitle = "맞춤 운동 추천을 위해 필요해요"
        }

        enum Q2 {
            static var usuallyExercise = "평소 운동을 하시나요?"
        }

        enum Q3 {
            static var exerciseTitle = "평소 하는 운동을 알려주세요"
            static var exercisePowerSubtitle = "운동 강도에 따라 선택해주세요"
            static var highTitle = "고강도 운동"
            static var highSubtitle = "등산, 에어로빅, 크로스핏, 헬스 등"
            static var middleTitle = "중강도 운동"
            static var middleSubtitle = "빠르게 걷기, 골프, 필라테스 등"
            static var lowTitle = "저강도 운동"
            static var lowSubtitle = "걷기, 요가, 스트레칭 등"

            static var howManyExercise = "일주일에 운동을\n몇 번 하시나요?"
            static var one = "1일 미만"
            static var two = "1-2회"
            static var three = "3-4회"
            static var five = "5회 이상"

            static var howLongExercise = "하루에 몇 시간 정도\n운동하시나요?"
            static var thirtyMinutes = "30분 미만"
            static var oneHour = "30분 - 1시간"
            static var twoHour = "1시간 - 2시간"
            static var twoHourOver = "2시간 이상"
        }
    }

    enum Home {
        static var date = "\(DateLiterals.year)년 \(DateLiterals.month)월 \(DateLiterals.day)일"
        static var pick = "오늘 할 운동을 골라주세요!"
        static var firstMission = "8천걸음 걷고\n스쿼트 10번 하기"
        static var secondMission = "8천걸음 걸어서\n트리 보러가기"
        static var walk = "걸음 수"
        static var myWalk = "내 걸음"
        static var parentWalk = "부모님 걸음"
        static var clearPercent = "운동 달성률"
        static var checkMission = "운동 인증하기"
    }
    
    enum MyPage {
        static var exerciseInfo = "운동 정보"
        static var checkExerciseInfo = "내 운동 정보를 확인하세요!"
        static var parent = "의지뿜뿜 부모님"
        static var child = "행복팡팡 자녀"
        static var service = "서비스 이용약관"
        static var privacyPolicy = "개인정보 처리방침"
        static var openSourceLicense = "오픈소스 라이선스"
        static var developerInfo = "개발자 정보"
        static var AppInfoItems: [String] = ["서비스 이용약관", "개인정보 처리방침", "오픈소스 라이선스", "개발자 정보"]
        static var ToKakaoChannel = "카카오채널 문의하기"
        static var appInfo = "앱 정보"
        static var back = "이전"
        static var exercisestatus = "운동여부"
        static var intensity = "운동 / 신체활동 강도"
        static var WeeklyaverageFrequency = "주 평균 횟수"
        static var averageTimePerDay = "하루 평균 시간"
        static var pointsToNote = "주의할 곳"
        
    }
}


