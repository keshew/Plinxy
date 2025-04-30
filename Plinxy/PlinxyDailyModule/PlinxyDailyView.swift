import SwiftUI

struct PlinxyDailyView: View {
    @StateObject var plinxyDailyModel =  PlinxyDailyViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShow: Bool
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if verticalSizeClass == .regular {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    VictoryParticlesView()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Spacer(minLength: 30)
                            
                            Text("DAILY REWARD!")
                                .BubbleGradient(size: 40)
                                .multilineTextAlignment(.center)
                            
                            Spacer(minLength: 70)
                            
                            Image(.scoreBack)
                                .resizable()
                                .overlay {
                                    HStack(spacing: 10) {
                                        Image(.coin)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                        
                                        VStack(spacing: 5) {
                                            Text("COINS")
                                                .BubbleNoOutline(size: 10, color: .white)
                                            
                                            Text("\(UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1)")
                                                .BubbleNoOutline(size: 10,
                                                                 color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                        }
                                    }
                                }
                                .frame(width: 175, height: 58)
                            
                            Spacer(minLength: 130)
                            
                            HStack {
                                Text("+100")
                                    .BubbleGradient(size: 80)
                                
                                Image(.coin)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 91, height: 91)
                            }
                            
                            Spacer(minLength: 130)
                            
                            Button(action: {
                                isShow = false
                                UserDefaultsManager().daily()
                            }) {
                                Image(.take)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 111, height: 50)
                            }
                        }
                        .padding(.top)
                    }
                }
                .onAppear() {
                    OrientationManager.setLandscapeOrientation()
                }
            }
        } else {
            if verticalSizeClass == .compact {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    VictoryParticlesView()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Spacer(minLength: 30)
                            
                            Text("DAILY REWARD!")
                                .BubbleGradient(size: 40)
                            
                            Spacer(minLength: 30)
                            
                            Image(.scoreBack)
                                .resizable()
                                .overlay {
                                    HStack(spacing: 10) {
                                        Image(.coin)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                        
                                        VStack(spacing: 5) {
                                            Text("COINS")
                                                .BubbleNoOutline(size: 10, color: .white)
                                            
                                            Text("\(UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1)")
                                                .BubbleNoOutline(size: 10,
                                                                 color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                        }
                                    }
                                }
                                .frame(width: 175, height: 58)
                            
                            Spacer(minLength: 30)
                            
                            HStack {
                                Text("+100")
                                    .BubbleGradient(size: 80)
                                
                                Image(.coin)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 91, height: 91)
                            }
                            
                            Spacer(minLength: 30)
                            
                            Button(action: {
                                isShow = false
                                UserDefaultsManager().daily()
                            }) {
                                Image(.take)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 111, height: 50)
                            }
                        }
                        .padding(.top)
                    }
                }
                .onAppear() {
                    OrientationManager.setLandscapeOrientation()
                }
            }
        }
    }
}

#Preview {
    PlinxyDailyView(isShow: .constant(false))
}
