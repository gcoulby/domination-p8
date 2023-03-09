function populateCards(table, player, count, empty)
    for i=1, count do
        table[i] = nil
        if empty ~= true then
            table[i] = {player=player, values = {}}
            for j=1, 4 do
                table[i]["values"][j] = flr(rnd(9)) + 1
            end
        end
    end
end

function isGameOver()
    emptyTiles = 9
    for i=1, 9 do
        if board[i] ~= nil then
            emptyTiles -= 1
        end
    end
    return emptyTiles == 0
end

function newGame()
    for player = 1, 2 do
        populateCards(players[player]["cards"], player, 5)
    end
    populateCards(board, 1, 9, true)

    currentPlayer = ternary(lastWinner == 0, flr(rnd(2) + 1), lastWinner)
    
    if DEBUG_ENABLE then
        currentPlayer = 1
    end
    showCursors = ternary(currentPlayer == 1, true, false)
end

function countPlayerCards(player)
    local playerCards = 0
    for i=1, 9 do
        if board[i] ~= nil then
            if board[i]["player"] == player then
                playerCards += 1
            end    
        end
    end
    return playerCards
end

function countCards()
    players[1]["gamescore"] = countPlayerCards(1)
    players[2]["gamescore"] = countPlayerCards(2)
end

function changePlayers()
    currentPlayer = ternary(currentPlayer == 1, 2, 1)
    selectingHand = true
    handSelectPos = 0
    boardSelectPos = 0
    showCursors = ternary(currentPlayer == 1, true, false)
end


function placeCard(player, boardPos, cardId)
    debugLog("placing card at pos " .. boardPos, "log")
    if board[boardPos] == nil then
        debugLog("card being placed at pos " .. boardPos, "log")
        board[boardPos] = players[player]["cards"][cardId]
        players[player]["cards"][cardId] = nil
        flipAdjacentCardsIfEqualOrGreater(boardPos, true);
        changePlayers()
        debugLog("------------------", "log")
    end
end

function resetBoardState(initialBoardState)
    board = initialBoardState
end

function isEqualOrHigherThanAdjacentCard(challengerPos, challengedPos, challengerValId, challengedValId, forceGreaterThan)
    if board[challengedPos] == nil then return false end
    if board[challengerPos]["player"] == board[challengedPos]["player"] then return false end
    if forceGreaterThan then
        debugLog("!> challenger " .. challengerPos .. ":" .. challengerValId .. " vs " .. challengedPos .. ":" .. challengedValId .. " | " .. board[challengerPos]["values"][challengerValId] .. " > " .. board[challengedPos]["values"][challengedValId], "log")
        return board[challengerPos]["values"][challengerValId] > board[challengedPos]["values"][challengedValId]
    else
        debugLog(">= challenger " .. challengerPos .. ":" .. challengerValId .. " vs " .. challengedPos .. ":" .. challengedValId .. " | " .. board[challengerPos]["values"][challengerValId] .. " >= " .. board[challengedPos]["values"][challengedValId], "log")
        return board[challengerPos]["values"][challengerValId] >= board[challengedPos]["values"][challengedValId]
    end
end

function flipAdjacentCardsIfEqualOrGreater(boardPos, cascade)
    local checkUp = boardPos >= 4
    local checkDown = boardPos < 7
    local checkLeft = not ((boardPos-1) % 3 == 0)
    local checkRight = not ((boardPos ) % 3 == 0)
    local newBoardPos = boardPos
    if checkUp and isEqualOrHigherThanAdjacentCard(boardPos, boardPos-3, 1, 4, not cascade) then
        board[boardPos-3]["player"] = board[boardPos]["player"]
        if cascade then
            flipAdjacentCardsIfEqualOrGreater(boardPos-3, false)
        end
        debugLog("flip card ".. boardPos - 3 .. ": " .. boardPos .. ternary(cascade, " >= ", " == ") .. boardPos - 3, "log")
    end
    if checkDown and isEqualOrHigherThanAdjacentCard(boardPos, boardPos+3, 4, 1, not cascade) then
        board[boardPos+3]["player"] = board[boardPos]["player"]
        if cascade then
            flipAdjacentCardsIfEqualOrGreater(boardPos+3, false)
        end
        debugLog("flip card ".. boardPos + 3 .. ": " .. boardPos .. ternary(cascade, " >= ", " == ") .. boardPos + 3, "log")
        
    end
     
    if checkLeft and isEqualOrHigherThanAdjacentCard(boardPos, boardPos-1, 2, 3, not cascade) then
        board[boardPos-1]["player"] = board[boardPos]["player"]
        if cascade then
            flipAdjacentCardsIfEqualOrGreater(boardPos-1, false)
        end
        debugLog("flip card ".. boardPos - 1 .. ": " .. boardPos .. ternary(cascade, " >= ", " == ") .. boardPos - 1, "log")        
    end
    if checkRight and isEqualOrHigherThanAdjacentCard(boardPos, boardPos+1, 3, 2, not cascade) then
        board[boardPos+1]["player"] = board[boardPos]["player"]
        if cascade then
            flipAdjacentCardsIfEqualOrGreater(boardPos+1, false)
        end
        debugLog("flip card ".. boardPos + 1 .. ": " .. boardPos .. ternary(cascade, " >= ", " == ") .. boardPos + 1, "log")
    end
