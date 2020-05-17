import PlaygroundSupport
import UIKit

public var scene = RhythmGameViewController()

public func setup(){
    PlaygroundPage.current.needsIndefiniteExecution = true

    PlaygroundPage.current.setLiveView(scene)
}
