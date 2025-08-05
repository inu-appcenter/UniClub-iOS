import SwiftUI
import PhotosUI

struct ProfileData: Codable {
    let name: String
    let status: String
    let room: String
    let president: String
    let contact: String
    let intro: String
    let recruitmentPeriod: String
    let notice: String
    let description: String
    let thumbnailImages: [String]
}

struct PromotionView: View {
    @State private var thumbnailImages: [String] = []
    @State private var clubName: String = ""
    @State private var clubStatus: String = ""
    @State private var clubRoom: String = ""
    @State private var president: String = ""
    @State private var contact: String = ""
    @State private var clubIntro: String = ""
    @State private var recruitmentPeriod: String = ""
    @State private var announcement: String = ""
    @State private var clubDescription: String = ""
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
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

                    // MARK: 라벨 및 정보 카드
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            TextField("동아리 이름", text: $clubName)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.orange)
                                .cornerRadius(12)

                            TextField("상태", text: $clubStatus)
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
                                TextField("동아리방 입력", text: $clubRoom)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack {
                                Text("회장")
                                    .bold()
                                TextField("회장 입력", text: $president)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack {
                                Text("연락처")
                                    .bold()
                                TextField("연락처 입력", text: $contact)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .keyboardType(.phonePad)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        TextField("소개 문구", text: $clubIntro)
                            .foregroundColor(.red)
                            .fontWeight(.medium)
                            .background(
                                Image("Rounded rectangle-3")
                                    .resizable()
                                    .scaledToFill()
                            )

                        VStack(alignment: .leading, spacing: 2) {
                            TextField("모집기간 입력", text: $recruitmentPeriod)
                                .padding(10)
                                .font(.footnote)
                                .foregroundColor(.black)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            TextField("공지 입력", text: $announcement)
                                .padding(10)
                                .font(.footnote)
                                .foregroundColor(.black)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal)

                    // MARK: 소개글
                    TextEditor(text: $clubDescription)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .frame(minHeight: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )

                    // MARK: 썸네일 영역 (슬라이드)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            if thumbnailImages.isEmpty {
                                ForEach(0..<3) { _ in
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 110, height: 140)
                                        .cornerRadius(10)
                                }
                            } else {
                                ForEach(thumbnailImages.indices, id: \.self) { index in
                                    ZStack(alignment: .topTrailing) {
                                        AsyncImage(url: URL(string: thumbnailImages[index])) { image in
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

                                        Button(action: {
                                            thumbnailImages.remove(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.white)
                                                .background(Circle().fill(Color.black.opacity(0.6)))
                                        }
                                        .offset(x: -5, y: 5)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // MARK: 이미지 추가 버튼
                    PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 3, matching: .images) {
                        HStack {
                            Image(systemName: "plus")
                            Text("이미지 추가")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .onChange(of: selectedPhotos) { _, newValue in
                        Task {
                            await uploadImages(newValue)
                        }
                    }

                    // MARK: 정보 저장 버튼
                    Button(action: {
                        Task {
                            await saveClubData()
                        }
                    }) {
                        Text("정보 저장")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // MARK: 하단 버튼 이미지
                    NavigationLink(
                        destination: ProfileInfoView(
                            profileData: ProfileData(
                                name: clubName,
                                status: clubStatus,
                                room: clubRoom,
                                president: president,
                                contact: contact,
                                intro: clubIntro,
                                recruitmentPeriod: recruitmentPeriod,
                                notice: announcement,
                                description: clubDescription,
                                thumbnailImages: thumbnailImages
                            )
                        )
                    ) {
                        Image("Frame 22")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .task {
                await fetchClubData()
            }
        }
    }

    // MARK: 서버에서 데이터 가져오기
    private func fetchClubData() async {
        isLoading = true
        defer { isLoading = false }

        guard let url = URL(string: "https://your-api.com/api/club") else {
            errorMessage = "잘못된 URL입니다."
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let profileData = try JSONDecoder().decode(ProfileData.self, from: data)
            clubName = profileData.name
            clubStatus = profileData.status
            clubRoom = profileData.room
            president = profileData.president
            contact = profileData.contact
            clubIntro = profileData.intro
            recruitmentPeriod = profileData.recruitmentPeriod
            announcement = profileData.notice
            clubDescription = profileData.description
            thumbnailImages = profileData.thumbnailImages
        } catch {
            errorMessage = "데이터를 가져오지 못했습니다: \(error.localizedDescription)"
        }
    }

    // MARK: 서버로 데이터 저장하기
    private func saveClubData() async {
        isLoading = true
        defer { isLoading = false }

        guard let url = URL(string: "https://your-api.com/api/club") else {
            errorMessage = "잘못된 URL입니다."
            return
        }

        let profileData = ProfileData(
            name: clubName,
            status: clubStatus,
            room: clubRoom,
            president: president,
            contact: contact,
            intro: clubIntro,
            recruitmentPeriod: recruitmentPeriod,
            notice: announcement,
            description: clubDescription,
            thumbnailImages: thumbnailImages
        )

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(profileData)

            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("데이터 저장 성공")
            } else {
                errorMessage = "데이터 저장 실패"
            }
        } catch {
            errorMessage = "데이터 저장 중 오류: \(error.localizedDescription)"
        }
    }

    // MARK: 이미지 업로드
    private func uploadImages(_ photos: [PhotosPickerItem]) async {
        isLoading = true
        defer { isLoading = false }

        guard let url = URL(string: "https://your-api.com/api/upload-image") else {
            errorMessage = "잘못된 이미지 업로드 URL입니다."
            return
        }

        for photo in photos {
            do {
                if let data = try await photo.loadTransferable(type: Data.self) {
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    let boundary = UUID().uuidString
                    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                    var body = Data()
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                    body.append(data)
                    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

                    request.httpBody = body

                    let (responseData, _) = try await URLSession.shared.data(for: request)
                    if let imageUrl = String(data: responseData, encoding: .utf8) {
                        thumbnailImages.append(imageUrl)
                    }
                }
            } catch {
                errorMessage = "이미지 업로드 실패: \(error.localizedDescription)"
            }
        }
    }
}

struct PromotionView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionView()
    }
}
