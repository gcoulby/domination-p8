# Domination P8

This is a PICO-8 remake of a gameboy game I made called domination.

## How to play the game

To play the game either search for domination in PICO-8 SPLORE app
or head to [https://gcoulby.github.io/domination-p8/](https://gcoulby.github.io/domination-p8/)

> _The app is playable on mobile too, and has nice on-screen cotrols!_

> You can also download the image below load the file on your PICO-8 console
> _(the game is actually contained in the image file, so you don't need to download the .p8 file separately)_

![https://github.com/gcoulby/domination-p8/raw/main/dominaiton.p8.png](https://github.com/gcoulby/domination-p8/raw/main/dominaiton.p8.png)

## Instructions

---

The goal of the game is to have the most cards.

You play a card by moving the cursor in your hand with ⬅️➡️ and pressing 🅾️ to select a card.

Select an available slot on the board and press 🅾️ to play it.

Cards can be won by placing your card adjacent to an opponent's card.

When the values on your card are > or = to adjacent values on your opponent's card, you win their card.

This effect can cascade when you win a card! When a card is won adjacencies are then evaluated accordingly, for the newly aquired card. however, this cascade can only happen once and only if the values on your new card are > the adjacent vales on the next layer of opponent cards.

You win the round by having the most cards when the last card is played. enjoy!

---

### PICO-8

For information on the PICO-8 or to buy your own license visit:
[https://www.lexaloffle.com/pico-8.php](https://www.lexaloffle.com/pico-8.php)
