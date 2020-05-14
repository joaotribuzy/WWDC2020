import AVFoundation

public class BeatPlayer {
    var audioFiles: [AVAudioFile] = []
    var engine: AVAudioEngine
    var audioAudioNodes = [AVAudioPlayerNode]()
    var mixer: AVAudioMixerNode
    var urls: [SoundElement] = []
    
    public init (urls: [SoundElement] = []) {
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
    
    public func playSequence(compassTempo: Double, numberOfPositionNodes: Int, sequence: [SoundElement]){
        for element in sequence{
            switch element{
            case SoundElement.kick:
                  playBeat(withIndex: 0)
              case SoundElement.snare:
                  playBeat(withIndex: 1)
              case SoundElement.hihat:
                  playBeat(withIndex: 2)
              default:
                  break
              }
              sleep(UInt32(compassTempo / Double(numberOfPositionNodes)))
          }
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


