# CS3217 Problem Set 3

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
1. If pegs overlap or go out of game area, the peg will be automatically removed. The user can then add a peg again if it was dragged on mistake. Alternative is to move the peg back to its initial position, but the first choice was chosen as removing it seems more intuitive to the users. 

## Dev Guide
You may put your dev guide either in this section, or in a new file entirely.
You are encouraged to include diagrams where appropriate in order to enhance
your guide.

Util or constant class is omitted to show high level design. 

### Class diagrams
As MV pattern is used (discussed below in design trade off), there are only Views and Models. 

![image](https://user-images.githubusercontent.com/68801331/215267470-5051b475-b28e-49da-b937-6aa02e32d7d0.png)

`PaletteView` is designed in such a way that it compose of `GameView`, where `GameView` can be reused for an actual game (i.e. when not designing). 

### Sequence diagrams
Observer pattern is used. Whenever the board model instance changes, views that observes it will be automatically rerendered to update. (functionality of `@Published` and `ObservedObject` in SwiftUI) 

Load board sequence:

![image](https://user-images.githubusercontent.com/68801331/215268141-67eb378a-4ec7-433e-b2e6-4b12e08334ae.png)


Add peg sequence: 

![image](https://user-images.githubusercontent.com/68801331/215268153-3affe90a-b39a-4e1a-98e8-23028c4a74ac.png)



## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

- Unit tests for models are written in code. 

### Level designer integration testing 

- Test palette
    - Blue button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs and it is within game area, it should add a blue peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a blue peg 
    - Orange button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs  and it is within game area, it should add a orange peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a orange peg 
    - Clear button 
        - When button is tapped, it should indicate that it is selected
        - When button is tapped and a peg is tapped, peg should be removed
    - Pegs 
        - When long pressed, peg should be removed
        - When dragged, peg should move to new location unless it collides with other pegs or it is not within game area, if so it should be removed 
        
- Test storage 
    - Level name field 
        - When field is tapped, it should allow user to type 
    - Load button
        - When load button is tapped with level name indicated, it should load the associated level 
        - When load button is tapped with level name not indicated, it should load the default "peggle.data"
    - Save button
        - When save button is tapped with level name ("levelname") indicated, it should save the level with the level name as "levelname.data"
        - When save button is tapped with level name not indicated, it should save with the default name "peggle.data"
    - Reset button 
        - When reset button is tapped, game area is cleared. 


Recording of test: 

https://drive.google.com/file/d/1aa3bxTQl1EE2Sn8mfvshYUiqql9SrI06/view?usp=share_link


## Written Answers

### Design Tradeoffs
> When you are designing your system, you will inevitably run into several
> possible implementations, in which you need to choose one among all. Please
> write at least 2 such scenarios and explain the trade-offs in the choices you
> are making. Afterwards, explain what choices you choose to implement and why.
>
> For example (might not happen to you -- this is just hypothetical!), when
> implementing a certain touch gesture, you might decide to use the method
> `foo` instead of `bar`. Explain what are the advantages and disadvantages of
> using `foo` and `bar`, and why you decided to go with `foo`.

Your answer here
