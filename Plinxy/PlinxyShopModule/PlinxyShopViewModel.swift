import SwiftUI

class PlinxyShopViewModel: ObservableObject {
    let contact = PlinxyShopModel()
    @Published var redraw = 0
}
