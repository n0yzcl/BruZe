RegisterServerEvent('baseevents:onPlayerDied')
RegisterServerEvent('baseevents:onPlayerKilled')
RegisterServerEvent('baseevents:onPlayerWasted')
RegisterServerEvent('baseevents:enteringVehicle')
RegisterServerEvent('baseevents:enteringAborted')
RegisterServerEvent('baseevents:enteredVehicle')
RegisterServerEvent('baseevents:leftVehicle')

AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
	local victim = source
	if GetPlayerName(killedBy) and GetPlayerName(victim) then
		TriggerClientEvent('chatMessage', -1, "^1-", {0, 255, 0}, "^3"..GetPlayerName(killedBy).." "..data.deathreason.." "..GetPlayerName(victim))
	elseif GetPlayerName(killedBy) and not GetPlayerName(victim) then
		TriggerClientEvent('chatMessage', -1, "^1-", {0, 255, 0}, "^3"..GetPlayerName(killedBy).." "..data.deathreason.." Someone")
	elseif not GetPlayerName(killedBy) and GetPlayerName(victim) then
		TriggerClientEvent('chatMessage', -1, "^1-", {0, 255, 0}, "^3Someone "..data.deathreason.." "..GetPlayerName(victim))
	end
	RconLog({msgType = 'playerKilled', victim = victim, attacker = killedBy, data = data})
end)

AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source

	RconLog({msgType = 'playerDied', victim = victim, attackerType = killedBy, pos = pos})
end)