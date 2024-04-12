-- Made by Idraumel for Interstellar Mines in 2023. (project cancelled)
-- This ModuleScript allows to create and manage a serverside 3d block grid.
-- It also features a function which generates random and natural-looking caves.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Layers = require(ReplicatedStorage.ModuleScripts.Layers)
local GridSettings = require(ReplicatedStorage.ModuleScripts.GridSettings)
local Rarity = require(ReplicatedStorage.ModuleScripts.Rarity)
local Utility = require(ReplicatedStorage.ModuleScripts.Utility)
local BlockLib = require(ReplicatedStorage.ModuleScripts.BlockLib)

local MineCapacityUpdate = ReplicatedStorage.RemoteEvents.MineCapacityUpdate
local NotificationClient = ReplicatedStorage.RemoteEvents.NotificationClient

local Grid = {}
Grid.__index = Grid

function Grid:Reset()
	
	-- destroy all physical parts
	for _, Block in pairs(self.Blocks) do
		
		Block:Destroy()
	end
	table.clear(self.Blocks)
	
	-- cleanup stored positions
	table.clear(self.StoredPositions)
	table.clear(self.BlocksPos)
	
	self:Generate()
end

function Grid:RefreshMineStatus()
	
	local function getCanUpdate()
		
		local canUpdate = false
		
		if not self.LastMineCapacityUpdateTime then
			
			canUpdate = true
			self.LastMineCapacityUpdateTime = time()
		else
			
			local delta = time() - self.LastMineCapacityUpdateTime
			if delta >= GridSettings.MineCapacityClientUpdateFrequence then
				
				canUpdate = true
				self.LastMineCapacityUpdateTime = time()
			end
		end
		
		return canUpdate
	end
	
	while true do
		
		local percentage = #self.StoredPositions / GridSettings.MineCapacity
		if percentage >= 1 then

			warn("The mine has reached its capacity, reset process debuting")
			
			-- begin reset process
			-- notify clients via custom announcement system
			local message = string.format("The mine will reset in %i seconds", GridSettings.MineResetCountdownSeconds)
			local notificationData = {
				
				SubjectKey = "MineReset",
				Message = message
			}
			NotificationClient:FireAllClients(notificationData)
			MineCapacityUpdate:FireAllClients(percentage)
			
			task.wait(GridSettings.MineResetCountdownSeconds)
			
			-- after cooldown is passed, teleport all players to surface
			Utility.teleportAllToSurface()
			
			-- reset grid
			self:Reset()
			
			percentage = #self.StoredPositions / GridSettings.MineCapacity
			MineCapacityUpdate:FireAllClients(percentage)
		end
		
		local canUpdate = getCanUpdate()
		if canUpdate then
			
			MineCapacityUpdate:FireAllClients(percentage)
		end
		
		task.wait(GridSettings.MineCapacityRefreshFrequence)
	end
end

function Grid.new()
	
	local self = {}
	setmetatable(self, Grid)
	
	-- the first ones are on the surface
	self.Blocks = {} -- dictionary with as key block ids and value the block's part
	self.StoredPositions = {} -- table containing all grid positions which are or were occupied by a block, prevents blocks from spawning where another was mined
	self.BlocksPos = {} -- dictionary which associate a string grid position to a block part
	self.LastUsedBlockId = 0
	self.LowestGridY = Layers.getLowestGridY()
	self.LastMineCapacityUpdateTime = nil
	self.refreshMineStatusCoroutine = coroutine.create(function()
		
		self:RefreshMineStatus()
	end)
	coroutine.resume(self.refreshMineStatusCoroutine)
	
	_G.Grid = self
	
	return self
end

function Grid:GetUniqueId()
	
	local uniqueId = tostring(tonumber(self.LastUsedBlockId) + 1)
	self.LastUsedBlockId = uniqueId
	
	return uniqueId
end

function Grid:GetTruePosition(gridY, gridX, gridZ)
	
	local truePosition = GridSettings.StartPosition + Vector3.new(gridX * GridSettings.BlockSize.X, gridY * GridSettings.BlockSize.Y, gridZ * GridSettings.BlockSize.Z)
	
	return truePosition
end

function Grid:DestroyBlock(blockId, Part, gridPositionStr)

	Part:Destroy()
	self.Blocks[blockId] = nil
	self.BlocksPos[gridPositionStr] = nil
end

