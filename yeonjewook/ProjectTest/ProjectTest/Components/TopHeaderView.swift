import SwiftUI

struct TopHeaderView: View {
    var body: some View {
        HStack {
            // UniClub 텍스트 로고
            Text("UniClub")
                .font(.custom("Krona One", size: 20))
                .foregroundColor(Color(red: 1, green: 0.35, blue: 0))
                .frame(height: 24)

            Spacer()

            // 검색 아이콘
            Image("Icon_search")
                .resizable()
                .frame(width: 24, height: 23)

            // 알림 아이콘
            Image("Icon_alarm")
                .resizable()
                .frame(width: 20, height: 21)
                .padding(.leading, 12)
        }
        .padding(.horizontal)
        .padding(.top, 20) // Figma 기준 spacing
        .padding(.bottom, 12)
        .background(Color.white)
    }
}

#Preview {
    TopHeaderView()
}
