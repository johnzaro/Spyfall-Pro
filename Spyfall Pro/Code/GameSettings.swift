//
//  ViewRouter.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 19/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public class GameSettings: ObservableObject
{
    enum PAGE
    {
        case WELCOME
        case INFO
        case GAME
        case LOCATIONS
    }
    @Published var currentPage = PAGE.WELCOME
    
    let accentColor = Color(hex: "FF6906").opacity(0.8)
    
    let fontSmall = Font.custom("Codename Coder Free 4F", size: 20)
    let fontNormal = Font.custom("Codename Coder Free 4F", size: 25)
    let fontBig = Font.custom("Codename Coder Free 4F", size: 40)
    let fontVeryBig = Font.custom("Codename Coder Free 4F", size: 45)
    
    // Welcome Page Options
    
    var oldNumOfPlayers = 0.0
    @Published var numberOfPlayers = 4.0
    {
        didSet
        {
            if numberOfPlayers != oldNumOfPlayers
            {
                oldNumOfPlayers = numberOfPlayers
                playSliderClickSound()
            }
        }
    }
    
    @Published var isFantasyOn = false { didSet { isFantasyOn ? playToggleOnSound() : playToggleOffSound() } }
    @Published var isNSFWOn = false { didSet { isNSFWOn ? playToggleOnSound() : playToggleOffSound() } }
    
    // Game Variables
    
    enum GAME_STATE
    {
        case GETTING_READY
        case PLAYING
        case PAUSED
        case ENDED
    }
    @Published var gameState = GAME_STATE.GETTING_READY
    {
        didSet
        {
            UIApplication.shared.isIdleTimerDisabled = gameState == .PLAYING
        }
    }
    
    @Published var currentPlayer = 1
    @Published var minutes = 0.0
    @Published var remainingSeconds = 0.0
    @Published var isTimerEnding = false
    @Published var isShowingPlace = false
    @Published var spyIndex1 = -1
    @Published var spyIndex2 = -1
    @Published var allSpies = false
    @Published var selectedPlace = ""
    
    @Published var proceedText = ""
    @Published var placeText = ""
    @Published var timerText = ""
    
    @Published var locations: [String] = []
    
    @Published var progressColors: [String] = ["2ecc71", "35cc6d", "3ecc69", "49cc64", "55cc5d", "61cc57", "70cc50", "7dcc48", "8dcc40", "9bcc39", "aacc32", "b8cc2a", "c5cb24", "d2ca1e", "dcc918", "e7c714", "eec510", "f1c20f", "f1c00f", "f1bd0f", "f1b80f", "f1b50f", "f1b10f", "f1ac0f", "f1a70f", "f1a211", "f19e13", "f19916", "ef9318", "ec8f1a", "ea8a1d", "e8861e", "e78221", "e67e22", "e67a24", "e67725", "e67327", "e66f28", "e66c2b", "e6692c", "e6662e", "e66230", "e65f31", "e65c34", "e75935", "e75736", "e85339", "e8513a", "e8503b", "e84e3d"]
    @Published var progressColorsIndex: Double = 0
    @Published var progressColorsStep: Double = 0
    
    public func loadPlaces(sortingEnabled: Bool)
    {
        let language = Locale.preferredLanguages[0].contains("el") ? "el" : "en"
        
        locations = []
        
        do
        {
            let array = try JSONSerialization.jsonObject(with:
                Data(contentsOf: URL(fileURLWithPath:
                    Bundle.main.path(forResource: "locations", ofType: "json")!)), options: .mutableContainers) as! [Any]
            
            for location in array
            {
                let locationsDict = location as! [String: Any]
                let type = locationsDict["type"] as! String
                if type == "basic" || type == "fantasy" && isFantasyOn || type == "nsfw" && isNSFWOn
                {
                    locations.append(locationsDict[language] as! String)
                }
            }
            
            if sortingEnabled
            {
                locations = locations.sorted { $0 < $1 }
            }
        } catch { }
    }
    
    public func setup(reloadPlaces: Bool)
    {
        if reloadPlaces || locations.isEmpty
        {
            loadPlaces(sortingEnabled: false)
        }
        
        selectedPlace = locations.remove(at: Int.random(in: 0..<locations.count))
        
        isShowingPlace = false
        
        minutes = numberOfPlayers == 4 ? 5 : numberOfPlayers + 2
        remainingSeconds = minutes * 60.0
        isTimerEnding = false
        
        allSpies = Int.random(in: 1...15) == 1
        
        spyIndex1 = Int.random(in: 1...Int(numberOfPlayers))
        
        if numberOfPlayers >= 10
        {
            repeat
            {
                spyIndex2 = Int.random(in: 1...Int(numberOfPlayers))
            }
            while spyIndex2 == spyIndex1
        }
        else
        {
            spyIndex2 = -1
        }
        
        currentPlayer = 1
        gameState = .GETTING_READY
        
        proceedText = "showLocation".localized()
        
        progressColorsIndex = 0
        progressColorsStep = Double(progressColors.count) / remainingSeconds
    }
    
    public func showWelcomePage()
    {
        currentPage = .WELCOME
    }
    
    public func showInfoPage()
    {
        currentPage = .INFO
    }
    
    public func showGamePage()
    {
        currentPage = .GAME
    }
    
    public func showLocationsPage()
    {
        currentPage = .LOCATIONS
    }
}
