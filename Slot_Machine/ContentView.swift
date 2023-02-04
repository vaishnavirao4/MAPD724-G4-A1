/**App Name: Slot Machine
Version: 1.0
Created on: 22-01-2023
 
 
Created by:
 
 
Krishna Patel 301268911
Vaishnavi Santhapuri 301307031
Kowndinya Varanasi 301210621
 
 Description:
 This is a Slot Machine App.
 It has 3 reels, when a user clicks on Spin button, the items present in the reels will change randomly
 There are two labels bet and credit and Three buttons Spin, Exit  and Reset
 Bet refers to the amount of money that a user puts on a single spin of the reels
 Credit refers to the amount of money or tokens that a player has available to use for making bets.
 Spin button is used to change the reels randomly
 Reset button resets the game to its initial state
 Exit button gives an alert to exit from the Application*/

import SwiftUI

struct ContentView: View {
    
    private var symbols = ["pineapple" , "watermelon", "raspberry"]
    @State private var numbers = [0, 1, 2]
    @State private var credits = 10000
    @State private var jackpot = 500
    @State private var showConfirm = false
    @State private var isDisabled = true
    @State private var showAlert = false
    private var bet = 50
    var body: some View {
        
        ZStack {
            //Rectangle().fill(.blue.gradient)
              //  .edgesIgnoringSafeArea(.all)
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.4)
            
            VStack {
            //Title
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer()
            //Cards
                HStack {
                    Spacer()
                    Image(symbols[numbers[0]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 3)
                        )
                    Image(symbols[numbers[1]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 3)
                        )
                    Image(symbols[numbers[2]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 3)
                        )
                    Spacer()
                }
                //Credit counter
                Spacer()
                HStack{
                    Text("Bet: " + String(bet))
                        .foregroundColor(.red)
                        .font(.system(size: 25, weight: .bold, design: .monospaced))
                        .padding(.all,10)
                        .background(Color.indigo)
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                        )
                    Text("Credits: " + String(credits))
                        .foregroundColor(.green)
                        .font(.system(size: 25, weight: .bold, design: .monospaced))
                        .padding(.all,10)
                        .background(Color.indigo)
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                        )
                }
    
            
                //Button
                    Spacer()
                    //Spacer()
                    //Button(action: {
                        
                        //check if mninimum credits are available to play
                    if self.credits <= 9900 {
                                   Button(action: {
                                       self.showAlert = true
                                   }) {
                                       Text("SPIN")
                                           .font(.custom("AmericanTypewriter-Semibold", fixedSize: 30))
                                           .foregroundColor(.black)
                                           .padding(.all,10)
                                           .padding([.leading,.trailing], 30)
                   //                        .background(Color(red: 1, green: 0.8, blue: 0))
                                           .background(LinearGradient(gradient: Gradient(colors: [.gray, .gray, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                   //
                                           .cornerRadius(30)
                                           .overlay(
                                                   RoundedRectangle(cornerRadius: 30)
                                                       .stroke(.bar, style: StrokeStyle(lineWidth: 3, dash: [8, 5]))
                                           )
                                   }
                                   .alert(isPresented: $showAlert) {
                                       Alert(title: Text("Insufficient Credits"), message: Text("You need more credits to perform this action"), dismissButton: .default(Text("Ok")))
                                   }
                               } else {
                                   Button(action: {
                                       // Perform action here
                                       //Change the symbols
                                       self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                                       self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                                       self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
                                       
                                       //check winnings
                                       if self.numbers[0] == self.numbers[1] &&
                                           self.numbers[1] == self.numbers[2]
                                       {
                                           //Won
                                           self.credits += self.bet * 10
                                       }
                                          else {
                                           self.credits -= self.bet
                                       }
                                     
                                   }) {
                                       Text ("SPIN")
                                           .font(.custom("AmericanTypewriter-Semibold", fixedSize: 30))
                                           .foregroundColor(.black)
                                           .padding(.all,10)
                                           .padding([.leading,.trailing], 30)
                   //                        .background(Color(red: 1, green: 0.8, blue: 0))
                                           .background(LinearGradient(gradient: Gradient(colors: [.red, .yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                   //
                                           .cornerRadius(30)
                                           .overlay(
                                                   RoundedRectangle(cornerRadius: 30)
                                                       .stroke(.bar, style: StrokeStyle(lineWidth: 3, dash: [8, 5]))
                                           )

                                   }
                               }
              
                
                
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        //reset the credits
                            self.credits = 10000
                    }) {
                        Image("reset1")
                            .resizable()
                            .frame(width: 90, height: 90)
                            
                    }
                    Spacer(minLength: 180)
                    Button(action: {
                                self.showConfirm = true
                            }) {
                                Image("exit")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                            }
                            .alert(isPresented: $showConfirm) {
                                Alert(title: Text("Confirm"), message: Text("Are you sure you want to quit the app?"), primaryButton: .destructive(Text("Quit")) {
                                    exit(0)
                                }, secondaryButton: .cancel())
                
                            }
                    
                    
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
