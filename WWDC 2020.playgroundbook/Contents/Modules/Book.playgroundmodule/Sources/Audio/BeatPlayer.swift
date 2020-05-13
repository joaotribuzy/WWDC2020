import AVFoundation

public enum Beat{
    case kick
    case snare
    case hihat
    
    var file: URL{
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
public class BeatPlayer {
    var audioFiles: [AVAudioFile] = []
    var engine: AVAudioEngine
    var audioAudioNodes = [AVAudioPlayerNode]()
    var mixer: AVAudioMixerNode
    var urls: [Beat] = []
    
    public init (urls: [Beat] = []) {
        audioFiles = urls.map { try! AVAudioFile(forReading: $0.file) }
        
        engine = AVAudioEngine()
        mixer = AVAudioMixerNode()
        
        engine.attach(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        self.urls = urls
        for _ in audioFiles {
            audioAudioNodes += [AVAudioPlayerNode()]
        }
    }
    
    public func start() {
        try! engine.start()
        
        for node in audioAudioNodes {
            engine.attach(node)
            engine.connect(node, to: mixer, format: nil)
        }
        try! engine.start()
    }
    
    public func playBeat(withIndex: Int){
        DispatchQueue.global().async{ [unowned self] in
            let node = self.audioAudioNodes[withIndex]
            node.stop()
            node.scheduleFile(self.audioFiles[withIndex], at: nil, completionHandler: nil)
            node.play()
        }
    }
    
    
}

