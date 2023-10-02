//
//  CaseListView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 10.11.2022.
//

import SwiftUI

struct CaseListView: View {
    
    @State private var searchText = ""
    
    private let cases = Array<LawCase>()
    
    var body: some View {
        List(self.cases, children: \.subitems) { lawCase in
            if lawCase.subitems == nil {
                NavigationLink(destination: DetailCaseView(lawCase: lawCase)) {
                    Text(lawCase.title)
                }
            } else {
                Text(lawCase.title)
            }
        }
        .refreshable {
            print("Refreshing")
        }
        .searchable(text: self.$searchText)
        .navigationTitle("Мои дела")
    }
    
}

struct CaseListView_Previews: PreviewProvider {
    static var previews: some View {
        CaseListView()
    }
}


