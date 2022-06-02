//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by whybhav on 23/05/22.
//

import SwiftUI

struct FlagImage: View {
    var name: String

    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 1)
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var gameReset = false
    @State private var countryName = ""
    @State private var streak = 0
    @State private var freshStart = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap on the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagTapped(number)
                            countryName = countries[number]
                        }) {
                            GuessTheFlag.FlagImage(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert(scoreTitle, isPresented: $gameReset) {
            Button("Retry", action: newGame)
        } message: {
            Text("""
                That's the flag of \(countryName)
                Well tried! Your score is \(currentScore)
                """)
        }
        .alert(scoreTitle, isPresented: $freshStart) {
            Button("Reset", action: newGame)
        } message: {
            Text("You got all 8 correctly!")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer && streak < 7 {
            scoreTitle = "Correct"
            currentScore += 1
            streak += 1
            showingScore = true
        } else if number == correctAnswer && streak == 7{
            scoreTitle = "Congratulations!"
            currentScore += 1
            freshStart = true
            newGame()
        } else {
            scoreTitle = "Wrong!"
            gameReset = true
        }
    }

    func newGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentScore = 0
        streak = 0
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
