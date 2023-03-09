function drawMenu()
    cls()

    --print the title in the centre of the screen
    print("domination", 42, 7, 12)
    spr(4, 7, 7)
    spr(5, 14, 7)
    spr(5, tileWidth * 21 + 2, 7)
    spr(4, tileWidth * 21 + 2 + 7, 7)
    for i = 0, 8 do
        drawCard("BOARD", i, nil, 0, 7, 12)
    end

    printChar(3, (6 * tileWidth) + (1 * 25) + 6, tileHeight + 18, 0, 7)
    printChar(5, (6 * tileWidth) + (1 * 25) + 6, tileHeight + 75, 0, 7)
    printChar(4, (6 * tileWidth) + (0 * 25) + 6, tileHeight + 47, 0, 7)
    printChar(6, (6 * tileWidth) + (2 * 25) + 6, tileHeight + 47, 0, 7)
    print("press 🅾️ to start", 29, 102, 12)
end