AddEventHandler('playerConnecting', function(playerName, setKickReason)
	
end)

-- Load Data --

-- Load Player Data --

-- Save Data --

-- Check If Data Exists --

-- Check The Hex --

-- Check If Hex Exists --

-- Check If Banned --

--[[ Plan 

	- Player connects
	- Check if they have a hex
		- Kick if they don't
	- See if the player data exists to that hex
		- If none exists, create one with the default data
		- Load that player data and spawn the player using it

]] --

local DefaultPlayer = {
	["coords"] = {x=1,y=1,z=1}, -- Their current location
	["model"] = 0, -- Their player model
	["money"] = 2000, -- How much money they have
	["weapons"] = {}, -- Their weapons they own
	["inventory"] = {}, -- Their inventory
	["zkills"] = 0, -- How many zombie kills theyve had
	["pkills"] = 0, -- How many player kills theyve had
	["humanity"] = 0, -- How much humanity they have
	["other"] = {
		online = true,
		new = true,
	},
}