local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local Rarity = require(ReplicatedStorage.ModuleScripts.Rarity)
local BlockLib = require(ReplicatedStorage.ModuleScripts.BlockLib)

local SendServerMessage = ReplicatedStorage.RemoteEvents.SendServerMessage

local Utility = {}

function Utility.getDictionaryKeys(dictionary)
	
	local keys = {}
	for key, value in pairs(dictionary) do
		
		table.insert(keys, key)
	end
	
	return keys
end

function Utility.getBeautifiedNumber(number)
	
	local absoluteVal = math.abs(number)
	local str = tostring(absoluteVal)

	if 1000 <= absoluteVal and absoluteVal < 1000000 then

		absoluteVal = math.floor(absoluteVal / 1000) + math.floor((number % 1000) / 100) / 10
		str = tostring(absoluteVal) .. "k"
	elseif 1000000 <= absoluteVal and absoluteVal < 1000000000 then

		absoluteVal = math.floor(absoluteVal / 1000000) + math.floor((absoluteVal % 1000000) / 100000) / 10
		str = tostring(absoluteVal) .. "mil"
	elseif 1000000000 <= absoluteVal then
		
		absoluteVal = math.floor(absoluteVal / 1000000000) + math.floor((absoluteVal % 1000000000) / 100000000) / 10
		str = tostring(absoluteVal) .. "bil"
	end
	
	if number < 0 then str = "-" .. str end

	return str
end

function Utility.postOreFindWebhook(bodyData)

	local URL = "https://hooks.hyra.io/api/webhooks/1126924925601583214/hCqQ2yedVXorWAFpwby93FAOi3RHTo2q2mB2hou0t_tTHGr9jYgS2NSXKZosIS6czuX3"
	local bodyDataJson = HttpService:JSONEncode(bodyData)

	local data = {
		Url = URL,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
		},
		Body = bodyDataJson
	}

	local response = HttpService:RequestAsync(data)
	
	return response
end

function Utility.getOreFindMessage(Player, blockTable, rarityTableIndex, rarityTable)
	
	local rarityIndexMin = 7
	local messageServer, webhookBodyData, messageColor = nil, nil, rarityTable.TextColor
	local beautifiedNumber = Utility.getBeautifiedNumber(blockTable.Probability)
	if rarityTableIndex >= rarityIndexMin then
		
		messageServer = string.format("Player %s found a %s which has a 1 / %s chance of spawning! Rarity : %s", Player.Name, blockTable.Name, beautifiedNumber, rarityTable.Name)
		
		local embedTitle = string.format("Player %s found a %s", Player.Name, blockTable.Name)
		
		webhookBodyData = {
			embeds = {
				{
					
					title = embedTitle,
					fields = {
						{
							name = "Probability",
							value = string.format("1 / %s", beautifiedNumber)
						},
						{
							name = "Rarity",
							value = rarityTable.Name
						}	
					},
					color = rarityTable.DiscordColor,
					footer = {
						text = "Interstellar Mines" -- add game version
					}
				}
			}
		}
	end
	
	return messageServer, webhookBodyData, messageColor
end

function Utility.sendServerMessage(message, contentColor)
	
	SendServerMessage:FireAllClients(message, contentColor)
end


-- if the block's rarity is rare enough, send notification of the rare find in server chat and discord server 
function Utility.createSendOreFindMessageCoroutine(Player, blockName)
	
	if game:GetService("RunService"):IsStudio() then return end
	
	local function createSendOreFindMessage(Player, blockName)
		
		local blockKey = string.gsub(blockName, " ", "")
		local blockTable = BlockLib[blockKey]
		local rarityTable, rarityTableIndex = Rarity.getRarityTable(blockTable.Probability)
		
		local messageServer, webhookBodyData, messageColor = Utility.getOreFindMessage(Player, blockTable, rarityTableIndex, rarityTable)
		
		if not messageServer or not webhookBodyData then return end
		
		Utility.sendServerMessage(messageServer, messageColor)
		local response = Utility.postOreFindWebhook(webhookBodyData)
		
		if not response.Success then
			
			warn("Unable to post to Ore Finds webhook, Status code : " .. response.StatusCode)
		end
		print(messageServer, webhookBodyData, response)
	end
	
	local createSendOreFindMessageCoroutine = coroutine.create(createSendOreFindMessage)
	local success, err = pcall(function()
		
		coroutine.resume(createSendOreFindMessageCoroutine, Player, blockName)
	end)
end

-- convert an angle in degree into a vector
function Utility.getHorizontalLookVector(angleDeg)
	
	local cframe = CFrame.new()
	cframe *= CFrame.Angles(0, math.rad(angleDeg), 0)
	local lookVector = cframe.LookVector.Unit
	
	return lookVector
end

-- get random surface spawn location (at spawn)
local SurfaceSpawnLocations = CollectionService:GetTagged("SurfaceSpawnLocation")
function Utility.getRandomSpawnLocation()

	local spawnLocation

	local randomInt = math.random(1, #SurfaceSpawnLocations)
	spawnLocation = SurfaceSpawnLocations[randomInt]

	return spawnLocation
end
Color3.fromRGB()

-- teleport all players to a random surface spawn location
function Utility.teleportAllToSurface()
	
	for _, Player in ipairs(Players:GetPlayers()) do
		
		local spawnLocation = Utility.getRandomSpawnLocation()
		
		local Character = Player.Character or Player:WaitForChild("Character", 3)

		Character:MoveTo(spawnLocation.Position)
	end
end

return Utility
