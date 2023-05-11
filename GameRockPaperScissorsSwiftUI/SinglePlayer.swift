//
//  ScreenOne.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 14.04.2023.
//

import SwiftUI

struct SinglePlayer: View {
    @State var screenState: ScreenState = .choose
    @State var selfChoice: Choices = .none
    @State var oponentChoice: Choices = .none
    @State var myScore: Int = 0
    @State var botScore:Int = 0
    @State var round: Int = 0
    
    
    var body: some View {
        switch screenState {
        case .choose:
            ChooseView(selfChoice: $selfChoice, screenState: $screenState,myScore: $myScore,botScore: $botScore).navigationTitle("Round #\(round)")
        case .change:
            ChangeChoiceView(choice: $selfChoice, screenState: $screenState,myScore: $myScore,botScore: $botScore).navigationTitle("Round #\(round)")
        case .openentChoose:
            OpenentWaitView(screenState: $screenState).navigationTitle("Round #\(round)")
        case .showOponent:
            OpenentChoiceView(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState).navigationTitle("Round #\(round)")
        case .tie:
            Tie(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState).navigationTitle("Round #\(round)")
        case .win:
            Win(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState).navigationTitle("Round #\(round)")
        case .lose:
            Lose(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState,round: $round).navigationTitle("Round #\(round)")
        }
        
    }
}

struct ChooseView: View {
    @Binding var selfChoice: Choices
    @Binding var screenState: ScreenState
    @State var anim = false
    @Binding var myScore: Int
    @Binding var botScore: Int
    var body: some View {
        VStack{
            Text("Take your pick")
                .font(.system(size: 54).bold())
                .padding(.horizontal,16)
                .padding(.bottom,10)
                .padding(.top,80)
            Text("Score \(myScore):\(botScore)")
                .foregroundColor(.purple)
                .padding(.bottom,65)
            
            VStack(spacing: 24){
                ChoiceButton(name: "📃")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        selfChoice = .paper
                        withAnimation (.default){
                            screenState = .change
                        }
                    }
                ChoiceButton(name: "✂️")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        selfChoice = .scissors
                        withAnimation (.default){
                            screenState = .change
                        }
                    }
                ChoiceButton(name: "🗿")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        selfChoice = .rock
                        withAnimation (.default){
                            screenState = .change
                        }
                    }
            }
            .padding(.bottom,122)
            Spacer()
        }
    }
}

struct ChangeChoiceView: View {
    @Binding var choice: Choices
    @Binding var screenState: ScreenState
    @Binding var myScore: Int
    @Binding var botScore: Int
    var body: some View {
        VStack {
            Text("Your pick")
                .font(.system(size: 54).bold())
                .padding(.top,110)
                .padding(.bottom,12)
            Text("Score \(myScore):\(botScore)")
                .foregroundColor(.purple)
                .padding(.bottom,226)
            ChoiceButton(name: choice.name)
                .padding(.horizontal,16)
                .padding(.bottom,184)
                .onTapGesture {
                    withAnimation(.spring()) {
                        screenState = .openentChoose
                    }
                    
                }
            PurpleButton(name: "I changed my mind")
                .padding(.bottom,110)
                .onTapGesture {
                    withAnimation(.spring()) {
                        screenState = .choose}
                }
            
        }
        
    }
}

struct OpenentWaitView: View {
    // @Binding var oponentChoice: Choices
    @Binding var screenState: ScreenState
    
    var body: some View {
        VStack{
            Text("Your   opponent is thinking")
            //                .layoutPriority(1)
                .multilineTextAlignment(.center)
                .padding(.horizontal,16)
                .font(.system(size: 54).bold())
                .padding(.top,60)
                .padding(.bottom,120)
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                    .frame(height: 128)
                DottedSpinner()
                    .frame(width: 40,height: 40)
            }
            .padding(.horizontal,16)
            Spacer()
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                //                    oponentChoice = .rock
                screenState = .showOponent
            }
        }
    }
}

struct OpenentChoiceView: View {
    //@Binding var oponentChoice: botChoices
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var screenState: ScreenState
    @State var see = false
    @State var curentbotchoice = Int.random(in: 0 ..< 3)
    let botmoves = ["📃","✂️","🗿"]
    
    
    
    var body: some View {
        VStack{
            Text("Your opponent's pick")
                .font(.system(size: 54).bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal,16)
                .padding(.top,60)
                .padding(.bottom,120)
            ChoiceButton(name: oponentChoice.name)
                .padding(.horizontal,16)
                .onTapGesture {
                    if (choice.name == "🗿" && oponentChoice.name == "✂️") || (choice.name == "📃" && oponentChoice.name == "🗿") || (choice.name == "✂️" && oponentChoice.name == "📃"){
                        myScore += 1
                        withAnimation (.spring()){
                            screenState = .win
                        }
                        
                    }else if choice.name == oponentChoice.name{
                        withAnimation (.spring()){
                            screenState = .tie}
                    }
                    else{
                        botScore += 1
                        withAnimation (.spring()){
                            screenState = .lose}
                    }
                }
            Spacer()
        }
        .onAppear(){
            if botmoves[curentbotchoice] == "📃"{
                oponentChoice = .paper
            }else if botmoves[curentbotchoice] == "✂️"{
                oponentChoice = .scissors
            }else if botmoves[curentbotchoice] == "🗿"{
                oponentChoice = .rock
            }
            
        }
    }
}

struct Tie: View{
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var screenState: ScreenState
    var body: some View{
        Text("Tie!")
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .leading, endPoint: .trailing))
            .font(.system(size: 54).bold())
            .padding(.top,40)
            .padding(.bottom,12)
        Text("Score \(myScore):\(botScore)")
            .foregroundColor(.purple)
            .padding(.bottom,110)
        Spacer()
        ResultButton(sign1: choice.name, sign2: oponentChoice.name)
        Spacer()
        PurpleButton(name: "Another round")
            .padding(.bottom,10)
            .onTapGesture {
                withAnimation (.spring()){
                    screenState = .choose}
            }
    }
    
    var qwe: some View{
        Text("")
    }
}

struct Win: View{
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var screenState: ScreenState
    var body: some View{
        Text("Win!")
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.71, green: 0.93, blue: 0.61), Color(red: 0.14, green: 0.68, blue: 0.26)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
        
            .font(.system(size: 54).bold())
            .padding(.top,40)
            .padding(.bottom,12)
        Text("Score \(myScore):\(botScore)")
            .foregroundColor(.purple)
            .padding(.bottom,110)
        Spacer()
        ResultButton(sign1: choice.name, sign2: oponentChoice.name)
        Spacer()
        PurpleButton(name: "Another round")
            .onTapGesture {
                withAnimation (.spring()){
                    screenState = .choose}
            }
    }
}

struct Lose: View{
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var screenState: ScreenState
    @Binding var round: Int
    var body: some View{
        Text("Lose")
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.41, blue: 0.38), Color(red: 0.99, green: 0.30, blue: 0.30)]),startPoint: .leading,endPoint: .trailing
                                           )
            )
            .font(.system(size: 54).bold())
            .padding(.top,40)
            .padding(.bottom,12)
        Text("Score \(myScore):\(botScore)")
            .foregroundColor(.purple)
            .padding(.bottom,110)
        Spacer()
        ResultButton(sign1: choice.name, sign2: oponentChoice.name)
        Spacer()
        PurpleButton(name: "Another round")
            .onTapGesture {
                round += 1
                withAnimation (.spring()){
                    screenState = .choose}
            }
    }
}
struct ScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayer()
    }
}
