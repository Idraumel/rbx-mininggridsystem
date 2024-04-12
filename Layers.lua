local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local BlockLib = require(ReplicatedStorage.ModuleScripts.BlockLib)

local Layers = {}

Layers.Lib = {

	{
		
		MaxGridPositionY = -1,
		MinGridPositionY = -500,
		LootTable = {

			BlockLib.Bismuth, BlockLib.DawgCrystal, BlockLib.SparkleCrystal, BlockLib.Galaxy, BlockLib.Amethyst, BlockLib.Electronium, BlockLib.Leafonium, BlockLib.Xyphrine, BlockLib.Coal, BlockLib.Iron, BlockLib.Silver, BlockLib.Storminite, BlockLib.Ruby, BlockLib.Sparktite, BlockLib.Stone
		},
		BaseBlock = BlockLib.Stone
	},
	{

		MaxGridPositionY = -501,
		MinGridPositionY = -1000,
		LootTable = {

			BlockLib.Nickel, BlockLib.Ethernite, BlockLib.Sulfur, BlockLib.GreenSparktite, BlockLib.Zoomfernum, BlockLib.Cobalt, BlockLib.Sapphire, BlockLib.BlueSteel, BlockLib.Heartonium, BlockLib.Cloudnite, BlockLib.Nexotunium, BlockLib.Coal, BlockLib.Marble, BlockLib.Icetonium, BlockLib.Snow
		},
		BaseBlock = BlockLib.Marble
	},
	{

		MaxGridPositionY = -1001,
		MinGridPositionY = -1500,
		LootTable = {

			BlockLib.Chrome, BlockLib.Photonite, BlockLib.Nebulite, BlockLib.Phlournium, BlockLib.Steel, BlockLib.Emerald, BlockLib.Topaz, BlockLib.Diamond, BlockLib.Sandinite, BlockLib.Ulstranium, BlockLib.Granite, BlockLib.BlackDiamond, BlockLib.Snowsplistium
		},
		BaseBlock = BlockLib.Granite
	},
	{

		MaxGridPositionY = -1501,
		MinGridPositionY = -2000,
		LootTable = {

			BlockLib.Brass, BlockLib.NorthernStar, BlockLib.LaserCrystal, BlockLib.Gold, BlockLib.Clay, BlockLib.Gassnesium, BlockLib.Tarcoonum, BlockLib.Grooveonium, BlockLib.Blosum, BlockLib.Galaxite, BlockLib.Salt
		},
		BaseBlock = BlockLib.Clay
	},
	{

		MaxGridPositionY = -2001,
		MinGridPositionY = -2500,
		LootTable = {

			BlockLib.Teal, BlockLib.Grass, BlockLib.Limestone, BlockLib.QuasarA3, BlockLib.Reflectum, BlockLib.CondensedBallOfMatterFromSpace, BlockLib.Cinnabar, BlockLib.Uranium, BlockLib.WaterCrystal, BlockLib.Terranium
		},
		BaseBlock = BlockLib.Limestone
	},
	{

		MaxGridPositionY = -2501,
		MinGridPositionY = -3000,
		LootTable = {

			BlockLib.Quartz, BlockLib.Tungsten, BlockLib.Obsidian, BlockLib.Darkitinuim, BlockLib.R3a49, BlockLib.Frostical, BlockLib.Glaxtintium, BlockLib.SpectralQuartz, BlockLib.Darkrite, BlockLib.Blacktite
		},
		BaseBlock = BlockLib.Obsidian
	},
	{

		MaxGridPositionY = -3001,
		MinGridPositionY = -3500,
		LootTable = {

			BlockLib.Core, BlockLib.Platinum, BlockLib.Copper, BlockLib.SolarFlare, BlockLib.Flamenite, BlockLib.Tanzinite, BlockLib.Incineratium, BlockLib.Flare, BlockLib.Crystanite, BlockLib.Barrier
		},
		BaseBlock = BlockLib.Core
	}
}

local function sortLootTables()
	
	for _, layer in ipairs(Layers.Lib) do
		
		-- get a table containing all of the blocks of the loot table in ascending order (least to most probable)
		local sortedTable = table.clone(layer.LootTable)
		table.sort(sortedTable, function(a, b)
			
			return a.Probability > b.Probability
		end)
		layer.SortedLootTable = sortedTable
	end
end
-- sort look tables with sorting using probability and going from rarest to most common (base block)
sortLootTables()

-- gets a random block depending on the layer's loottable and a possible luck multiplier
function Layers.getRandomBlock(gridY, luckMultiplier)	
	
	-- get the layer associated with this gridY
	local layer, i = nil, 1
	while not layer and i <= #Layers.Lib do
		
		local currentLayer = Layers.Lib[i]
		
		if currentLayer.MinGridPositionY <= gridY and gridY <= currentLayer.MaxGridPositionY then

			layer = currentLayer
		end
		
		i += 1
	end
	
	-- if there are no layers for this gridY then return nil
	if not layer then return end
	
	-- from the rarest to the most common block in the loot table, check if it can spawn. If not then try the next one
	local block, i = nil, 1
	while not block and i <= #layer.LootTable do
		
		local currentBlock = layer.SortedLootTable[i]
		
		local processedProbability = currentBlock.Probability
		if luckMultiplier then processedProbability = math.ceil(processedProbability / luckMultiplier) end
		
		local randomInt = Random.new():NextInteger(1, processedProbability)
		
		if randomInt == 1 then
			
			block = currentBlock
			break
		end
		
		i += 1
	end
	
	return block
end

-- get the lowest gridY of the lowest layer
function Layers.getLowestGridY()
	
	local lowestGridY = math.huge
	
	for _, layer in ipairs(Layers.Lib) do
		
		if layer.MinGridPositionY < lowestGridY then
			
			lowestGridY = layer.MinGridPositionY
		end
	end
	
	return lowestGridY
end

-- TODO - should be done at the start of the game
function Layers.getBlockDepthInterval(blockName)
	
	local MaxGridPositionY, MinGridPositionY = -math.huge, 0
	for _, layerTable in ipairs(Layers.Lib) do
		
		local foundBlock, i = false, 1
		while not foundBlock and i <= #layerTable.LootTable do
			
			local lootTableBlockTable = layerTable.LootTable[i]
			local key = string.gsub(lootTableBlockTable.Name, " ", "")
			if key == blockName then
				
				if layerTable.MaxGridPositionY > MaxGridPositionY then MaxGridPositionY = layerTable.MaxGridPositionY end
				if layerTable.MinGridPositionY < MinGridPositionY then MinGridPositionY = layerTable.MinGridPositionY end
				foundBlock = true
			end
			
			i += 1
		end
	end
	
	return MaxGridPositionY, MinGridPositionY
end

return Layers
