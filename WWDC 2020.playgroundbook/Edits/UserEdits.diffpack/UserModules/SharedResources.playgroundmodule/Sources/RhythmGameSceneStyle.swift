import SpriteKit

extension RhythmGameScene{
    public func setupButton(){
        addChild(firstButton)
        addChild(secondButton)
        addChild(thirdButton)
        addChild(fourthButton)
        
        buttonsList.append(firstButton)
        buttonsList.append(secondButton)
        buttonsList.append(thirdButton)
        buttonsList.append(fourthButton)
        
        addChild(firstButtonDown)
        addChild(secondButtonDown)
        addChild(thirdButtonDown)
        addChild(fourthButtonDown)
        
        buttonsList.append(firstButtonDown)
        buttonsList.append(secondButtonDown)
        buttonsList.append(thirdButtonDown)
        buttonsList.append(fourthButtonDown)
        
        setupButtonsStyle()
        setupButtonsPosition()
        setupButtonsName()
    }
    
    private func setupButtonsName(){
        firstButton.soundElement = SoundElement.kick
        secondButton.soundElement = SoundElement.hihat
        thirdButton.soundElement = SoundElement.snare
        fourthButton.soundElement = SoundElement.hihat
        
        firstButtonDown.soundElement = SoundElement.kick
        secondButtonDown.soundElement = SoundElement.hihat
        thirdButtonDown.soundElement = SoundElement.snare
        fourthButtonDown.soundElement = SoundElement.hihat
    }
    
    private func setupButtonsStyle(){
        firstButton.fillColor = .yellow
        firstButton.lineWidth = 0
        secondButton.fillColor = .green
        secondButton.lineWidth = 0
        thirdButton.fillColor = .blue
        thirdButton.lineWidth = 0
        fourthButton.fillColor = .brown
        fourthButton.lineWidth = 0
        
        firstButtonDown.fillColor = .yellow
        firstButtonDown.lineWidth = 0
        secondButtonDown.fillColor = .green
        secondButtonDown.lineWidth = 0
        thirdButtonDown.fillColor = .blue
        thirdButtonDown.lineWidth = 0
        fourthButtonDown.fillColor = .brown
        fourthButtonDown.lineWidth = 0
    }
    
    public func setupButtonsPosition(){
        firstButton.position = CGPoint(x: -266, y: 480 - 150)
        firstButton.previousPosition = firstButton.position
        firstButton.initialPosition = firstButton.position
        secondButton.position = CGPoint(x: -89, y: 480 - 150)
        secondButton.previousPosition = secondButton.position
        secondButton.initialPosition = secondButton.position
        thirdButton.position = CGPoint(x: 89, y: 480 - 150)
        thirdButton.previousPosition = thirdButton.position
        thirdButton.initialPosition = thirdButton.position
        fourthButton.position = CGPoint(x: 266, y: 480 - 150)
        fourthButton.previousPosition = fourthButton.position
        fourthButton.initialPosition = fourthButton.position
        
        firstButtonDown.position = CGPoint(x: -266, y: -480)
        firstButtonDown.previousPosition = firstButton.position
        firstButtonDown.initialPosition = firstButton.position
        secondButtonDown.position = CGPoint(x: -89, y: -480)
        secondButtonDown.previousPosition = secondButton.position
        secondButtonDown.initialPosition = secondButton.position
        thirdButtonDown.position = CGPoint(x: 89, y: -480)
        thirdButtonDown.previousPosition = thirdButton.position
        thirdButtonDown.initialPosition = thirdButton.position
        fourthButtonDown.position = CGPoint(x: 266, y: -480)
        fourthButtonDown.previousPosition = fourthButton.position
        fourthButtonDown.initialPosition = fourthButton.position
        
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
    
    public func setupPointerPosition(){
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
        playButton.position = CGPoint(x: 0, y: 480 - 25)
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


