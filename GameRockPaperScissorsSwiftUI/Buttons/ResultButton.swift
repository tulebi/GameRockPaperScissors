//
//  ResultButton.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 15.04.2023.
//

import SwiftUI

struct ResultButton: View {
    let sign1: String
    let sign2: String
    var body: some View {
        VStack{
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 48)
                        .fill(Color(red: 0.953, green: 0.949, blue: 0.973))
                        .frame(width: 190,height: 128)
                        .overlay(
                            RoundedRectangle(cornerRadius: 48)
                                .stroke(Color.white, lineWidth: 10)
                        )
                    Text(sign1)
                        .font(.system(size: 80))
                }.offset(x: -130,y: -70)
                ZStack{
                    RoundedRectangle(cornerRadius: 48)
                        .fill(Color(red: 0.953, green: 0.949, blue: 0.973))
                        .frame(width: 190,height: 128)
                        .overlay(
                            RoundedRectangle(cornerRadius: 48)
                                .stroke(Color.white, lineWidth: 10)
                        )
                    Text(sign2)
                        .font(.system(size: 80))
                }
            }
        }
        .padding(.leading,130)
    }
}

struct ResultButton_Previews: PreviewProvider {
    static var previews: some View {
        ResultButton(sign1: "", sign2: "")
    }
}
