//
//  PhoneOTPView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 04/07/23.
//

import SwiftUI

public struct PhoneOTPView: View {
    @Binding var isLoading: Bool
    public var phoneNumber: String
    public var otpFilled: (_ otp: String)->Void
    public var getOTPAgain: ()->Void
    public var changePhoneNumber: ()->Void
    
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
    public var body: some View {
        
        VStack {
            
            numberView

            otpView
            
            HStack {}.frame(height: 20)
            
            verifyButton
        }
        .onAppear {
            self.fieldFocused = true
            self.activeIndex = self.otpText.count
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
                    self.verifyButtonDisabled = true
                    switch newValue.count {
                    case 0:
                        self.activeIndex = newValue.count
                        self.setOTP()
                    case 1..<self.otpCount:
                        self.activeIndex = newValue.count-1
                        self.setOTP()
                    case self.otpCount:
                        self.verifyButtonDisabled = false
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
                        HStack {
                            Button("Cancel") {
                                fieldFocused = false
                            }.frame(width: 60)
                                .padding(.leading, 10)
                            
                            
                            Spacer()
                            Button("Done") {
                                fieldFocused = false
                                self.activeIndex = -1
                            }.frame(width: 60)
                                .padding(.trailing, 10)
                        }.frame(width: UIScreen.main.bounds.size.width)
                    }
                }
                .opacity(0.001)
                .textContentType(.oneTimeCode)
            HStack {
                ForEach(0..<otpCount, id: \.self) { index in
                    Button {
                        self.updateEditing(for: index)
                    } label: {
                        VStack {
                            Text(self.otp[index])
                                .foregroundColor(.black)
                        }
                        .frame(width: otpViewWidth, height: otpViewWidth)
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
            }.padding(.horizontal, 20)
        }
    }
    
    var verifyButton: some View {
        LoaderButton(isAnimating: self.$isLoading,
                     loaderType: .constant(.basic),
                     action: self.sendOTP,
                     buttonTitle: "Verify",
                     frame: CGRect(x: 00, y: 0, width: 108, height: 34),
                     backgroundColor: verifyButtonDisabled ? .black.opacity(0.2) : .teal,
                     cornerRadius: 17)
        .disabled(self.verifyButtonDisabled)
        .foregroundColor(.black)
        
    }
    
    var otpViewWidth: Double {
        let horizontalPadding: Double = 40
        let interItemSpacing: Double = 12
        
        
        let actualWidth: Double = UIScreen.main.bounds.size.width - horizontalPadding
        let widthAfterSpacing: Double = actualWidth - (interItemSpacing*Double(self.otpCount))
        return min(widthAfterSpacing/Double(self.otpCount), 60)
    }
}

// MARK: Helper Functions
extension PhoneOTPView {
    
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

// MARK: Preview
struct PhoneOTPView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneOTPView(
            isLoading: .constant(false),
            phoneNumber: "06394026062",
            otpFilled: {_ in },
            getOTPAgain: {},
            changePhoneNumber: {}
        )
    }
}
