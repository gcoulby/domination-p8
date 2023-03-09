
INT_MIN = -32768

function printChar(char, x, y, color, bgColor)
    rectfill(x,y,x+4,y+6,bgColor)
    print(char,x+1,y+1,color)
end

function padWithLeadingZeroes(num, len)
    local str = tostr(num)
    while #str < len do
        str = "0"..str
    end
    return str
end

function ternary ( cond , T , F )
    if cond then return T else return F end
end

function debug ( o , x)
    print(o, ternary(x ~= nil, x, 1), 1, 7)
end


function delay ( len )
    local t0 = t()
    repeat
        -- wait
        printh("AI is thinking..." .. " " .. t() .. " " .. t0, "log")
    until t() - t0 > len
    -- while t() - t0 <= len do end
end


function wait(a) for i = 1,a do flip() end end

function startMusic(n)
    if(stat(57) == false) then
        music(n)
    end
end

function stopMusic()
    if(stat(57)== true) then
        music(-1)
    end
end