//
//  RectanglularButton.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 22/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct RoundedRectanglularButton: View
{
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var label: String
    var accentColor: Color
    var action: () -> Void
    
    var body: some View
    {
        Button(action: action)
        {
            ZStack()
            {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(accentColor)
                    .frame(width: width, height: height)
                
                Text(label)
            }
        }
        .buttonStyle(ButtonScaleOnPress())
    }
}

struct RectanglularButton_Previews: PreviewProvider
{
    static var previews: some View
    {
        RoundedRectanglularButton(width: 100, height: 50, cornerRadius: 50, label: "label", accentColor: .red, action: {})
    }
}
