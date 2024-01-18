//
//  Text.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

enum TextLiterals {
    
    enum Onboarding {
        static var next = "다음"
        static var yes = "네"
        static var no = "아니요"
        static var slogan = "가족과 함께 만들어 나가는\n오늘의 운동 습관 "
        static var loginRetry = "로그인을 다시 한 번 시도해주세요."

        enum Authorization {
            static var title = "접근 권한 안내"
            static var introlLabel = "원활한 이용을 위해\n다음 권한의 허용이 필요해요."
            static var action = "동작 및 피트니스"
            static var actionLabel = "동작 및 피트니스 앱으로 걸음수를 측정할게요"
            static var camera = "카메라"
            static var cameraLabel = "카메라 기능으로 운동을 인증할 수 있어요"
            static var picture = "사진"
            static var pictureLabel = "사진 기능으로 운동을 인증할 수 있어요"
            static var essential = "(필수)"
            static var caution = "허용하지 않아도 앱을 이용할 수 있으나, 일부\n서비스 이용이 제한될 수 있어요. 거부 후 설정에서\n다시 허용할 수 있어요. "
            static var allow = "허용하기"
        }

        enum Terms {
            static var title = "이용약관"
            static var allTerms = "약관 전체 동의"
            static var termsOfUse = "이용약관 동의"
            static var termsOfInfoCollection = "개인정보수집 및 이용 동의"
            static var termsOfInfoHangling = "개인정보 처리방침 동의"
            static var see = "보기"

            static var termOfUserURL = "https://www.notion.so/gayeong04/7f6097380a0b43d38ae265ea985152e7?pvs=4"
            static var termOfInfoCollectionURL = "https://www.notion.so/gayeong04/iOS-dc7e5c4540df40a298dba1ed15ef45d6?pvs=4"
            static var termOfInfoHandlingURL = "https://gayeong04.notion.site/df1e215e4b2248d28a913ea27788a777"
        }

        enum Login {
            static var slogan = "가족과 함께 만들어 나가는\n오늘의 운동 습관"
            static var motivooStart = "모티부 시작하기"
            static var invitationCode = "초대코드 입력하기"
        }

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
            static var one = "1회 미만"
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

            static var input = "초대받은 코드를\n붙여넣거나 입력해주세요"
            static var inputPalceholder = "초대코드를 입력해주세요"
            static var wrongInvitation = "초대코드가 올바르지 않아요"
        }
    }

    enum Home {
        enum Main {
            static var date = "\(DateLiterals.year)년 \(DateLiterals.month)월 \(DateLiterals.day)일"
            static var pick = "오늘 할 운동을 골라주세요!"
            static var firstMission = "8천걸음 걷고\n스쿼트 10번 하기"
            static var secondMission = "8천걸음 걸어서\n트리 보러가기"
            static var walk = "걸음 수"
            static var myWalk = "내 걸음"
            static var parentWalk = "부모님 걸음"
            static var clearPercent = "운동 달성률"
            static var checkMission = "운동 인증하기"
            static var completedMission = "인증 완료"
        }
        
        enum Prove {
            static var save = "사진은 운동 모아보기에 저장돼요"
            static var takePicture = "사진 찍기"
            static var gallery = "앨범에서 선택하기"
            static var title = "운동 인증이 완료되었어요!"
            static var subTitle = "오늘도 멋지게 운동을 해내셨군요"
            static var check = "확인"
        }
        
        enum Auth {
            static var healthNoAuthTitle = "‘건강’ 설정이 꺼져있습니다."
            static var healthNoAuthMessage = "설정 > 건강 > 데이터 접근 및 기기 > 모티부에서 걸음 읽기를 허용해주세요."
            static var cameraNoAuthTitle = "‘카메라’ 설정이 꺼져있습니다."
            static var cameraNoAuthMessage = "모티부에서 사용자가 기념 사진을 업로드하기 위해 해당 설정이 켜져있어야 합니다. 권한 허용을 위해 설정으로 이동합니다."
        }
    }
    enum MissionOverview {
        static var todayExercise = "오늘의 운동"
        static var alertMessage = "운동 기록은 30일간 보간 후 사라져요!"
        static var noImg = "운동을 완료하고\n사진을 등록해보세요!"
        static var fail = "다음 운동은\n완료해봐요!"
        static var Myexercise = "내 운동"
        static var doing = "진행중"
        static var onlyfail = "실패"
        static var onlysuccess = "성공"
        static var parentExercise = "부모님 운동"
        static var childExercise = "자녀 운동"

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
        static var weeklyaverageFrequency = "주 평균 횟수"
        static var averageTimePerDay = "하루 평균 시간"
        static var pointsToNote = "주의할 곳"
        static var leave = "회원탈퇴"
        static var logout = "로그아웃"
        static var leaveDescription = "탈퇴 시 모든 정보가 삭제됩니다."
        static var name = "이름"
        static var age = "나이"
        static var no = "안할래요"
        static var realLogout = "정말 로그아웃 하실건가요?"
        static var realLeave = "정말 탈퇴하시겠어요?"
        static var leaveSubtitle = "회원 탈퇴 시, 모든 정보가\n삭제되며 복구가 불가능해요."
        static var leaveTitle = "탈퇴하기"
        static var opensource = "https://gayeong04.notion.site/c78b181acf8a41f28f2ed653db998650"
        static var developer =  "https://gayeong04.notion.site/39aa420262384587957479ca4da2ba2e"
        static var kakao = "https://gayeong04.notion.site/08592ddcf3bf4a3b80e3c54110444ebf"
      
    }
    enum NoComplete {
        static var goExerciseMessage = "아직 완료한 운동이 없어요\n운동하고 나만의 엘범을 만들어봐요!"
        static var goTodayExercise = "오늘의 운동 하러가기"
    }


    enum URLs {
        static var postLogin = "/oauth/login"
        static var postExercise = "/user/exercise"
        static var getExercise = "/user/onboarding"
        static var patchInviteCode = "/parentchild/match"
        static var getMatchingCheck = "/onboarding/match"
    }
    enum URL {
        static var getMyInfo = "/user/me"
        static var getExerciseInfo = "/user/exercise"
        static var postLogout = "/oauth/logout"
        static var deleteLeave = "/withdraw"
        static var getMission = "/mission"
    }
}


