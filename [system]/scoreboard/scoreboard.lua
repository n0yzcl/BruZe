local listOn = false
Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)
        if IsControlPressed(0, 20) then
            if not listOn then
                local players = {}
                ptable = GetPlayers()
                for _, i in ipairs(ptable) do
                    r, g, b = GetPlayerRgbColour(i)
                    table.insert(players, 
                    '<tr><td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td><td></td></tr>'
                    )
                end
                
                SendNUIMessage({ text = table.concat(players), count = #players })

                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 20) == false) then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    
    return players
end