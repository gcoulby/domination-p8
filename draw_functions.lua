globalXOffset = 1
function drawCard(location, position,  card, color, bgColor, yoffset)
    local x = 0
    local y = 0
    if(location == "HAND") then
        x = tileWidth + (position * 25) + globalXOffset
        y = tileHeight * 14
    elseif(location == "BOARD") then
        local offset = 6
        
        if(position < 3) then
            y = tileHeight
            x = (offset * tileWidth) + (position * 25) + globalXOffset
        elseif(position < 6) then
            y = tileHeight * 5
            x = (offset * tileWidth) + ((position - 3) * 25) + globalXOffset

        elseif(position < 9) then
            y = tileHeight * 9
            x = (offset * tileWidth) + ((position - 6) * 25) + globalXOffset
        end 

    end
    if(yoffset ~= nil) then
        y = y + yoffset
    end
    rectfill(x, y, x + (tileWidth * 3) - 1, y + (tileHeight*3) - 1, bgColor)
        
    if(card ~= nil) then
        printChar(card["values"][1], x+5, y, color, bgColor)
        printChar(card["values"][2], x, y+7, color, bgColor)
        printChar(card["values"][3], x+10, y+7, color, bgColor)
        printChar(card["values"][4], x+5, y+14, color, bgColor)
    else
        rectfill(x, y, x + (tileWidth * 3) - 1, y + (tileHeight*3) - 1, 7)
    end
    
end

function drawBoard()
    map(0)
    for i = 0, 8 do
        drawCard("BOARD", i, nil, 0, 7)
    end
    for i = 0, 4 do
        drawCard("HAND", i, nil, 0, 7)
    end
    for i = 0, 25 do
        spr(0, i * 5, tileHeight * 13, 1, 1)
    end    
end


function drawPlayerCards()
    for i = 1, 5 do
        drawCard("HAND",i-1, players[1]["cards"][i], 7, 12)
    end
end

function drawBoardCards()
    for i = 1, 9 do
        drawCard("BOARD",i-1, board[i], 7, ternary(board[i] ~= nil and board[i]["player"] == 1, 12, 1))
    end
end


-- BOARD COMPONENTS
function drawScore(player)
    local x = 0
    local y = tileHeight * 6
    if(player == 1) then
        x = tileWidth + 2 + globalXOffset
    elseif(player == 2) then
        x = tileWidth * 21 + 2 + globalXOffset
    end
    spr(4 + player - 1, x-1, tileHeight * 5 )
    spr(4 + player - 1, x+7, tileHeight * 5 )
    spr(4 + player - 1, x-1, tileHeight * 7 )
    spr(4 + player - 1, x+7, tileHeight * 7 )
    print(padWithLeadingZeroes(players[player]["wins"], 3), x, y, 7)
end

function drawCardCount(player)
    local x = 0
    local y = tileHeight * 2
    if(player == 1) then
        x = tileWidth + 9 + globalXOffset
    elseif(player == 2) then
        x = tileWidth * 22 + 5 + globalXOffset 
    end
    print(players[player]["gamescore"], x-7,y)
    spr(1, x-1, tileHeight * 2 )
end

function drawPlayerMarker(player)
    local x = 0
    local y = tileHeight * 2
    if(player == 1) then
        x = tileWidth + 9 + globalXOffset
    elseif(player == 2) then
        x = tileWidth * 22 + 4 + globalXOffset
    end
    
    spr(6, x-9, tileHeight * 3 )
    spr(7, x-2, tileHeight * 3 )
end

function drawHandSelectPos()
    local s = 3
    if not selectingHand or currentPlayer == 2 then 
        s = 2
    end
        local x = tileWidth + (handSelectPos * 25)  + globalXOffset
        local y = tileHeight * 17
        spr(s, x, y)
        spr(s, x + tileWidth, y)
        spr(s, x + (tileWidth*2), y)
end

function drawBoardSelectPos()
    local s = 3
    if selectingHand then 
        s = 2
    end
    local offset = 6
    local x = 0
    local y = 0

    if(boardSelectPos < 3) then
        x = (offset * tileWidth) + (boardSelectPos * 25) + globalXOffset           
        y = tileHeight * 4
    elseif(boardSelectPos < 6) then
        x = (offset * tileWidth) + ((boardSelectPos - 3) * 25) + globalXOffset
        y = tileHeight * 8

    elseif(boardSelectPos < 9) then
        x = (offset * tileWidth) + ((boardSelectPos - 6) * 25) + globalXOffset
        y = tileHeight * 12
    end 

    spr(s, x, y)
    spr(s, x + tileWidth, y)
    spr(s, x + (tileWidth*2), y)
end

function drawCursors()
    if showCursors then
        drawHandSelectPos()
        drawBoardSelectPos()
    end
end

function drawWinStatus()
    if(players[1]["gamescore"] > players[2]["gamescore"]) then
        players[1]["wins"] = players[1]["wins"] + 1
        print("You", tileWidth + 2, tileHeight * 9, 7 )
        print("WIN", tileWidth + 2, tileHeight * 10, 7 )
    else
        players[2]["wins"] = players[2]["wins"] + 1
        print("AI", tileWidth * 21+4, tileHeight * 9, 7 )
        print("WINS", tileWidth * 21, tileHeight * 10, 7 )
    end
end

function drawGame()
    -- map(0,0)

    drawBoard()
    drawScore(1)
    drawScore(2)
    drawCardCount(1)
    drawCardCount(2)
    drawCursors()
    drawPlayerMarker(currentPlayer)
    drawPlayerCards()
    drawBoardCards()
end