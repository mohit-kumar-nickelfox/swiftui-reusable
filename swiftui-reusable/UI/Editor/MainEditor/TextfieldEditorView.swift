//
//  ComponentEditorView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 07/07/23.
//

import SwiftUI

enum TextfieldEditorType: String {
    case title = "Title"
    case placeholder = "Placeholder"
    case titleColor = "Title Color"
    case titleFont = "Title Font"
    case borderColor = "Border Color"
    case textColor = "Text Color"
    case textFont = "Text Font"
    case cornerRadius = "Corner Radius"
    case borderWidth = "Border Width"
    
    
    static var allValues: [TextfieldEditorType] {
        return [
            .title,
            .placeholder,
            .titleColor,
            .titleFont,
            .borderColor,
            .textColor,
            .textFont,
            .cornerRadius,
            .borderWidth
        ]
    }
}

struct TextfieldEditorView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var title: String
    @Binding var placeholder: String
    @Binding var titleColor: Color
    @Binding var borderColor: Color
    @Binding var textColor: Color
    @Binding var cornerRadius: Double
    @Binding var borderWidth: Double
    
    @Binding var showTextfieldEditor: Bool
    
    @State var selectedBottomEditor: TextfieldEditorType = .title
    @State var text: String = "Sample Text"
    var body: some View {
        
        ZStack {
            
            bottomEditorView
        }.frame(width: UIScreen.main.bounds.size.width,
                height: UIScreen.main.bounds.size.height)
        
    }
    
    var choosenEditorView: some View {
        VStack {
            switch self.selectedBottomEditor {
            case .title:
                titleEditorView.padding(.horizontal, 20)
            case .placeholder:
                placeholderEditorView.padding(.horizontal, 20)
            case .titleColor:
                titleColorPicker.padding(.horizontal, 20)
            case .titleFont: EmptyView()
            case .borderColor:
                borderColorPicker.padding(.horizontal, 20)
            case .textColor:
                textColorPicker.padding(.horizontal, 20)
            case .textFont: EmptyView()
            case .cornerRadius:
                cornerRadiusEditorView.padding(.horizontal, 20)
            case .borderWidth:
                borderWidthEditorView.padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: Bottom Editor View
    var bottomEditorView: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack {
                
                closeButton.padding(.horizontal, 20)
                    .padding(.top, 20)
                sampleTextfieldView
                    .padding(20)
                
                choosenEditorView
                
                
                //                HStack{}.frame(height: 10)
                
                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(TextfieldEditorType.allValues, id: \.self) { item in
                                VStack {
                                    Button {
                                        self.selectedBottomEditor = item
                                    } label: {
                                        Text("\(item.rawValue)").padding(5)
                                            .fontWeight(.bold)
                                            .foregroundColor(
                                                self.colorScheme == .light
                                                ? .black
                                                : .white)
                                        
                                    }
                                    
                                    
                                }
                                .background(self.selectedBottomEditor == item
                                            ? colorScheme == .light ? Color.white.opacity(0.9) : Color.black.opacity(0.9)
                                            : colorScheme == .light ? Color.white.opacity(0.4) : Color.black.opacity(0.3))
                                .cornerRadius(6)
                                //                                .shadow(Color.black, radius: 10)
                                .shadow(
                                    color: colorScheme == .light
                                    ?.black.opacity(0.5)
                                    : .white.opacity(0.5),
                                    radius: 5,
                                    x: 0,
                                    y: 0)
                            }
                        }
                        .padding(10)
                    }
                }
                
                HStack{}.frame(height: 30)
                
            }
            .background(self.colorScheme == .light
                        ? .gray
                        : .gray)
            
            
        }
        
    }
    
    // MARK: Sample Textfield
    var sampleTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: self.placeholder,
                    text: self.$text,
                    isSecureField: false,
                    title: self.$title,
                    titleColor: self.$titleColor,
                    titleFont: .constant(.body),
                    textColor: self.$textColor,
                    textFont: .constant(.body),
                    errorText: .constant(""),
                    borderWidth: self.$borderWidth,
                    borderColor: self.$borderColor,
                    cornerRadius: self.$cornerRadius,
                    keyboardType: .namePhonePad,
                    onEditingChanged: {_ in })
                //                .background(GeometryGetter(rect: $kGuardian.rects[0]))
                //                .focused($focusedField, equals: .name)
                .font(.body)
                .autocorrectionDisabled()
                .textContentType(.name)
            }
        }
    }
    
    // MARK: Close Button
    var closeButton: some View {
        HStack {
            Text("Configure Textfield")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(self.colorScheme == .light
                                 ? .black
                                 : .white)
            
            Spacer()
            
            Button {
                withAnimation {
                    self.showTextfieldEditor.toggle()
                }
                
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                //                    .foregroundColor(self.colorScheme == .light
                //                                     ? .black
                //                                     : .white)
                    .foregroundColor(.red)
            }
            
        }
    }
    
    // MARK: Title Editor
    var titleEditorView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title: ")
                    .font(.title3)
                    .font(.body.weight(.black))
                    .fontWeight(.bold)
                    .foregroundColor(self.colorScheme == .light
                                     ? .black
                                     : .white)
                
                TextField("", text: self.$title)
                    .frame(height: 44)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(self.colorScheme == .light
                                     ? .black
                                     : .white)
                
                Spacer()
            }
        }
    }
    
    // MARK: Placeholder Editor
    var placeholderEditorView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Placeholder: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(self.colorScheme == .light
                                     ? .black
                                     : .white)
                
                TextField("", text: self.$placeholder)
                    .frame(height: 44)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(self.colorScheme == .light
                                     ? .black.opacity(0.3)
                                     : .white.opacity(0.3))
                
                Spacer()
            }
        }
    }
}