end

function isAIValueEqualOrHigherThanAdjacentCard(challengedPos, challengedValId, challengerVal, forceGreaterThan)
    if board[challengedPos] == nil then return false end
    if board[challengedPos]["player"] == 2 then return false end
    if forceGreaterThan then
        return challengerVal > board[challengedPos]["values"][challengedValId]
    else
        return challengerVal >= board[challengedPos]["values"][challengedValId]
    end
end


function checkAIFlips(boardPos, cardId, cascade)
    local checkUp = boardPos >= 4
    local checkDown = boardPos < 7
    local checkLeft = not ((boardPos-1) % 3 == 0)
    local checkRight = not ((boardPos ) % 3 == 0)
    local card = players[2]["cards"][cardId]["values"]

    if checkUp and isAIValueEqualOrHigherThanAdjacentCard(boardPos-3, 4, card[1], not cascade) then
        aiFlips += 1
        if cascade then
            checkAIFlips(boardPos-3, cardId, false)
        end
    end
    if checkDown and isAIValueEqualOrHigherThanAdjacentCard(boardPos+3, 1, card[4], not cascade) then
        aiFlips += 1
        if cascade then
            checkAIFlips(boardPos-3, cardId, false)
        end
    end
    if checkLeft and isAIValueEqualOrHigherThanAdjacentCard(boardPos-3, 3, card[2], not cascade) then
        aiFlips += 1
        if cascade then
            checkAIFlips(boardPos-1, cardId, false)
        end
    end
    if checkRight and isAIValueEqualOrHigherThanAdjacentCard(boardPos-3, 2, card[3], not cascade) then
        aiFlips += 1
        if cascade then
            checkAIFlips(boardPos+1, cardId, false)
        end
    end
end

function getAIScore2(cardId, boardPos)
    --    Scoring:
    --    +50: for each card taken ✔
    --    -1: for each value shielded eg: 9 = -9
    --    +1: for each value exposed eg: 9 = +9
    local score = 0
    aiFlips = 0
    local card = players[2]["cards"][cardId]["values"]

    checkAIFlips(boardPos, cardId, true)
    score += aiFlips * 50
    local checkUp = boardPos >= 4
    local checkDown = boardPos < 7
    local checkLeft = not ((boardPos - 1) % 3 == 0)
    local checkRight = not ((boardPos ) % 3 == 0)
    

    if checkUp then
        score += ternary(board[boardPos - 3] == nil, card[1], (card[1] * -1))
    elseif checkDown then
        score += ternary(board[boardPos + 3] == nil, card[4], (card[4] * -1))
    elseif checkLeft then
        score += ternary(board[boardPos - 1] == nil, card[2], (card[2] * -1))
    elseif checkRight then
        score += ternary(board[boardPos + 1] == nil, card[3], (card[3] * -1))
    end

    return score
end

function AI()
    bestScore = INT_MIN
    bestBoardPos = -1
    bestCardId = -1

    for cardId=1,5 do
        if players[2]["cards"][cardId] ~= nil then 
            for boardPos = 1, 9 do
                if board[boardPos] == nil then
                    local score = getAIScore2(cardId, boardPos)
                    
                    if score > bestScore then 
                        bestScore = score
                        bestBoardPos = boardPos
                        bestCardId = cardId
                    end
                end
            end
        end
    end
    debugLog("bestScore: " .. bestScore .. " | bestBoardPos: " .. bestBoardPos .. " | bestCardId: " .. bestCardId, "log")
    if bestBoardPos >= 1 and bestCardId >= 1 then
        placeCard(2, bestBoardPos, bestCardId)
    end
    
end

function takeAITurn()
    if not aiThinking then
        aiThinking = true
        wait(rnd(40)+10)
        AI();
        aiThinking = false
    end
end