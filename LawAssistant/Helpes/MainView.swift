//
//  MainView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 10.11.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                CaseListView()
            }
            .tabItem {
                Label("Мои дела", systemImage: "list.bullet.rectangle.portrait.fill")
            }
            NavigationView {
                MeetingsView()
            }
            .tabItem {
                Label("График заседаний", systemImage: "calendar")
            }
            NavigationView {
                ServicesView()
            }
            .tabItem {
                Label("Услуги", systemImage: "case")
            }
            NavigationView {
                ChatView()
            }
            .tabItem {
                Label("Онлайн чат", systemImage: "captions.bubble")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
