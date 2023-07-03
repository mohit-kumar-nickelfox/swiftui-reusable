//
//  SegmentedLoginView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

struct SegmentedLoginView: View {
    @Binding var selectedSegment: String
    @State var segments = ["Email", "Phone"]
    var body: some View {
        VStack {
            SegmentedView(selectedSegment: self.$selectedSegment)
            Spacer()
        }
    }
}

struct SegmentedLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedLoginView(selectedSegment: .constant("Email"))
    }
}

struct SegmentedView: View {

    let segments: [String] = ["Email", "Phone"]
    @State private var selected: String = "Email"
    @Namespace var name
    @Binding var selectedSegment: String

    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                    self.selectedSegment = segment
                } label: {
                    VStack {
                        Text(segment)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(selected == segment ? .green : Color(uiColor: .systemGray))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected == segment {
                                Capsule()
                                    .fill(Color.green)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
    }
}
