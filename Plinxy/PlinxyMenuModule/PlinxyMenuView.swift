import SwiftUI

struct PlinxyMenuView: View {
    @StateObject var plinxyMenuModel =  PlinxyMenuViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
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
                                
                            }) {
                                Image(.music)
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
                                
                            }) {
                                Image(.sound)
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
                                            
                                            Text("1000000")
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
                                            
                                            Text("1000")
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
                                    
                                }) {
                                    Image(.daily)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 111, height: 50)
                                }
                                
                                Text("DAILY!")
                                    .BubbleNoOutline(size: 17, color: .white)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    PlinxyMenuView()
}

