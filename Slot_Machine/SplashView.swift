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

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                Image("splashscreen")
                    .resizable()
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
