local GridSettings = {
	
	BaseSize = 20,
	BlockSize = Vector3.new(6, 6, 6),
	StartPosition = workspace.GridSpawn.Position,
	MineCapacity = 150000, -- the number of mined blocks at which the mine will begin the reset process
	MineResetCountdownSeconds = 30,
	MineCapacityRefreshFrequence = 1, -- the time in seconds to wait between each refresh server-side
	MineCapacityClientUpdateFrequence = 10 -- the time in seconds to wait before updating the client's mine capacity
}

return GridSettings
