# Hangman on Rails

If you want to play the live version of this game, visit [hamgmanonrails.com](http://hangmanonrails.com/).


# Features

In its current iteration, this is a barebones version of hangman. The available features are as follows.

* Creating a dedicated game lobby which can be shared with a friend through a persistent link

* Play with a random word automatically selected from a dictionary API OR enter one yourself

* Select anywhere between 1 – 15 lives and have the graphics adjust

* Switch between showing / hiding the word upon losing a game

This is a solid base for a functional hangman game, but it is something I feel I can expand upon.
These are the features I would like to add in the near future.

* Account system, which can be used to track past games and challenge friends

* <s>Ability to select difficulty of the randomly selected word</s> Feature added

* Expand the gameplay to include more complex game modes


# Motivation

The motivation for this project was twofold. The majority of my programming experience up to now has been working with desktop applications, game development, and algorithms, mostly through various university assignments. I've been interested in rails development since attending an industry talk on it in 2017 - the streamlined way you can create and deploy apps entirely self-contained to rails was extremely appealing to me.

The second reason I undertook this project was more spontaneous - I was trying to find an online hangman game quickly to play with a friend, but every link I clicked had either died with adobe flash, or was riddled with ads and pop ups.

I decided to take this opportunity to tackle learning ruby on rails with an achievable goal in mind that might prove useful to some people in the future.


# Deployment

The biggest challenge I encountered undertaking this project was deployment, as it was the aspect I had the least experience in. I used a fairly complex but extremely scalable stack, mirroring the way a more industrial application would be deployed.

I chose a Digital Ocean droplet for the hosting service, as it is an affordable option I’ve had experience with in the past. I employed Passenger as the application server, integrated with Nginx as the Web Server. Passenger allows Nginx to seamlessly work with rails, automating much of the servers function.

Finally, I used Capistrano to automate deployment through my github. It was important to me that continued updates to the application are as easy as possible, and Cap allows me to redeploy an updated version with a single command practically instantly.
