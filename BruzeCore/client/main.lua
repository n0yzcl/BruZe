Citizen.CreateThread(function ()
	while not NetworkIsSessionStarted() do
		Citizen.Wait(0)
	end
	Citizen.Wait(1000)
	
    TriggerServerEvent('z.getPlayer', GetServerId(-1), function(user)
	    local model = GetHashKey(user.getModel())
        if IsModelInCdimage(model) and IsModelValid(model) then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
        end
        
        local coords = user.getCoords()
	    SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z, 1, 0, 0, 1)
    end)
end)