import SwiftUI

struct ProfileInfoView: View {
    let profileData: ProfileData
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: 상단 배너 이미지 + 프로필
                ZStack(alignment: .bottomLeading) {
                    Image("Rectangle 256")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()

                    HStack {
                        Image("Component 7")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .padding(.leading, 20)
                            .padding(.bottom, -40)
                        Spacer()
                    }
                }
                .padding(.bottom, 20)

                // MARK: 정보 표시
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 10) {
                        Text(profileData.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange)
                            .cornerRadius(12)

                        Text(profileData.status)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                    }

                    HStack {
                        VStack {
                            Text("동아리방")
                                .bold()
                            Text(profileData.room)
                        }
                        Spacer()
                        VStack {
                            Text("회장")
                                .bold()
                            Text(profileData.president)
                        }
                        Spacer()
                        VStack {
                            Text("연락처")
                                .bold()
                            Text(profileData.contact)
                        }
                        Spacer()
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                    Text(profileData.intro)
                        .foregroundColor(.red)
                        .fontWeight(.medium)
                        .background(
                            Image("Rounded rectangle-3")
                                .resizable()
                                .scaledToFill()
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(profileData.recruitmentPeriod)
                            .padding(10)
                        Text(profileData.notice)
                            .padding(10)
                    }
                    .font(.footnote)
                    .foregroundColor(.black)
                }
                .padding(.horizontal)

                // MARK: 소개글
                Text(profileData.description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                // MARK: 썸네일 영역
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        if profileData.thumbnailImages.isEmpty {
                            ForEach(0..<3) { _ in
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 110, height: 140)
                                    .cornerRadius(10)
                            }
                        } else {
                            ForEach(profileData.thumbnailImages, id: \.self) { imageUrl in
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 110, height: 140)
                                        .clipped()
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 110, height: 140)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.bottom, 40)
        }
        .navigationBarTitle("프로필 정보", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.black)
        })
    }
}

struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView(
            profileData: ProfileData(
                name: "크레퍼스 (CREPERS)",
                status: "모집중",
                room: "17호관 414호",
                president: "이석준",
                contact: "010.1234.5678",
                intro: "동아리에서 함께 연주하고 추억을 쌓아봐요!",
                recruitmentPeriod: "모집기간: 7월 16일 ~ 24일 오후 6시",
                notice: "공지: 25일 동아리방 출입공지",
                description: """
                이 글은 동아리 소개 예시글입니다. 저희 동아리는 전공과 학년을 넘어 다양한 사람들이 모여 코드에 관심을 나누고, 유쾌한 경험을 쌓아가는 그루입니다. 잘못 하나쯤 나에 진심을 담고, 소소한 일상도 특별하게 만드는 우리. 처음이라도 괜찮아요. 어쩌든 환영합니다. 당신의 자리를 만들어드릴게요.
                """,
                thumbnailImages: []
            )
        )
    }
}
