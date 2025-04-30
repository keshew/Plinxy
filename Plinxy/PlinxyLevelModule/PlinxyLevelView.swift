import SwiftUI

struct PlinxyLevelView: View {
    @StateObject var plinxyLevelModel =  PlinxyLevelViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var isPlay = false
    @Environment(\.presentationMode) var presentationMode
    @State var ud = UserDefaultsManager()
    
    var body: some View {
        if verticalSizeClass == .compact {
            ZStack {
                Image(.loadingBG)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.girl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 275, height: 357)
                    .position(x: UIScreen.main.bounds.width / 8, y: UIScreen.main.bounds.height / 1.5)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.backBtn)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 56, height: 44)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("LEVEL \(plinxyLevelModel.currentIndex + 1)")
                                    .BubbleGradient(size: 35)
                                
                                Text("\(plinxyLevelModel.contact.arrayOfName[plinxyLevelModel.currentIndex])")
                                    .Suez(size: 25,
                                          color: LinearGradient(colors: [plinxyLevelModel.contact.arrayOfColors[plinxyLevelModel.currentIndex]], startPoint: .bottom, endPoint: .top),
                                          width: 0.4)
                            }
                            .offset(x: 50)
                            
                            Spacer()
                            
                            Image(.scoreBack)
                                .resizable()
                                .overlay {
                                    HStack(spacing: 10) {
                                        Image(.star)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 36, height: 32)
                                        
                                        VStack(spacing: 5) {
                                            Text("TOTAL SCORE:")
                                                .BubbleNoOutline(size: 10, color: .white)
                                            
                                            Text("\(ud.getScore(for: plinxyLevelModel.currentIndex))/100")
                                                .BubbleNoOutline(size: 10,
                                                                 color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                        }
                                    }
                                }
                                .frame(width: 175, height: 58)
                        }
                        .padding(.leading)
                        
                        HStack(spacing: 50) {
                            Image(plinxyLevelModel.contact.arrayOfImages[plinxyLevelModel.currentIndex])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 222, height: 230)
                                .padding(.leading, 215)
                            
                            Button(action: {
                                isPlay = true
                            }) {
                                Image(.play)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 179, height: 102)
                            }
                        }
                        
                        VStack {
                            Text("SWIPE LEFT TO NEXT\nSWIPE RIGHT TO PREV")
                                .Suez(size: 20, color: LinearGradient(colors: [.white], startPoint: .top, endPoint: .bottom), width: 0)
                        }
                    }
                    .padding(.top)
                }
                .disabled(plinxyLevelModel.currentIndex >= UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1 ? true : false)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let horizontalAmount = value.translation.width
                            let verticalAmount = value.translation.height
                            if abs(horizontalAmount) > abs(verticalAmount) && abs(horizontalAmount) > 30 {
                                if horizontalAmount < 0 {
                                    if plinxyLevelModel.currentIndex <= 13 {
                                        plinxyLevelModel.currentIndex += 1
                                    }
                                } else {
                                    if plinxyLevelModel.currentIndex >= 1 {
                                        plinxyLevelModel.currentIndex -= 1
                                    }
                                }
                            }
                        }
                )
                
                if plinxyLevelModel.currentIndex >= UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1 {
                    ZStack {
                        Color.black
                            .ignoresSafeArea()
                            .opacity(0.5)
                        
                        ScrollView(showsIndicators: false) {
                            VStack {
                                Text("LOCKED!")
                                    .BubbleGradient(size: 40)
                                
                                Spacer(minLength: 30)
                                
                                Image(.locked)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 483, height: 218)
                                    .overlay {
                                        VStack(spacing: 0) {
                                            Text("Take your time,\nchampion, complete the")
                                                .BubbleNoOutline(size: 20, color: .white)
                                                .multilineTextAlignment(.center)
                                            
                                            Text("last level to start\nthis one")
                                                .BubbleNoOutlineGradient(size: 20,
                                                                         color: LinearGradient(colors: [Color(red: 110/255, green: 149/255, blue: 255/255),
                                                                                                 Color(red: 9/255, green: 77/255, blue: 255/255)], startPoint: .top, endPoint: .bottom))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                
                                Text("SWIPE LEFT TO NEXT\nSWIPE RIGHT TO PREV")
                                    .Suez(size: 20, color: LinearGradient(colors: [.white], startPoint: .top, endPoint: .bottom), width: 0)
                                    .padding(.top, 30)
                            }
                            .padding(.top)
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    let horizontalAmount = value.translation.width
                                    let verticalAmount = value.translation.height
                                    if abs(horizontalAmount) > abs(verticalAmount) && abs(horizontalAmount) > 30 {
                                        if horizontalAmount < 0 {
                                            if plinxyLevelModel.currentIndex <= 13 {
                                                plinxyLevelModel.currentIndex += 1
                                            }
                                        } else {
                                            if plinxyLevelModel.currentIndex >= 1 {
                                                plinxyLevelModel.currentIndex -= 1
                                            }
                                        }
                                    }
                                }
                        )
                    }
                }
            }
            .onAppear() {
                OrientationManager.setLandscapeOrientation()
            }
            .fullScreenCover(isPresented: $isPlay) {
                PlinxyGameView(level: plinxyLevelModel.currentIndex)
            }
        }
    }
}

#Preview {
    PlinxyLevelView()
}