function Grid:SpawnBlock(gridY, gridX, gridZ, luckMultiplier)
	
	local block = Layers.getRandomBlock(gridY, luckMultiplier)
	local rarityTable = Rarity.getRarityTable(block.Probability)
	local Part = block.Part:Clone()
	Part.Anchored = true
	Part:SetAttribute("GridY", gridY)
	Part:SetAttribute("GridX", gridX)
	Part:SetAttribute("GridZ", gridZ)

	local uniqueId = self:GetUniqueId()
	Part:SetAttribute("Id", uniqueId)

	CollectionService:AddTag(Part, "Block")

	self.Blocks[uniqueId] = Part
	
	local gridPositionStr = "Y" .. gridY .. "X" .. gridX .. "Z" .. gridZ
	table.insert(self.StoredPositions, gridPositionStr)
	self.BlocksPos[gridPositionStr] = Part
	
	local truePosition = Grid:GetTruePosition(gridY, gridX, gridZ)
	Part.Position = truePosition

	Part.Parent = workspace.Blocks
	
	local SpawnSFX = rarityTable.SpawnSFX
	if SpawnSFX then
		
		SpawnSFX:Play()
	end
	
	return Part
end

function Grid:ReplaceBlock(blockId, gridX, gridY, gridZ, oldBlockPart, newBlockTable)

	local gridPositionStr = "Y" .. gridY .. "X" .. gridX .. "Z" .. gridZ
	self:DestroyBlock(blockId, oldBlockPart, gridPositionStr)
	
	local rarityTable = Rarity.getRarityTable(newBlockTable.Probability)
	
	local Part = newBlockTable.Part:Clone()
	Part.Anchored = true
	Part:SetAttribute("GridY", gridY)
	Part:SetAttribute("GridX", gridX)
	Part:SetAttribute("GridZ", gridZ)

	Part:SetAttribute("Id", blockId)

	CollectionService:AddTag(Part, "Block")

	self.Blocks[blockId] = Part
	
	table.insert(self.StoredPositions, gridPositionStr)
	self.BlocksPos[gridPositionStr] = Part

	local truePosition = Grid:GetTruePosition(gridY, gridX, gridZ)
	Part.Position = truePosition

	Part.Parent = workspace.Blocks
	
	local SpawnSFX = rarityTable.SpawnSFX
	if SpawnSFX then

		SpawnSFX:Play()
	end
	
	return Part
end

function Grid:Generate()
	
	local gridY = -1
	for gridX = 1, GridSettings.BaseSize, 1 do
		
		for gridZ = 1, GridSettings.BaseSize, 1 do
			
			self:SpawnBlock(gridY, gridX, gridZ)
		end
	end
end

-- get the 6 surrounding grid positions of a grid position
function Grid:GetSurroundingPositions(gridY, gridX, gridZ)
	
	local gridPositionTop = {GridY = gridY + 1, GridX = gridX, GridZ = gridZ}
	local gridPositionBottom = {GridY = gridY - 1, GridX = gridX, GridZ = gridZ}
	local gridPositionFront = {GridY = gridY, GridX = gridX, GridZ = gridZ - 1}
	local gridPositionBack = {GridY = gridY, GridX = gridX, GridZ = gridZ + 1}
	local gridPositionRight = {GridY = gridY, GridX = gridX + 1, GridZ = gridZ}
	local gridPositionLeft = {GridY = gridY, GridX = gridX - 1, GridZ = gridZ}

	local gridPositions = {
		
		[1] = gridPositionTop,
		[2] = gridPositionBottom,
		[3] = gridPositionFront,
		[4] = gridPositionBack,
		[5] = gridPositionRight,
		[6] = gridPositionLeft
	}
	
	return gridPositions
end

-- check if a grid position is valid based on its gridY and if this position was never occupied
function Grid:GetGridPositionIsValid(gridY, gridX, gridZ)
	
	local isValid = false
	local gridYValid, positionIsNew = false, false
	
	-- check the gridY can exist according to the gridY extremums of the grid
	if self.LowestGridY < gridY and gridY <= -1 then
		
		gridYValid = true
	end
	
	local gridPositionStr = "Y" .. gridY .. "X" .. gridX .. "Z" .. gridZ
	positionIsNew = not table.find(self.StoredPositions, gridPositionStr)
	
	isValid = gridYValid and positionIsNew
	
	return isValid
end

