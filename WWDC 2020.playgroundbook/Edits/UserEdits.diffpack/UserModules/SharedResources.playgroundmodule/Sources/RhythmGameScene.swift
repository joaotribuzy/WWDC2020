import SpriteKit

public class RhythmGameScene: SKScene{
    public let firstButton = BeatButtonNode(circleOfRadius: 30)
    public let secondButton = BeatButtonNode(circleOfRadius: 30)
    public let thirdButton = BeatButtonNode(circleOfRadius: 30)
    public let fourthButton = BeatButtonNode(circleOfRadius: 30)
    
    public let firstButtonDown = BeatButtonNode(circleOfRadius: 30)
    public let secondButtonDown = BeatButtonNode(circleOfRadius: 30)
    public let thirdButtonDown = BeatButtonNode(circleOfRadius: 30)
    public let fourthButtonDown = BeatButtonNode(circleOfRadius: 30)
    
    public var buttonsList: [BeatButtonNode] = [] 
    public let clock = SKShapeNode(circleOfRadius: 300)
    
    public var timeOfSequence: TimeInterval = 1.5
    public var numberOfSpaces: Int = 8
    
    public var pointer = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 280))
    
    public var positionNodes: [PositionNode] = []
    
    public var playButton: SKShapeNode = SKShapeNode(circleOfRadius: 50)
    
    public let audioPlayer = BeatPlayer(urls: [.kick, .hihat, .snare, .cowbell, .conga, .conga2])
    
    override public func didMove(to view: SKView) {
        backgroundColor = .purple
        audioPlayer.start()
        setupClock()
        setupButton()
        setupPositionNodes(numberOfSpaces)
        setupPlayButton()
        setupPointer()
        
    }
}


