# CS3217 Problem Set 4

**Name:** Lee Yong Ler

**Matric No:** A0219859J


## Tips
1. CS3217's docs is at https://cs3217.github.io/cs3217-docs. Do visit the docs often, as
   it contains all things relevant to CS3217.
2. A Swiftlint configuration file is provided for you. It is recommended for you
   to use Swiftlint and follow this configuration. We opted in all rules and
   then slowly removed some rules we found unwieldy; as such, if you discover
   any rule that you think should be added/removed, do notify the teaching staff
   and we will consider changing it!

   In addition, keep in mind that, ultimately, this tool is only a guideline;
   some exceptions may be made as long as code quality is not compromised.
3. Do not burn out. Have fun!

## Notes
If you have changed the specifications in any way, please write your
justification here. Otherwise, you may discard this section.

Own behaviours added: 
1. Player can drag the ball around and tap it to launch the ball. Magnitude and direction is controlled by relative position of ball to top center of screen. 

## Dev Guide
You may put your dev guide either in this section, or in a new file entirely.
You are encouraged to include diagrams where appropriate in order to enhance
your guide.


### Class diagrams
![image](https://user-images.githubusercontent.com/68801331/218320230-46683487-d5a6-420a-b7f7-118e69d29075.png)

Model objects and physics objects that represent them are seperated to provide an abstraction and seperation of code. i.e. the model does not need to know about the physics object representation. Example would be peg object in board has a corresponding pegphysics object belonging in gameengine. This introduces loose coupling. 

Models basically represent what the objects are and what they can do, while views handle the rendering to the screen. Models are split into 3 main category, game engine, board and board store. Game engine category consists of `GameEngine` and `PeggleGameEngine`, which is in charge of all the kinematics. 

The design is of a facade, where `PeggleGameEngine` acts as the facade of the models and communicates with the views. 

Util or constant class is omitted to show high level design. 


### Sequence diagrams
Observer pattern is used. Whenever the board model instance changes, views that observes it will be automatically rerendered to update. (functionality of `@Published` and `ObservedObject` in SwiftUI) 


- Game loop
1. When a board is rendered, it autmotically calls `PeggleGameEngine.updateGameArea` which updates gameArea of the board, set ball to initial position, set board objects into phsyics objects into game engine and also calls `createDisplayLink()`
2. `createDisplayLink()` then sets up a CADisplayLink that is tied to device screen and calls `update` every frame. 
3. `update` gets the frame duration and calls `gameEngine.moveAll(time: frameDuration)` to simulate kinematics of all game objects. 
4. The returned list of collided physics objects is taken as input for `updateBoardWithGameEngine(collidedObjects: collidedObjects)`, which updates the board instance with the latest positions of all physics objects. 

- Launch ball 
1. When the ball is tapped, `PeggleGameEngine.launchBall()` is called which sets the ball with velocity and acceleration. 
2. The ball moves according to the game engine kinematics in `GameEngine.move()` and bounces if it hits pegs or walls. 
3. The returned collided physicsObjects are then processed by `PeggleGameEngine`. If it is a `PegPhysicsObject`, the peg is lighted up. 
4. If the ball is stuck in place for too long (`timeForPrematureRemoval`), `board.clearAllLitPegs()` is called to do premature removal. 
5. If the ball falls out of gameArea, it is removed in `removeBallIfOutOfBounds()`



## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

- PS2 tests are omitted 
- Unit tests for models are written in code. 

### Unit Testing 

- Acceleration 
   - Instance should be initialised with x and y inputs without fail
   - Should be able to call `update(velocity: Vector, time: Double)` and returns the new velocity that is acted upon acceleration self instance
- Ball 
   - Should be able to initialise with `centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration, radius: CGFloat` without fail 
   - Should be able to call `moveCentre(by: CGSize)` and mutates own centre 
- Board 
   - Should be able to call lightUp(peg: Peg) and set peg.isLit to true if it is false. if already true, ignore and return 
   - `clearAllLitPegs()` should remove all pegs in self.pegs that has isLit = true
   - `setBall(_ ball: Ball)` should be able to set the ball input as the board's ball
   - `setBall()` should set a ball instance at the top centre of the gamearea with `Vector.zero` and `Acceleration.zero`
   - `removeBall()` should set self.ball = nil
   - `ballIsOutOfBounds` should return whether the ball.centre is out of bounds (i.e.  ball.centre.y > gameArea.height)
   - `removeBallIfOutOfBounds()` should remove ball if is out of bounds
   - ` moveBall(by: CGSize)` should move the ball by specified size, ignore if if ball does not exist or if ball is moving (`ball.velocity != Vector.zero && ball.acceleration != Acceleration.zero`
   - `updateGameArea(_ gameArea: CGSize)` should updates self.gameArea with input
- CircleObject 
    - Should be able to initialise with `centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration, radius: CGFloat` without fail 
   - `vertices` Should be able to access computed vertices (treat circle as polygon) 
   - Should be able to be equatable with another physicsObject
- GameEngine 
   -  `addPhysicsObject(object: PhysicsObject) ` Should be able to add input to self.objects
   -  `removePhysicsObject(object: PhysicsObject)` should remove input from self.objects
   -  `resolveCollision` should resolve collision of object1 to object2 by changing object1.velocity depending on object2's shape
   -  `collidedObjects(object: PhysicsObject) -> [PhysicsObject]` should return list of physics objects from self.objects that collided by input object 
   -  `move(object: PhysicsObject, time: Double) -> [PhysicsObject]` should move a physics object based on its velocity and avcceleration as well as resolve any collision and return a list of physics objects that is collided 
   -  `moveAll(time: Double) -> [PhysicsObject]` should call `move` on self.objects and return a list of physics objects that is collided 
   -  `clearObjects()` should set self.objects = []

- PegPhysicsObject
   - Should be able to initialise with `centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration, radius: CGFloat` without fail 
   - Should be able to initialise with `peg: Peg` without fail 
   - ` getPeg() -> Peg` should return self.peg

- PeggleGameEngine
   - Should initialise and set  `board = Board.sampleGameBoard
        lastBallPosition = CGPoint(x: 0, y: 0)
        timeAtLastBallPosition = Double(Calendar.current.component(.second, from: Date()))`
   - `setupWalls()` should setup up left, right, top walls that are rectangleObjects dependant on gameArea and add to gameEngine objects. 
   - `createDisplayLink()` should initialise CADisplayLink and automatically call `update` at every frame change. 
   - `update(displaylink: CADisplayLink)` should call `let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)` without fail 
   - `launchBall()` should set self.launcedBall to true, and set the board.ball to a ball with velocity dependant on position of ball and also add it into gameengine.objects. ignore if self.launchedBall is false
   - setBoardToGameEngine() 
   - `updateBoardWithGameEngine` should getPeg from each pegphysicsobject and add into board, and if ball is not out of bounds add into board. If premature removal is needed, call board.clearAllLitPegs()


### Integration testing 

- Game 
    - When game is tested on potrait screen, it should work as below sections 
    - When game is tested on different ipad screen sizes, it should work as below sections
- Ball 
    - When ball is dragged, ball should move to new location 
    - When ball is tapped, ball should be launched from top center of screen (downwards, never upwards), ball should be launched in the direction from top center of screen to its position before tapped 
    - When ball collides with a peg, it should bounce away 
    - When ball collids with wall, it should bounce away 
    - When ball exits the stage, lit pegs will be removed with animation. New ball will appear at top center of screen
    - When ball is stuck with no way of reaching bottom of screen, lit pegs will be prematurely removed (pegs will not be prematurely removed in any other case)
    - When ball does not collide with any objects, it should move normally (like how balls move in real life)
- Peg 
    - When peg is hit by ball, it should light up 
    - When a peg is light up, it should remain lit 
    - When lit pegs are removed and ball exits the stage, new ball should be provided at the top


- Saving 
    Note that while your application should work on all iPad sizes, persisted data need not be compatible across sizes. In particular, level data saved from a certain iPad size, when loaded on another iPad size, does not need to be exactly the same level (it does not need to work either)
     
## Rules of the Game
Please write the rules of your game here. This section should include the
following sub-sections. You can keep the heading format here, and you can add
more headings to explain the rules of your game in a structured manner.
Alternatively, you can rewrite this section in your own style. You may also
write this section in a new file entirely, if you wish.

### Cannon Direction
Please explain how the player moves the cannon.

### Win and Lose Conditions
Please explain how the player wins/loses the game.

## Level Designer Additional Features

### Peg Rotation
Please explain how the player rotates the triangular pegs.

### Peg Resizing
Please explain how the player resizes the pegs.

## Bells and Whistles
Please write all of the additional features that you have implemented so that
your grader can award you credit.

## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

## Written Answers

### Reflecting on your Design
> Now that you have integrated the previous parts, comment on your architecture
> in problem sets 2 and 3. Here are some guiding questions:
> - do you think you have designed your code in the previous problem sets well
>   enough?
> - is there any technical debt that you need to clean in this problem set?
> - if you were to redo the entire application, is there anything you would
>   have done differently?

Your answer here
