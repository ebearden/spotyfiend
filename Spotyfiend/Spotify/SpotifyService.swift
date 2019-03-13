//
//  SpotifyService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

final class SpotifyService: NSObject {
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "SpotifyService_AccessToken")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SpotifyService_AccessToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    var completion: ((_ success: Bool) -> Void)?
    
    lazy var configuration = SPTConfiguration(clientID: SpotifyConstants.clientId, redirectURL: SpotifyConstants.redirectUrl)
    
    lazy var sessionManager: SPTSessionManager = {
        configuration.tokenSwapURL = SpotifyConstants.tokenSwapUrl
        configuration.tokenRefreshURL = SpotifyConstants.tokenRefreshUrl
        
        return SPTSessionManager(configuration: configuration, delegate: self)
    }()
    
    func authenticate(completion: @escaping (_ success: Bool) -> Void) {
        self.completion = completion
        let requestedScopes: SPTScope = [.playlistReadPrivate]
        sessionManager.initiateSession(with: requestedScopes, options: .default)
    }
}

extension SpotifyService: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Success", session)
        accessToken = session.accessToken
        DispatchQueue.main.async {
            self.completion?(true)
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failure", error)
        DispatchQueue.main.async {
            self.completion?(false)
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Renew", session)
        accessToken = session.accessToken
        DispatchQueue.main.async {
            self.completion?(true)
        }
    }
}
