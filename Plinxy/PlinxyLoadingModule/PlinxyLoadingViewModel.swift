import SwiftUI

class PlinxyLoadingViewModel: ObservableObject {
    let contact = PlinxyLoadingModel()
    @Published var width: CGFloat = 0
    @Published var isAnimationDone = false
    @Published var index = 0
    @Published var timer: Timer?
    @Published var currentText = "Loading."
    
    func increaseWidth() {
        if width <= 672 {
            withAnimation(.linear(duration: 0.1)) {
                width += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.increaseWidth()
            }
        } else {
            isAnimationDone = true
        }
    }
 
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.changeText()
        }
    }
    
    func changeText() {
        index -= 1
        if index == -1 {
            index = 2
        }
        currentText = contact.arrayOfLoading[index]
    }
}
