//
//  PhoneOTPView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 04/07/23.
//

import SwiftUI

struct PhoneOTPView: View {
    var phoneNumber: String
    var otpFilled: (_ otp: String)->Void
    var getOTPAgain: ()->Void
    var changePhoneNumber: ()->Void
    
    var cornerRadius: Double?// = 4
    var borderWidth: Double?// = 2
    var borderColor: Color?// = .black
    var emptyBorderColor: Color? // = .gray
    var filledBorderColor: Color? // = .gray
    var activeBorderColor: Color? // = .red
    var otpCount: Int = 6
    @State var otp: [String] = Array(repeating: "", count: 6)
    @State var otpText: String = ""
    @FocusState private var fieldFocused: Bool
    @State var activeIndex: Int = -1
    @State var verifyButtonDisabled: Bool = true
    @State var showLoader: Bool = false
    var body: some View {
        
        VStack {
            
            numberView

            otpView
            
            HStack {}.frame(height: 20)
            
            verifyButton
        }
    }
    
    var numberView: some View {
        HStack {
            Text("OTP sent to " + self.phoneNumber)
                .foregroundColor(.gray)
            .font(.caption2)
            
            Button {
                self.changePhoneNumber()
            } label: {
                Text("Change Number?")
                    .font(.caption)
            }
        }
    }
    
    var otpView: some View {
        ZStack {
            TextField("", text: self.$otpText)
                .focused($fieldFocused)
                .border(.black)
                .keyboardType(.numberPad)
                .onChange(of: self.otpText) { newValue in
                    
                    switch newValue.count {
                    case 0:
                        self.activeIndex = newValue.count
                        self.setOTP()
                    case 1..<self.otpCount:
                        self.activeIndex = newValue.count-1
                        self.setOTP()
                    case self.otpCount:
                        fieldFocused = false
                        self.activeIndex = -1
                        self.setOTP()
                    case self.otpCount...Int.max:
                        self.otpText = String(newValue.prefix(otpCount))
                    default: ()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            fieldFocused = false
                        }
                    }
                }
                .opacity(0.001)
            HStack {
                ForEach(0..<otpCount, id: \.self) { index in
                    Button {
                        self.updateEditing(for: index)
                    } label: {
                        VStack {
                            Text(self.otp[index])
                                .foregroundColor(.black)
                        }
                        .frame(width: 30, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius ?? 4)
                                .stroke(
                                    activeIndex == index
                                    ? self.activeBorderColor ?? .red
                                    : self.otp[index].isEmpty
                                    ? self.emptyBorderColor ?? .gray
                                    : self.filledBorderColor ?? .black,
                                    lineWidth: borderWidth ?? 2)
                        )
                    }
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }
                }
            }
        }
    }
    
    var verifyButton: some View {
        CustomButton(
            action: self.sendOTP,
            buttonTitle: "Verify",
            frame: CGRect(x: 00, y: 0, width: 108, height: 34),
            backgroundColor: verifyButtonDisabled ? .black.opacity(0.2) : .teal,
            cornerRadius: 17)
        .disabled(self.verifyButtonDisabled)
        
    }
    
    func sendOTP() {
        self.otpFilled(otpText)
    }
    
    func updateEditing(for index: Int) {
        if !self.fieldFocused {
            self.fieldFocused = true
        }
        
        if self.otpText.isEmpty {
            self.activeIndex = 0
        } else {
            self.activeIndex = self.otpText.count-1
        }
    }
    
    func setOTP() {
        let actualCount = self.otpText.count
        print(actualCount, "Actual count")
        print("difference", self.otpCount-actualCount)
        var newArray = [String]()
        
        for char in self.otpText {
            newArray.append(String(char))
        }
        
        for _ in 0..<(self.otpCount-actualCount) {
            newArray.append("")
        }
        
        self.otp = newArray
    }
}

struct PhoneOTPView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneOTPView(
            phoneNumber: "06394026062",
            otpFilled: {_ in },
            getOTPAgain: {},
            changePhoneNumber: {}
        )
    }
}
