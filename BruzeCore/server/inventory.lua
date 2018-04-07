--[[
	
	Item Types -
		0 then no use
		1 then eat
		2 then drink
		3 then heal
		4 then armour

	Reserved Item IDs - 
		1 - 9 Food
		10 - 19 Drink
		20 - 49 Other
		50+ Missions

]]--

items = {
	-- Food
	{name="Chocolate Bar", id = 1, itemType = 1},

	-- Drinks
	{name="Water", id = 10, itemType = 2},
	{name="Red Bull", id = 11, itemType = 2},

	-- Other
	{name="Medkit", id = 20, itemType = 3},
	{name="Armour", id = 21, itemType = 4},

	-- Missions
	{name="Loot Crate Key", id = 50, itemType = 0},
	{name="Loot Crate", id = 51, itemType = 0},
}