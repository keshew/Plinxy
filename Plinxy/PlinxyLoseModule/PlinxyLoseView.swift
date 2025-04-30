import SwiftUI

struct PlinxyLoseView: View {
    @StateObject var plinxyLoseModel =  PlinxyLoseViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var isMenu = false
    @State var isNext = false
    var level: Int
    var score: Int
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if verticalSizeClass == .regular {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    VictoryParticlesView()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Game over!")
                                .BubbleGradient(size: 40)
                            
                            Spacer(minLength: 70)
                            
                            HStack(spacing: 10) {
                                Image(.scoreBack)
                                    .resizable()
                                    .overlay {
                                        HStack(spacing: 7) {
                                            Image(.star)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 29, height: 26)
                                            
                                            VStack {
                                                Text("SCORE:")
                                                    .BubbleNoOutline(size: 10, color: .white)
                                                
                                                Text("\(score)/100")
                                                    .BubbleNoOutline(size: 10,
                                                                     color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                            }
                                        }
                                    }
                                    .frame(width: 141, height: 46)
                                
                                Image(.scoreBack)
                                    .resizable()
                                    .overlay {
                                        HStack(spacing: 10) {
                                            Image(.coin)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                                .padding(.leading, 30)
                                            
                                            VStack {
                                                Text("COINS:")
                                                    .BubbleNoOutline(size: 10, color: .white)
                                                
                                                Text("1000")
                                                    .BubbleNoOutline(size: 10,
                                                                     color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: 141, height: 46)
                            }
                            
                            Spacer(minLength: 200)
                            
                            Image(.locked)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay {
                                    VStack {
                                        Text("Try once more!")
                                            .BubbleNoOutline(size: 20, color: .white)
                                        
                                        HStack {
                                            Text("YOUR SCORE:1000")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Image(.star)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 39, height: 35)
                                        }
                                        
                                        HStack {
                                            Text("YOUR LOSSES:100")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Image(.coin)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 27, height: 27)
                                        }
                                        
                                        HStack(spacing: 40) {
                                            Button(action: {
                                                isMenu = true
                                            }) {
                                                Image(.menu)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 111, height: 50)
                                            }
                                            
                                            Button(action: {
                                                isNext = true
                                            }) {
                                                Image(.retry)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 111, height: 50)
                                            }
                                        }
                                        .offset(y: 10)
                                    }
                                    .offset(y: 28)
                                }
                                .frame(width: 356, height: 161)
                        }
                        .padding(.top, 30)
                    }
                }
                .onAppear() {
                    OrientationManager.setLandscapeOrientation()
                }
                .fullScreenCover(isPresented: $isMenu) {
                    PlinxyMenuView()
                }
                .fullScreenCover(isPresented: $isNext) {
                    PlinxyGameView(level: level)
                }
            }
        } else {
            if verticalSizeClass == .compact {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    VictoryParticlesView()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Game over!")
                                .BubbleGradient(size: 40)
                            
                            Spacer(minLength: 20)
                            
                            HStack(spacing: 10) {
                                Image(.scoreBack)
                                    .resizable()
                                    .overlay {
                                        HStack(spacing: 7) {
                                            Image(.star)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 29, height: 26)
                                            
                                            VStack {
                                                Text("SCORE:")
                                                    .BubbleNoOutline(size: 10, color: .white)
                                                
                                                Text("\(score)/100")
                                                    .BubbleNoOutline(size: 10,
                                                                     color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                            }
                                        }
                                    }
                                    .frame(width: 141, height: 46)
                                
                                Image(.scoreBack)
                                    .resizable()
                                    .overlay {
                                        HStack(spacing: 10) {
                                            Image(.coin)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                                .padding(.leading, 30)
                                            
                                            VStack {
                                                Text("COINS:")
                                                    .BubbleNoOutline(size: 10, color: .white)
                                                
                                                Text("1000")
                                                    .BubbleNoOutline(size: 10,
                                                                     color: Color(red: 12/255, green: 77/255, blue: 249/255))
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: 141, height: 46)
                            }
                            
                            
                            Image(.locked)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay {
                                    VStack {
                                        Text("Try once more!")
                                            .BubbleNoOutline(size: 20, color: .white)
                                        
                                        HStack {
                                            Text("YOUR SCORE:1000")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Image(.star)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 39, height: 35)
                                        }
                                        
                                        HStack {
                                            Text("YOUR LOSSES:100")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Image(.coin)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 27, height: 27)
                                        }
                                        
                                        HStack(spacing: 40) {
                                            Button(action: {
                                                isMenu = true
                                            }) {
                                                Image(.menu)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 111, height: 50)
                                            }
                                            
                                            Button(action: {
                                                isNext = true
                                            }) {
                                                Image(.retry)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 111, height: 50)
                                            }
                                        }
                                        .offset(y: 10)
                                    }
                                    .offset(y: 28)
                                }
                                .frame(width: 356, height: 161)
                        }
                        .padding(.top, 30)
                    }
                }
                .onAppear() {
                    OrientationManager.setLandscapeOrientation()
                }
                .fullScreenCover(isPresented: $isMenu) {
                    PlinxyMenuView()
                }
                .fullScreenCover(isPresented: $isNext) {
                    PlinxyGameView(level: level)
                }
            }
        }
    }
}

#Preview {
    PlinxyLoseView(level: 1, score: 1)
}

