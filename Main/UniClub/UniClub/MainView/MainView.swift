//
//  MainView.swift
//  ProjectTest
//
//  Created by 제욱 on 7/20/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // 전체 스크롤
            ScrollView {
                VStack(spacing: 50) {
                    
                    // 상단 바 높이만큼 여백
                    Color.clear.frame(height: 80)
                    
                    //콘텐츠
                    TopBanner()
                    
                    
                    Text("이런 동아리는 어떠세요?")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                    
                    ClubCardView()
                    
                    HStack {
                        Text("카테고리")
                            .font(.system(size: 16, weight: .bold)) // ← 임시 폰트
                            .foregroundColor(.black)

                        Spacer()
                            .frame(width: 208)

                        Text("전체보기")
                            .font(.system(size: 11, weight: .medium)) // ← 임시 폰트
                            .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.69))
                        
                    }
                    .padding(.top, 8)
                    
                    CategoryButtonsView( )

                }
                .padding(.horizontal)
            }

            // ✅ 고정 상단 바
            TopHeaderView()
                .frame(height: 80)
                .padding(.horizontal)
                .background(Color.white)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview(){
    MainView()
}
