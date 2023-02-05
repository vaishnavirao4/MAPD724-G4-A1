/**App Name: Slot Machine
 Version: 2.0
 Created on: 05-02-2023
 
 
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
 Exit button gives an alert to exit from the Application */

import SwiftUI

@main
struct Slot_MachineApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
