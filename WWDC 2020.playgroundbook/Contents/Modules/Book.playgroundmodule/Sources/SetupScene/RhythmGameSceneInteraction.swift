import SpriteKit
import UIKit
import AVFoundation
import PlaygroundSupport

extension RhythmGameScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            if playButton.contains(location){
                if audioPlayer.isPlaying == false{
                    if currentPage != Page.second{
                        disableInteractionNodes()
                    }
                    audioPlayer.isPlaying = true
                    audioPlayer.playSequence(sequence: positionNodes, totalTime: timeOfSequence, quantity: 8)
                    rotatePointer()
                } else{
                    if currentPage != Page.second{
                        enableInteractionNodes()
                    }
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
        
        
        
        
        if firstButtonDown.contains(location){
            firstButtonDown.zPosition = 4
            if firstButtonDown.intersects(secondButtonDown) || firstButtonDown.intersects(thirdButtonDown) || firstButton.intersects(fourthButtonDown) || firstButtonDown.intersects(firstButton) || firstButtonDown.intersects(secondButton) || firstButtonDown.intersects(thirdButton) || firstButtonDown.intersects(fourthButton){
                firstButtonDown.position = firstButtonDown.initialPosition
                firstButtonDown.previousPosition = firstButtonDown.initialPosition
                firstButtonDown.previousNodePosition = nil
            }else{
                firstButtonDown.position = location
            }
            
        } else if secondButtonDown.contains(location){
            secondButtonDown.zPosition = 4
            if secondButtonDown.intersects(firstButtonDown) || secondButton.intersects(thirdButtonDown) || secondButton.intersects(fourthButtonDown) || secondButtonDown.intersects(firstButton) || secondButtonDown.intersects(secondButton) || secondButtonDown.intersects(thirdButton) || secondButtonDown.intersects(fourthButton){
                secondButtonDown.position = secondButtonDown.initialPosition
                secondButtonDown.previousPosition = secondButtonDown.initialPosition
                secondButtonDown.previousNodePosition = nil
            }else{
                secondButtonDown.position = location
            }
            
        } else if thirdButtonDown.contains(location){
            thirdButtonDown.zPosition = 4
            if thirdButtonDown.intersects(firstButton) || thirdButtonDown.intersects(secondButtonDown) || thirdButtonDown.intersects(fourthButtonDown) || thirdButtonDown.intersects(firstButton) || thirdButtonDown.intersects(secondButton) || thirdButtonDown.intersects(thirdButton) || thirdButtonDown.intersects(fourthButton){
                thirdButtonDown.position = thirdButtonDown.initialPosition
                thirdButtonDown.previousPosition = thirdButtonDown.initialPosition
                thirdButtonDown.previousNodePosition = nil
            } else {
                thirdButtonDown.position = location
            }
        } else if fourthButtonDown.contains(location){
            fourthButtonDown.zPosition = 4
            if fourthButtonDown.intersects(firstButtonDown) || fourthButtonDown.intersects(secondButtonDown) || fourthButtonDown.intersects(thirdButtonDown) || fourthButtonDown.intersects(firstButton) || fourthButtonDown.intersects(secondButton) || fourthButtonDown.intersects(thirdButton) || fourthButtonDown.intersects(fourthButton){
                fourthButtonDown.position = fourthButtonDown.initialPosition
                fourthButtonDown.previousPosition = fourthButtonDown.initialPosition
                fourthButtonDown.previousNodePosition = nil
            }else{
                fourthButtonDown.position = location
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
        } else if firstButtonDown.contains(location){
            node = firstButtonDown
        } else if secondButtonDown.contains(location){
            node = secondButtonDown
        } else if thirdButtonDown.contains(location){
            node = thirdButtonDown
        } else if fourthButtonDown.contains(location){
            node = fourthButtonDown
        }
        
        guard node != nil else {return}
        
        guard clock.frame.contains(location) else {
            node?.previousNodePosition?.isOcupped = false
            node?.previousNodePosition?.occupedWith = nil
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
            } else if pos.intersects(fourthButton){
                pos.isOcupped = true
                pos.occupedWith = fourthButton.soundElement
            }else if pos.intersects(firstButtonDown) {
                pos.isOcupped = true
                pos.occupedWith = firstButtonDown.soundElement
            } else if pos.intersects(secondButtonDown){
                pos.isOcupped = true
                pos.occupedWith = secondButtonDown.soundElement
            }else if pos.intersects(thirdButtonDown){
                pos.isOcupped = true
                pos.occupedWith = thirdButtonDown.soundElement
            } else if pos.intersects(fourthButtonDown){
                pos.isOcupped = true
                pos.occupedWith = fourthButtonDown.soundElement
            }
        }
    }
    
    func enableInteractionNodes(){
        for btn in buttonsList{
            if btn.position == btn.initialPosition{
                btn.isHidden = false
            }
        }
    }
    
    func disableInteractionNodes(){
        for btn in buttonsList{
            if btn.position == btn.initialPosition{
                btn.isHidden = true
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
        } else if firstButtonDown.contains(location){
            playSoundElement(SoundElement.kick)
        } else if secondButtonDown.contains(location){
            playSoundElement(SoundElement.cowbell)
        } else if thirdButtonDown.contains(location){
            playSoundElement(SoundElement.conga)
        } else if fourthButtonDown.contains(location){
            playSoundElement(SoundElement.conga2)
        }
    }
    public func playSoundElement(_ element: SoundElement){
        switch element {
        case SoundElement.kick: audioPlayer.playBeat(withIndex: 0)
        case SoundElement.hihat: audioPlayer.playBeat(withIndex: 1)
        case SoundElement.snare: audioPlayer.playBeat(withIndex: 2)
        case SoundElement.cowbell: audioPlayer.playBeat(withIndex: 3)
        case SoundElement.conga: audioPlayer.playBeat(withIndex: 4)
        case SoundElement.conga2: audioPlayer.playBeat(withIndex: 5)
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
