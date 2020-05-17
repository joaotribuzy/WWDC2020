import UIKit
import Foundation

public enum SoundElement{
    case kick
    case snare
    case hihat
    case cowbell
    case conga
    case conga2
    
    public var description: String {
        switch self {
        case .kick: return "kick"
        case .hihat: return "hihat"
        case .snare: return "snare"
        case .cowbell: return "cowbell"
        case .conga: return "conga"
        case .conga2: return "conga2"
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
        case .cowbell:
            return bundle.url(forResource: "cowbell", withExtension: "mp3")!
        case .conga:
            return bundle.url(forResource: "conga", withExtension: "mp3")!
        case .conga2:
            return bundle.url(forResource: "conga2", withExtension: "mp3")!
        default:
            break
        }
    }
}
