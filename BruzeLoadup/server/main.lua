--[[ Kick a player if they try joining ]]--
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    setKickReason("Connection Refused:Server on startup")
    CancelEvent()
end)