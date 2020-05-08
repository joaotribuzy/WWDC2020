import SpriteKit

public class RhythmGameScene: SKScene{
    internal let firstButton = SKShapeNode(circleOfRadius: 60)
    internal let secondButton = SKShapeNode(circleOfRadius: 60)
    internal let thirdButton = SKShapeNode(circleOfRadius: 60)
    
    internal let clock = SKShapeNode(circleOfRadius: 300)
    
    override public func didMove(to view: SKView) {
        backgroundColor = .purple
        setupButton()
        setupClock()
    }
}
extension RhythmGameScene{
    private func setupButton(){
        setupButtonsStyle()
        setupButtonsPosition()
    }
    
    private func setupButtonsStyle(){
        firstButton.fillColor = .yellow
        secondButton.fillColor = .green
        thirdButton.fillColor = .blue
    }
    
    private func setupButtonsPosition(){
        firstButton.position = CGPoint(x: 0 - 200, y: 480 - 80)
        addChild(firstButton)
        
        secondButton.position = CGPoint(x: 0, y: 480 - 80)
        addChild(secondButton)
        
        thirdButton.position = CGPoint(x: 0 + 200, y: 480 - 80)
        addChild(thirdButton)
    }
}

extension RhythmGameScene{
    private func setupClock(){
        setupClockStyle()
        setupClockPosition()
    }
    
    private func setupClockStyle(){
        clock.fillColor = .red
    }
    
    private func setupClockPosition(){
        clock.position = CGPoint(x: 0, y: 0 - 100)
        addChild(clock)
    }
}
