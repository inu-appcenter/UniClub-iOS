//
//  ClubCardView.swift
//  ProjectTest
//
//  Created by 제욱 on 7/27/25.
//

import SwiftUI

struct ClubCardView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 23) {
                ForEach(0..<10) { index in
                    Rectangle()
                        .fill(Color(red: 0.77, green: 0.77, blue: 0.77))
                        .frame(width: 136, height: 206, alignment: .topLeading)
                        .cornerRadius(17)
                        .overlay(
                            Text("동아리 \(index + 1)")
                                .foregroundColor(.white)
                                .padding(8),
                            alignment: .topLeading
                        )
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
    }
}


#Preview {
    ClubCardView()
}
