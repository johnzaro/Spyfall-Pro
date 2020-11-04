//
//  ParentView.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 19/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct ParentView: View
{
    @EnvironmentObject var gameSettings: GameSettings
    
    @State var isAnimating = false
    
    @State var pipamanOnScreen = false
    @State var randomPos: CGPoint = CGPoint(x: -1000, y: -1000)
    @State var randomOffset: CGSize = CGSize(width: 0, height: 0)
    @State var randomAngle = 0.0
    @State var pipamanSide = 0
    let pipamanMaxAngle = 30.0
    
    let pipamanTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View
    {
        GeometryReader()
        {
            geometry in
            
            let deviceWidth = geometry.size.width + geometry.safeAreaInsets.leading + geometry.safeAreaInsets.trailing
            let deviceHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
            let mainContentHeight = deviceHeight * 0.6
            let contentWidth = min(gameSettings.currentPage == .INFO ? 500 : 350, deviceWidth * 0.85)
            
            let pipamanAspectRatio: CGFloat = 100.0 / 255.0
            let pipamanWidth: CGFloat = 0.15 * deviceWidth
            let pipamanHalfWidth: CGFloat = pipamanWidth * 0.5
            let pipamanHalfHeight: CGFloat = pipamanHalfWidth / pipamanAspectRatio
            
            ZStack()
            {
                Rectangle().foregroundColor(Color(hex: "3498db"))
                
                Rectangle()
                    .scaleEffect(x: 1, y: 2)
                    .rotationEffect(.degrees(45))
                    .foregroundColor(Color(hex: "2980b9"))
                
                Image("pipaman")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: pipamanWidth)
                    .rotationEffect(.degrees(randomAngle), anchor: .center)
                    .position(randomPos)
                    .offset(randomOffset)
                    .onReceive(pipamanTimer)
                    {
                        _ in
                        
                        if pipamanOnScreen
                        {
                            if Int.random(in: 1...3) == 1 // 1 in 3 times pipaman will be hidden
                            {
                                pipamanOnScreen = false
                                withAnimation(Animation.easeOut(duration: 0.5))
                                {
                                    randomOffset.width = 0
                                    randomOffset.height = 0
                                }
                            }
                        }
                        else
                        {
                            if Int.random(in: 1...10) == 1 // 1 in 10 times pipaman will be shown
                            {
                                pipamanOnScreen = true
                                randomAngle = Double.random(in: (-pipamanMaxAngle)...pipamanMaxAngle)
                                pipamanSide = Int.random(in: 1...4) // top right down left
                                if pipamanSide == 1
                                {
                                    randomPos.x = CGFloat.random(in: pipamanWidth...(deviceWidth - pipamanWidth))
                                    randomPos.y = -pipamanHalfHeight
                                    randomAngle += 180
                                    withAnimation(Animation.easeOut(duration: 0.5))
                                    {
                                        randomOffset.width = -pipamanHalfHeight * tan(CGFloat(randomAngle * Double.pi / 180.0))
                                        randomOffset.height = pipamanHalfHeight
                                    }
                                }
                                else if pipamanSide == 2
                                {
                                    randomPos.x = deviceWidth + pipamanHalfHeight
                                    randomPos.y = CGFloat.random(in: pipamanWidth...(deviceHeight - pipamanWidth))
                                    randomAngle += 270
                                    withAnimation(Animation.easeOut(duration: 0.5))
                                    {
                                        randomOffset.width = -pipamanHalfHeight
                                        randomOffset.height = pipamanHalfHeight / tan(CGFloat(randomAngle * Double.pi / 180.0))
                                    }
                                }
                                else if pipamanSide == 3
                                {
                                    randomPos.x = CGFloat.random(in: pipamanWidth...(deviceWidth - pipamanWidth))
                                    randomPos.y = deviceHeight + pipamanHalfHeight
                                    randomAngle += 0
                                    withAnimation(Animation.easeOut(duration: 0.5))
                                    {
                                        randomOffset.width = pipamanHalfHeight * tan(CGFloat(randomAngle * Double.pi / 180.0))
                                        randomOffset.height = -pipamanHalfHeight
                                    }
                                }
                                else
                                {
                                    randomPos.x = -pipamanHalfHeight
                                    randomPos.y = CGFloat.random(in: pipamanWidth...(deviceHeight - pipamanWidth))
                                    randomAngle += 90
                                    withAnimation(Animation.easeOut(duration: 0.5))
                                    {
                                        randomOffset.width = pipamanHalfHeight
                                        randomOffset.height = -pipamanHalfHeight / tan(CGFloat(randomAngle * Double.pi / 180.0))
                                    }
                                }
                            }
                        }
                    }
                
                VStack(spacing: 0)
                {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(40)
                        .shadow(color: Color.black.opacity(0.5), radius: 15, x: 10, y: 10)
                        .frame(width: min(250, 0.465 * deviceWidth))
                        .animation(nil)
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                        .animation(Animation.linear(duration: 4.0).repeatForever(autoreverses: true))
                        .onAppear { isAnimating = true }
                        .onDisappear { isAnimating = false }
                    
                    Group()
                    {
                        if gameSettings.currentPage == .WELCOME
                        {
                            WelcomeView_OptionsView(height: mainContentHeight)
                        }
                        else if gameSettings.currentPage == .INFO
                        {
                            WelcomeView_InfoView(height: mainContentHeight)
                        }
                        else if gameSettings.currentPage == .GAME
                        {
                            GameView()
                        }
                        else
                        {
                            WelcomeView_ListOfLocations(width: contentWidth, height: mainContentHeight)
                        }
                    }
                    .frame(height: mainContentHeight)
                    
                    Spacer()
                }
                .environmentObject(gameSettings)
                .foregroundColor(.black)
                .font(gameSettings.fontNormal)
                .frame(width: contentWidth)
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ParentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ParentView().environmentObject(GameSettings()).environment(\.locale, .init(identifier: "el"))
    }
}
