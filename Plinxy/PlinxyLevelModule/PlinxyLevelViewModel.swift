import SwiftUI

class PlinxyLevelViewModel: ObservableObject {
    let contact = PlinxyLevelModel()
    @Published var currentIndex = 0
}
