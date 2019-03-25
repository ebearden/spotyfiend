//
//  SpotifyConstants.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

public struct SpotifyConstants {
    public static let clientId = "ca782dd19fb04c61af14c4d3147e6cd9"
    public static let clientSecret = "2f3a94e3cf7847b3b8228307c412ef87"
    public static let redirectUrl = "spotyfiend://spotify-login-callback"
    public static let tokenSwapUrl = URL(string: "https://spotyfiend-token-service.herokuapp.com/api/token")!
    public static let tokenRefreshUrl = URL(string: "https://spotyfiend-token-service.herokuapp.com/api/refresh_token")!
}
