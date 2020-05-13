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
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        let frontTouchedNode = atPoint(location)
        
        playSoundElement(frontTouchedNode)
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        let frontTouchedNode = atPoint(location)
        
        guard frontTouchedNode == firstButton else {return}
        
        if frontTouchedNode.frame.contains(touch.previousLocation(in: self)){
            frontTouchedNode.position = touch.location(in: self)
        }
        
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        let frontTouchedNode = atPoint(location)
        
        guard frontTouchedNode == firstButton else {return}
        
        print(frontTouchedNode.frame)
        
        var isInPosition = 0
        for posNode in positionNodes{
            print(posNode)
            print(frontTouchedNode)
            if frontTouchedNode.frame.contains(CGPoint(x: posNode.position.x, y: posNode.position.y - 100)){
                frontTouchedNode.position.x = posNode.position.x
                frontTouchedNode.position.y = posNode.position.y - 100
                print("vai")
                isInPosition += 1
            } 
        }
        if isInPosition == 0{
            setupButtonsPosition()
        }
        
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
}

extension RhythmGameScene{
    public func setupPositionNodes(_ quantity: Int = 4){
        let radius: CGFloat = 250
        let numberOfCircle = quantity
        for i in 0...numberOfCircle {
            let circle = SKShapeNode(circleOfRadius: 10)
            circle.strokeColor = .clear
            circle.fillColor = .cyan
            circle.name = String(format:"circle%d",i)
            let angle = 2 * Double.pi / Double(numberOfCircle) * Double(i)
            
            let circleX = radius * cos(CGFloat(angle))
            let circleY = radius * sin(CGFloat(angle))
            
            circle.position = CGPoint(x:circleX + frame.midX, y:circleY + frame.midY)
            
            positionNodes.append(circle)
            clock.addChild(circle)
            positionNodes.first!.fillColor = .systemPink
        }
    }
}
