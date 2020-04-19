//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pradeep on 18/04/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import SwiftUI

enum ActiveAlert {
    case first, second
}

struct ContentView: View {
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var isRightAns = false
    @State private var scoreTitle = ""
    @State private var wrongScoreMessage = ""
    @State private var correctScoreValue = 0
    @State private var wrongScoreValue = 0
    
    var body: some View {
        
        ZStack{
            //Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the Flage of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer].capitalized)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    
                    Button(action:{
                        
                        self.flagTapped(number)
                        
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                        //.border(Color.red, width: 2)
                    }
                }
                Text("Correct Answer: \(correctScoreValue)").foregroundColor(.white)
                Text("Wrong Answer: \(wrongScoreValue)").foregroundColor(.white)
                Spacer()
            }
            
            .alert(isPresented: $showingScore) {
                if(isRightAns){
                    return Alert(title: Text(scoreTitle), message: Text("Your score is \(correctScoreValue - wrongScoreValue)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    })
                }
                else{
                    return Alert(title: Text(scoreTitle), message: Text("Wrong! That’s the flag of \(wrongScoreMessage)"), dismissButton: .default(Text("Continue")){
                        self.askQuestion()
                    })
                }
               
            }
            
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            isRightAns = true
            correctScoreValue += 1
            
        } else {
            scoreTitle = "Wrong"
            isRightAns = false
            wrongScoreValue += 1
            wrongScoreMessage = countries[number].capitalized
        }
        showingScore = true
        
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
