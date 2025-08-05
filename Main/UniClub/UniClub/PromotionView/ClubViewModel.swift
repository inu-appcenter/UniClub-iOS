import Foundation
import Combine

class ClubViewModel: ObservableObject {
    @Published var club: Club?

    func fetchClubData() {
        // 실제 API URL로 교체하세요
        guard let url = URL(string: "https://yourserver.com/api/club") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(Club.self, from: data) {
                    DispatchQueue.main.async {
                        self.club = decoded
                    }
                }
            }
        }.resume()
    }
}
