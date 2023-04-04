//
//  ButtonNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 04/04/23.
//

import Foundation
import SpriteKit
 
class ButtonNode: SKSpriteNode {
    let buttonTexture: SKTexture
    let action: () -> Void
    
    init(buttonTexture: String, action : @escaping () -> Void){
        self.buttonTexture = SKTexture(imageNamed: buttonTexture)
        self.buttonTexture.filteringMode = .nearest
        self.action = action
        
        super.init(texture: self.buttonTexture, color: .clear, size: self.buttonTexture.size())
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
}
