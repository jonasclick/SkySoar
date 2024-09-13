

# SkySoar (Mobile App for iOS)

SkySoar lets glider pilots keep track of their flights and gives them immediate access to their practice state, without the manual work of having to look up past flight logs and doing calculations.
Calculating the practice state is a tedious process and is therefore often left out, which impacts safety in the private aviation sector.


<img src="https://github.com/jonasclick/hosting-images/blob/main/SkySoar%20Promo%20Banner.png" alt="Image of the SkySoar App" style="max-width: 100%; height: auto;"> 

This mobile app is developed for iOS in Swift (mostly SwiftUI). It has been released in the App Store and [can be downloaded here.](https://apps.apple.com/ch/app/skysoar/id6608979357?)

<br><br>

### Why should I use SkySoar?

SkySoar gives you the ability to keep track of your flights in well-designed and easy to use app. It's your digital flight book with superpowers: The dashboard let's you see and sort your flight data and even calculates your practice state. 

The German Aero Club [Deutscher Aero Club e.V.](https://www.daec.de) calculates practice state by a certain combination of the amount of flight hours in the last six months and the amount of starts in the last six months, as shown on [their Practice Barometer poster](https://www.daec.de/media/files/2023/Sportarten/Segelflug/Downloads/DAeC-Trainingbarometer_A3-Plakat_RZ_Druck_a.pdf), which [can be found here](https://www.daec.de/sportarten/segelflug/downloads-termine/#c505).

SkySoar evaluates the users flight data and displays a practice state of either green, yellow or red with the traffic light that can be found on the home screen. This allows glider pilots to make informed decisions about their readiness to fly. By making practice state information easily accessible through a user-friendly interface, this app aims to become an essential companion for both novice and experienced glider pilots.

<br><br>

## Features

- **Flight Log Management**: Allows pilots to add and edit their flights.
- **Practice State Visualization**: Displays the pilot's practice state using a color-coded system.
- **Onboarding**: The app comes with an onboarding sequence and the ability to add sample flight data for new users to explore the app without having to add their flight details first.

<br><br>

## How is the practice state calculated?
The poster of [Deutscher Aero Club e.V.](https://www.daec.de), as you can [find it here](https://www.daec.de/media/files/2023/Sportarten/Segelflug/Downloads/DAeC-Trainingbarometer_A3-Plakat_RZ_Druck_a.pdf), differentiates **three practice states: red, yellow and green.** When using the poster to determine the practice state a pilot manually checks her/his flight logs to then sum the amount of flight hours in the past six months and the amount of starts in the past six months. With those two sums she/he can draw an imaginary line in the poster and the center point of this line will fall in either the red, yellow or green area of the barometer, representing the current practice state.

<br>

**Practice State Calculation in SkySoar:**

SkySoar follows the example of the German Aero Club ([Deutscher Aero Club e.V.](https://www.daec.de)) and calculates practice state accordingly.

When creating a graph with 
 - **x** being the amount of **hours** in the last six months
 - **y** being the amount of **starts** in the last six months

the areas of the practice states red and yellow are separated by the function

    y = (20 - x) / 0.7
    
and the areas of the practice states yellow and green are separated by the function

    y = (39 - x) / 0.65


<img src="https://github.com/jonasclick/TBARO-Images/blob/main/Separator%20Lines%20Graph.png?raw=true" alt="Image of a graph" style="max-width: 100%; height: auto;">

<br><br>
This logic is then represented in SkySoar using the following Swift function:
        
    // Calculate Training State
    private func calculateTrainingStateInt(hours: Double, starts: Double) -> Int {
        
      // Boundary equations according to training barometer
      let redYellowBoundary = (20 - hours) / 0.7
      let yellowGreenBoundary = (39 - hours) / 0.65
      
      // Return Training State as Int
      if starts > yellowGreenBoundary {
          return 3 // Training State Green
      } else if starts > redYellowBoundary || starts == yellowGreenBoundary {
          return 2 // Training State Yellow
      } else if starts > 0 && starts <= redYellowBoundary {
          return 1 // Training State Red
      } else if starts == 0 {
          return 0 // No flights have been added yet
      } else {
          return 0 // Default return
      }
      
    }
    
The function returns the integer
 - 0 if no flight logs exist,
 - 1 for practice state **red**,
 - 2 for practice state **yellow**,
 - 3 for practice state **green**.



<br><br>

## How to Contribute

You're welcome to contribute! Whether you want to add new features, fix bugs, or improve documentation, your help is appreciated.

<br>

### Design

You can find the design file for this app [here](https://www.figma.com/design/L1Fn3gFKQ1TWshIywxj2zx/Trainingsbarometer-App?node-id=0-1&t=8CDHrlqvVWP6JOLS-1).
This app has been designed using figma and almost all the screens in the app have their corresponding frame in the figma file.

<br>

### Languages (Localizations)

The app currently supports English and German. Feel free to contribute by adding another language.

<br><br>

## Disclaimer and Copyright

<br>

### Disclaimer

This application is designed to assist your flying hobby and enhance safety by presenting user-provided information in a clear and accessible manner.

However, reliance solely on the information provided by this application is not recommended. It is crucial to verify all information independently, as the application may contain functional errors or inaccuracies, and user-entered data may be incorrect.

The developers and the application itself disclaim any liability for actions or decisions, flying-related or not, made based on the information provided by the application.

<br>

### Copyright

The concept of the pilot practice barometer found in this application was first introduced by

Deutscher Aero Club e.V.  
Hermann-Blenk-Str. 28  
38108 Braunschweig  
[www.daec.de](https://www.daec.de)

This app follows the logic of the German Aero Club and calculates practice state accordingly.
