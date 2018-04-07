Players = {}
Users = {}

local dir = { main = "D:/Bruze/data",	users = "D:/Bruze/data/users", bans = "D:/Bruze/data/bans"}

local DefaultUser = {
	license = "",
    group = "user", 
    permissions = 0,
    coords = {x = -208.037, y = -1018.613, z = 30.138},
	model = "S_M_M_Gaffer_01",
	money = 2000,
	weapons = {},
	inventory = {},
	zkills = 0,
	pkills = 0,
	humanity = 0,
	online = true,
	new = true,
}

-- Player Joins --
AddEventHandler('playerConnecting', function(playerName, setKickReason)
	local identifier = getID("steam", source)
	if identifier then
		print("[BruZe Core] Player ".. playerName .." (".. identifier ..") is connecting...")
		local steamHex = string.gsub(identifier, "steam:", "")

		local bans = loadData("bans.txt", dir.bans)
		local found = false
		for i = 1, #bans do
			if bans[i] == identifier then
				found = true
			end
		end
		if not found then
			if file_exists(steamHex..".txt", dir.users) then
				print("[BruZe Core] ".. playerName .." is a returning player.")
				loadUser(steamHex, source)
			else
				print("[BruZe Core] ".. playerName .." is a new player.")
				loadNewUser(steamHex, source)
			end
		else
			setKickReason("You are banned from the BruZe servers.")
			print("[BruZe Core] Player ".. playerName .." tried to connect but is banned.")
			CancelEvent()
		end
	else
		setKickReason("BruZe - You must be connected to steam to play on this server!")
		print("[BruZe Core] Player ".. playerName .." tried to connect but isn't logged in to steam.")
		CancelEvent()
	end

end)

-- Player Leaves --
AddEventHandler('playerDropped', function()
	print("[BruZe Core] Player ".. GetPlayerName(source) .." is disconnecting...")
	local src = tonumber(source)
    if(Users[src]) or Users[src] ~= nil then
        local user = Users[src]
        local saveUser = {
        	license = v.getLicense(),
            group = v.getGroup(), 
   			permissions = v.getPermissions(),
    		coords = v.getCoords(),
			model = v.getModel(),
		    money = v.getMoney,
			weapons = v.getWeapons(),
			inventory = v.getInventory(),
			zkills = v.getZombieKills(),
			pkills = v.getPlayerKills(),
			humanity = v.getHumanity(),
			online = v.getOnline(),
			new = v.getNew(),
        }
        saveData(saveUser, string.gsub(user.getIdentifier(), "steam:", "")..".txt",dir.users)
        Users[src] = nil
		print("[BruZe Core] Player ".. GetPlayerName(source) .." has disconnected.")
    end
end)

-- Create User --
function loadNewUser(identifier, source)
	local newUser = DefaultUser
	newUser.license = getID("license", source)
	saveData(newUser, identifier..".txt", dir.users)
	loadUser(identifier, source)
end

-- Load User --
function loadUser(identifier, source)
	local data = loadData(string.gsub(getID("steam", source), "steam:", "")..".txt", dir.users)
    Users[source] = createUser(source, data)
    print("[BruZe Core] Player ".. GetPlayerName(source) .." has loaded.")
end

-- Save User --
function saveUser()
	SetTimeout(60000, function()
		for k,v in pairs(Users)do
            if Users[k] ~= nil then
                if v.get('haveChanged') == true then
                    local saveUser = {
                        group = v.getGroup(), 
   						permissions = v.getPermissions(),
    					coords = v.getCoords(),
						model = v.getModel(),
						money = v.getMoney,
						weapons = v.getWeapons(),
						inventory = v.getInventory(),
						zkills = v.getZombieKills(),
						pkills = v.getPlayerKills(),
						humanity = v.getHumanity(),
						online = v.getOnline(),
						new = v.getNew(),
                    }
                    saveData(saveUser, string.gsub(v.getIdentifier(), "steam:", "")..".txt",dir.users)
                    v.set('haveChanged', 0)
                end
            end
        end
        saveUser()
	end)
end
saveUser()

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

-- Get Players --
AddEventHandler('f:getPlayers', function(cb)
    cb(Users)
end)

-- Get All Players --
AddEventHandler('f:getAllPlayers', function(cb)
    local All = {}
    for k,v in pairs(Players) do
        local u = loadData(v..".txt",dir.users)
        table.insert(All, u)
    end
    cb(All)
end)

-- Get Player File --
AddEventHandler("f:getPlayerFile", function(identifier, cb)
    if file_exists(identifier..".txt",dir.users) then
        cb(loadData(identifier..".txt",dir.users))
    else
        cb(nil)
    end
end)

-- Get Player --
AddEventHandler("z:getPlayer", function(user, cb)
    if(Users)then
        if(Users[user])then
            cb(Users[user])
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

-- Get Dir --
AddEventHandler("z:getdir", function(cb)
    cb(dir.main)
end)