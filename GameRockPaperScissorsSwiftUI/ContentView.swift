//
//  ContentView.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 14.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 10){
                    Text("Oyinga qosh keldinizder!")
                        .font(.system(size: 54).bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top,92)
                    Spacer()
                    NavigationLink(destination:SinglePlayer()) {
                        PurpleButton(name: "Single player")
                    }
                    .toolbarRole(.editor)
                    NavigationLink(destination:MultiPlayer()) {
                        PurpleButton(name: "Multi player")
                        }
                }
                .padding(.bottom,40)
            }
            .accentColor(.purple)
            .navigationTitle("")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
