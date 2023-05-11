//
//  MultiPlayer.swift
//  fullAppRockPaperScissors
//
//  Created by Тулеби Берик on 15.04.2023.
//

import SwiftUI


struct MultiPlayer: View {
    @State var screenState: ScreenState = .choose
    @State var selfChoice: Choices = .none
    @State var oponentChoice: Choices = .none
    @State var myScore: Int = 0
    @State var botScore:Int = 0
    @State var round: Int = 0
    
    
    var body: some View {
        switch screenState {
        case .choose:
            ChooseView1(selfChoice: $selfChoice, screenState: $screenState,myScore: $myScore,botScore: $botScore).navigationTitle("Round #\(round)")
        case .change:
            ChangeChoiceView1(choice: $selfChoice, screenState: $screenState,myScore: $myScore,botScore: $botScore).navigationTitle("Round #\(round)")
        case .openentChoose:
            OpenentWaitView1(screenState: $screenState).navigationTitle("Round #\(round)")
        case .showOponent:
            OpenentChoiceView1(choice: $selfChoice, screenState: $screenState,round: $round,myScore: $myScore,botScore: $botScore,oponentChoice: $oponentChoice).navigationTitle("Round #\(round)")
        case .tie:
            Tie1(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState).navigationTitle("Round #\(round)")
        case .win:
            Win1(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState,round: $round).navigationTitle("Round #\(round)")
        case .lose:
            Lose1(choice: $selfChoice, oponentChoice: $oponentChoice,myScore: $myScore,botScore: $botScore,screenState: $screenState).navigationTitle("Round #\(round)")
        }
        
    }
}

struct ChooseView1: View {
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
            Text("Player 1 • Score \(myScore):\(botScore)")
                .foregroundColor(.purple)
                .padding(.bottom,65)
            
            VStack(spacing: 24){
                ChoiceButton(name: "📃")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        selfChoice = .paper
                        withAnimation (.spring()){
                            screenState = .change}
                    }
                ChoiceButton(name: "✂️")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        selfChoice = .scissors
                        withAnimation (.spring()){
                            screenState = .change}
                    }
                ChoiceButton(name: "🗿")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        selfChoice = .rock
                        withAnimation (.spring()){
                            screenState = .change}
                    }
            }
            .padding(.bottom,122)
            Spacer()
        }
        
    }
}

struct ChangeChoiceView1: View {
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
                    withAnimation (.spring()){
                        screenState = .openentChoose}
                }
            PurpleButton(name: "I changed my mind")
                .padding(.bottom,110)
                .onTapGesture {
                    withAnimation (.spring()){
                        screenState = .choose}
                }
            
        }
        
    }
}

struct OpenentWaitView1: View {
    // @Binding var oponentChoice: Choices
    @Binding var screenState: ScreenState
    
    var body: some View {
        VStack{
            Text("Pass the phone to your opponent")
            //                .layoutPriority(1)
                .multilineTextAlignment(.center)
                .padding(.horizontal,16)
                .font(.system(size: 54).bold())
                .padding(.top,60)
                .padding(.bottom,120)
            Spacer()
            PurpleButton(name: "Ready to continue")
                .onTapGesture {
                    withAnimation (.spring()){
                        screenState = .showOponent}
                }
        }
    }
}

struct OpenentChoiceView1: View {
    @Binding var choice: Choices
    @Binding var screenState: ScreenState
    @Binding var round: Int
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var oponentChoice: Choices
    var body: some View {
        VStack{
            Text("Your pick")
                .font(.system(size: 54).bold())
                .padding(.horizontal,16)
                .padding(.bottom,10)
                .padding(.top,80)
            Text("Player 2 • Score \(myScore):\(botScore)")
                .foregroundColor(.purple)
                .padding(.bottom,65)
            
            VStack(spacing: 24){
                ChoiceButton(name: "📃")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        oponentChoice = .paper
                        if choice.name == "✂️"{
                            myScore += 1
                            withAnimation (.spring()){
                                screenState = .win}
                        }
                        else if choice.name == "🗿"{
                            botScore += 1
                            withAnimation (.spring()){
                                screenState = .lose}
                        }
                        else {
                            withAnimation (.spring()){
                                screenState = .tie}
                        }
                    }
                ChoiceButton(name: "✂️")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        oponentChoice = .scissors
                        if choice.name == "🗿"{
                            myScore += 1
                            withAnimation (.spring()){
                                screenState = .win}
                        }
                        else if choice.name == "📃"{
                            botScore += 1
                            withAnimation (.spring()){
                                screenState = .lose}
                        }
                        else {
                            withAnimation (.spring()){
                                screenState = .tie}
                        }
                    }
                ChoiceButton(name: "🗿")
                    .padding(.horizontal,24)
                    .onTapGesture {
                        oponentChoice = .rock
                        if choice.name == "📃"{
                            myScore += 1
                            withAnimation (.spring()){
                                screenState = .win}
                        }
                        else if choice.name == "✂️"{
                            botScore += 1
                            withAnimation (.spring()){
                                screenState = .lose}
                        }
                        else {
                            withAnimation (.spring()){
                                screenState = .tie}
                        }
                    }
            }
            .padding(.bottom,122)
            Spacer()
        }
    }
       
    }


struct Tie1: View{
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

struct Win1: View{
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var screenState: ScreenState
    @Binding var round: Int
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
                    round += 1
                withAnimation (.spring()){
                    screenState = .choose}
            }
    }
}

struct Lose1: View{
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Binding var myScore: Int
    @Binding var botScore: Int
    @Binding var screenState: ScreenState
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
                withAnimation (.spring()){
                    screenState = .choose}
            }
    }
}
struct MultiPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MultiPlayer()
    }
}
