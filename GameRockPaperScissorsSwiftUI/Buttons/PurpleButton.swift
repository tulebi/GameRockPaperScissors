//
//  PurpleButton.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 14.04.2023.
//

import SwiftUI

struct PurpleButton: View{
    let name: String
    var body: some View{
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.404, green: 0.314, blue: 0.643))
                    .frame(height: 50)
                    .padding(.horizontal,16)
                Text(name)
                    .foregroundColor(.white)
                
            }
        }
    }
}
