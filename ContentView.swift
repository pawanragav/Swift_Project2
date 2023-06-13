//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pawan's Mac on 16/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries =
    ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
   @State private var correctAnswer = Int.random(in: 0...2)
    @State private var animationAmount = 0.0
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(stops: [
                    .init(color: Color(red:0.1,green:0.2,blue:0.45), location: 0.3),
                    .init(color:Color(red:0.76,green:0.15,blue:0.26),location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                VStack(spacing: 30){
                    VStack {
                        Text("Tap the Flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                   
                    ForEach(0..<3){number in
                        Button {
                            flagTapped(number)
                            withAnimation{
                                animationAmount += 360}
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                }
                
                
            }
            .navigationTitle("GuessTheFlag")
        }
            
        .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
        }message: {
                Text("Your score is ???")
            }
            
        
        
    }
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
        }
        else{
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in:0...2)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
