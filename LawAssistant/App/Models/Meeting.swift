//
//  Meeting.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 13.11.2022.
//

import Foundation

struct Meeting: Identifiable {
    var id = UUID().uuidString
    var time = Date()
    var lawCase: LawCase
}

struct MeetingData: Identifiable {
    var id = UUID().uuidString
    var meeting: [Meeting]
    var meetingDate: Date
    
//    static var meetings: [MeetingData] = {
//        let lawCases = LawCase.getCases()
//        return [MeetingData(meeting: [Meeting(lawCase: lawCases[0].subitems?[0] ?? LawCase(title: "")),
//                                      Meeting(lawCase: lawCases[0].subitems?[1] ?? LawCase(title: "")),
//                                      Meeting(lawCase: lawCases[0].subitems?[2] ?? LawCase(title: ""))],
//                            meetingDate: getSampleDate(offset: 2)),
//                
//                MeetingData(meeting: [Meeting(lawCase: lawCases[1].subitems?[0] ?? LawCase(title: "")),
//                                      Meeting(lawCase: lawCases[1].subitems?[1] ?? LawCase(title: "")),
//                                      Meeting(lawCase: lawCases[1].subitems?[2] ?? LawCase(title: ""))],
//                            meetingDate: getSampleDate(offset: 4)),
//                
//                MeetingData(meeting: [Meeting(lawCase: lawCases[2].subitems?[0] ?? LawCase(title: "")),
//                                      Meeting(lawCase: lawCases[2].subitems?[1] ?? LawCase(title: "")),
//                                      Meeting(lawCase: lawCases[2].subitems?[2] ?? LawCase(title: ""))],
//                            meetingDate: getSampleDate(offset: 6))
//        ]
//    }()
    
}

func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}


