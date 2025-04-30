import SwiftUI
import SpriteKit

struct PlinxyPauseView: View {
    @StateObject var plinxyPauseModel =  PlinxyPauseViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var game: GameData
    var scene: SKScene
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if verticalSizeClass == .regular {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    VictoryParticlesView()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Pause?")
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
                                                
                                                Text("0/100")
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
                                        VStack {
                                            Text("HOLD A MINUTE TO ")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Text("RELAX")
                                                .BubbleNoOutline(size: 20, color: Color(red: 8/255, green: 78/255, blue: 255/255))
                                        }
                                        
                                        VStack {
                                            Text("YOUR GAME ON")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Text("PAUSE")
                                                .BubbleNoOutline(size: 20, color: Color(red: 8/255, green: 78/255, blue: 255/255))
                                        }
                                        
                                        
                                        HStack(spacing: 40) {
                                            Button(action: {
                                                game.isExit = true
                                                game.isPause = false
                                            }) {
                                                Image(.exit)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 111, height: 50)
                                            }
                                            
                                            Button(action: {
                                                game.isPause = false
                                                scene.isPaused = false
                                            }) {
                                                Image(.continue)
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
            }
        } else {
            if verticalSizeClass == .compact {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    VictoryParticlesView()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Pause?")
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
                                                
                                                Text("0/100")
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
                                        VStack {
                                            Text("HOLD A MINUTE TO ")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Text("RELAX")
                                                .BubbleNoOutline(size: 20, color: Color(red: 8/255, green: 78/255, blue: 255/255))
                                        }
                                        
                                        VStack {
                                            Text("YOUR GAME ON")
                                                .BubbleNoOutline(size: 20, color: .white)
                                            
                                            Text("PAUSE")
                                                .BubbleNoOutline(size: 20, color: Color(red: 8/255, green: 78/255, blue: 255/255))
                                        }
                                        
                                        
                                        HStack(spacing: 40) {
                                            Button(action: {
                                                game.isExit = true
                                                game.isPause = false
                                            }) {
                                                Image(.exit)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 111, height: 50)
                                            }
                                            
                                            Button(action: {
                                                game.isPause = false
                                                scene.isPaused = false
                                            }) {
                                                Image(.continue)
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
            }
        }
    }
}

#Preview {
    let gameData = GameData()
    let scene = SKScene()
    PlinxyPauseView(game: gameData, scene: scene)
}

