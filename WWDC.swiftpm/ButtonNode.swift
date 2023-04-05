//
//  ButtonNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 04/04/23.
//

import Foundation
import SpriteKit

enum ButtonType {
    case play, about
}

class ButtonNode: SKSpriteNode {
    let buttonAnimation : [SKTexture] = [
        SKTexture(imageNamed: "buttonPlay0"),
        SKTexture(imageNamed: "buttonPlay1"),
        SKTexture(imageNamed: "buttonPlay2")
    ]
    
    let buttonAboutAnimation : [SKTexture] = [
        SKTexture(imageNamed: "buttonAbout0"),
        SKTexture(imageNamed: "buttonAbout1"),
        SKTexture(imageNamed: "buttonAbout2"),
    ]
    let action: () -> Void
    
    init(buttonType: ButtonType, action : @escaping () -> Void){
        var texture : SKTexture
        var textureAnimation: [SKTexture]
        
        switch buttonType {
        case .play :
            texture = buttonAnimation[0]
            textureAnimation = buttonAnimation
        case .about :
            texture = buttonAboutAnimation[0]
            textureAnimation = buttonAboutAnimation
        }
        
        self.action = action
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        run(.repeatForever(.animate(with: textureAnimation, timePerFrame: 0.1)))
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
}
