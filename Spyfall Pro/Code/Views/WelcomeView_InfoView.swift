//
//  InfoView.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 19/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct InfoText: View
{
    var label: String
    
    var body: some View { Text(label + "\n") }
}

struct TitledInfoText: View
{
    var label: String
    
    var body: some View { Text(label + "\n").bold().underline() }
}

struct WelcomeView_InfoView: View
{
    @EnvironmentObject var gameSettings: GameSettings
    
    var height: CGFloat
    
    var body: some View
    {
        VStack()
        {
            Spacer()
            
            ScrollView()
            {
                VStack()
                {
                    VStack()
                    {
                        TitledInfoText(label: "roundsTitle".localized())
                        InfoText(label: "roundsText".localized())
                        
                        TitledInfoText(label: "spiesTitle".localized())
                        InfoText(label: "spiesText".localized())
                        
                        TitledInfoText(label: "timerTitle".localized())
                        InfoText(label: "timerText".localized())
                        
                        TitledInfoText(label: "endOfRoundTitle".localized())
                        InfoText(label: "endOfRoundText".localized())
                        
                        TitledInfoText(label: "objectivesAndStrategiesTitle".localized())
                        InfoText(label: "objectivesAndStrategiesText".localized())
                    }
                    
                    VStack()
                    {
                        TitledInfoText(label: "scoringTitle".localized())
                        InfoText(label: "scoringText".localized())
                        
                        TitledInfoText(label: "spyVictoryTitle".localized())
                        InfoText(label: "spyVictoryText".localized())
                        
                        TitledInfoText(label: "nonSpyVictoryTitle".localized())
                        InfoText(label: "nonSpyVictoryText".localized())
                        
                        TitledInfoText(label: "endOfTheGameTitle".localized())
                        InfoText(label: "endOfTheGameText".localized())
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .cornerRadius(40)
            }
            .cornerRadius(40)
            .font(gameSettings.fontSmall)
            .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
            .frame(height: height * 0.75)
            
            Spacer()
            
            RoundedRectanglularButton(width: 185, height: 60, cornerRadius: 25, label: "return".localized(), accentColor: gameSettings.accentColor, action:
            {
                playButtonClickSound()
                
                gameSettings.showWelcomePage()
            })
            .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
        }
        .transition(AnyTransition.opacity.animation(.linear(duration: 0.2)))
    }
}

struct WelcomeView_InfoView_Previews: PreviewProvider
{
    static var previews: some View
    {
        WelcomeView_InfoView(height: 500).environmentObject(GameSettings())
    }
}
