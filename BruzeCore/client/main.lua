local default = {x = -208.037, y = -1018.613, z = 30.138, skin = "S_M_M_Gaffer_01"}

Citizen.CreateThread(function ()
	while not NetworkIsSessionStarted() do
		Citizen.Wait(0)
	end
	Citizen.Wait(1000)
	
	local model = GetHashKey(default.skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    end
	SetEntityCoords(GetPlayerPed(-1), default.x, default.y, default.z, 1, 0, 0, 1)
end)