-- destroys a block and generates blocks around it where possible
-- returns all blocks mined - will return more than 1 if the miningAreaDiameter is more than 1
function Grid:MineBlock(Part, luckMultiplier, miningAreaDiameter, Player)
	
	if Player then
		
		Utility.createSendOreFindMessageCoroutine(Player, Part.Name)
	end
	
	local gridY, gridX, gridZ = Part:GetAttribute("GridY"), Part:GetAttribute("GridX"), Part:GetAttribute("GridZ")
	local gridPositionStr = "Y" .. gridY .. "X" .. gridX .. "Z" .. gridZ
	local surroundingPositions = self:GetSurroundingPositions(gridY, gridX, gridZ)

	local blockId = Part:GetAttribute("Id")
	if blockId == "-1" then return end

	self:DestroyBlock(blockId, Part, gridPositionStr)
	
	local blocksMined = {Part}
	
	local function placeSurroundingBlocks()
		
		for _, gridPosition in ipairs(surroundingPositions) do

			local isValid = self:GetGridPositionIsValid(gridPosition.GridY, gridPosition.GridX, gridPosition.GridZ)

			if isValid then

				local blockPart = self:SpawnBlock(gridPosition.GridY, gridPosition.GridX, gridPosition.GridZ, luckMultiplier)
			end

			if miningAreaDiameter > 1 then

				local gridPositionStr = "Y" .. gridPosition.GridY .. "X" .. gridPosition.GridX .. "Z" .. gridPosition.GridZ
				local blockPart = self.BlocksPos[gridPositionStr]
				if blockPart then

					local newMiningAreaDiameter = miningAreaDiameter - 2
					local blocksMined2 = self:MineBlock(blockPart, luckMultiplier, newMiningAreaDiameter, Player)

					for _, blockMined in ipairs(blocksMined2) do

						table.insert(blocksMined, blockMined)
					end
				end
			end
		end
	end
	local placeSurroundingBlocksCoroutine = coroutine.create(placeSurroundingBlocks)
	coroutine.resume(placeSurroundingBlocksCoroutine)
	
	return blocksMined
end

