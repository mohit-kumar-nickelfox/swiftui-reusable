//
//  SegmentedLoginView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

struct SegmentedLoginView: View {
    @Binding var selectedSegment: LoginType
    @State var segments: [LoginType] = [.email, .phone]
    var color: Color
    
    var body: some View {
        VStack {
            SegmentedView(selectedSegment: self.$selectedSegment,
                          color: color)
        }
    }
}

struct SegmentedLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedLoginView(selectedSegment: .constant(.email),
                           color: .pink)
    }
}

struct SegmentedView: View {
    
    let segments: [LoginType] = [.email, .phone]
    @State private var selected: LoginType = .email
    @Namespace var name
    @Binding var selectedSegment: LoginType
    var color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                    self.selectedSegment = segment
                    
                } label: {
                    VStack {
                        Text(segment.rawValue)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(selected == segment ? color : Color(uiColor: .systemGray))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected == segment {
                                Capsule()
                                    .fill(color)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }.padding(.top, 10)
                }
            }
        }.background(Color.black.opacity(0.15))
            .cornerRadius(4)
    }
}
