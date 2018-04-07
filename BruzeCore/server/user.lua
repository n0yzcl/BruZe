function createUser(source, data)
	
	local self = {}
	self.source = tonumber(source)
	self.group = data.group, 
    self.permissions = data.permissions,
    self.coords = data.coords,
	self.model = data.model,
	self.money = data.money,
	self.weapons = data.weapons,
	self.inventory = data.inventory,
	self.zkills = data.zkills,
	self.pkills = data.pkills,
	self.humanity = data.humanity,
	self.new = data.new,
	self.haveChanged = false

	local z = {}

	z.getGroup = function()
		return self.group
	end

	z.setGroup = function(group)
		self.group = group
		SetChange(self)
	end

	z.getPermissions = function()
		return self.permissions
	end

	z.setPermissions = function(permissions)
		self.permissions = permissions
		SetChange(self)
	end

	z.getCoords = function()
		return self.coords
	end

	z.setCoords = function(coords)
		self.coords = coords
		SetChange(self)
	end

	z.getModel = function()
		return self.model
	end

	z.setModel = function(model)
		self.model = model
		SetChange(self)
	end

	z.getMoney = function()
		return self.money
	end

	z.addMoney = function(amount)
		self.money = self.money + amount
		SetChange(self)
	end

	z.removeMoney = function(amount)
		if self.money > amount then
			self.money = self.money - amount
			SetChange(self)
			return true
		else
			return false
		end
	end

	z.setMoney = function(money)
		self.money = money
		SetChange(self)
	end

	z.getWeapons = function()
		return self.weapons
	end

	z.setWeapons = function(weapons)
		self.weapons = weapons
		SetChange(self)
	end

	z.getInventory = function()
		return self.inventory
	end

	z.setInventory = function()
		self.inventory = {}
		SetChange(self)
	end

	z.addItem = function(itemId, amount)
		self.inventory[itemId] = self.inventory[itemId] + amount
		SetChange(self)
	end

	z.removeItem = function(itemId, amount)
		if not self.inventory[itemId] == nil then
			if self.inventory[itemId] >= amount then
				self.inventory[itemId] = self.inventory[itemId] - amount
				SetChange(self)
				return true
			else
				print("[BruZe Core] [User] Unable to remove item (Code 2)")
				return false
			end
		else
			print("[BruZe Core] [User] Unable to remove item (Code 1)")
			return false
		end
	end

	z.checkItem = function(itemId)
		return self.inventory[itemId]
	end

	z.addZombieKill = function()
		self.zkills = self.zkills + 1
		SetChange(self)
	end

	z.addPlayerKill = function()
		self.pkills = self.pkills + 1
		SetChange(self)
	end

	z.addHumanity = function(amount)
		self.humanity = self.humanity + amount
		if self.humanity > 2000 then
			self.humanity = 2000
			SetChange(self)
		end
	end

	z.removeHumanity = function(amount)
		self.humanity = self.humanity - amount
		if self.humanity < -2000 then
			self.humanity = -2000
			SetChange(self)
		end
	end

	z.checkHumanity = function()
		return self.humanity
	end

	z.markOld = function()
		self.new = false
		SetChange(self)
	end

	z.getOnline = function()
		return self.online
	end

	z.getNew = function()
		return self.new
	end
end

function SetChange(user)
	user.haveChanged = true
end