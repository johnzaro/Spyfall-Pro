//
//  ContentView.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 17/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct WelcomeView_OptionsView: View
{
    @EnvironmentObject var gameSettings: GameSettings
    
    var height: CGFloat
    
    var body: some View
    {
        VStack()
        {
            Spacer()
            
            VStack(spacing: 0.09 * height)
            {
                VStack(spacing: 0.054 * height)
                {
                    TitleWithVariable(title: "numOfPlayers".localized(), variable: ": \(String(format: "%#2d", Int(gameSettings.numberOfPlayers)))")
                    
                    SliderWithMinMaxValues(sliderValue: $gameSettings.numberOfPlayers, minValue: 4, maxValue: 15, step: 1, accentColor: gameSettings.accentColor, intValues: true)
                }
                
                VStack(spacing: 0.054 * height)
                {
                    Text("extraCategories".localized()).underline()
                    
                    HStack()
                    {
                        Spacer()
                        
                        CustomToggle(isOn: $gameSettings.isFantasyOn, label: "fantasy".localized(), accentColor: gameSettings.accentColor)
                        
                        Spacer()
                        
                        CustomToggle(isOn: $gameSettings.isNSFWOn, label: "nsfw".localized(), accentColor: gameSettings.accentColor)
                        
                        Spacer()
                    }
                }
                
                RoundedRectanglularButton(width: 250, height: 60, cornerRadius: 25, label: "locationsList".localized(), accentColor: gameSettings.accentColor, action:
                {
                    playButtonClickSound()
                    gameSettings.loadPlaces(sortingEnabled: true)
                    gameSettings.showLocationsPage()
                })
                .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
            }
            
            Spacer()
            
            HStack(spacing: 18)
            {
                RoundedRectanglularButton(width: 185, height: 60, cornerRadius: 25, label: "start".localized(), accentColor: gameSettings.accentColor, action:
                {
                    playButtonClickSound()
                    gameSettings.showGamePage()
                    gameSettings.setup(reloadPlaces: true)
                })
                .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)

                CircularButton(radius: 30, label: "i", accentColor: gameSettings.accentColor, action:
                {
                    playButtonClickSound()
                    gameSettings.showInfoPage()
                })
                .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
            }
            .offset(x: 39)
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
    }
}

struct WelcomeView_OptionsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        WelcomeView_OptionsView(height: 500).environmentObject(GameSettings()).environment(\.locale, .init(identifier: "el"))
    }
}
