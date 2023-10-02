//
//  LawCase.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 11.11.2022.
//

import Foundation

struct LawCase: Equatable, Identifiable {
    
    let id = UUID()
    let title: String
    var applicant: String? = nil
    var defendant: String? = nil
    var courtName: String? = nil
    var nextСourt: Date? = nil
    var judgeName: String? = nil
    var shortReference: String? = nil
    var note: String? = nil
    var subitems: [LawCase]? = nil
    var documents: [Document]? = nil
    
//    static func getCases() -> [LawCase] {
//
//        let items = [
//            LawCase(title: "А2813-113/2020",
//                    applicant: "ООО \"КЦСР\"",
//                    defendant: "ООО \"ОЛЬВИЯ\"",
//                    nextСourt: Date(),
//                    shortReference: "Дело о взыскании денежных средств фжылвтфдвтфывфылвтжфдлвджфвдлжфыовжлфыовжфывждфывждофыждвлфыжвлфждлвждфлвждфылвждфлвждфлывджфлывждфлывждфлывджфлыджвлфыжвлфыжлвджфлвджфлвджфлвждфлвждфлвджфлвждфылвджфлыджвлфыждвлфывжд",
//                    note: "Необходимо предоставить выписку из ЕГРЮЛ",
//                    documents:  [Document(filename: "Документ1.pdf", type: .financial),
//                                 Document(filename: "Документ2.pdf", type: .financial),
//                                 Document(filename: "Документ3.pdf", type: .financial),
//                                 Document(filename: "Документ4.pdf", type: .procedural),
//                                 Document(filename: "Документ5.pdf", type: .signIns),
//                                 Document(filename: "Документ6.pdf", type: .signIns)]
//                   ),
//            LawCase(title: "462/5947/1_2", applicant: "ООО Котики", defendant: "ООО Собачки"),
//            LawCase(title: "462/5947/1_3", applicant: "ООО Мышки", defendant: "ООО Совы")
//        ]
//
//        let items2 = [LawCase(title: "462/5947/2_1", applicant: "ООО Слоняры", defendant: "ООО Бублики"),
//                      LawCase(title: "462/5947/2_2", applicant: "ООО Котики", defendant: "ООО Собачки"),
//                      LawCase(title: "462/5947/2_3", applicant: "ООО Мышки", defendant: "ООО Совы")
//        ]
//
//        let items3 = [LawCase(title: "462/5947/3_1", applicant: "ООО Слоняры", defendant: "ООО Бублики"),
//                      LawCase(title: "462/5947/3_2", applicant: "ООО Котики", defendant: "ООО Собачки"),
//                      LawCase(title: "462/5947/3_3", applicant: "ООО Мышки", defendant: "ООО Совы")
//        ]
//
//        let items4 = [LawCase(title: "462/5947/4_1", applicant: "ООО Слоняры", defendant: "ООО Бублики"),
//                      LawCase(title: "462/5947/4_2", applicant: "ООО Котики", defendant: "ООО Собачки"),
//                      LawCase(title: "462/5947/4_3", applicant: "ООО Мышки", defendant: "ООО Совы")
//        ]
//
//        let items5 = [LawCase(title: "462/5947/5_1", applicant: "ООО Слоняры", defendant: "ООО Бублики"),
//                      LawCase(title: "462/5947/5_2", applicant: "ООО Котики", defendant: "ООО Собачки"),
//                      LawCase(title: "462/5947/5_3", applicant: "ООО Мышки", defendant: "ООО Совы")
//        ]
//
//       let cases = [LawCase(title: "Судебные дела", subitems: items),
//                    LawCase(title: "Претензионная работа", subitems: items2),
//                    LawCase(title: "Исполнительное производство", subitems: items3),
//                    LawCase(title: "Административное и антимонопольное право", subitems: items4),
//                    LawCase(title: "Банкротство", subitems: items5)]
//
//        return cases
//    }
    
}


