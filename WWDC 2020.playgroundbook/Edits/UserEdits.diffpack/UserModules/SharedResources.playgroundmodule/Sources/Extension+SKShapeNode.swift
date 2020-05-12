import SpriteKit
import UIKit
import AVFoundation
import PlaygroundSupport

public enum SoundElement{
    case kick
    case snare
    case hihat
    public var description: String {
        switch self {
        case .kick: return "kick"
        case .hihat: return "hihat"
        case .snare: return "snare"
        }
    }
}

extension RhythmGameScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        let frontTouchedNode = atPoint(location)
        
        playSoundElement(frontTouchedNode)
        
        scaleDown(frontTouchedNode)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        let frontTouchedNode = atPoint(location)
        
        scaleUp(frontTouchedNode)
    }
    
    public func playSoundElement(_ node: SKNode){
        switch node.name {
        case SoundElement.kick.description:
            audioPlayer.playBeat(withIndex: 0)
        case SoundElement.hihat.description:
            audioPlayer.playBeat(withIndex: 1)
        case SoundElement.snare.description:
            audioPlayer.playBeat(withIndex: 2)
        default:
            break 
        }
    }
    
    func scaleDown(_ node: SKNode) {
        let scaleDownAction = SKAction.scale(to: 0.7, duration: 0.3)
        node.run(scaleDownAction)
    }
    func scaleUp(_ node: SKNode){
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        node.run(scaleDownAction)
    }
}

