//
//  Text.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

enum TextLiterals {
    
    enum Onboarding {
        static var Next = "다음"
        static var Yes = "네"
        static var No = "아니요"

        enum Q1 {
            static var Parent = "부모"
            static var Child = "자녀"
            static var ParentOrChild = "부모 or 자녀"
            static var Age = "나이"
            static var TextArea = "텍스트 영역"

            static var AgeInput = "14세부터 99세까지 사용 가능해요."

            static var ParentTitle = "당신은\n부모인가요 자녀인가요?"
            static var ParentSubtitle = "맞춤 운동을 제공해드려요!"
            static var AgeTitle = "나이를 알려주세요"
            static var AgeSubtitle = "맞춤 운동 추천을 위해 필요해요"
        }

        enum Q2 {
            static var UsuallyExercise = "평소 운동을 하시나요?"
        }

        enum Q3 {
            static var ExerciseTitle = "평소 하는 운동을 알려주세요"
            static var ExercisePowerSubtitle = "운동 강도에 따라 선택해주세요"
            static var HighTitle = "고강도 운동"
            static var HighSubtitle = "등산, 에어로빅, 크로스핏, 헬스 등"
            static var MiddleTitle = "중강도 운동"
            static var MiddleSubtitle = "빠르게 걷기, 골프, 필라테스 등"
            static var LowTitle = "저강도 운동"
            static var LowSubtitle = "걷기, 요가, 스트레칭 등"

            static var HowManyExercise = "일주일에 운동을\n몇 번 하시나요?"
            static var One = "1일 미만"
            static var Two = "1-2회"
            static var Three = "3-4회"
            static var Five = "5회 이상"

            static var HowLongExercise = "하루에 몇 시간 정도\n운동하시나요?"
            static var ThirtyMinutes = "30분 미만"
            static var OneHour = "30분 - 1시간"
            static var TwoHour = "1시간 - 2시간"
            static var TwoHourOver = "2시간 이상"
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


