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
        firstButton.name = SoundElement.kick.description
        secondButton.name = SoundElement.snare.description
        thirdButton.name = SoundElement.hihat.description
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
        secondButton.position = CGPoint(x: 0, y: 480 - 80)
        thirdButton.position = CGPoint(x: 0 + 200, y: 480 - 80)
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


