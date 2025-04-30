import SwiftUI

struct PlinxyMenuView: View {
    @StateObject var plinxyMenuModel =  PlinxyMenuViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var isShop = false
    @State var isRecords = false
    @State var isDaily = false
    @State var play = false
    @State var ud = UserDefaultsManager()
    @State private var showToast = false
    @State private var toastMessage = ""
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        if verticalSizeClass == .compact {
            ZStack {
                Image(.loadingBG)
                    .resizable()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                soundManager.toggleMusic()
                                
                                if ud.isMusicEnabled() {
                                    soundManager.playBackgroundMusic()
                                } else {
                                    soundManager.stopBackgroundMusic()
                                }
                            }) {
                                Image(ud.isMusicEnabled() ? .music : .musicOff)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 56, height: 44)
                            }
                            
                            Spacer()
                            
                            Text("Plinxy")
                                .Bubble(size: 60)
                                .offset(y: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                soundManager.toggleSound()
                                soundManager.isSoundEnabled = ud.isSoundEnabled()
                            }) {
                                Image(ud.isSoundEnabled() ? .sound : .soundOff)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 56, height: 44)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                        
                        HStack(spacing: 30) {
                            Image(.scoreBack)
                                .resizable()
                                .overlay {
                                    HStack(spacing: 10) {
                                        Image(.star)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 36, height: 32)
                                        
                                        VStack {
                                            Text("all SCORE:")
                                                .BubbleNoOutline(size: 10, color: .white)
                                            
                                            Text("\(ud.getTotalScore())")
                                                .BubbleNoOutline(size: 10,
                                                                 color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                        }
                                    }
                                }
                                .frame(width: 175, height: 58)
                            
                            Image(.scoreBack)
                                .resizable()
                                .overlay {
                                    HStack(spacing: 20) {
                                        Image(.coin)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 35)
                                        
                                        VStack {
                                            Text("COINS:")
                                                .BubbleNoOutline(size: 10, color: .white)
                                            
                                            Text("\(UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1)")
                                                .BubbleNoOutline(size: 10,
                                                                 color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: 175, height: 58)
                        }
                        
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            play = true
                        }) {
                            Image(.play)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 169, height: 102)
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack(spacing: 30) {
                            VStack(spacing: 10) {
                                Button(action: {
                                    isShop = true
                                }) {
                                    Image(.shop)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 111, height: 50)
                                }
                                
                                Text("SHOP")
                                    .BubbleNoOutline(size: 17, color: .white)
                            }
                            
                            VStack(spacing: 10) {
                                Button(action: {
                                    isRecords = true
                                }) {
                                    Image(.records)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 111, height: 50)
                                }
                                
                                Text("RECORDS")
                                    .BubbleNoOutline(size: 17, color: .white)
                            }
                            
                            VStack(spacing: 10) {
                                Button(action: {
                                    if ud.canShowDailyView() {
                                        isDaily = true
                                    } else {
                                        toastMessage = "Not yet!"
                                        withAnimation {
                                            showToast = true
                                        }
                                    }
                                }) {
                                    Image(.daily)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 111, height: 50)
                                        .overlay {
                                            if showToast {
                                                Text(toastMessage)
                                                    .BubbleNoOutline(size: 20, color: .white)
                                                    .transition(.opacity)
                                                    .zIndex(1)
                                                    .onAppear {
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                            withAnimation {
                                                                showToast = false
                                                            }
                                                        }
                                                    }
                                                    .offset(y: -50)
                                            }
                                        }
                                }
                                
                                Text("DAILY!")
                                    .BubbleNoOutline(size: 17, color: .white)
                            }
                        }
                    }
                    .padding(.top)
                }
                
                if isShop {
                    PlinxyShopView(isShow: $isShop)
                }
                
                if isDaily {
                    PlinxyDailyView(isShow: $isDaily)
                }
            }
            .onChange(of: isDaily) { newValue in
                if newValue == false {
                    ud.updateLastShowDate()
                }
            }
            
            .onAppear() {
                OrientationManager.setLandscapeOrientation()
            }
            .fullScreenCover(isPresented: $isRecords) {
                PlinxyRecordsView()
            }
            .fullScreenCover(isPresented: $play) {
                PlinxyLevelView()
            }
        }
    }
}

#Preview {
    PlinxyMenuView()
}

