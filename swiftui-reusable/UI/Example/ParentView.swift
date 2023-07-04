//
//  ParentView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 04/07/23.
//

import SwiftUI

struct ParentView: View {
    var body: some View {
        NavigationView {
              VStack {
                List {
                  Section("Screens") {
                      NavigationLink {
                          LoginViewExample()
                      } label: {
                          Text("login Screen")
                      }
                  }
                  
//                  Section("Components") {
//                    ForEach(contacts, id: \.self) { contact in
//                      Text(contact)
//                    }
//                  }
                }
              }
              .listStyle(SidebarListStyle())
              .navigationTitle("SwiftUI Reusable")
            }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
