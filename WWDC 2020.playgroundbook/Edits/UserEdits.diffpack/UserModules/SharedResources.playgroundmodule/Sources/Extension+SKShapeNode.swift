import SpriteKit
import UIKit

enum SoundElement{
    case kick
    case snare
    case hihat
    public var description: String {
        switch self {
        case .kick: return "kick"
        case .snare: return "snare"
        case .hihat: return "hihat"
        }
    }
}

extension RhythmGameScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        let frontTouchedNode = atPoint(location).name
        
        // TODO: play audio
        
    }
}
