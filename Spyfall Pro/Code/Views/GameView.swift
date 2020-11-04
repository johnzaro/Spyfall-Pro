//
//  GameView.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 19/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct GameView: View
{
    @EnvironmentObject var gameSettings: GameSettings
    
    @State private var showingAlert = false
    
    let countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View
    {
        VStack()
        {
            Spacer()
            
            Text(gameSettings.currentPlayer > Int(gameSettings.numberOfPlayers) ?
                    "haveFun".localized() :
                    "%d numOfPlayer".localizedWithParam(min(gameSettings.currentPlayer, Int(gameSettings.numberOfPlayers))))
                .frame(width: 400)
                .font(gameSettings.fontVeryBig)
                .transition(AnyTransition.opacity.animation(.linear(duration: 0.2)))
            
            Spacer()
            
            RoundedRectanglularButton(width: 280, height: 60, cornerRadius: 25, label: gameSettings.proceedText, accentColor: gameSettings.accentColor, action:
            {
                playButtonClickSound()
                
                if gameSettings.currentPlayer <= Int(gameSettings.numberOfPlayers)
                {
                    if gameSettings.isShowingPlace
                    {
                        if gameSettings.currentPlayer == Int(gameSettings.numberOfPlayers)
                        {
                            gameSettings.proceedText = "nextRound".localized()
                            gameSettings.gameState = .PLAYING
                            playGameStartedSound()
                        }
                        else
                        {
                            gameSettings.proceedText = "showLocation".localized()
                        }
                        gameSettings.currentPlayer += 1
                        
                        withAnimation(.easeInOut(duration: 0.2)) { gameSettings.isShowingPlace = false }
                    }
                    else
                    {
                        gameSettings.proceedText = gameSettings.currentPlayer == Int(gameSettings.numberOfPlayers) ? "start".localized() : "nextPlayer".localized()
                        
                        if gameSettings.allSpies || gameSettings.currentPlayer == gameSettings.spyIndex1 || gameSettings.currentPlayer == gameSettings.spyIndex2
                        {
                            gameSettings.placeText = "spy".localized()
                        }
                        else
                        {
                            gameSettings.placeText = gameSettings.selectedPlace
                        }
                        
                        withAnimation(.easeInOut(duration: 0.2)) { gameSettings.isShowingPlace = true }
                    }
                }
                else
                {
                    gameSettings.setup(reloadPlaces: false)
                }
            })
            .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
            
            Spacer()
            
            Group()
            {
                if gameSettings.gameState == .GETTING_READY
                {
                    Text(gameSettings.placeText)
                        .font(gameSettings.fontBig)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .frame(width: 280)
                        .scaleEffect(gameSettings.isShowingPlace ? 1 : 0)
                        .transition(AnyTransition.opacity.animation(.linear(duration: 0.2)))
                }
                else if gameSettings.gameState == .PLAYING || gameSettings.gameState == .PAUSED
                {
                    VStack(spacing: 20)
                    {
                        ProgressView(value: gameSettings.remainingSeconds, total: gameSettings.minutes * 60)
                            .accentColor(Color(hex: gameSettings.progressColors[Int(gameSettings.progressColorsIndex)]))
                            .frame(width: 100)
                            .scaleEffect(3)
                            .onReceive(countDownTimer)
                            {
                                time in guard gameSettings.gameState == .PLAYING else { return }
                                
                                if gameSettings.remainingSeconds > 0
                                {
                                    gameSettings.remainingSeconds -= 1
                                    
                                    gameSettings.isTimerEnding = gameSettings.remainingSeconds < 30
                                    
                                    let newProgressColorsIndex = gameSettings.progressColorsIndex + gameSettings.progressColorsStep
                                    gameSettings.progressColorsIndex = Int(newProgressColorsIndex) >= gameSettings.progressColors.count ? 0.0 : newProgressColorsIndex
                                }
                                else
                                {
                                    playTimeOverSound()
                                    gameSettings.gameState = .ENDED
                                }
                            }
                        
                        Text("\(Int(gameSettings.remainingSeconds) / 60):\(Int(gameSettings.remainingSeconds) % 60, specifier: "%02d")")
                            .font(gameSettings.fontVeryBig)
                            .foregroundColor(gameSettings.isTimerEnding && gameSettings.remainingSeconds.truncatingRemainder(dividingBy: 2) == 0 ? Color(hex: "#c0392b") : .black)
                            .scaleEffect(gameSettings.isTimerEnding ? 1.7 : 1.3)
                            .animation(gameSettings.isTimerEnding ? Animation.easeInOut(duration: 0.55).repeatForever(autoreverses: true) : nil)
                            .rotationEffect(gameSettings.isTimerEnding ? gameSettings.remainingSeconds == 29 ? .degrees(3) : .degrees(-3) : .degrees(0))
                            .animation(gameSettings.isTimerEnding ? Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true) : nil)
                        
                        Button(action:
                        {
                            if gameSettings.gameState == .PLAYING
                            {
                                gameSettings.gameState = .PAUSED
                                playPauseSound()
                            }
                            else
                            {
                                gameSettings.gameState = .PLAYING
                                playResumeSound()
                            }
                        })
                        {
                            Image(systemName: gameSettings.gameState == .PLAYING ? "pause.fill" : "play.fill").font(gameSettings.fontBig)
                        }
                        .buttonStyle(ButtonScaleOnPress())
                        .frame(height: 40)
                    }
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.2)))
                }
                else
                {
                    Text("timerEnded".localized()).font(gameSettings.fontVeryBig)
                }
            }.frame(height: 85)
            
            Spacer()
            
            RoundedRectanglularButton(width: 185, height: 60, cornerRadius: 25, label: "return".localized(), accentColor: gameSettings.accentColor, action:
            {
                playButtonClickSound()
                
                showingAlert = true
            })
            .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
            .alert(isPresented:$showingAlert)
            {
                Alert(title: Text("alert".localized()), primaryButton: .destructive(Text("yes".localized()))
                {
                    gameSettings.showWelcomePage()
                    gameSettings.gameState = .GETTING_READY
                }, secondaryButton: .cancel(Text("no".localized())))
            }
        }
        .transition(AnyTransition.opacity.animation(.linear(duration: 0.2)))
    }
}

struct GameView_Previews: PreviewProvider
{
    static var previews: some View
    {
        GameView().environmentObject(GameSettings())
    }
}
