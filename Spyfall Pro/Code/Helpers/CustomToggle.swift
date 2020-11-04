//
//  CustomToggle.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 22/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct CustomToggle: View
{
    @Binding var isOn: Bool
    var label: String
    var accentColor: Color
    
    var body: some View
    {
        Toggle(isOn: $isOn)
        {
            Text(label)
        }
        .toggleStyle(SwitchToggleStyle(tint: accentColor))
        .fixedSize()
    }
}

struct CustomToggle_Previews: PreviewProvider
{
    static var previews: some View
    {
        CustomToggle(isOn: Binding.constant(true), label: "label", accentColor: .green)
    }
}
