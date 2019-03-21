//
//  TextInputAccessoryView.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/21/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class TextInputAccessoryView: UIView, NibFileOwnerLoadable {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var sendButtonAction: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        if textView.text.hasSuffix("\n") {
            textView.text.removeLast()
        }
        
        if textView.text.hasSuffix(" ") {
            textView.text.removeLast()
        }
        
        sendButtonAction?()
        textView.text = nil
    }
}
