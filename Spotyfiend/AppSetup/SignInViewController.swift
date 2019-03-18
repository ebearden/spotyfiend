//
//  SignInViewController.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/14/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

protocol SignInDelegate: class {
    func signInSuccessful(user: User)
}

class SignInViewController: UIViewController {
    weak var delegate: SignInDelegate?
    
    init() {
        super.init(nibName: String(describing: SignInViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension SignInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension SignInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil, let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            guard error == nil, let user = authResult?.user else { return }
            self.delegate?.signInSuccessful(user: user)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

extension SignInViewController: GIDSignInUIDelegate {
    
}
