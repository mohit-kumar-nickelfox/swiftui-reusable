//
//  CustomEditorView+Components.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

extension CustomEditorView {
    
    // MARK: Editor View
    var editorView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VStack(spacing: 4) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(self.viewModel.allScreens, id: \.self) { screen in
                                VStack {
                                    Button {
                                        print(screen.title, "tapped")
                                        self.viewModel.selectedScreen = screen
                                    } label: {
                                        Text(screen.title)
                                            .font(.subheadline)
                                            .foregroundColor(
                                                colorScheme == .light
                                                ? .black
                                                : .white
                                            )
                                            .padding(10)
                                    }
                                }
                                .background(
                                    self.viewModel.selectedScreen == screen
                                    ? colorScheme == .light ? Color.white.opacity(1.0) : Color.black.opacity(0.4)
                                    : colorScheme == .light ? Color.white.opacity(0.25) : Color.black.opacity(0.14)
                                )
                                .cornerRadius(4)
                            }
                        }.padding(.horizontal, 20)
                        
                    }
                    .frame(height: 40)
                    .background(Color.gray)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(self.viewModel.selectedScreen.components, id: \.self) { component in
                                VStack {
                                    Button {
                                        self.openEditor(for: component)
                                    } label: {
                                        Text(component.rawValue)
                                            .font(.caption)
                                            .foregroundColor(
                                                colorScheme == .light
                                                ? .black
                                                : .white
                                            )
                                            .padding(5)
                                            
                                    }
                                }
                                .background(
                                    self.backgroundColor(forComponent: component)
                                )
                                .cornerRadius(4)
                            }
                        }.padding(.horizontal, 20)
                        
                    }
                    .frame(height: 30)
                    .background(Color.gray)
                }

            }
            .background(Color.gray)
            Spacer()
        }
        .animation(.easeOut(duration: editorAnimationDuration), value: self.showEditor)
        .offset(CGSize(
            width: 0.0,
            height: showEditor ? 0.0 : -204))
    }
    
    func backgroundColor(forComponent component: CustomComponents) -> Color {
        
        if self.viewModel.selectedComponent == component {
            return colorScheme == .light ? Color.white.opacity(1.0) : Color.black.opacity(0.4)
        } else {
            return colorScheme == .light ? Color.white.opacity(0.25) : Color.black.opacity(0.14)
        }
    }
    
    func openEditor(for type: CustomComponents) {
        switch type {
        case .segment:
            ()
        case .userIdField, .passwordField:
            withAnimation {
                self.openTextFieldEditor.toggle()
            }
            
        case .loginButton:
            ()
        case .signupText:
            ()
        case .signupButtton:
            ()
        case .forgotPasswordButton:
            ()
        case .none:
            ()
        }
    }
    
    // MARK: Editor Button
    var editorButton: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation(.easeOut(duration: editorAnimationDuration)) {
                        self.showEditor.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: showEditor
                              ? "chevron.up"
                              : "chevron.down")
                        Text("Editor")
                    }.padding(.trailing, 20)
                }

            }.padding(.top, 10)
            
            Spacer()
        }
    }
}

// MARK: Preview
struct CustomEditorViewComponents_Previews: PreviewProvider {
    static var previews: some View {
        CustomEditorView()
    }
}