function Grid:GenerateCave(Player: Player, targetGridY, targetGridX, targetGridZ)
	
	local gridY, gridX, gridZ = targetGridY, targetGridX, targetGridZ
	local highestCaveWallGridPosition = Vector3.new(gridX, gridY, gridZ)
	
	local Settings = {

		toleranceMin = .34,
		toleranceMax = .4,
		scaleMin = 12,
		scaleMax = 20,
		caveSizeXMin = 35,
		caveSizeXMax = 60,
		caveSizeYMin = 35,
		caveSizeYMax = 60,
		caveSizeZMin = 35,
		caveSizeZMax = 60,
		Lacunarity = 2,
		Persistence = .1,
		Octaves = 1
	}

	local seed = Random.new():NextNumber(1, 10e5)
	local scales = {

		x = math.random(Settings.scaleMin, Settings.scaleMax),
		y = math.random(Settings.scaleMin, Settings.scaleMax),
		z = math.random(Settings.scaleMin, Settings.scaleMax)
	}
	local blockSize = Vector3.new(6, 6, 6)
	local length = 50
	local toleranceMax = - math.random(Settings.toleranceMin * 100, Settings.toleranceMax * 100) / 100
	local gridSize = Vector3.new(math.random(Settings.caveSizeXMin, Settings.caveSizeXMax), math.random(Settings.caveSizeYMin, Settings.caveSizeYMax), math.random(Settings.caveSizeZMin, Settings.caveSizeZMax))

	local startExecTime, maxTime
	local budget = 1 / 15
	local function reset()

		startExecTime = os.clock()
		maxTime = startExecTime + budget
	end
	local function maybeYield()

		if os.clock() > maxTime then

			game:GetService("RunService").Heartbeat:Wait()
			reset()
		end
	end

	-- get the 6 surrounding grid positions of a grid position
	local function getSurroundingPositions(x, y, z)

		local gridPositionTop = Vector3.new(x, y + 1, z)
		local gridPositionBottom = Vector3.new(x, y - 1, z)
		local gridPositionFront = Vector3.new(x, y, z - 1)
		local gridPositionBack = Vector3.new(x, y, z + 1)
		local gridPositionRight = Vector3.new(x + 1, y, z)
		local gridPositionLeft = Vector3.new(x - 1, y, z)

		local gridPositions = {

			[1] = gridPositionTop,
			[2] = gridPositionBottom,
			[3] = gridPositionFront,
			[4] = gridPositionBack,
			[5] = gridPositionRight,
			[6] = gridPositionLeft
		}

		return gridPositions
	end

	-- this function was found on the Internet
	local function getFractalDensity(x, y, z)
		-- The sum of our octaves
		local value = 0 

		-- These coordinates will be scaled the lacunarity
		local x1 = x 
		local y1 = y
		local z1 = z

		-- Determines the effect of each octave on the previous sum
		local amplitude = 1

		for i = 1, Settings.Octaves, 1 do

			-- Multiply the noise output by the amplitude and add it to our sum
			value += math.noise((x1 / scales.x) + seed, y1 / scales.y, z1 / scales.z) * amplitude

			-- Scale up our perlin noise by multiplying the coordinates by lacunarity
			y1 *= Settings.Lacunarity
			x1 *= Settings.Lacunarity

			-- Reduce our amplitude by multiplying it by persistence
			amplitude *= Settings.Persistence
		end

		-- It is possible to have an output value outside of the range [-1,1]
		-- For consistency let's clamp it to that range
		return math.clamp(value, -1, 1)
	end
	
	print(string.format("seed : %s", tostring(seed)))
	print(string.format("tolerance : %s", tostring(toleranceMax)))
	print(string.format("scales - x : %i, y : %i, z : %i", scales.x, scales.y, scales.z))
	print(string.format("grid size : %i, %i, %i", gridSize.X, gridSize.Y, gridSize.Z))

	-- find a position which is air using a max tolerance value
	local x, y, z = 0, -1000000, 0
	local airPosition
	while true do

		local d = getFractalDensity(x, y, z)
		if d <= toleranceMax then

			airPosition = Vector3.new(x, y, z)
			break
		end

		x += 1
	end

	local startPosition = Vector3.new(x, y, z)
	local xMin, xMax, yMin, yMax, zMin, zMax = startPosition.X - gridSize.X / 2, startPosition.X + gridSize.X / 2, startPosition.Y - gridSize.Y / 2, startPosition.Y + gridSize.Y / 2, startPosition.Z - gridSize.Z / 2, startPosition.Z + gridSize.Z / 2

	local scannedPositionsStr = {}
	local airPositions = {}
	local caveWallPositions = {}
	local positionsToCheck = {startPosition}
	local highestAirPosition = startPosition

	reset()

	local scanStartTime = os.clock()

	while #positionsToCheck > 0 do

		maybeYield()

		local currentPosition = positionsToCheck[1]

		local surroundingPositions = getSurroundingPositions(currentPosition.X, currentPosition.Y, currentPosition.Z)

		for _, surroundingPosition in ipairs(surroundingPositions) do

			local positionStr = surroundingPosition.X .. "_" .. surroundingPosition.Y .. "_" .. surroundingPosition.Z
			local alreadyScanned = table.find(scannedPositionsStr, positionStr)
			if alreadyScanned then continue end
			table.insert(scannedPositionsStr, positionStr)

			local outOfBounds = false
			outOfBounds = surroundingPosition.X < xMin or surroundingPosition.X > xMax or surroundingPosition.Y < yMin or surroundingPosition.Y > yMax or surroundingPosition.Z < zMin or surroundingPosition.Z > zMax
			if outOfBounds then table.insert(caveWallPositions, surroundingPosition) continue end

			--local d = getDensity(surroundingPosition.X, surroundingPosition.Y, surroundingPosition.Z)
			local d = getFractalDensity(surroundingPosition.X, surroundingPosition.Y, surroundingPosition.Z)
			if d <= toleranceMax then

				table.insert(airPositions, surroundingPosition)

				table.insert(positionsToCheck, surroundingPosition)

				if surroundingPosition.Y > highestAirPosition.Y then highestAirPosition = surroundingPosition end
			else

				table.insert(caveWallPositions, surroundingPosition)
			end
		end

		table.remove(positionsToCheck, 1)
	end

	local scanEndTime = os.clock()
	local scanDuration = scanEndTime - scanStartTime

	print("cave scan took : " .. scanDuration)
	
	local spawnStartTime = os.clock()

	-- highlight the highest cave wall position found 
	local highestCaveWallPosition = highestAirPosition + Vector3.new(0, 1, 0)

	-- find offset using highest cave wall position found
	local offset = highestCaveWallGridPosition - highestCaveWallPosition
	
	-- for each air position, add it to the stored positions to prevent block spawn
	for _, airPosition in ipairs(airPositions) do
		
		local airGridPosition = airPosition + offset
		local gridPositionStr = "Y" .. airGridPosition.Y .. "X" .. airGridPosition.X .. "Z" .. airGridPosition.Z
		
		table.insert(self.StoredPositions, gridPositionStr)
	end
	
	-- for each cave wall position, spawn a block with a luck multiplier of 1 (for now)
	local luckMultiplier = 1
	for _, caveWallPosition in ipairs(caveWallPositions) do
		
		local caveWallGridPosition = caveWallPosition + offset
		
		local isValid = self:GetGridPositionIsValid(caveWallGridPosition.Y, caveWallGridPosition.X, caveWallGridPosition.Z)
		if not isValid then continue end
		
		self:SpawnBlock(caveWallGridPosition.Y, caveWallGridPosition.X, caveWallGridPosition.Z, luckMultiplier)
	end
	
	local spawnEndTime = os.clock()
	local spawnDuration = spawnEndTime - spawnStartTime
	
	print("cave spawn took : " .. spawnDuration)
	
	return
end

return Grid
