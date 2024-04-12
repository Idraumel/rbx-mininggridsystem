local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BlockSpawn = ReplicatedStorage.Assets.SFX.BlockSpawn

local Rarity = {}

Rarity.Lib = {
	
	{
		Min = 1,
		Max = 1,
		Name = "Common",
		Color = Color3.fromRGB(63, 63, 63)
	},
	{
		Min = 2,
		Max = 999,
		Name = "Uncommon",
		Color = Color3.fromRGB(147, 147, 147)
	},
	{
		Min = 1000,
		Max = 9999,
		Name = "Rare",
		Color = Color3.fromRGB(166, 236, 255)
	},
	{
		Min = 10000,
		Max = 99999,
		Name = "Super Rare",
		Color = Color3.fromRGB(255, 161, 253)
	},
	{
		Min = 100000,
		Max = 499999,
		Name = "Legendary",
		Color = Color3.fromRGB(255, 165, 55)
	},
	{
		Min = 500000,
		Max = 999999,
		Name = "Relic",
		Color = Color3.fromRGB(163, 13, 16)
	},
	{
		Min = 1000000,
		Max = 19999999,
		Name = "Mythical",
		Color = Color3.fromRGB(255, 255, 12),
		TextColor = Color3.fromRGB(255, 255, 12),
		SpawnSFX = BlockSpawn.Mythical,
		DiscordColor = 16776960
	},
	{
		Min = 20000000,
		Max = 49999999,
		Name = "Celestial",
		Color = Color3.fromRGB(143, 15, 255),
		TextColor = Color3.fromRGB(192, 34, 255),
		SpawnSFX = BlockSpawn.Celestial,
		DiscordColor = 10181046
	},
	{
		Min = 50000000,
		Max = 99999999,
		Name = "OMEGA",
		Color = Color3.fromRGB(23, 255, 42),
		TextColor = Color3.fromRGB(23, 255, 42),
		SpawnSFX = BlockSpawn.OMEGA,
		DiscordColor = 5763719
	},
	{
		Min = 100000000,
		Max = 499999999,
		Name = "Boundless",
		Color = Color3.fromRGB(11, 18, 81),
		TextColor = Color3.fromRGB(73, 152, 255),
		SpawnSFX = BlockSpawn.Boundless,
		DiscordColor = 3447003
	},
	{
		Min = 500000000,
		Max = 999999999,
		Name = "Fathomless",
		Color = Color3.fromRGB(255, 255, 255),
		TextColor = Color3.fromRGB(255, 255, 255),
		SpawnSFX = BlockSpawn.Fathomless,
		DiscordColor = 16777215
	},
	{
		Min = 1000000000,
		Max = 19999999999,
		Name = "Unworldly",
		Color = Color3.fromRGB(),
		TextColor = Color3.fromRGB(255, 133, 198),
		SpawnSFX = BlockSpawn.Unworldly,
		DiscordColor = 15277667
	},
	{
		Min = 20000000000,
		Max = math.huge,
		Name = "DEATH",
		Color = Color3.fromRGB(255, 0, 0),
		TextColor = Color3.fromRGB(255, 0, 0),
		SpawnSFX = BlockSpawn.DEATH,
		DiscordColor = 15548997
	}
}

function Rarity.getRarityTable(probability)
	
	local rarityTable, i = nil, 1
	while not rarityTable and i <= #Rarity.Lib do
		
		local currentRarityTable = Rarity.Lib[i]
		
		if currentRarityTable.Min <= probability and probability <= currentRarityTable.Max then
			
			rarityTable = currentRarityTable
		end
		
		i += 1
	end
	
	i -= 1
	
	return rarityTable, i
end

return Rarity
