-- [[ Disable Reticle ]] --
Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)

-- [[ Disable NPC Spawns - Credit to Blu ]] --
Citizen.CreateThread(function()
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE") -- this should disable city sounds
	while true do
		-- These natives has to be called every frame.
		SetVehicleDensityMultiplierThisFrame(0.0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)

		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);

		-- These natives do not have to be called everyframe.
		SetGarbageTrucks(0)
		SetRandomBoats(0)

		EnableDispatchService(1,false)
		EnableDispatchService(2,false)
		EnableDispatchService(3,false)
		EnableDispatchService(4,false)
		EnableDispatchService(5,false)
		EnableDispatchService(6,false)
		EnableDispatchService(7,false)
		EnableDispatchService(8,false)
		EnableDispatchService(9,false)
		EnableDispatchService(10,false)
		EnableDispatchService(11,false)
		EnableDispatchService(12,false)
		EnableDispatchService(13,false)
		EnableDispatchService(14,false)
		EnableDispatchService(15,false)
		
		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
				SetPlayerWantedLevel(PlayerId(), 0, false)
				SetPlayerWantedLevelNow(PlayerId(), false)
		end
		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		local handle, veh = FindFirstVehicle()
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
		repeat
			if GetVehicleEngineHealth(veh) <= 100 then
				SetEntityAsMissionEntity(veh,true,true)
				SetEntityAsNoLongerNeeded(veh)
				local model = GetEntityModel(veh)
				SetModelAsNoLongerNeeded(model)
				SetVehicleUndriveable(veh,true)
				SetVehicleEngineOn(veh,false,true,true)
				SetEntityAsMissionEntity(veh,true,true)
			end
			finished, veh = FindNextVehicle(handle) -- first param returns true while entities are found
			if GetVehicleEngineHealth(veh) <= 100 then
				SetEntityAsMissionEntity(veh,true,true)
				SetEntityAsNoLongerNeeded(veh)
				local model = GetEntityModel(veh)
				SetVehicleUndriveable(veh,true)
				SetVehicleEngineOn(veh,false,true,true)
				SetModelAsNoLongerNeeded(model)
			end
		until not finished
		EndFindVehicle(handle)
		Citizen.Wait(160000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local handle, ped = FindFirstPed()
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
		repeat
			if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) then
				SetEntityAsMissionEntity(ped,true,true)
				SetEntityAsNoLongerNeeded(ped)
				local model = GetEntityModel(ped)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(ped,true,true)
				DeleteEntity(ped)
				Citizen.Trace("Deleted Dead Zombie")
			end
			finished, ped = FindNextPed(handle) -- first param returns true while entities are found
			if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) then
				SetEntityAsMissionEntity(ped,true,true)
				SetEntityAsNoLongerNeeded(ped)
				local model = GetEntityModel(ped)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(ped,true,true)
				DeleteEntity(ped)
				Citizen.Trace("Deleted Dead Zombie")
			end
		until not finished
		EndFindPed(handle)
		Citizen.Wait(60000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local handle, ped = FindFirstPed()
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
		repeat
			if not IsPedAPlayer(ped) then
				if GetRelationshipBetweenPeds(ped, PlayerPedId()) ~= 5 then
					DeletePed(ped)
				end
			end

			finished, ped = FindNextPed(handle) -- first param returns true while entities are found

			if not IsPedAPlayer(ped) then
				if GetRelationshipBetweenPeds(ped, PlayerPedId()) ~= 5 then
					DeletePed(ped)
				end
			end

		until not finished
		EndFindPed(handle)
		Citizen.Wait(60000)
	end
end)

-- [[ Improved Recoil - Credit to Blu I believe ]] --
local recoils = {
	[453432689] = 0.4, -- PISTOL
	[3219281620] = 0.4, -- PISTOL MK2
	[1593441988] = 0.3, -- COMBAT PISTOL
	[584646201] = 0.2, -- AP PISTOL
	[2578377531] = 0.7, -- PISTOL .50
	[324215364] = 0.3, -- MICRO SMG
	[736523883] = 0.3, -- SMG
	[2024373456] = 0.2, -- SMG MK2
	[4024951519] = 0.2, -- ASSAULT SMG
	[3220176749] = 0.3, -- ASSAULT RIFLE
	[961495388] = 0.3, -- ASSAULT RIFLE MK2
	[2210333304] = 0.2, -- CARBINE RIFLE
	[4208062921] = 0.2, -- CARBINE RIFLE MK2
	[2937143193] = 0.2, -- ADVANCED RIFLE
	[2634544996] = 0.2, -- MG
	[2144741730] = 0.2, -- COMBAT MG
	[3686625920] = 0.2, -- COMBAT MG MK2
	[487013001] = 0.5, -- PUMP SHOTGUN
	[2017895192] = 0.8, -- SAWNOFF SHOTGUN
	[3800352039] = 0.5, -- ASSAULT SHOTGUN
	[2640438543] = 0.3, -- BULLPUP SHOTGUN
	[911657153] = 0.2, -- STUN GUN
	[100416529] = 0.7, -- SNIPER RIFLE
	[205991906] = 0.8, -- HEAVY SNIPER
	[177293209] = 0.8, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.02, -- MINIGUN
	[3218215474] = 0.3, -- SNS PISTOL
	[1627465347] = 0.2, -- GUSENBERG
	[3231910285] = 0.3, -- SPECIAL CARBINE
	[3523564046] = 0.6, -- HEAVY PISTOL
	[2132975508] = 0.3, -- BULLPUP RIFLE
	[137902532] = 0.5, -- VINTAGE PISTOL
	[2828843422] = 0.8, -- MUSKET
	[984333226] = 0.3, -- HEAVY SHOTGUN
	[3342088282] = 0.4, -- MARKSMAN RIFLE
	[1672152130] = 99.9, -- HOMING LAUNCHER
	[1198879012] = 1.0, -- FLARE GUN
	[171789620] = 0.3, -- COMBAT PDW
	[3696079510] = 1.0, -- MARKSMAN PISTOL
  	[1834241177] = 99.4, -- RAILGUN
	[3675956304] = 0.4, -- MACHINE PISTOL
	[3249783761] = 0.7, -- REVOLVER
	[4019527611] = 0.8, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.4, -- COMPACT RIFLE
	[317205821] = 1.0, -- AUTO SHOTGUN
	[125959754] = 0.6, -- COMPACT LAUNCHER
	[3173288789] = 0.2, -- MINI SMG		
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= recoils[wep]
			end
			
		end
	end
end)

-- [[ Weapon Drop - Blu again ]] --
RegisterNetEvent("dropweapon")
AddEventHandler('dropweapon', function()
	local ped = PlayerPedId()
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		local x,y,z = table.unpack(GetEntityCoords(ped,true))
		local weaponHash = GetSelectedPedWeapon(ped)
		local ammo = GetAmmoInPedWeapon(ped, weapon)
		local _,clipammo = GetAmmoInClip(ped, weapon)
		--RemoveWeaponFromPed(ped, weapon)
		local weapon = tostring(weaponHash)
		local weapon = reverseWeaponHash(weapon,2)
		if weapon then
			RemoveWeaponFromPed(ped, weaponHash)
			ForceCreateWeaponPickupAtCoord(x+4,y,z, weapon, ammo-(clipammo*2))
		end
	end
end)