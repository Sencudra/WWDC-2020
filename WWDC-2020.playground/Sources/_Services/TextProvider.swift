import Foundation
import UIKit

public protocol TextProvider {

    // Intro

    var introTitle: String { get }
    var introSubtitle: String { get }

    // Presentation

    var presentation: String { get }

    // Story

    var story: String? { get }
    var storyMessages: String { get }

    // Interactive

    var interactiveTitle: String { get }
    var interactiveScoreTitle: String { get }
    var interactiveMagicScoreTitle: String { get }
    var interactiveRandom: String { get }

    // Outro Fail

    var gameOverTitle: String { get }
    var gameOverSubtitle: String { get }
    var gameOverSubtitle2: String { get }
    var gameOverAcceptButton: String { get }
    var gameOverRefuseButton: String { get }

    // Outro Successed

    var outroTitle: String { get }
    var outroSubtitle: String { get }
    var outroCredits: String { get }

}

// MARK: - Implementation

final class DefaultTextProvider: TextProvider {

    // MARK: - Internal proeprties

    var introTitle: String {
        return "This is a story about us..."
    }

    var introSubtitle: String {
        return "by Uladzislau Tarasevich"
    }

    var presentation: String {
        let text = """
            20/20 is a term in medicine that means\n
            that a person has perfect vision. Vision\n
            is not just the ability to see code on a\n
            monitor. This is a gift to know the beauty\n
            of the world around us, this is what allows\n
            us to see the inner world of other people.\n
            Make sure to take care of your eyesight\n
            and put your health above life goals not only\n
            this #yearofvision2020
        """
        return text
    }

    // Story

    var storyCounter = -1
    var story: String? {
        let text = [
            "Hi, it's me! ... In my natural habitat.",
            "No, really, I don’t sit like this all day.\nI have a very comfortable sofa.",
            "An inquisitive viewer could already notice that\n I really love space, rockets and Chinese trinkets ...",
            "...",
            "Auch, what's goting on?! My eyes!!!",
            "Where are my eye medications?",
        ]
        storyCounter += 1
        if storyCounter >= text.count {
            return nil
        }
        return text[storyCounter]
    }

    var storyMessages: String {
        let text = [
            "Hey, close the door!",
            "My name is Vlad",
            "In the middle...",
            "...lies opportinity",
            "Do not enter withour food!",
            "Hi"
        ]
        return text.randomElement()!
    }

    // Interactive

    var interactiveTitle: String {
        "Smash EYES to save me from blindness 😝"
    }

    var interactiveScoreTitle: String {
        "Eyes left: "
    }

    var interactiveMagicScoreTitle: String {
        "Oh #$@&%*!, this shouldn't work like that"
    }

    var interactiveRandom: String {
        let string = [
            "This socks are snatched!",
            "Wig!",
            "Yanny",
            "Laurel",
            "Hah, try harder, my friend!",
            "Oh nooo, they are so close!",
            "Un, deux, trois, quatre...",
            "I love Swift!",
            "WATCH OUT!",
            "Where's the bathroom?",
            "Aww...",
            "Bravo!",
            "Bingo!",
            "Please, God",
            "Ooops...",
            "Hoolly Coooww!",
            "Tut-Tut...",
            "Wow!",
            "Yeah booooy!",
            "Yippeeeeee..."
        ]
        return string.randomElement()!
    }

    // Outro fail

    var gameOverTitle: String {
        return "GAME OVER"
    }

    var gameOverSubtitle: String {
        return "What?! How could you lose here?"
    }

    var gameOverSubtitle2: String {
        return "At least you did eye exercises!"
    }

    var gameOverAcceptButton: String {
        return "TRY AGAIN"
    }

    var gameOverRefuseButton: String {
        return "NO, I WON"
    }

    // Outro success

    var outroTitle: String {
        return "#YEAROFVISION2020"
    }

    var outroSubtitle: String {
        let text = """
            Let's make 20/20 the International Year of\n
            Eye Health. This will help raise awareness\n
            of eye health among developers. The sooner\n
            we learn about ways to protect eyesight,\n
            the more benefits we can bring to the health\n
            of our eyes now and in the future.\n
            \n
            Take care of your eyes!
        """
        return text
    }