extension TextfieldEditorView {
    // MARK: Title Color Picker
    var titleColorPicker: some View {
        VStack {
            ColorPicker("Title Color: ", selection: $titleColor)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(self.colorScheme == .light
                            ? .black
                            : .white)
        }
    }
    
    // MARK: Border Color Picker
    var borderColorPicker: some View {
        VStack {
            ColorPicker("Border Color: ", selection: $borderColor)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(self.colorScheme == .light
                            ? .black
                            : .white)
        }
    }
    
    // MARK: Text Color Picker
    var textColorPicker: some View {
        VStack {
            ColorPicker("Text Color: ", selection: $textColor)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(self.colorScheme == .light
                            ? .black
                            : .white)
        }
    }
    
    // MARK: Corner Radius Editor
    var cornerRadiusEditorView: some View {
        VStack {
            HStack {
                Text("Corner Radius: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(self.colorScheme == .light
                                ? .black
                                : .white)
                
                Text(String(format: "%.0f", cornerRadius))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(self.colorScheme == .light
                                ? .black
                                : .white)
                
                Stepper("", value: self.$cornerRadius)

                
                Spacer()
            }
        }
    }
    
    // MARK: Border Width Editor
    var borderWidthEditorView: some View {
        VStack {
            HStack {
                Text("Border Width: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(self.colorScheme == .light
                                ? .black
                                : .white)
                
                Text(String(format: "%.0f", borderWidth))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(self.colorScheme == .light
                                ? .black
                                : .white)
                
                Stepper("", value: self.$borderWidth)

                
                Spacer()
            }
        }
    }
    
    // MARK: Font Editor
    var fontEditorView: some View {
        VStack {
            
        }
    }
}



struct TextfieldEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldEditorView(
            title: .constant("Phone"),
            placeholder: .constant("Enter you name"),
            titleColor: .constant(.black),
            borderColor: .constant(.black),
            textColor: .constant(.black),
            cornerRadius: .constant(8),
            borderWidth: .constant(2),
            showTextfieldEditor: .constant(true))//title: .constant("Phone"))
    }
}
