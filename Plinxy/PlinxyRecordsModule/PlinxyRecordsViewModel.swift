import SwiftUI

class PlinxyRecordsViewModel: ObservableObject {
    let contact = PlinxyRecordsModel()
    @Published var levelScores: [Int: Int] = [:]

    init() {
        loadScores()
    }

    func loadScores() {
        levelScores = UserDefaultsManager().getLevelScores()
    }

    func score(for level: Int) -> Int {
        return levelScores[level] ?? 0
    }
}
