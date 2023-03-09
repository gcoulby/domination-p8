
function _init()
    debugLog("----------------------------------------------------------", "log", true)
end

function _update()
    if(splashShown) then
        startMusic(8)
    end
    if in_menu and not in_instructions then
        if btnp(4) then
            sfx(59)
            in_menu = false
            newGame()
            
            started = true
        elseif btnp(5) then
            sfx(61)
            instructions_offset = 0
            in_instructions = true
        end
    elseif in_instructions then
        if btnp(0) then
            sfx(61)
            instructions_offset = 0  
        elseif btnp(1) then
            sfx(61)
            instructions_offset = -170  
        elseif btnp(2) then
            sfx(61)
            instructions_offset = instructions_offset + 10
            if instructions_offset > 0 then
                instructions_offset = 0
            end
        elseif btnp(3) then
            sfx(61)
            instructions_offset = instructions_offset - 10
            if instructions_offset <= -170 then
                instructions_offset = -170
            end
        elseif btnp(5) then
            sfx(61)
            in_instructions = false
        end
    elseif currentPlayer == 1 then
        if selectingHand then
            if btnp(0) then
                sfx(61)
                handSelectPos = handSelectPos - 1
                if handSelectPos < 0 then
                    handSelectPos = 4
                end
            elseif btnp(1) then
                sfx(61)
                handSelectPos = handSelectPos + 1
                if handSelectPos > 4 then
                    handSelectPos = 0
                end
            elseif btnp(4) then
                if players[1]["cards"][handSelectPos+1] ~= nil then
                    sfx(62)
                    selectingHand = false
                    boardSelectPos = 0
                else
                    sfx(56)
                end
                
            end
        else
            if btnp(0) then
                sfx(61)
                boardSelectPos = boardSelectPos - 1
                if boardSelectPos < 0 then
                    boardSelectPos = 8
                end
            elseif btnp(1) then
                sfx(61)
                boardSelectPos = boardSelectPos + 1
                if boardSelectPos > 8 then
                    boardSelectPos = 0
                end
            elseif btnp(2) then
                sfx(61)
                if boardSelectPos < 3 then
                    boardSelectPos = boardSelectPos + 6
                else
                    boardSelectPos = boardSelectPos - 3
                end
            elseif btnp(3) then
                sfx(61)
                if boardSelectPos >= 6 then
                    boardSelectPos = boardSelectPos - 6
                else
                    boardSelectPos = boardSelectPos + 3
                end
            elseif btnp(4) then
                if board[boardSelectPos+1] == nil then
                    sfx(60)
                    placeCard(1, boardSelectPos+1, handSelectPos+1)
                else
                    sfx(56)
                end
            elseif btnp(5) then
                sfx(60)
                selectingHand = true
                handSelectPos = 0
            end
            
        end
    elseif currentPlayer == 2 then
        takeAITurn()
    end
end



function _draw()    
    cls()
    
    if(started) then
        countCards();
        drawGame()
        if isGameOver() then
            if(players[1]["gamescore"] > players[2]["gamescore"]) then
                sfx(58)
            else
                sfx(57)
            end
            drawWinStatus()
            wait(60)
            newGame()
        end        
    else
        if DEBUG_ENABLE then
            -- started = true
            -- newGame()
            in_menu = true
            if(in_instructions) then
                drawInstructions()
            else
                drawMenu()
            end
        else
            coresume(splashScreen)
            if costatus(splashScreen) == "dead" then
                in_menu = true
                if(in_instructions) then
                    drawInstructions()
                else
                    drawMenu()
                end
            end
        end
    end
end