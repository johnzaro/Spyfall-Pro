//
//  CircularButton.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 22/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct CircularButton: View
{
    var radius: CGFloat
    var label: String
    var accentColor: Color
    var action: () -> Void
    
    var body: some View
    {
        Button(action: action)
        {
            ZStack()
            {
                Circle().fill(accentColor)
               
                Text(label)
            }
        }
        .frame(width: 2 * radius, height: 2 * radius)
        .buttonStyle(ButtonScaleOnPress())
    }
}

struct CircularButton_Previews: PreviewProvider
{
    static var previews: some View
    {
        CircularButton(radius: 50, label: "label", accentColor: .red, action: {})
    }
}
