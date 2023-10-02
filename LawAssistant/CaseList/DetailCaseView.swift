//
//  DetailCaseView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 12.11.2022.
//

import SwiftUI

struct DetailCaseView: View {
    
    @State private var searchText = ""
    
    private let lawCase: LawCase
    
    init(lawCase: LawCase) {
        self.lawCase = lawCase
    }
    
    var body: some View {
        
        VStack {
            List {
                Section("О деле") {
                    MainRowView(title: "Истец:", subtitle: self.lawCase.applicant)
                    MainRowView(title: "Ответчик:", subtitle: self.lawCase.defendant)
                    MainRowView(title: "Суд:", subtitle: self.lawCase.courtName)
                    MainRowView(title: "Судья:", subtitle: self.lawCase.judgeName)
                    MainRowView(title: "Краткая справка:", subtitle: self.lawCase.shortReference)
                    MainRowView(title: "Заметки:", subtitle: self.lawCase.note)
                    //            self.showCellIfNeeded(title: "Ближайшее заседание:", value: String(self.lawCase.nextСourt))
                }
                .font(.headline)
                Section("Документы") {
                    ForEach(LawDocumentType.allCases, id: \.rawValue) { type in
                        if let documents = self.lawCase.documents?.filter({ $0.type == type }), !documents.isEmpty {
                            Section(type.rawValue) {
                                ForEach(documents) { document in
                                    DocumentRowView(title: document.filename, state: .uploaded)
                                }
                            }.font(.headline)
                        }
                    }
                }
                .font(.headline)
            }
            .listStyle(.sidebar)
            .navigationTitle("№" + self.lawCase.title)
            .searchable(text: $searchText)
        }
    }
    
}

private struct MainRowView: View {
    
    let title: String
    let subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .font(.subheadline)
            Text(self.subtitle ?? "-")
                .font(.body)
        }
    }
    
}

private struct DocumentRowView: View {
    
    let title: String
    @State var state: DocumentItemViewState
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.body)
            }
            Spacer()
            CircularProgressView(state: self.state, progress: 10)
                .frame(width: 30, height: 30)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            self.state = .downloading(0.5)
                        }
                )
        }
    }
    
}

//struct DetailCaseView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCaseView(lawCase: <#T##LawCase#>)
//    }
//}
