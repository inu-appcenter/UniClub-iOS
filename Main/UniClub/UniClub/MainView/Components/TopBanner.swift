//
//  TopBanner.swift
//  ProjectTest
//
//  Created by 제욱 on 7/26/25.
//
import SwiftUI

struct TopBanner: View {
    var body: some View {
        GeometryReader { geo in
            let bannerWidth = geo.size.width * 0.9  // 화면 너비의 90%
            let bannerHeight = bannerWidth * (249 / 324)  // 비율 유지

            Rectangle()
                .fill(Color(red: 0.77, green: 0.77, blue: 0.77))
                .frame(width: bannerWidth, height: bannerHeight)
                .cornerRadius(21)
                .overlay(
                    Text("배너 영역") // 임시 텍스트 or 이미지
                        .foregroundColor(.white)
                )
                .position(x: geo.size.width / 2, y: bannerHeight / 2)
        }
        .frame(height: 249) // GeometryReader 자체 높이 고정
    }
}

#Preview {
    TopBanner()
}
