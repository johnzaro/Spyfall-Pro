//
//  WelcomeView_ListOfLocations.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 23/10/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct WelcomeView_ListOfLocations: View
{
    @EnvironmentObject var gameSettings: GameSettings

    var width: CGFloat
    var height: CGFloat

    var body: some View
    {
        VStack()
        {
            Spacer()
            
            ScrollView()
            {
                ForEach(gameSettings.locations, id:\.self) { Text($0) }
            }
            .frame(width: width, height: height * 0.75)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .background(Color.black.opacity(0.75))
            .foregroundColor(.white)
            .cornerRadius(40)
            .font(gameSettings.fontSmall)
            .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
            
            Spacer()
            
            RoundedRectanglularButton(width: 185, height: 60, cornerRadius: 25, label: "return".localized(), accentColor: gameSettings.accentColor, action:
            {
                playButtonClickSound()
                gameSettings.showWelcomePage()
                gameSettings.gameState = .GETTING_READY
            })
            .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
        }
        .transition(AnyTransition.opacity.animation(.linear(duration: 0.2)))
    }
}
