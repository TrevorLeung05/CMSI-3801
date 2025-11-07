import Foundation

func firstThenLowerCase<S: StringProtocol>(of elements: [S], satisfying predicate: (S) -> Bool) -> String? {
    return elements.first(where: predicate)?.lowercased()
}

class PhraseBuilder {
    private var currentPhrase: String
    
    var phrase: String {
        return currentPhrase
    }
    
    init(_ start: String) {
        self.currentPhrase = start
    }
    
    @discardableResult
    func and(_ nextWord: String) -> PhraseBuilder {
        let newPhrase = self.currentPhrase + " " + nextWord
        return PhraseBuilder(newPhrase)
    }
}

func say() -> PhraseBuilder {
    return PhraseBuilder("")
}

func say(_ start: String) -> PhraseBuilder {
    return PhraseBuilder(start)
}

func meaningfulLineCount(_ filename: String) async -> Result<Int, Error> {
    do {
        let url = URL(fileURLWithPath: filename)
        var count = 0
        
        for try await line in url.lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if !trimmedLine.isEmpty && trimmedLine.first != "#" {
                count += 1
            }
        }
        return .success(count)
    } catch {
        return .failure(error)
    }
}

struct Quaternion: Equatable, CustomStringConvertible {
    let a, b, c, d: Double
    
    init(a: Double = 0.0, b: Double = 0.0, c: Double = 0.0, d: Double = 0.0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }
    
    static let ZERO = Quaternion()
    static let I = Quaternion(b: 1)
    static let J = Quaternion(c: 1)
    static let K = Quaternion(d: 1)
    
    var coefficients: [Double] {
        return [a, b, c, d]
    }
    
    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }
    
    var description: String {
        var parts: [String] = []
        
        func formatComponent(_ value: Double, _ unit: String = "") -> String? {
            if value == 0 { return nil }

            if unit.isEmpty {
                if value.truncatingRemainder(dividingBy: 1) == 0 {
                    return String(format: "%.1f", value)
                } else {
                    return String(format: "%g", value)
                }
            }

            if value == 1 { return parts.isEmpty ? unit : "+\(unit)" }
            if value == -1 { return "-\(unit)" }

            let signStr: String
            if value > 0 {
                signStr = parts.isEmpty ? "" : "+"
            } else {
                signStr = "-"
            }
            let absVal = abs(value)
            let numStr = (absVal.truncatingRemainder(dividingBy: 1) == 0)
                ? String(format: "%.1f", absVal)
                : String(format: "%g", absVal)
            return "\(signStr)\(numStr)\(unit)"
        }
        
        if let aStr = formatComponent(a) { parts.append(aStr) }
        if let bStr = formatComponent(b, "i") { parts.append(bStr) }
        if let cStr = formatComponent(c, "j") { parts.append(cStr) }
        if let dStr = formatComponent(d, "k") { parts.append(dStr) }
        
        if parts.isEmpty { return "0" }
        return parts.joined().replacingOccurrences(of: "+-", with: "-")
    }
}

func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    return Quaternion(
        a: lhs.a + rhs.a,
        b: lhs.b + rhs.b,
        c: lhs.c + rhs.c,
        d: lhs.d + rhs.d
    )
}

func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    return Quaternion(
        a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
        b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
        c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
        d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
    )
}

indirect enum BinarySearchTree: CustomStringConvertible {
    case empty
    case node(BinarySearchTree, String, BinarySearchTree)
    
    var size: Int {
        switch self {
        case .empty:
            return 0
        case .node(let left, _, let right):
            return 1 + left.size + right.size
        }
    }
    
    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(.empty, value, .empty)
        case .node(let left, let currentValue, let right):
            if value == currentValue {
                return self
            } else if value < currentValue {
                return .node(left.insert(value), currentValue, right)
            } else {
                return .node(left, currentValue, right.insert(value))
            }
        }
    }
    
    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case .node(let left, let currentValue, let right):
            if value == currentValue {
                return true
            } else if value < currentValue {
                return left.contains(value)
            } else {
                return right.contains(value)
            }
        }
    }
    
    var description: String {
        switch self {
        case .empty:
            return "()"
        case .node(let left, let value, let right):
            let leftStr: String
            switch left {
            case .empty: leftStr = ""
            default: leftStr = "\(left.description)"
            }
            let rightStr: String
            switch right {
            case .empty: rightStr = ""
            default: rightStr = "\(right.description)"
            }
            return "(\(leftStr)\(value)\(rightStr))"
        }
    }
}