    var outroCredits: String {
        // YEAH, THAT'S HOT
        let text = """
            Story by\nUladzislau Tarasevich\n\n
            CEO & Chairman\nUladzislau Tarasevich\n\n
            Executive Vice President\nUladzislau Tarasevich\n\n
            Executive Vice President of prodiction\nUladzislau Tarasevich\n\n
            Vice President of prodiction development\nUladzislau Tarasevich\n\n
            Executive Producer\nUladzislau Tarasevich\n\n
            Producer\nUladzislau Tarasevich\n\n
            Assistant Producer\nUladzislau Tarasevich\n\n
            Senior Manafer of 1st Party Relations\nUladzislau Tarasevich\n\n
            Senior Production coordinator\nUladzislau Tarasevich\n\n
            Director of Monitoring Group\nUladzislau Tarasevich\n\n
            Monitoring Group Supervisor\nUladzislau Tarasevich\n\n
            Monitoring Group Project Lead\nUladzislau Tarasevich\n\n
            Monitoring Group Senior Tester\nUladzislau Tarasevich\n\n
            Monitoring Group Tester\nUladzislau Tarasevich\n\n
            Monitoring Group XYZ Coordinator\nUladzislau Tarasevich\n\n
            Monitoring Group XYZ Coordinator\nUladzislau Tarasevich\n\n
            Monitoring Group XYZ Project Lead\nUladzislau Tarasevich\n\n
            Monitoring Group XYZ Tester\nUladzislau Tarasevich\n\n
            Monitoring Group XYZ Coordinator\nUladzislau Tarasevich\n\n
            Monitoring Group Lab Coordiantor\nUladzislau Tarasevich\n\n
            Monitoring Group Mastering Lab Coordinator\nUladzislau Tarasevich\n\n
            Vice President of Marketing\nUladzislau Tarasevich\n\n
            Markering Director\nUladzislau Tarasevich\n\n
            Senior Brand Manager\nUladzislau Tarasevich\n\n
            Associate Brand Manager\nUladzislau Tarasevich\n\n
            Senior Manager of Public Relations\nUladzislau Tarasevich\n\n
            Director of Creative Services\nUladzislau Tarasevich\n\n
            Senior Manager of Creative Services/Marketing\nUladzislau Tarasevich\n\n
            Graphic Designer\nUladzislau Tarasevich\n\n
            Audio/Video Specialist\nUladzislau Tarasevich\n\n
            Vice President of Licensing and Business Development\nUladzislau Tarasevich\n\n
            Vice President of Sales\nUladzislau Tarasevich\n\n
            Vice President of Operations\nUladzislau Tarasevich\n\n
            Director of Sales Support and Operations\nUladzislau Tarasevich\n\n
            Vice President of Legal Afairs\nUladzislau Tarasevich\n\n
            Vice President of Human Resources\nUladzislau Tarasevich\n\n
            Minion\nUladzislau Tarasevich\n\n
            Zombie\nUladzislau Tarasevich\n\n
            Art Director\nUladzislau Tarasevich\n\n
            UI Artist\nUladzislau Tarasevich\n\n
            FX Artist\nUladzislau Tarasevich\n\n
            Cinematic Lead\nUladzislau Tarasevich\n\n
            Lead Level Designer\nUladzislau Tarasevich\n\n
            Designer\nUladzislau Tarasevich\n\n
            Writer\nUladzislau Tarasevich\n\n
            Artist\nUladzislau Tarasevich\n\n
            Concept Artist\nUladzislau Tarasevich\n\n
            Lead Engineer\nUladzislau Tarasevich\n\n
            Engineer\nUladzislau Tarasevich\n\n
            Platform Lead Engineer\nUladzislau Tarasevich\n\n
            Quality Assurance\nUladzislau Tarasevich\n\n
            Motion Capture Lead\nUladzislau Tarasevich\n\n
            Animator\nUladzislau Tarasevich\n\n
            Motion Capture Talent\nUladzislau Tarasevich\n\n
            Audio Lead\nUladzislau Tarasevich\n\n
            Sound Designer\nUladzislau Tarasevich\n\n
            System Administrator\nUladzislau Tarasevich\n\n
            Office Manager\nUladzislau Tarasevich\n\n
            Playtester\nUladzislau Tarasevich\n\n
            Special thanks\nUladzislau Tarasevich\n\n
            2020 WWWDC\nUladzislau Tarasevich\n\n
        """
        return text
    }

}
