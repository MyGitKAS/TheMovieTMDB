//
//  Constants.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 4.03.24.
//

import UIKit

struct Constants {
    static let mainColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
    static let elementCornerRadius: CGFloat = 10
}

enum TextSize {
    case small
    case medium
    case large
    case extraLarge

    func getSize() -> CGFloat {
        switch self {
        case .small:
            return 10
        case .medium:
            return 14
        case .large:
            return 18
        case .extraLarge:
            return 25
        }
    }
}
