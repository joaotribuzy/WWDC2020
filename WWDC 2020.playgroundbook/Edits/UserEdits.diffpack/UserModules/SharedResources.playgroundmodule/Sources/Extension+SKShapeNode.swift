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
    
    public var file: URL{
        let bundle = Bundle.main
        switch self {
        case .kick:
            return bundle.url(forResource: "kick", withExtension: "mp3")!
        case .snare:
            return bundle.url(forResource: "snare", withExtension: "mp3")!
        case .hihat:
            return bundle.url(forResource: "hihat", withExtension: "mp3")!
        default:
            break 
        }
    }
}

extension RhythmGameScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        let frontTouchedNode = atPoint(location)
        playSoundElement(frontTouchedNode as! SKShapeNode)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        let frontTouchedNode = atPoint(location)
        
        moveNode(frontTouchedNode as! BeatButtonNode, touch: touch)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        let frontTouchedNode = atPoint(location)
        
        plugInPosition(frontTouchedNode as! BeatButtonNode, touch: touch)
    }
}

extension RhythmGameScene{
    public func setupPositionNodes(_ quantity: Int = 4){
        let radius: CGFloat = 250
        let numberOfCircle = quantity
        for i in 0...numberOfCircle {
            let circle = PositionNode(circleOfRadius: 10)
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

extension RhythmGameScene{
    public func moveNode(_ node: BeatButtonNode, touch: UITouch){
        guard buttonsList.contains(node) else {return}
        
        if node.frame.contains(touch.previousLocation(in: self)){
            node.position = touch.location(in: self)
        }
    }
    
    public func plugInPosition(_ node: BeatButtonNode, touch: UITouch){
        guard buttonsList.contains(node) else {return}
        
        guard clock.frame.contains(node.frame) else {
            node.position = node.initialPosition
            node.previousPosition = node.initialPosition
            node.previousNodePosition = nil
            return
        }
        
        var isInPosition = 0
        for posNode in positionNodes{
            if node.frame.contains(CGPoint(x: posNode.position.x, y: posNode.position.y - 100)) && posNode.isOcupped == false{
                node.position.x = posNode.position.x
                node.position.y = posNode.position.y - 100
                if node.previousNodePosition != nil{
                    node.previousNodePosition?.isOcupped = false
                    node.previousNodePosition?.occupedWith = nil
                }
                node.previousNodePosition = posNode
                node.previousPosition = node.position
                posNode.isOcupped = true
                posNode.occupedWith = node.soundElement
                isInPosition += 1
            } else if posNode.isOcupped == true{
//                  node.position = node.previousPosition
//                  refreshOccuped()
            }
        }
        if isInPosition == 0{
            node.position = node.previousPosition
        }
    }
    
    func refreshOccuped(){
        for pos in positionNodes{
            pos.isOcupped = false
            pos.occupedWith = nil
        }
        for button in buttonsList{
            for (index, pos) in positionNodes.enumerated(){
                if button.frame.contains(CGPoint(x: pos.position.x, y: pos.position.y - 100)){
                    positionNodes[index].isOcupped = true
                    positionNodes[index].occupedWith = button.soundElement
                } else{
//                      positionNodes[index].isOcupped = false
//                      positionNodes[index].occupedWith = nil
                }
            }
        }
    }
}

extension RhythmGameScene{
    public func playSoundElement(_ node: SKShapeNode){
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
