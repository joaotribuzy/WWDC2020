//#-hidden-code
showClock()
currentPage = Page.first
sceneViewController.skScene.playButton.isHidden = true
for bt in sceneViewController.skScene.buttonsList{
    if bt == sceneViewController.skScene.firstButton{
        bt.isHidden = false
    }else {
        bt.isHidden = true
    }
}
sceneViewController.skScene.pointer.isHidden = true
//#-end-hidden-code
//#-code-completion(everything, hide)
/*:
**Rhythm:** Let's see this by other way...
 
 Hey! My name is João, and... let me tell you something

'Rhythm' is one of the three pilars of music('Harmony', 'Melody' and 'Rhythm') and commoly represented with others in a music score.
 
 'Rhythm' it's not just a element of music. We can found everywhere around us... in a heartbeat, **ticking of a clock**... So, 'Rhythm is a event repeting over time'
 
 But... let's do something... let's try to see a other way to "see" 'Rhythm' out of a music score

 I'll show you some tools to help you to make this.
 
 First, when you press *"Run my Code"*, you'll see a clock(Do you remember of our friend?) and a little circle that have a sound into then.
 
 To discover the sound of the circle, you can tap them...
 
 Try to drag the circle to one of positions of the clock. When you make this, you  are positioning a sound on a determinated beat of a rhythm... after you can go to [Next Page](@next)...
*/

