//
//  TitleWithVariable.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 22/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import SwiftUI

struct TitleWithVariable: View
{
    var title: String
    var variable: String
    
    var body: some View
    {
        HStack(spacing: 0)
        {
            Text(title).underline()
            
            Text(variable)
        }
    }
}

struct TitleWithVariable_Previews: PreviewProvider
{
    static var previews: some View
    {
        TitleWithVariable(title: "Title", variable: "Variable")
    }
}
