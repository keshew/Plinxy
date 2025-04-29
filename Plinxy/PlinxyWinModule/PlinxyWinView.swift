import SwiftUI

struct PlinxyWinView: View {
    @StateObject var plinxyWinModel =  PlinxyWinViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        if verticalSizeClass == .compact {
            ZStack {
                Color.black.opacity(0.5).ignoresSafeArea()
                
                VictoryParticlesView()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("VIctorY!")
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
                                    Text("GREAT JOB!")
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
                                        Text("YOUR WINNINGS:100")
                                            .BubbleNoOutline(size: 20, color: .white)
                                        
                                        Image(.coin)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 27, height: 27)
                                    }
                                    
                                    HStack(spacing: 40) {
                                        Button(action: {
                                            
                                        }) {
                                            Image(.menu)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 111, height: 50)
                                        }
                                        
                                        Button(action: {
                                            
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
        }
    }
}

#Preview {
    PlinxyWinView()
}

