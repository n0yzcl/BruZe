Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
	local diedAt

    while true do
        Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end

                local killer = NetworkGetEntityKillerOfPlayer(player)
				local killerentitytype = GetEntityType(killer)
				local killertype = -1
				local killerinvehicle = false
				local killervehiclename = ''
                local killervehicleseat = 0
                local causeOfDeath = GetPedCauseOfDeath(ped)
				if killerentitytype == 1 then
					killertype = GetPedType(killer)
					if IsPedInAnyVehicle(killer, false) == 1 then
						killerinvehicle = true
						killervehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(killer)))
                        killervehicleseat = GetPedVehicleSeat(killer)
					else killerinvehicle = false
					end
				end
                if (causeOfDeath == GetHashKey("WEAPON_RUN_OVER_BY_CAR") or causeOfDeath == GetHashKey("WEAPON_RAMMED_BY_CAR")) then
                    causeOfDeath = "flattened"
                elseif (causeOfDeath == GetHashKey("WEAPON_CROWBAR")) or (causeOfDeath == GetHashKey("WEAPON_BAT")) or
                       (causeOfDeath == GetHashKey("WEAPON_HAMMER")) or (causeOfDeath == GetHashKey("WEAPON_GOLFCLUB")) or
                       (causeOfDeath == GetHashKey("WEAPON_NIGHTSTICK")) or (causeOfDeath == GetHashKey("WEAPON_KNUCKLE")) or
                       (causeOfDeath == GetHashKey("WEAPON_BATTLEAXE")) or (causeOfDeath == GetHashKey("WEAPON_POOLCUE")) or
                       (causeOfDeath == GetHashKey("WEAPON_HATCHET")) or (causeOfDeath == GetHashKey("WEAPON_WRENCH")) or
                       (causeOfDeath == GetHashKey("WEAPON_MACHETE")) then
                    causeOfDeath = "whacked"
                elseif (causeOfDeath == GetHashKey("WEAPON_DAGGER")) or (causeOfDeath == GetHashKey("WEAPON_KNIFE")) or
                       (causeOfDeath == GetHashKey("WEAPON_SWITCHBLADE")) or (causeOfDeath == GetHashKey("WEAPON_BOTTLE")) then
                    causeOfDeath = "stabbed"
                elseif (causeOfDeath == GetHashKey("WEAPON_SNSPISTOL")) or (causeOfDeath == GetHashKey("WEAPON_HEAVYPISTOL")) or
                       (causeOfDeath == GetHashKey("WEAPON_VINTAGEPISTOL")) or (causeOfDeath == GetHashKey("WEAPON_PISTOL")) or
                       (causeOfDeath == GetHashKey("WEAPON_APPISTOL")) or (causeOfDeath == GetHashKey("WEAPON_COMBATPISTOL")) or
                       (causeOfDeath == GetHashKey("WEAPON_REVOLVER")) or (causeOfDeath == GetHashKey("WEAPON_MACHINEPISTOL")) or
                       (causeOfDeath == GetHashKey("WEAPON_MARKSMANPISTOL")) or (causeOfDeath == GetHashKey("WEAPON_PISTOL_MK2")) then
                    causeOfDeath = "shot"
                elseif (causeOfDeath == GetHashKey("WEAPON_GRENADELAUNCHER")) or (causeOfDeath == GetHashKey("WEAPON_HOMINGLAUNCHER")) or 
                       (causeOfDeath == GetHashKey("VEHICLE_WEAPON_PLANE_ROCKET")) or (causeOfDeath == GetHashKey("WEAPON_COMPACTLAUNCHER")) or 
                       (causeOfDeath == GetHashKey("WEAPON_STICKYBOMB")) or( causeOfDeath == GetHashKey("WEAPON_PROXMINE")) or 
                       (causeOfDeath == GetHashKey("WEAPON_RPG")) or (causeOfDeath == GetHashKey("WEAPON_EXPLOSION")) or 
                       (causeOfDeath == GetHashKey("VEHICLE_WEAPON_TANK")) or (causeOfDeath == GetHashKey("WEAPON_GRENADE")) or 
                       (causeOfDeath == GetHashKey("WEAPON_RAILGUN")) or (causeOfDeath == GetHashKey("WEAPON_FIREWORK")) or 
                       (causeOfDeath == GetHashKey("WEAPON_PIPEBOMB")) or (causeOfDeath == GetHashKey("VEHICLE_WEAPON_SPACE_ROCKET")) then
                    causeOfDeath = "bombed"
                elseif (causeOfDeath == GetHashKey("WEAPON_MICROSMG")) or (causeOfDeath == GetHashKey("WEAPON_SMG")) or
                       (causeOfDeath == GetHashKey("WEAPON_ASSAULTSMG")) or (causeOfDeath == GetHashKey("WEAPON_MG")) or
                       (causeOfDeath == GetHashKey("WEAPON_COMBATMG")) or (causeOfDeath == GetHashKey("WEAPON_COMBATPDW")) or
                       (causeOfDeath == GetHashKey("WEAPON_COMBATMG_MK2")) or (causeOfDeath == GetHashKey("WEAPON_MINIGUN")) or
                       (causeOfDeath == GetHashKey("WEAPON_SMG_MK2")) then
                    causeOfDeath = "sprayed"
                elseif (causeOfDeath == GetHashKey("WEAPON_ASSAULTRIFLE")) or (causeOfDeath == GetHashKey("WEAPON_CARBINERIFLE")) or
                       (causeOfDeath == GetHashKey("WEAPON_ADVANCEDRIFLE")) or (causeOfDeath == GetHashKey("WEAPON_BULLPUPRIFLE")) or
                       (causeOfDeath == GetHashKey("WEAPON_MARKSMANRIFLE")) or (causeOfDeath == GetHashKey("WEAPON_COMPACTRIFLE")) or
                       (causeOfDeath == GetHashKey("WEAPON_ASSAULTRIFLE_MK2")) or (causeOfDeath == GetHashKey("WEAPON_CARBINERIFLE_MK2")) or
                       (causeOfDeath == GetHashKey("WEAPON_SPECIALCARBINE")) or (causeOfDeath == GetHashKey("WEAPON_GUSENBERG")) then
                    causeOfDeath = "rifled"
                elseif (causeOfDeath == GetHashKey("WEAPON_HEAVYSNIPER_MK2")) or (causeOfDeath == GetHashKey("WEAPON_SNIPERRIFLE")) or
                       (causeOfDeath == GetHashKey("WEAPON_HEAVYSNIPER")) or (causeOfDeath == GetHashKey("WEAPON_ASSAULTSNIPER")) or
                       (causeOfDeath == GetHashKey("WEAPON_REMOTESNIPER")) then
                    causeOfDeath = "sniped"
                elseif (causeOfDeath == GetHashKey("WEAPON_BULLPUPSHOTGUN")) or (causeOfDeath == GetHashKey("WEAPON_ASSAULTSHOTGUN")) or
                       (causeOfDeath == GetHashKey("WEAPON_PUMPSHOTGUN")) or (causeOfDeath == GetHashKey("WEAPON_HEAVYSHOTGUN")) or
                       (causeOfDeath == GetHashKey("WEAPON_SAWNOFFSHOTGUN")) then
                    causeOfDeath = "shotgunned"
                elseif (causeOfDeath == GetHashKey("WEAPON_MOLOTOV")) or (causeOfDeath == GetHashKey("WEAPON_FLAREGUN")) then
                    causeOfDeath = "torched"
                else
                    causeOfDeath = "killed"
                end
				local killerid = GetPlayerByEntityID(killer)
				if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
				else killerid = -1
				end

                if killer == ped or killer == -1 then
                    TriggerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    TriggerServerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped)), deathreason=causeOfDeath})
                    TriggerServerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped)), deathreason=causeOfDeath})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end

            -- check if the player has to respawn in order to trigger an event
            if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
                TriggerEvent('baseevents:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })
                TriggerServerEvent('baseevents:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })

                hasBeenDead = true
            elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
                hasBeenDead = false
            end
        end
    end
end)

function GetPlayerByEntityID(id)
	for i=0,32 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end