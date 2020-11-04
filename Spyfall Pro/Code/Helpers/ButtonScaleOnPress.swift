//
//  File.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 23/10/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct ButtonScaleOnPress: ButtonStyle
{
    func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .animation(nil)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(Animation.easeInOut(duration: 0.05))
    }
}
