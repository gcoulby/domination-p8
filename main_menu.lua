function drawMenu()
    cls()

    --print the title in the centre of the screen
    print("domination", 43, 7, 12)
    spr(4, 8, 7)
    spr(5, 15, 7)
    spr(5, tileWidth * 21 + 3, 7)
    spr(4, tileWidth * 21 + 3 + 7, 7)
    for i = 0, 8 do
        drawCard("BOARD", i, nil, 0, 7, 12, true)
    end

    printChar(2, (6 * tileWidth) + (1 * 25) + 6, tileHeight + 19, 0, 7)
    printChar(7, (6 * tileWidth) + (1 * 25) + 6, tileHeight + 75, 0, 7)
    printChar(3, (6 * tileWidth) + (0 * 25) + 6, tileHeight + 47, 0, 7)
    printChar(5, (6 * tileWidth) + (2 * 25) + 6, tileHeight + 47, 0, 7)
    print("press 🅾️ to start", 29, 102, 12)
    print("press ❎ for instructions", 13, 116, 12)
end

function drawInstructions()
    cls()
    
    print("instructions (press ❎ to exit)", 1, 1 + instructions_offset, 12)
    print("-------------------------------", 1, 9 + instructions_offset, 12)

    print("the goal of the game is to", 1, 17 + instructions_offset, 12)
    print("have the most cards", 1, 25 + instructions_offset, 12)
    
    print("you play a card by moving the", 1, 41 + instructions_offset, 12)
    print("cursor in your hand with ⬅️➡️", 1, 49 + instructions_offset, 12)
    print("and pressing 🅾️ to select a card", 1, 57 + instructions_offset, 12)

    print("select an available slot on the", 1, 73 + instructions_offset, 12)
    print("board and press 🅾️ to play it", 1, 81 + instructions_offset, 12)

    print("cards can be won by placing your", 1, 97 + instructions_offset, 12)
    print("card adjacent to an opponent's", 1, 105 + instructions_offset, 12)
    print("card", 1, 113 + instructions_offset, 12)
  
    print("when the values on your card are", 1, 129 + instructions_offset, 12)
    print("are > or = to adjacent values on", 1, 137 + instructions_offset, 12)
    print("your opponent's card, you win", 1, 145 + instructions_offset, 12)
    print("their card", 1, 153 + instructions_offset, 12)

    print("this effect can cascade when you", 1, 169 + instructions_offset, 12)
    print("win a card! When a card is won", 1, 177 + instructions_offset, 12)
    print("adjacencies are then evaluated", 1, 185 + instructions_offset, 12)
    print("accordingly, for the newly", 1, 193 + instructions_offset, 12)
    print("aquired card. however, this", 1, 201 + instructions_offset, 12)
    print("cascade can only happen once and", 1, 209 + instructions_offset, 12)
    print("only if the values on your new", 1, 217 + instructions_offset, 12)
    print("card are > the adjacent vales on", 1, 225 + instructions_offset, 12)
    print("the next layer of opponent cards", 1, 233 + instructions_offset, 12)
    
    print("you win the round by having the", 1, 249 + instructions_offset, 12)
    print("most cards when the last card", 1, 257 + instructions_offset, 12)
    print("is played. enjoy!", 1, 265 + instructions_offset, 12)

    print("press ❎ to exit", 1, 281 + instructions_offset, 12)

    
    rectfill(108,119,127,127,2)
    if instructions_offset < 0 then
        print("⬆️", 110, 121, 7)
    end
    if instructions_offset > -170 then
        print("⬇️", 119, 121, 7)
    end
end