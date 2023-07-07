//
//  CustomButtonsExample.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 05/07/23.
//

import SwiftUI

struct CustomButtonsExample: View {
    
    @State var isLB1Animating: Bool = false
    @State var isLB2Animating: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: Body
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack{}.frame(height: 1)
                customBasicButtons
                divider
                loaderButtons
                HStack{}.frame(height: 1)
            }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            .gray,
                            lineWidth: 2)
                )
                .padding(20)
                .cornerRadius(20)
        }
    }
    
    var customBasicButtons: some View {
        VStack {
            customButton1
            divider
            customButton2
            divider
            customButton3
        }
    }
    
    var loaderButtons: some View {
        VStack {
            loaderButton1
            divider
            loaderButton2
        }
    }
    
    var divider: some View {
        HStack{
            colorScheme == .light
            ? Color.black.opacity(0.2)
            : Color.white.opacity(0.2)
            
        }.frame(height: 1)
    }
    
    var customButton1: some View {
        VStack {
            
            HStack {
                Text("Custom Button 1: Plane \n\nPadding: Horizontal, 20 \n Background Color: Gray \n Border Color: Black \n Corner Radius: 8 \n Border Width: 2 \n Foreground Color: White \n Font: Subheadline \n FontWeight: Heavy")
                    .padding(.leading, 20)
                    .foregroundColor(colorScheme == .light
                                     ? Color.black
                                     : Color.white)
                Spacer()
            }
            CustomButton(action: {print("Custom Button 1 Tapped")},
                         buttonTitle: "Button",
                         backgroundColor: .gray,
                         borderWidth: 2,
                         borderColor: colorScheme == .light
                         ? Color.black
                         : Color.white,
                         cornerRadius: 8)
            .frame(height: 44)
            .foregroundColor(colorScheme == .light
                             ? Color.white
                             : Color.black)
            .font(.subheadline)
            .fontWeight(.heavy)
            .padding(.horizontal, 20)
        }
    }
    
    var customButton2: some View {
        VStack {
            HStack {
                Text("Custom Button 2: Plane \n\nWidth: 108 \n Background Color: Teal \n Border Color: Green \n Corner Radius: 22 \n Border Width: 2 \n Foreground Color: Black \n Font: Subheadline \n FontWeight: Heavy")
                    .padding(.leading, 20)
                Spacer()
            }
            CustomButton(action: {print("Custom Button 2 Tapped")},
                         buttonTitle: "Button",
                         backgroundColor: .teal,
                         borderWidth: 2,
                         borderColor: .green,
                         cornerRadius: 22)
            .frame(width: 108, height: 44)
            .foregroundColor(colorScheme == .light
                             ? Color.black
                             : Color.white)
            .font(.subheadline)
            .fontWeight(.heavy)
            .transaction { transaction in
                transaction.animation = .easeIn(duration: 0.5)
            }
        }
    }
    
    var customButton3: some View {
        VStack {
            HStack {
                Text("Custom Button 3: Plane \n\nWidth: 108 \n Background Color: Clear \n Border Color: Clear \n Corner Radius: 0 \n Border Width: 0 \n Foreground Color: Blue \n Font: Subheadline \n FontWeight: Heavy")
                    .padding(.leading, 20)
                Spacer()
            }
            CustomButton(action: {print("Custom Button 2 Tapped")},
                         buttonTitle: "Button",
                         backgroundColor: .clear,
                         borderWidth: 0,
                         borderColor: .clear,
                         cornerRadius: 0)
            .frame(width: 108)
            .foregroundColor(.blue)
            .font(.subheadline)
            .fontWeight(.heavy)
            .transaction { transaction in
                transaction.animation = .easeIn(duration: 0.5)
            }
            
        }
    }
    
    var loaderButton1: some View {
        VStack {
            HStack {
                Text("Loader Button 1: Plane \n\nWidth: 108 \n Background Color: Mint \n Border Color: Yellow \n Corner Radius: 8 \n Border Width: 2 \n Foreground Color: Black(Loader picks from here) \n Loader Type: Basic")
                    .padding(.leading, 20)
                Spacer()
            }
            LoaderButton(isAnimating: self.$isLB1Animating,
                         loaderType: .constant(.basic),
                         action: { self.isLB1Animating.toggle() },
                         buttonTitle: "Animate",
                         frame: CGRect(
                            x: 0,
                            y: 0,
                            width: 108,
                            height: 44),
                         backgroundColor: .mint,
                         borderWidth: 2,
                         borderColor: .yellow,
                         cornerRadius: 8)
            .foregroundColor(.black)
        }
    }
    
    var loaderButton2: some View {
        VStack {
            HStack {
                Text("Loader Button 1: Plane \n\nWidth: 108 \n Background Color: Mint \n Border Color: Yellow \n Corner Radius: 8 \n Border Width: 2 \n Foreground Color: Black(Loader picks from here) \n Loader Type: Classic")
                    .padding(.leading, 20)
                Spacer()
            }
            LoaderButton(isAnimating: self.$isLB2Animating,
                         loaderType: .constant(.classic),
                         action: { self.isLB2Animating.toggle() },
                         buttonTitle: "Animate",
                         frame: CGRect(
                            x: 0,
                            y: 0,
                            width: 108,
                            height: 44),
                         backgroundColor: .mint,
                         borderWidth: 2,
                         borderColor: .yellow,
                         cornerRadius: 8)
            .foregroundColor(.black)
            .transaction { transaction in
                transaction.animation = .easeIn(duration: 0.001)
            }
        }
    }
}

// MARK: Preview
struct CustomButtonsExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonsExample()
    }
}
