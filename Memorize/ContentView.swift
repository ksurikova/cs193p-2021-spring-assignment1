//
//  ContentView.swift
//  Memorize
//
//  Created by Ksenia Surikova on 05.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    //Mark: Theme
    var themes :[emojiTheme] =
    [emojiTheme(description: "dolce vita", imageName: "crown", emojis: ["🕶","👗", "👠", "💍", "🏰", "👸🏼", "🍸", "🧁", "🌆", "🏝", "🎁"]),
     emojiTheme(description: "weather", imageName: "sun.min", emojis: ["☁️","☀️", "🌪", "🌈", "☂️", "⚡️", "💧", "❄️", "🌱", "⛱", "🍁"]),
     emojiTheme(description: "animals", imageName: "hare", emojis: [  "🐤", "🦈", "🦓","🐕","🦧", "🦩", "🦡", "🦉", "🦋", "🐛", "🐟", "🐨"])]
    
    
    struct emojiTheme: Hashable {
        
        var description: String
        var imageName: String
        var emojis: [String]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(imageName)
        }
    }


    struct ThemeButton: View {
        var theme: emojiTheme
        var act: () -> Void
        
        var body: some View {
            Button{
                act()
            }
        label: {
            VStack {
                Image(systemName: theme.imageName)
                Text(theme.description).font(.body)
            }
        }
        }
    }
    
    @State var currentTheme :emojiTheme?
    
    //Mark: body
    var body: some View {
        VStack {
            Text("Memorized!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 65))]) {
                    ForEach(currentTheme?.emojis.shuffled() ?? [String](), id: \.self){ emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }.foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            Spacer()
            HStack {ForEach(themes, id: \.self) {theme in ThemeButton(theme: theme, act: {currentTheme = theme})}
            }.font(.largeTitle).padding(.horizontal)
        }.padding(.horizontal)
    }
}






struct CardView: View {
    
@State var isFaceUp: Bool = true
    var content: String
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(content).font(.largeTitle)
            }
            else {
                shape.fill()
            }
        }.onTapGesture{
            isFaceUp = !isFaceUp
    }
}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
