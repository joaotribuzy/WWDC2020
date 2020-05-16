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
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            if playButton.contains(location){
                if audioPlayer.isPlaying == false{
                    audioPlayer.isPlaying = true
                    audioPlayer.playSequence(sequence: positionNodes, totalTime: timeOfSequence, quantity: 8)
                    rotatePointer()
                } else{
                    audioPlayer.isPlaying = false
                    audioPlayer.stop()
                    audioPlayer.start()
                    stopPointer()
                }
            }
            playOnce(location)
        }
        
    }
    
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            moveNode(location)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            plugInPosition(location)
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            plugInPosition(location)
        }
        
    }
}

extension RhythmGameScene{
    public func moveNode(_ location: CGPoint){
        if firstButton.contains(location){
            firstButton.zPosition = 4
            if firstButton.intersects(secondButton) || firstButton.intersects(thirdButton) || firstButton.intersects(fourthButton){
                firstButton.position = firstButton.initialPosition
                firstButton.previousPosition = firstButton.initialPosition
                firstButton.previousNodePosition = nil
            }else{
                firstButton.position = location
            }
            
        } else if secondButton.contains(location){
            secondButton.zPosition = 4
            if secondButton.intersects(firstButton) || secondButton.intersects(thirdButton) || secondButton.intersects(fourthButton){
                secondButton.position = secondButton.initialPosition
                secondButton.previousPosition = secondButton.initialPosition
                secondButton.previousNodePosition = nil
            }else{
                secondButton.position = location
            }

        } else if thirdButton.contains(location){
            thirdButton.zPosition = 4
            if thirdButton.intersects(firstButton) || thirdButton.intersects(secondButton) || thirdButton.intersects(fourthButton){
                thirdButton.position = thirdButton.initialPosition
                thirdButton.previousPosition = thirdButton.initialPosition
                thirdButton.previousNodePosition = nil
            } else {
                thirdButton.position = location
            }
        } else if fourthButton.contains(location){
            fourthButton.zPosition = 4
            if fourthButton.intersects(firstButton) || fourthButton.intersects(secondButton) || fourthButton.intersects(thirdButton){
                fourthButton.position = fourthButton.initialPosition
                fourthButton.previousPosition = fourthButton.initialPosition
                fourthButton.previousNodePosition = nil
            }else{
                fourthButton.position = location
            }
        }
    }
    
    public func plugInPosition(_ location: CGPoint){
        var node: BeatButtonNode? = nil
        
        if firstButton.contains(location){
            node = firstButton
        } else if secondButton.contains(location){
            node = secondButton
        } else if thirdButton.contains(location){
            node = thirdButton
        } else if fourthButton.contains(location){
            node = fourthButton
        }
        
        guard node != nil else {return}
        
        guard clock.frame.contains(location) else {
            node?.position = node!.initialPosition
            node?.previousPosition = node!.initialPosition
            node?.previousNodePosition = nil
            return
        }
        
        var isInPosition = 0
        for posNode in positionNodes{
            if (node?.frame.contains(CGPoint(x: posNode.position.x, y: posNode.position.y - 100)))! && posNode.isOcupped != true{
                node?.position.x = posNode.position.x
                node?.position.y = posNode.position.y - 100
                refreshOccupedPositions()
                node?.previousNodePosition?.isOcupped = false
                node?.previousNodePosition?.occupedWith = nil
                node?.previousNodePosition = posNode
                node?.previousPosition = node!.position
                posNode.isOcupped = true
                posNode.occupedWith = node!.soundElement
                isInPosition += 1
            } 
        }
        if isInPosition == 0{
            node?.position = node!.previousPosition
        }
    }
}

extension RhythmGameScene{
    private func refreshOccupedPositions(){
        for pos in positionNodes{
            if pos.intersects(firstButton) {
                pos.isOcupped = true
                pos.occupedWith = firstButton.soundElement
            } else if pos.intersects(secondButton){
                pos.isOcupped = true
                pos.occupedWith = secondButton.soundElement
            }else if pos.intersects(thirdButton){
                pos.isOcupped = true
                pos.occupedWith = thirdButton.soundElement
            }
        }
    }
}

extension RhythmGameScene{
    public func playOnce(_ location: CGPoint){
        if firstButton.contains(location){
            playSoundElement(SoundElement.kick)
        } else if secondButton.contains(location){
            playSoundElement(SoundElement.hihat)
        } else if thirdButton.contains(location){
            playSoundElement(SoundElement.snare)
        } else if fourthButton.contains(location){
            playSoundElement(SoundElement.hihat)
        }
    }
    public func playSoundElement(_ element: SoundElement){
        switch element {
        case SoundElement.kick:
            audioPlayer.playBeat(withIndex: 0)
        case SoundElement.hihat:
            audioPlayer.playBeat(withIndex: 1)
        case SoundElement.snare:
            audioPlayer.playBeat(withIndex: 2)
        default:
            break 
        }
    }
    
    private func rotatePointer(){
        let rotate = SKAction.rotate(byAngle: CGFloat(-2 * Double.pi), duration: timeOfSequence)
        let repeatForever = SKAction.repeatForever(SKAction.sequence([rotate]))
        pointer.run(repeatForever)
    }
    
    private func stopPointer(){
        pointer.removeAllActions()
        pointer.removeFromParent()
        pointer = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 280))
        setupPointer()
    }
}
