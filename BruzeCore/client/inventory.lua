-- [[ Vars ]] --
local maxHunger = 200
local maxThirst = 200
local hunger = maxHunger
local thirst = maxThirst

-- [[ Item Usage ]] --
function use(itemId, itemType)
	if itemType == 1 then eat(itemId) end
	if itemType == 2 then drink(itemId) end
	if itemType == 3 then heal(itemId) end
	if itemType == 4 then armour(itemId) end
end

function eat(itemId)
	if hunger < maxHunger then
		if itemId == 1 then -- Chocolate bar
			hunger = hunger + 25
			if hunger > maxHunger then hunger = maxHunger end
		else
			Notify("This item can not be eaten.")
		end
	else
		Notify("Your hunger is already full.")
	end
end

function drink(itemId)
	if thirst < maxThirst then
		if itemId == 10 then -- Water
			thirst = thirst + 25	
		elseif itemId == 11 then
			thirst = thirst + 30	
		else
			Notify("This item can not be drunk.")
		end
		if thirst > maxThirst then thirst = maxThirst end
	else
		Notify("Your thirst is already full.")
	end
end

function heal(itemId)
end

function armour(itemId)
end

-- [[ Hunger/Thirst ]] --
Citizen.CreateThread(function()
	while true do
		if hunger > 0 then
			hunger = hunger - 1
		end
		if thirst > 0 then
			thirst = thirst - 1
		end
		Citizen.Wait(9000) -- 9 second wait
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = GetPlayerPed(-1)
		if hunger < 30 then
			SetEntityHealth(ped, GetEntityHealth(ped) - 10)
			if hunger < 10 then
				SetEntityHealth(ped, GetEntityHealth(ped) - 25)
				if hunger < 2 then
					SetEntityHealth(ped, GetEntityHealth(ped) - 50)
				end
			end
		end

		if thirst < 30 then
			SetEntityHealth(ped, GetEntityHealth(ped) - 10)
			if thirst < 10 then
				SetEntityHealth(ped, GetEntityHealth(ped) - 25)
				if thirst < 2 then
					SetEntityHealth(ped, GetEntityHealth(ped) - 50)
				end
			end
		end
	end
end)

-- [[ HUD Stuff ]] --