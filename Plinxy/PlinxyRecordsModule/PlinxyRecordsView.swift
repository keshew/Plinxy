import SwiftUI

struct PlinxyRecordsView: View {
    @StateObject var plinxyRecordsModel =  PlinxyRecordsViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    let grids = [GridItem(.flexible(), spacing: 0),
                 GridItem(.flexible(), spacing: 0),
                 GridItem(.flexible(), spacing: 0),
                 GridItem(.flexible(), spacing: 0)]
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        if verticalSizeClass == .compact {
            ZStack {
                Image(.bg2)
                    .resizable()
                    .ignoresSafeArea()
                
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
                            
                            Text("Best records")
                                .Bubble(size: 30)
                            
                            Spacer(minLength: 250)
                        }
                        .padding(.leading)
                        
                        Spacer(minLength: 30)
                        
                        LazyVGrid(columns: grids) {
                            ForEach(0..<15, id: \.self) { index in
                                let score = plinxyRecordsModel.score(for: index + 1)
                                
                                if UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1 < index + 1 {
                                    LockedRecords(index: index)
                                } else {
                                    OpenRecords(index: index, score: score)
                                }
                            }
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
    PlinxyRecordsView()
}


struct OpenRecords: View {
    var index: Int
    var score: Int
    var body: some View {
        VStack(spacing: 5) {
            Text("LEVEL \(index + 1)")
                .Bubble(size: 12)
                .padding(.leading, 65)
            
            HStack(spacing: 3) {
                Image(.levelPin)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 47, height: 37)
                    .overlay {
                        Text("\(index + 1)")
                            .Bubble(size: 20)
                    }
                
                Image(.scoreBack)
                    .resizable()
                    .overlay {
                        HStack(spacing: 5) {
                            Image(.star)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 21, height: 19)
                            
                            VStack(spacing: 2) {
                                Text("TOTAL SCORE:")
                                    .BubbleNoOutline(size: 6, color: .white)
                                
                                Text("\(score)/100")
                                    .BubbleNoOutline(size: 6,
                                                     color: Color(red: 12/255, green: 77/255, blue: 249/255))
                            }
                        }
                    }
                    .frame(width: 105, height: 34)
            }
        }
    }
}

struct LockedRecords: View {
    var index: Int
    var body: some View {
        VStack(spacing: 5) {
            Text("LEVEL \(index + 1)")
                .Bubble(size: 12, color: LinearGradient(colors: [.black, Color(red: 154/255, green: 10/255, blue: 249/255)], startPoint: .top, endPoint: .bottom))
                .padding(.leading, 65)
            
            HStack(spacing: 3) {
                Image(.lockedLevelPin)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 47, height: 37)
                    .overlay {
                        Text("\(index + 1)")
                            .Bubble(size: 20, color: LinearGradient(colors: [.black, Color(red: 154/255, green: 10/255, blue: 249/255)], startPoint: .top, endPoint: .bottom))
                    }
                
                Image(.lockedScore)
                    .resizable()
                    .overlay {
                        HStack(spacing: 5) {
                            Image(.star)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 21, height: 19)
                            
                            VStack(spacing: 2) {
                                Text("TOTAL SCORE:")
                                    .BubbleNoOutline(size: 6, color: .white)
                                
                                Text("0/100")
                                    .BubbleNoOutline(size: 6,
                                                     color: Color(red: 12/255, green: 77/255, blue: 249/255))
                            }
                        }
                    }
                    .frame(width: 105, height: 34)
            }
        }
    }
}
