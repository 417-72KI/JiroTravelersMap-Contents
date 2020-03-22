import Foundation

struct Shop: Model, Identifiable {
    let id: Int
    let kind: Kind
    let name: String
    let status: Status
    let prefecture: Prefecture
    let address: String
    let location: Location
    let regularHoliday: [Day]
    let openingHours: OpeningHours
}

extension Shop {
    var openingToday: String {
        let today = openingHours.today
        if today.isEmpty { return "休" }
        return today.stringValue()
    }
}

// MARK: -
extension Shop {
    enum Kind: String, Model {
        case origin
        case inspired
    }
}

// MARK: -
extension Shop {
    enum Status: String, Model {
        case open
        case closed
        case beforeOpen = "before_open"
    }
}

// MARK: -
extension Shop {
    struct OpeningHours: Model {
        let monday: [Time]
        let tuesday: [Time]
        let wednesday: [Time]
        let thursday: [Time]
        let friday: [Time]
        let saturday: [Time]
        let sunday: [Time]
        let holiday: [Time]
    }
}

extension Shop.OpeningHours {
    var today: [Time] { forDate(Date()) }
}

extension Shop.OpeningHours {
    func forDate(_ date: Date) -> [Time] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let comp = calendar.dateComponents([.weekday], from: date)
        switch comp.weekday {
        case 1: return sunday
        case 2: return monday
        case 3: return tuesday
        case 4: return wednesday
        case 5: return thursday
        case 6: return friday
        case 7: return saturday
        default: fatalError("invalid")
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
        arrayValue.filter { !$1.isEmpty }
            .map { ($0, $1.stringValue(separator: R.string.symbol.separator())) }
            .map { "\($0): \($1)" }
            .joined(separator: "\n")
    }

    var arrayValue: [(String, [Time])] {
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
