import SpriteKit

public class BeatButtonNode: SKShapeNode{
    public var previousPosition: CGPoint = CGPoint(x: 0, y: 0)
    public var initialPosition: CGPoint = CGPoint(x: 0, y: 0)
    public var soundElement: SoundElement? = nil
    public var previousNodePosition: PositionNode? = nil
    
    
}
