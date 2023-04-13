//
//  ButtonNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 04/04/23.
//

import Foundation
import SpriteKit

enum ButtonType {
    case play, about, arrowRight, playAgain
}

class ButtonNode: SKSpriteNode {
    
    let action: () -> Void
    
    init(buttonType: ButtonType, action : @escaping () -> Void){
        var texture : SKTexture
        var textureAnimation: [SKTexture]
        
        switch buttonType {
        case .play :
            let buttonAnimation : [SKTexture] = [
                SKTexture(imageNamed: "buttonPlay0"),
                SKTexture(imageNamed: "buttonPlay1"),
                SKTexture(imageNamed: "buttonPlay2")
            ]
            
            texture = buttonAnimation[0]
            textureAnimation = buttonAnimation
        case .about :
            
            let buttonAnimation : [SKTexture] = [
                SKTexture(imageNamed: "buttonAbout0"),
                SKTexture(imageNamed: "buttonAbout1"),
                SKTexture(imageNamed: "buttonAbout2"),
            ]
            
            texture = buttonAnimation[0]
            textureAnimation = buttonAnimation
        case .arrowRight:
            let buttonAnimation : [SKTexture] = [
                SKTexture(imageNamed: "arrow0"),
                SKTexture(imageNamed: "arrow1"),
                SKTexture(imageNamed: "arrow2"),
            ]
            
            texture = buttonAnimation[0]
            textureAnimation = buttonAnimation
        case .playAgain:
            let buttonAnimation : [SKTexture] = [
                SKTexture(imageNamed: "buttonPlayAgain0"),
                SKTexture(imageNamed: "buttonPlayAgain1"),
                SKTexture(imageNamed: "buttonPlayAgain2"),
            ]
            
            texture = buttonAnimation[0]
            textureAnimation = buttonAnimation
        }
        
        self.action = action
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        run(.doodleEffect(with: textureAnimation))
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
}
