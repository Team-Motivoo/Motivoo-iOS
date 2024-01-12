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

            static var usuallyWorryExercise = "평소 활동 중 불편했거나\n걱정되는 곳을 선택해주세요"
            static var choiceMaxThree = "최대 3개까지 선택할 수 있어요"
            static var neck = "목"
            static var shoulder = "어깨"
            static var waist = "허리"
            static var knee = "무릎"
            static var wrist = "손목"
            static var ankle = "발목"
            static var startMotivoo = "모티부 시작하기"
        }

        enum Q4 {
            static var exerciseTitle = "일상생활 중 자주 하는 활동을 알려주세요"
            static var exercisePowerSubtitle = "가장 많이 하는 활동을 기준으로 선택해주세요"
            static var highTitle = "고강도 활동"
            static var highSubtitle = "무거운 물건 나르기, 육아 등"
            static var middleTitle = "중강도 활동"
            static var middleSubtitle = "가벼운 물건 나르기 등"
            static var lowTitle = "저강도 활동"
            static var lowSubtitle = "출퇴근, 가벼운 청소, 쇼핑 등"

            static var howManyExercise = "해당 활동을 일주일에\n몇 번 하시나요?"
            static var howLongExercise = "하루에 몇 시간 정도\n해당 활동을 하시나요?"
        }

        enum Invitation {
            static var share = "함께 운동할 가족에게\n초대코드를 공유해주세요!"
            static var invitationCode = "초대코드"
            static var copy = "복사하기"
            static var matchingCheck = "매칭 확인하기"
            static var checking = "아직 매칭을 확인하고 있어요"
            static var clipboard = "클립보드에 복사되었습니다"
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
        
    }
}


