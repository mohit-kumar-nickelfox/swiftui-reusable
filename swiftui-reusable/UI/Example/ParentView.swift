//
//  ParentView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 04/07/23.
//

import SwiftUI

struct ParentView: View {
    
    @State var screensSectionCollapsed: Bool = false
    @State var componentsSectionCollapsed: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    screens
                    components
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("SwiftUI Reusable")
        }
    }
    
    /// Screens Section
    /// 1. Login Screen
    var screens: some View {
        DisclosureGroup(isExpanded: self.$screensSectionCollapsed) {
            NavigationLink {
                LoginViewExample()
            } label: {
                HStack {
                    Image(systemName: "lock.desktopcomputer")
                    Text("Login Screen")
                }
            }
        } label: {
            HStack {
                Image(systemName: "iphone.gen1")
                Text("Screens")
                    .font(.headline)
            }
        }
    }
    
    /// Components Section
    /// 1. Custom Buttons
    var components: some View {
        DisclosureGroup(isExpanded: self.$componentsSectionCollapsed) {
            NavigationLink {
                VStack {
                    HStack {
                        Text("Custom Button 1")
                            .padding(.leading, 20)
                        Spacer()
                    }
                    CustomButton(action: {print("Custom Button 1 Tapped")},
                                 buttonTitle: "Button",
                                 backgroundColor: .gray,
                                 borderWidth: 2,
                                 borderColor: .black,
                                 cornerRadius: 8)
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 44)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.heavy)
                }
            } label: {
                HStack {
                    Image(systemName: "lightbulb.circle")
                    Text("Custom Buttons")
                }
            }
            
        } label: {
            HStack {
                Image(systemName: "puzzlepiece.extension")
                Text("Components")
                    .font(.headline)
            }
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
