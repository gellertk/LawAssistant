//
//  Document.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 12.11.2022.
//

import Foundation

enum LawDocumentType: String, CaseIterable {
    case financial = "Финансовые"
    case signIns = "Подписания"
    case procedural = "Процессуальные"
    case other = "Другое"
}

struct Document: Equatable, Identifiable {
    let id: UUID = UUID()
    let filename: String
    var url: URL? = nil
    let type: LawDocumentType
}
