import Foundation

public struct Shop: Model, Identifiable {
    public let id: Int
    public let kind: Kind
    public let name: String
    public let status: Status
    public let prefecture: Prefecture
    public let address: String
    public let location: Location
    public let regularHoliday: [Day]
    public let openingHours: OpeningHours
}

public extension Shop {
    var openingToday: String {
        guard let today = openingHours.today,
              !today.isEmpty else { return "休" }
        return today.stringValue()
    }
}

// MARK: -
public extension Shop {
    enum Kind: String, Model {
        case origin
        case inspired
    }
}

// MARK: -
public extension Shop {
    enum Status: String, Model {
        case `open`
        case closed
        case beforeOpen = "before_open"
    }
}

// MARK: -
public extension Shop {
    struct OpeningHours: Model {
        let monday: [Time]?
        let tuesday: [Time]?
        let wednesday: [Time]?
        let thursday: [Time]?
        let friday: [Time]?
        let saturday: [Time]?
        let sunday: [Time]?
        let holiday: [Time]?
    }
}

extension Shop.OpeningHours {
    var today: [Time]? { forDate(Date()) }
}

extension Shop.OpeningHours {
    func forDate(_ date: Date) -> [Time]? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let comp = calendar.dateComponents([.weekday], from: date)
        return switch comp.weekday {
        case 1: sunday
        case 2: monday
        case 3: tuesday
        case 4: wednesday
        case 5: thursday
        case 6: friday
        case 7: saturday
        default: fatalError("invalid dateComponents: \(comp)")
        }
    }
}

// MARK: -
extension Shop.OpeningHours {
    struct Time: Model {
        let start: String
        let end: String
    }
}

extension Shop.OpeningHours.Time {
    var stringValue: String { "\(start)~\(end)" }
}

extension Shop.OpeningHours.Time: CustomStringConvertible {
    var description: String { stringValue }
}

extension Array where Element == Shop.OpeningHours.Time {
    func stringValue(separator: String = "\n") -> String {
        map { $0.description }
            .joined(separator: separator)
    }
}

// MARK: -
extension Shop.OpeningHours {
    var stringValue: String {
        arrayValue.compactMap {
            if let v = $1, !v.isEmpty {
                ($0, v)
            } else {
                nil
            }
        }
        .map { ($0, $1.stringValue(separator: R.string.symbol.separator())) }
        .map { "\($0): \($1)" }
        .joined(separator: "\n")
    }

    var arrayValue: [(String, [Time]?)] {
        [
            (R.string.day.monday_short(), monday),
            (R.string.day.tuesday_short(), tuesday),
            (R.string.day.wednesday_short(), wednesday),
            (R.string.day.thursday_short(), thursday),
            (R.string.day.friday_short(), friday),
            (R.string.day.saturday_short(), saturday),
            (R.string.day.sunday_short(), sunday),
            (R.string.day.holiday_short(), holiday)
        ]
    }
}
