//
//  SliderWithMinMaxValues.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 22/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct SliderWithMinMaxValues: View
{
    @Binding var sliderValue: Double
    var minValue: Double
    var maxValue: Double
    var step: Double
    var accentColor: Color
    var intValues: Bool
    
    var body: some View
    {
        HStack()
        {
            Text(intValues ? "\(Int(minValue))" : "\(minValue)")
            
            Slider(value: $sliderValue, in: minValue...maxValue, step: step)
                .accentColor(accentColor)
            
            Text(intValues ? "\(Int(maxValue))" : "\(maxValue)")
        }
    }
}

struct SliderWithMinMaxValues_Previews: PreviewProvider
{
    static var previews: some View
    {
        SliderWithMinMaxValues(sliderValue: Binding.constant(4), minValue: 0, maxValue: 10, step: 1, accentColor: .black, intValues: true)
    }
}
