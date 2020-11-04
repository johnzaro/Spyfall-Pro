//
//  String+Localized.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 28/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import Foundation

extension String
{
    func localized () -> String
    {
        return NSLocalizedString(self, comment: "")
    }

    func localizedWithParam (_ param: Int) -> String
    {
        return String(format: NSLocalizedString(self, comment: ""), param)
    }
}
