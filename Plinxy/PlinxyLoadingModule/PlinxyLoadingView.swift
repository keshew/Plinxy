import SwiftUI

struct PlinxyLoadingView: View {
    @StateObject var plinxyLoadingModel =  PlinxyLoadingViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        if verticalSizeClass == .compact {
            ZStack {
                Image(.loadingBG)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text(plinxyLoadingModel.currentText)
                        .Bubble(size: 25)
                        .padding(.bottom)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                            .frame(width: 682, height: 28)
                            
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [Color(red: 223/255, green: 12/255, blue: 241/255), Color(red: 154/255, green: 10/255, blue: 249/255)], startPoint: .leading, endPoint: .trailing))
                            .frame(width: plinxyLoadingModel.width, height: 22)
                            .padding(.horizontal, 5)
                    }
                }
            }
            .onAppear() {
                plinxyLoadingModel.increaseWidth()
                plinxyLoadingModel.startTimer()
                OrientationManager.setLandscapeOrientation()
            }
            
            .fullScreenCover(isPresented: $plinxyLoadingModel.isAnimationDone) {
                PlinxyMenuView()
            }
        }
    }
}

#Preview {
    PlinxyLoadingView()
}

