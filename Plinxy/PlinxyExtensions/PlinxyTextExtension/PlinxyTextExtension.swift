import SwiftUI

extension Text {
    func Bubble(size: CGFloat,
                color: LinearGradient = LinearGradient(colors: [Color(red: 223/255, green: 12/255, blue: 243/255),
                                                                Color(red: 154/255, green: 10/255, blue: 249/255)], startPoint: .top, endPoint: .bottom),
                colorOutline: Color = .white,
                width: CGFloat = 0.7) -> some View {
        self.font(.custom("Super Bubble", size: size))
            .foregroundStyle(color)
            .outlineText(color: colorOutline, width: width)
    }
    
    func Suez(size: CGFloat,
              color: LinearGradient = LinearGradient(colors: [Color(red: 252/255, green: 241/255, blue: 58/255)], startPoint: .bottom, endPoint: .top),
              colorOutline: Color = .white,
              width: CGFloat = 0.7) -> some View {
        self.font(.custom("SuezOne-Regular", size: size))
            .foregroundStyle(color)
            .outlineText(color: colorOutline, width: width)
    }
    
    func BubbleNoOutline(size: CGFloat,
                         color: Color = Color(red: 223/255, green: 12/255, blue: 243/255)) -> some View {
        self.font(.custom("Super Bubble", size: size))
            .foregroundStyle(color)
    }
    
    func BubbleNoOutlineGradient(size: CGFloat,
                                 color: LinearGradient = LinearGradient(colors: [Color(red: 252/255, green: 241/255, blue: 58/255)], startPoint: .bottom, endPoint: .top)) -> some View {
        self.font(.custom("Super Bubble", size: size))
            .foregroundStyle(color)
    }
    
    func BubbleGradient(size: CGFloat,
                        color: LinearGradient = LinearGradient(colors: [Color(red: 223/255, green: 12/255, blue: 243/255),
                                                                        Color(red: 12/255, green: 77/255, blue: 249/255)], startPoint: .top, endPoint: .bottom),
                        colorOutline: Color = .white,
                        width: CGFloat = 0.7) -> some View {
        self.font(.custom("Super Bubble", size: size))
            .foregroundStyle(color)
            .outlineText(color: colorOutline, width: width)
    }
}
