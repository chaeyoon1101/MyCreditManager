import Foundation

var studentInfos = [String: [String: String]]()

while true {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    if let menuNumber = readLine() {
        switch menuNumber {
        case "1":
            addStudent()
        case "2":
            deleteStudent()
        case "3":
            addGrade()
        case "4":
            deleteGrade()
        case "5":
            viewGrade()
        case "X":
            print("프로그램을 종료합니다...")
            exit(0)
        default:
            print(ProgramError.incorrectMenuNumber.rawValue)
        }
    }
}

func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    guard let name = readLine() else {
        print(ProgramError.incorrectInput.rawValue)
        return
    }
    
    if isExistName(name) {
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        return
    }
    
    studentInfos[name] = [:]
    print("\(name) 학생을 추가했습니다.")
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    guard let name = readLine() else {
        print(ProgramError.incorrectInput.rawValue)
        return
    }
    
    if isExistName(name) {
        studentInfos[name] = nil
        print("\(name) 학생을 삭제하였습니다.")
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func addGrade() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적중 해당과목이 존재하면 기존점수가 갱신됩니다.")
    
    guard let info = readLine()?.components(separatedBy: " "), info.count == 3 else {
        print(ProgramError.incorrectInput.rawValue)
        return
    }
    
    let name = info[0], subject = info[1], grade = info[2]
    
    if isExistName(name) {
        studentInfos[name]?[subject] = grade
        print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func deleteGrade() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")
    
    guard let info = readLine()?.components(separatedBy: " "), info.count == 2 else {
        print(ProgramError.incorrectInput.rawValue)
        return
    }
    
    let name = info[0], subject = info[1]
    
    if isExistName(name) {
        studentInfos[name] = nil
        print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func viewGrade() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    guard let name = readLine() else {
        print(ProgramError.incorrectInput)
        return
    }
    
    if isExistName(name) {
        var score = 0.0
        studentInfos[name]?.forEach {
            print("\($0.key): \($0.value)")
            score += calculateScore($0.value)
        }
        
        print(score / Double(studentInfos[name]!.count))
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func isExistName(_ name: String) -> Bool {
    return studentInfos[name] != nil
}

func calculateScore(_ grade: String) -> Double {
    switch grade {
    case "A+":
        return 4.5
    case "A":
        return 4.0
    case "B+":
        return 3.5
    case "B":
        return 3.0
    case "C+":
        return 2.5
    case "C":
        return 2.0
    case "D+":
        return 1.5
    case "D":
        return 1.0
    default:
        return 0.0
    }
}
