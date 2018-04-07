local users = {}
local players = {}
local bans = {}
local dir = {
	main = "D:/Bruze/data",
	users = "D:/Bruze/data/users",
	bans = "D:/Bruze/data/bans",
}
local DefaultUser = {
	["Power"] = {
        group = "user", 
        permissions = 0,
    },
	["player"] = {
		coords = {},
		model = 0,
	},
	["owned"] = {
		money = 2000,
		weapons = {},
		inventory = {},
	},
	["stats"] = {
		zkills = 0,
		pkills = 0,
		humanity = 0,
	},
	["extras"] = {
		online = true,
		new = true,
	},
}

AddEventHandler('playerConnecting', function(playerName, setKickReason)
	local identifier = getID("steam", source)
	local hex = string.gsub(identifier, "steam:", "")
	print("[BruzeCore] User ".. playerName .." (".. identifier ..") is connecting...")

	if identifier == nil or identifier == 0 or identifier == false then
		print("[BruzeCore] User ".. playerName .." was declined as they are no signed into steam.")
		SetKickReason("You must be signed into steam to join this server!")
		CancelEvent()
	end

	bans = loadBans()
	for i, v in pairs(bans) do
		if v[1] == identifier then
			print("[BruzeCore] User ".. playerName .." was declined as they are banned.")
			setKickReason("You are banned: ".. v[2] .." - Appeal on discord.me/bruze")
			CancelEvent()
		end
	end

	if file_exists(hex..".txt", dir.users) then
		users[source] = loadPlayerData(hex)
		print("[BruzeCore] User ".. playerName .." (".. identifier ..") is a returning player.")
	else
		users[source] = DefaultPlayer
		print("[BruzeCore] User ".. playerName .." (".. identifier ..") is a new player!")
		if saveData(DefaultPlayer, hex..".txt", dir.users) then
			print("[BruzeCore] User ".. playerName .." (".. identifier ..") has successfully been saved!")
		else
			print("[BruzeCore] User ".. playerName .." (".. identifier ..") has unsuccessfully been saved!")
		end
	end

	table.insert(players, identifier)
	print("[BruzeCore] User ".. playerName .." (".. identifier ..") has connected.")
end)

-- Player Leaves --
AddEventHandler('playerDropped', function()
	local identifier = getID("steam", source)
	local hex = string.gsub(identifier, "steam:", "")
	print("[BruzeCore] User ".. GetPlayerName(source) .." (".. identifier ..") disconnecting...")
	for i, v in pairs(players) do
		if v[1] == identifier then
			table.remove(players, i)
		end
	end
	if saveData(users[source], hex..".txt", dir.users) then
		print("[BruzeCore] User ".. GetPlayerName(source) .." (".. identifier ..") has successfully been saved.")
	else
		print("[BruzeCore] User ".. GetPlayerName(source) .." (".. identifier ..") has unsuccessfully been saved.")
	end
end)

-- Load Data --
function loadData(filename, filepath)
    local path = filepath .. "/" .. filename
    local contents = ""
    local myTable = {}
    local file = io.open(path, "r")

    if file then
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close(file)
        return myTable
    end
    return nil
end

-- Load Player Data --
function loadPlayerData(hex)
	local data 

	if file_exists(hex..".txt", dir.users) then
		data = loadData(hex..".txt", dir.users)
	else
		data = {}
		print("[BruzeCore] No player data found for ".. hex ..".")
		-- Kick for no data
	end

	return data
end

-- Load Bans --
function loadBans()
	local data 

	if file_exists("bans.txt", dir.bans) then
		data = loadData("bans.txt", dir.bans)
	else
		data = {}
		saveData(data, "bans.txt", dir.bans)
	end

	return data
end

-- Save Data --
function saveData(t, filename, filepath)
    local path = filepath .. "/" .. filename
    local file = io.open(path, "w")

    if file then
        local contents = json.encode(t)
        file:write(contents)
        io.close(file)
        return true
    else
        return false
    end
end

-- Check If Data Exists --
function file_exists(filename, filepath)
    local path = filepath .. "/" .. filename
    local f=io.open(path,"r")
    if f~=nil then
        io.close(f)
        return true
    else 
        return false
    end
end

-- Check The Hex --
function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

--[[ Plan 

	- Player connects
	- Check if they have a hex
		- Kick if they don't
	- Check if the player is banned
		- Kick if they are
	- See if the player data exists to that hex
		- If none exists, create one with the default data
		- Load that player data and spawn the player using it

]] --