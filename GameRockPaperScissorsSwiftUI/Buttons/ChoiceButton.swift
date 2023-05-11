//
//  Button.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 14.04.2023.
//

import SwiftUI

struct ChoiceButton: View{
    let name: String
    var body: some View{
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                    .frame(height: 128)
                Text(name)
                    .font(.system(size: 80))
            }
            
        }
    }
}
