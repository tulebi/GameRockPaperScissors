//
//  DottedSpinner.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 14.04.2023.
//

import SwiftUI

struct DottedSpinner: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack{
            ZStack {
                ForEach(0..<8) { index in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 15, height: 15)
                        .opacity(isAnimating ? Double(index) * 0.1 + 0.1 : 0.1)
                        .offset(x: 0, y: -50)
                        .rotationEffect(isAnimating ? .degrees(Double(index) * 45) : .zero)
                }
            }
        }
        .frame(width: 40,height: 40)
        .onAppear() {
            withAnimation(Animation.linear(duration: 3.0).repeatForever()) {
                self.isAnimating = true
            }
        }
    }
}

struct DottedSpinner_Previews: PreviewProvider {
    static var previews: some View {
        DottedSpinner()
    }
}
