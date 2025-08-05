import SwiftUI

struct CategoryButtonsView: View {
    let categories = ["교양학술", "취미전시", "체육", "종교", "봉사", "문화"]
    let icons = ["Icon_academic", "Icon_hobby", "Icon_sports", "Icon_religion", "Icon_volunteer", "Icon_culture"]

    let columns = [
        GridItem(.fixed(72), spacing: 48),
        GridItem(.fixed(72), spacing: 48),
        GridItem(.fixed(72), spacing: 0)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(0..<categories.count, id: \.self) { i in
                VStack(spacing: 6) {
                    ZStack {
                        Image(icons[i])
                            .resizable()
                            .scaledToFit()
                    }

                    Text(categories[i])
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CategoryButtonsView()
}
