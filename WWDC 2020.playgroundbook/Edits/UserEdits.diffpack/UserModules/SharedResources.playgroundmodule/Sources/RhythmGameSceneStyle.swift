import SpriteKit

extension RhythmGameScene{
    public func setupButton(){
        addChild(firstButton)
        addChild(secondButton)
        addChild(thirdButton)
        setupButtonsStyle()
        setupButtonsPosition()
        setupButtonsName()
    }
    
    private func setupButtonsName(){
        firstButton.soundElement = SoundElement.kick
        secondButton.soundElement = SoundElement.hihat
        thirdButton.soundElement = SoundElement.snare
    }
    
    private func setupButtonsStyle(){
        firstButton.fillColor = .yellow
        firstButton.lineWidth = 0
        secondButton.fillColor = .green
        secondButton.lineWidth = 0
        thirdButton.fillColor = .blue
        thirdButton.lineWidth = 0
    }
    
    public func setupButtonsPosition(){
        firstButton.position = CGPoint(x: 0 - 200, y: 480 - 80)
        firstButton.previousPosition = firstButton.position
        firstButton.initialPosition = firstButton.position
        secondButton.position = CGPoint(x: 0, y: 480 - 80)
        secondButton.previousPosition = secondButton.position
        secondButton.initialPosition = secondButton.position
        thirdButton.position = CGPoint(x: 0 + 200, y: 480 - 80)
        thirdButton.previousPosition = thirdButton.position
        thirdButton.initialPosition = thirdButton.position
        
        for btn in buttonsList{
            btn.zPosition = 3
        }
    }
}

extension RhythmGameScene{
    public func setupClock(){
        setupClockStyle()
        setupClockPosition()
    }
    
    private func setupClockStyle(){
        clock.fillColor = .red
        clock.lineWidth = 0
    }
    
    private func setupClockPosition(){
        clock.position = CGPoint(x: 0, y: 0 - 100)
        addChild(clock)
    }
}

extension RhythmGameScene{
    public func setupPointer(){
        addChild(pointer)
        setupPointerPosition()
        setupPointerStyle()
    }
    
    private func setupPointerPosition(){
        pointer.position = CGPoint(x: 0, y: -100)
        pointer.anchorPoint = CGPoint(x: 0.5, y: 0)
        pointer.zPosition = 5
    }
    
    private func setupPointerStyle(){
    }
}

extension RhythmGameScene{
    public func setupPlayButton(){
        setupButtonPlayPosition()
        setupButtonPlayStyle()
    }
    
    private func setupButtonPlayPosition(){
        playButton.position = CGPoint(x: 0 + 200, y: 480 - 200)
        addChild(playButton)
    }
    
    private func setupButtonPlayStyle(){
        playButton.fillColor = .link
        playButton.lineWidth = 0
    }
}

extension RhythmGameScene{
    public func setupPositionNodes(_ quantity: Int = 8){
        let radius: CGFloat = 250
        let numberOfCircle = quantity
        
        for i in -2...numberOfCircle - 3 {
            let circle = PositionNode(circleOfRadius: 10)
            circle.strokeColor = .clear
            circle.fillColor = .cyan
            circle.name = String(format:"circle%d",i)
            let angle = -2 * Double.pi / Double(numberOfCircle) * Double(i)
            
            let circleX = radius * cos(CGFloat(angle))
            let circleY = radius * sin(CGFloat(angle))
            
            circle.position = CGPoint(x:circleX + frame.midX, y:circleY + frame.midY)
            
            positionNodes.append(circle)
            clock.addChild(circle)
        }
    }
}


