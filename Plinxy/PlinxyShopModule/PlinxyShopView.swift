import SwiftUI

struct PlinxyShopView: View {
    @StateObject var plinxyShopModel =  PlinxyShopViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var ud = UserDefaultsManager()
    @Binding var isShow: Bool
    var body: some View {
        if verticalSizeClass == .compact {
            ZStack {
                Color.black.opacity(0.5).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                isShow = false
                            }) {
                                Image(.backBtn)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 56)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Text("SHOP!")
                                .Bubble(size: 40)
                            
                            Spacer(minLength: 310)
                        }
                        
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
                        
                        HStack(spacing: 80) {
                            Image(.bomb)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 264, height: 191)
                                .overlay(content: {
                                    VStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            ud.buyBomb()
                                            plinxyShopModel.redraw = 1
                                        }) {
                                            Image(.buy)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 111, height: 50)
                                        }
                                    }
                                    .offset(y: 20)
                                })
                            
                            
                            
                            Image(.time)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 264, height: 191)
                                .overlay(content: {
                                    VStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            ud.buyTime()
                                            plinxyShopModel.redraw = 1
                                        }) {
                                            Image(.buy)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 111, height: 50)
                                        }
                                    }
                                    .offset(y: 20)
                                })
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

#Preview {
    PlinxyShopView(isShow: .constant(false))
}

