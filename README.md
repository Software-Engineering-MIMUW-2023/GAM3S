<p align="center">

  <h1 align="center">GAM3S <br/> Flutter app with 3 exciting two-person games </h1>
  <p align="center">
    <a href="https://github.com/kornelhowil"><strong>Kornel Howil</strong></a>
    ·
    <a href="https://github.com/SaLukasik"><strong>Sara Łukasik</strong></a>
    ·
    <a href="https://github.com/radionroman"><strong>Radionov Roman</strong></a>
    ·
    <a href="https://github.com/emros43"><strong>Emilia Rosła</strong></a>
    ·
    <a href="https://github.com/mikolajszym00"><strong>Mikołaj Szymański</strong></a>
  </p>
</p>

<p align="center">
<img src="https://github.com/Software-Engineering-MIMUW-2023/GAM3S/blob/main/logo.png" width=50% height=50%>
</p>
<br/><br/>

[![Cirrus CI - Specific Branch Build Status](https://img.shields.io/cirrus/github/Software-Engineering-MIMUW-2023/GAM3S/main)](https://cirrus-ci.com/github/Software-Engineering-MIMUW-2023/GAM3S)
[![Flutter Android](https://github.com/Software-Engineering-MIMUW-2023/insert-name/actions/workflows/flutter_actions_android.yml/badge.svg)](https://github.com/Software-Engineering-MIMUW-2023/insert-name/actions/workflows/flutter_actions_android.yml)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

# How to run

## Run on your computer

Install Flutter, Dart and Android Studio as in this [tutorial](https://www.youtube.com/watchv=1ukSR1GRtMU&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ).
After that you can just open this repository in Android Studio, select yout Android virtual machine and click run!

## Run on your Android phone (stable)
Just download .apk file which you can find in "apk/GAM3S.apk", put it on your phone and play!

## Run on your Android phone (newest)
Follow steps above to run app on your computer. Then, select Build > Build Bundle(s)/APK(s) > Build APK(s) from the toolbar menu.
Put generated .apk file on your phone and have fun :)

# Games

## Gomoku
Gomoku (Tic-Tac-Toe), also known as "Five in a Row", is a strategic board game traditionally played on a Go board with a grid of 19x19 lines. This game involves two players, one handling the black stones and the other the white stones. To begin, the player with the black stones places the first stone at the intersection of the lines on the board. Subsequently, players alternate turns, placing one stone each on any free intersection.

The primary objective of Gomoku is to create an unbroken chain of five stones in any direction - horizontally, vertically, or diagonally. The game is won by the first player who successfully forms this chain. If all the intersections on the board are occupied and no player has formed a line of five, the game results in a draw. Unlike Go, in Gomoku, stones once placed on the board are never removed.

<p align="center">
<img src="https://github.com/kornelhowil/GAM3S/blob/main/screenshots/tic_tac_toe.png" width=30% height=30%>
</p>

## Dots and Boxes
Players take turns connecting two adjacent dots with a line. \
When a player completes a box, they claim it and get an extra turn. \
The game ends when all dots are connected. \
The player with the most claimed boxes wins.
                                
<p align="center">
<img src="https://github.com/kornelhowil/GAM3S/blob/main/screenshots/dots_and_boxes.png" width=30% height=30%>
</p>

## Snakess
The Snake game is played by two players. At the beginning of the game, each player's snake is located at one of the corners of the board and consists only of a head. The head of each snake is marked with the letter 'S'. \
During the game, players take turns moving their snakes on the board. To move a snake, a player must tap on an empty tile that is in the same row, column, or diagonal as the snake's head. The tile should not be already occupied by the other player. \
The goal of the game is to cross the enemy snake as many times as possible. The player with the highest number of crossings wins. \
To cross an enemy snake, a player must move their snake through the area where the enemy snake lies. This can be done by passing through the head, body, or tail of the enemy snake. In one turn, only one point can be gained by crossing the enemy snake, regardless of how many times it is crossed. There is no penalty for crossing your own snake.
<p align="center">
<img src="https://github.com/kornelhowil/GAM3S/blob/main/screenshots/snakess.png" width=30% height=30%>
</p>

# Diagrams

![image](https://user-images.githubusercontent.com/91662997/228355179-b377eaa5-008c-471d-9b81-8fcccb27eba9.png)

[![](https://mermaid.ink/img/pako:eNqFU02P2jAU_CtPlvYGlLALhByQWtjuCRWJ7KUJB5O8EEuO7cZ2y4f2v9dJIKGFqkgR8cy8efNi-0wSmSIJyNMTaPxhUSS4ZHRf0iIW4H4Op9ZIYYsdlrHowMTIEqzGUgPV8F69tKSipWEJU1QYoEpVgs9KcZZQw6S4ceFSKrDCMF5bAYq0c6mR_nxeWQSQ5JRzFHuEssqpTRfFdahke2ZyuwtA00JxBOqESraqhu38SjS2FGByrHXARCbL4u-AzYBtkTZuspYU0rhits8NyKwRwF2q2iEAZU8nji17reaYdcX1WK4_0J20BjLG0RwV6k9cNl9O_ysXFfpXtT2Pe-NPyu1lssf1phrZbbrKIVw2olUUrSgTsEJht1vo9-ewiBa5lBrhjRYYxLFYSuN2X6TwRR5QOyBkCYTUPRLdaiGFwMTAV2nLbdv6f8YX5apmXqPo9cDMtgMHDt1EYbV337IMNtKKtDNfNII3L_oz271iFN2EvaefowfpF3Wm0HV3h59RfoHDGl7fatbRmtPjhV_X0Kr6xqRHCnTHjKXuzp0rOibuCBYYk8C9pphRy01MYvHhpNXN2xxFQgJTWuwRq1JqrvfzCrpb9l1Kt8wo182aBGdyIIE3GnhTbzTzZ_7Q_fuzHjmS4MUbjIeT2XQ69CvOf_7okVNt4IjZ1JuMJy_T4XDse_7k4zd7r0IV?type=png)](https://mermaid.live/edit#pako:eNqFU02P2jAU_CtPlvYGlLALhByQWtjuCRWJ7KUJB5O8EEuO7cZ2y4f2v9dJIKGFqkgR8cy8efNi-0wSmSIJyNMTaPxhUSS4ZHRf0iIW4H4Op9ZIYYsdlrHowMTIEqzGUgPV8F69tKSipWEJU1QYoEpVgs9KcZZQw6S4ceFSKrDCMF5bAYq0c6mR_nxeWQSQ5JRzFHuEssqpTRfFdahke2ZyuwtA00JxBOqESraqhu38SjS2FGByrHXARCbL4u-AzYBtkTZuspYU0rhits8NyKwRwF2q2iEAZU8nji17reaYdcX1WK4_0J20BjLG0RwV6k9cNl9O_ysXFfpXtT2Pe-NPyu1lssf1phrZbbrKIVw2olUUrSgTsEJht1vo9-ewiBa5lBrhjRYYxLFYSuN2X6TwRR5QOyBkCYTUPRLdaiGFwMTAV2nLbdv6f8YX5apmXqPo9cDMtgMHDt1EYbV337IMNtKKtDNfNII3L_oz271iFN2EvaefowfpF3Wm0HV3h59RfoHDGl7fatbRmtPjhV_X0Kr6xqRHCnTHjKXuzp0rOibuCBYYk8C9pphRy01MYvHhpNXN2xxFQgJTWuwRq1JqrvfzCrpb9l1Kt8wo182aBGdyIIE3GnhTbzTzZ_7Q_fuzHjmS4MUbjIeT2XQ69CvOf_7okVNt4IjZ1JuMJy_T4XDse_7k4zd7r0IV)
