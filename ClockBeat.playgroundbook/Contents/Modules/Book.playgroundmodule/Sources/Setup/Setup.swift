import PlaygroundSupport
import UIKit

public var sceneViewController = RhythmGameViewController()

/// Show a circular representation of Rhythm
public func showClock(){
    PlaygroundPage.current.needsIndefiniteExecution = true

    PlaygroundPage.current.setLiveView(sceneViewController)
}
