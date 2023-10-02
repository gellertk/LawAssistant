//
//  Date+Extension.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 13.11.2022.
//

import Foundation

public enum DateFormatterMode: Hashable {

    /// DD/MM
    case dayMonth

    /// dd/MM/yyyy
    case date

    /// HH:mm
    case time

    /// dd/MM/yyyy HH:mm
    case dateAndTime

    /// Today / Tomorrow / Monday / 10th October / etc
    case prettyDate

    /// Today 10:34 / Yesterday 10:34 / 10.03 10:34 / 10.03.2010 10:34
    case prettyDateTime

    /// sun 17 Oct
    case namedShortDate

    // sun
    case namedShortDayOfWeek

    // 10:33 / Yesterday / 10.03 / 10.03.2010
    case approximate

    case custom(String)
}

extension Date {

    public func stringified(_ mode: DateFormatterMode) -> String {
        
        let dateAndTime = "dd/MM/yyyy HH:mm"
        let dayMonth = "dd/MM"
        let namedFullMonthDay = "d MMMM"
        let namedShortDate = "E d MMM"
        let namedShortWeekday = "E"
        let onlyDate = "dd/MM/yyyy"
        let onlyTime = "HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        switch mode {

        case .approximate:
            if self.isInToday {
                return self.stringified(.time)
            } else if self.isInYesterday {
                return "Вчера"
            } else if self.isInThisWeek {
                return self.stringified(.namedShortDayOfWeek)
            } else if self.isInThisYear {
                return self.stringified(.dayMonth)
            } else {
                return self.stringified(.date)
            }

        case .prettyDateTime:
            if self.isInToday {
                return "Сегодня" + " " + self.stringified(.time)
            } else if self.isInYesterday {
                return "Вчера" + " " + self.stringified(.time)
            } else if self.isInThisWeek {
                return self.stringified(.namedShortDayOfWeek) + " " + self.stringified(.time)
            } else if self.isInThisYear {
                return self.stringified(.dayMonth) + " " + self.stringified(.time)
            } else {
                return self.stringified(.date) + " " + self.stringified(.time)
            }

        case .custom(let format):
            dateFormatter.dateFormat = format
        case .dayMonth:
            dateFormatter.dateFormat = dayMonth
        case .date:
            dateFormatter.dateFormat = onlyDate
        case .time:
            dateFormatter.dateFormat = onlyTime
        case .dateAndTime:
            dateFormatter.dateFormat = dateAndTime
        case .namedShortDate:
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = namedShortDate
        case .namedShortDayOfWeek:
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = namedShortWeekday
        case .prettyDate:
            dateFormatter.locale = Locale.current
            if self.isInTomorrow {
                return "Завтра"
            } else if self.isInToday {
                return "Сегодня"
            } else if self.isInYesterday {
                return "Вчера"
            } else if self.isInThisYear {
                dateFormatter.dateFormat = namedFullMonthDay
            } else {
                dateFormatter.dateStyle = .long
            }

        }
        return dateFormatter.string(from: self)
    }

    public func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }

    public func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }

    public func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }

    public var isInThisWeek: Bool {
        return self.isInSameWeek(date: Date())
    }

    public var isInThisYear: Bool {
        return self.isInSameYear(date: Date())
    }

    public var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    public var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    public var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    public var isInTheFuture: Bool {
        return Date() < self
    }

    public var isInThePast: Bool {
        return self < Date()
    }

    public var startOfDay: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    public var endOfDay: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }

}

