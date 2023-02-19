/**App Name: Slot Machine
 Version: 3.0
 Created on: 19-02-2023
 
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
 If the 3 images are same, then the user gets 500 credit and a message pops up as "You won Jackpot"
 Exit button gives an alert to exit from the Application
 An information button is added to give the instructions for playing the game
 Core Data is used to store the highest score in the database*/

import SwiftUI
import UIKit
import Combine
import NotificationCenter

//**********************
class PushNotificationManager {
    static let shared = PushNotificationManager()
    let valueChanged = PassthroughSubject<Void, Never>()
    private init() {}
}
//**********************

struct ContentView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Score.highScore, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Score>
    private var symbols = ["pineapple" , "watermelon", "raspberry"]
    @State private var numbers = [0, 1, 2]
    @State private var credits = 1000
    @State private var jackpot = 500
    @State private var showConfirm = false
    @State private var isDisabled = true
    @State private var showAlert = false
    @State private var showWinMessage = false
    @State private var enteredBet  = "0"
    private var bet = 50
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "highScore")
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.4)
                
                VStack {
                    HStack {
                        Spacer(minLength: 100)
                        //Title
                        Image("logo")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                    HStack {
                        //**********************
//                        .onReceive(PushNotificationManager.shared.valueChanged) { _ in
//                            // Code to execute when variable value changes
//                            print("Variable value changed!")
//                        }
//                        .onAppear {
//                            NotificationCenter.default.addObserver(forName: Notification.Name("MyVariableChanged"), object: nil, queue: .main) { notification in
//                                // Code to execute when push notification is received
//                                print("Push notification received!")
//                            }
//                        }
                        //**********************
                        Text("Credits: " + String(credits))
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .padding(.all,10)
                            .background(LinearGradient(gradient: Gradient(colors: [.purple, .black, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                            )
                        
                        Text("Highscore: " + String(self.highScore))
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .padding(.all,10)
                            .background(LinearGradient(gradient: Gradient(colors: [.purple, .black, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                            )
                    }
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
                        Spacer()
                        Text("Bet: ")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .semibold, design: .serif))
                            .padding(.all,10)
                            .background(LinearGradient(gradient: Gradient(colors: [.purple, .black, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                                
                            )
                        TextField("Enter your bet", text: $enteredBet)
                            .keyboardType(.numberPad)
                            .frame(width: 70)
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .semibold, design: .serif))
                            .padding(.all,10)
                            .background(LinearGradient(gradient: Gradient(colors: [.purple, .black, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                            )
                        Spacer()
                        
                        
                        Text("Jackpot: " + String((Int(enteredBet) ?? 0) * 10))                        .foregroundColor(.white)
                            .font(.system(size: 25, weight: .semibold, design: .serif))
                            .padding(.all,10)
                            .background(LinearGradient(gradient: Gradient(colors: [.purple, .black, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                            )
                        Spacer()
                    }
                    
                    
                    //Button
                    Spacer()
                    
                    //Button(action: {
                    
                    //check if mninimum credits are available to play
                    if self.credits <= Int(enteredBet) ?? 0 || Int(enteredBet) == 0 {
                        Button(action: {
                            self.showAlert = true
                        }) {
                            Text("SPIN")
                                .font(.custom("AmericanTypewriter-Semibold", fixedSize: 30))
                                .foregroundColor(.black)
                                .padding(.all,10)
                                .padding([.leading,.trailing], 30)
                                .background(LinearGradient(gradient: Gradient(colors: [.gray, .gray, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.bar, style: StrokeStyle(lineWidth: 3, dash: [8, 5]))
                                )
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Insufficient Credits / Invalid Bet"), message: Text("You need more credits to perform this action / You must enter bet amount"), dismissButton: .default(Text("Ok")))
                        }
                    } else {
                        
                        if showWinMessage {
                            Text("You Won Jackpot!")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .transition(.slide.combined(with: .scale)).transition(.move(edge: .trailing).combined(with: .move(edge: .top)))
                        }
                        
                        Button(action: {
                            // set highscore
                            if self.credits > self.highScore {
                                self.highScore = self.credits
                                UserDefaults.standard.set(highScore, forKey: "highScore")
                            }
                            //Change the symbols
                            self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                            self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                            self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
                            
                            //check winnings
                            if self.numbers[0] == self.numbers[1] &&
                                self.numbers[1] == self.numbers[2]
                            {
                                //Won
                                withAnimation(.linear(duration: 2))
                                {
                                    self.showWinMessage = true
                                }
                                self.credits += (Int(self.enteredBet) ?? 0) * 10
                                //**********************
                                PushNotificationManager.shared.valueChanged.send()
                                NotificationCenter.default.post(name: Notification.Name("MyVariableChanged"), object: nil)
                                //**********************
                            }
                            else {
                                self.credits -= Int(self.enteredBet) ?? 0
                                self.showWinMessage = false
                            }
                        })
                        {
                            Text ("SPIN")
                                .font(.custom("AmericanTypewriter-Semibold", fixedSize: 30))
                                .foregroundColor(.black)
                                .padding(.all,10)
                                .padding([.leading,.trailing], 30)
                                .background(LinearGradient(gradient: Gradient(colors: [.red, .yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
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
                            self.credits = 1000
                            self.enteredBet = "0"
                            self.showWinMessage = false
                            self.highScore = 1000
                            self.showConfirm = false
                        }) {
                            Image("reset1")
                                .resizable()
                                .frame(width: 90, height: 90)
                            
                        }
                        Spacer()
                        NavigationLink(destination: InfoView()) {
                            Image("info")
                                .resizable()
                                .frame(width: 90, height: 90)
                        }
                        Spacer()
                        //Spacer(minLength: 180)
                        Button(action: {
                            withAnimation {
                                self.showAlert.toggle()
                            }
                            self.showConfirm = true
                        }) {
                            Image("exit")
                                .resizable()
                                .frame(width: 90, height: 90)
                        }
                        .alert(isPresented: $showConfirm) {
                            Alert(title: Text("Confirm"), message: Text("Are you sure you want to quit the game?"), primaryButton: .destructive(Text("Quit")) {
                                exit(0)
                            }, secondaryButton: .cancel())
                            
                        }
                        .transition(.scale)
                        Spacer()
                    }
                }
                .padding()
            }
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(){
            // Load Highscore
            if self.credits > self.highScore {
                self.highScore = self.credits
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
        }
    }
}

struct InfoView: View {
    var body: some View {
        ZStack {
            
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack {
                
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                
//                VStack(spacing: 10) {
                    
                    Text("Game guidelines")
                        .font(.system(size: 23, weight: .bold, design: .serif))
                        .foregroundColor(.red)
//                        .padding(.bottom, 20)
  
                    Text("\u{2022} Click spin button to start the reels. \n\u{2022} Place a bet <=  credits.💵💵 \n\u{2022} Win a jackpot of 10x the bet💰💰")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .multilineTextAlignment(.trailing)
   
//                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                
                VStack(spacing: 10) {
                    Text("💥 Winning Combinations💥 ")
                        .font(.system(size: 23, weight: .bold, design: .serif))
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.center)
                    
//
                            HStack {
                                Image("icons8-pineapple-96")
//                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(Color.white.opacity(0))
                                    .cornerRadius(20)
                                    .padding(10)
                                
                                Image("icons8-pineapple-96")
//                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(Color.white.opacity(0))
                                    .cornerRadius(20)
                                
                                Image("icons8-pineapple-96")
//                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(Color.white.opacity(0))
                                    .cornerRadius(20)
                                
                                Text("--> 10x bet")
                                    .font(.system(size: 20, weight: .semibold, design: .serif))
                                    .multilineTextAlignment(.trailing)
                                Spacer()
                                    
                            }
                        
                        HStack {
                            Image("icons8-raspberry-96")
//                                    .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white.opacity(0))
                                .cornerRadius(20)
                                .padding(10)
                            
                            Image("icons8-raspberry-96")
//                                    .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white.opacity(0))
                                .cornerRadius(20)
                            
                            Image("icons8-raspberry-96")
//                                    .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white.opacity(0))
                                .cornerRadius(20)
                            
                            Text("--> 10x bet")
                                .font(.system(size: 20, weight: .semibold, design: .serif))
                                .multilineTextAlignment(.trailing)
                            Spacer()
                                
                        }
                        
                        HStack {
                            Image("icons8-watermelon-96")
//                                    .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white.opacity(0))
                                .cornerRadius(20)
                                .padding(10)
                            
                            Image("icons8-watermelon-96")
//                                    .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white.opacity(0))
                                .cornerRadius(20)
                            
                            Image("icons8-watermelon-96")
//                                    .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white.opacity(0))
                                .cornerRadius(20)
                            
                            Text("--> 10x bet")
                                .font(.system(size: 20, weight: .semibold, design: .serif))
                                .multilineTextAlignment(.trailing)
                            Spacer()
                                
                        }
//                        }
                        
                    }
                   
                       
                }
                .padding(.vertical, 20)
                Spacer()
            }
//        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
