local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Blocks = ReplicatedStorage.Assets.Models.Blocks

local BlockLib = {

	Stone = {

		Name = "Stone",
		Part = Blocks.Stone,
		Probability = 1,
		BaseColor = Color3.fromRGB(91, 93, 105),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Granite = {

		Name = "Granite",
		Part = Blocks.Granite,
		Probability = 1,
		BaseColor = Color3.fromRGB(143, 76, 42),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Clay = {

		Name = "Clay",
		Part = Blocks.Clay,
		Probability = 1,
		BaseColor = Color3.fromRGB(255, 89, 89),
		Creator = "BabyNeptunev",
		Description = ""
    },
	Limestone = {

		Name = "Limestone",
		Part = Blocks.Limestone,
		Probability = 1,
		BaseColor = Color3.fromRGB(204, 142, 105),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Obsidian = {

		Name = "Obsidian",
		Part = Blocks.Obsidian,
		Probability = 1,
		BaseColor = Color3.fromRGB(27, 42, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Core = {

		Name = "Core",
		Part = Blocks.Core,
		Probability = 1,
		BaseColor = Color3.fromRGB(255, 0, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Marble = {

		Name = "Marble",
		Part = Blocks.Marble,
		Probability = 1,
		BaseColor = Color3.fromRGB(231, 231, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Coal = {

		Name = "Coal",
		Part = Blocks.Coal,
		Probability = 25,
		BaseColor = Color3.fromRGB(17, 17, 17),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Iron = {

		Name = "Iron",
		Part = Blocks.Iron,
		Probability = 50,
		BaseColor = Color3.fromRGB(91, 93, 105),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Silver = {

		Name = "Silver",
		Part = Blocks.Silver,
		Probability = 150,
		BaseColor = Color3.fromRGB(231, 231, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Bismuth = {

		Name = "Bismuth",
		Part = Blocks.Bismuth,
		Probability = 1000,
		BaseColor = Color3.fromRGB(255, 176, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Amethyst  = {

		Name = "Amethyst",
		Part = Blocks.Amethyst,
		Probability = 1000,
		BaseColor = Color3.fromRGB(170, 0, 170),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Electronium = {

		Name = "Electronium",
		Part = Blocks.Electronium,
		Probability = 123000,
		BaseColor = Color3.fromRGB(4, 175, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Leafonium = {

		Name = "Leafonium",
		Part = Blocks.Leafonium,
		Probability = 800000,
		BaseColor = Color3.fromRGB(40, 127, 71),
		Creator = "BabyNeptunev",
		Description = ""
	},
	BlueSteel = {

		Name = "Blue Steel",
		Part = Blocks.BlueSteel,
		Probability = 15000,
		BaseColor = Color3.fromRGB(4, 175, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Brass = {

		Name = "Brass",
		Part = Blocks.Brass,
		Probability = 35,
		BaseColor = Color3.fromRGB(255, 176, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Cloudnite = {

		Name = "Cloudnite",
		Part = Blocks.Cloudnite,
		Probability = 657000,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Cobalt = {

		Name = "Cobalt",
		Part = Blocks.Cobalt,
		Probability = 1800,
		BaseColor = Color3.fromRGB(16, 42, 220),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Heartonium = {

		Name = "Heartonium",
		Part = Blocks.Heartonium,
		Probability = 253000,
		BaseColor = Color3.fromRGB(255, 0, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Nickel = {

		Name = "Nickel",
		Part = Blocks.Nickel,
		Probability = 15,
		BaseColor = Color3.fromRGB(163, 162, 165),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Sulfur = {

		Name = "Sulfur",
		Part = Blocks.Sulfur,
		Probability = 65,
		BaseColor = Color3.fromRGB(255, 255, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Tungsten = {

		Name = "Tungsten",
		Part = Blocks.Tungsten,
		Probability = 35,
		BaseColor = Color3.fromRGB(159, 161, 172),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Sapphire = {

		Name = "Sapphire",
		Part = Blocks.Sapphire,
		Probability = 5000,
		BaseColor = Color3.fromRGB(0, 0, 255),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Xyphrine = {

		Name = "Xyphrine",
		Part = Blocks.Xyphrine,
		Probability = 500000000,
		BaseColor = Color3.fromRGB(27, 42, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Storminite = {

		Name = "Storminite",
		Part = Blocks.Storminite,
		Probability = 5300000,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Nexotunium = {

		Name = "Nexotunium",
		Part = Blocks.Nexotunium,
		Probability = 7500000,
		BaseColor = Color3.fromRGB(3, 62, 255),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Ruby = {

		Name = "Ruby",
		Part = Blocks.Ruby,
		Probability = 5000,
		BaseColor = Color3.fromRGB(255, 0, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Chrome = {

		Name = "Chrome",
		Part = Blocks.Chrome,
		Probability = 30,
		BaseColor = Color3.fromRGB(159, 161, 172),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Steel = {

		Name = "Steel",
		Part = Blocks.Steel,
		Probability = 50,
		BaseColor = Color3.fromRGB(159, 161, 172),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Emerald = {

		Name = "Emerald",
		Part = Blocks.Emerald,
		Probability = 700,
		BaseColor = Color3.fromRGB(31, 128, 29),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Topaz = {

		Name = "Topaz",
		Part = Blocks.Topaz,
		Probability = 5555,
		BaseColor = Color3.fromRGB(218, 133, 65),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Diamond = {

		Name = "Diamond",
		Part = Blocks.Diamond,
		Probability = 50000,
		BaseColor = Color3.fromRGB(0, 16, 176),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Sandinite = {

		Name = "Sandinite",
		Part = Blocks.Sandinite,
		Probability = 650000,
		BaseColor = Color3.fromRGB(204, 142, 105),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Ulstranium = {

		Name = "Ulstranium",
		Part = Blocks.Ulstranium,
		Probability = 7777000,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Salt = {

		Name = "Salt",
		Part = Blocks.Salt,
		Probability = 150,
		BaseColor = Color3.fromRGB(202, 203, 209),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Quartz = {

		Name = "Quartz",
		Part = Blocks.Quartz,
		Probability = 300,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Gold = {

		Name = "Gold",
		Part = Blocks.Gold,
		Probability = 780,
		BaseColor = Color3.fromRGB(255, 255, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Copper = {

		Name = "Copper",
		Part = Blocks.Copper,
		Probability = 90,
		BaseColor = Color3.fromRGB(160, 95, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Grass = {

		Name = "Grass",
		Part = Blocks.Grass,
		Probability = 980,
		BaseColor = Color3.fromRGB(0, 255, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Teal = {

		Name = "Teal",
		Part = Blocks.Teal,
		Probability = 175,
		BaseColor = Color3.fromRGB(18, 238, 212),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Platinum = {

		Name = "Platinum",
		Part = Blocks.Platinum,
		Probability = 300,
		BaseColor = Color3.fromRGB(226, 220, 188),
		Creator = "BabyNeptunev",
		Description = ""
	},
	SolarFlare = {

		Name = "Solar Flare",
		Part = Blocks.SolarFlare,
		Probability = 67000000,
		BaseColor = Color3.fromRGB(255, 176, 0),
		Creator = "BabyNeptunev",
		Description = "An ore extracted directly from a star's raging core."
	},
	R3a49 = {

		Name = "R3a49",
		Part = Blocks.R3a49,
		Probability = 72000000,
		BaseColor = Color3.fromRGB(0, 32, 96),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Darkitinuim = {

		Name = "Darkitinuim",
		Part = Blocks.Darkitinuim,
		Probability = 21000000,
		BaseColor = Color3.fromRGB(226, 220, 188),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Gassnesium = {

		Name = "Gassnesium",
		Part = Blocks.Gassnesium,
		Probability = 33000000,
		BaseColor = Color3.fromRGB(0, 255, 0),
		Creator = "BabyNeptunev",
		Description = "A strange block of gas which spews out toxic chemicals. Found deep in Jupiter's core."
	},
	QuasarA3 = {

		Name = "QuasarA3",
		Part = Blocks.QuasarA3,
		Probability = 48500000,
		BaseColor = Color3.fromRGB(61, 21, 133),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Reflectum = {

		Name = "Reflectum",
		Part = Blocks.Reflectum,
		Probability = 25000000,
		BaseColor = Color3.fromRGB(180, 128, 255),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Glaxtintium = {

		Name = "Glaxtintium",
		Part = Blocks.Glaxtintium,
		Probability = 1500000000,
		BaseColor = Color3.fromRGB(27, 42, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Flamenite = {

		Name = "Flamenite",
		Part = Blocks.Flamenite,
		Probability = 7000000,
		BaseColor = Color3.fromRGB(196, 40, 28),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Frostical = {

		Name = "Frostical",
		Part = Blocks.Frostical,
		Probability = 3333333,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Sparktite = {

		Name = "Sparktite",
		Part = Blocks.Sparktite,
		Probability = 17000000,
		BaseColor = Color3.fromRGB(4, 175, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Tarcoonum = {

		Name = "Tarcoonum",
		Part = Blocks.Tarcoonum,
		Probability = 4200000,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Galaxy = {

		Name = "Galaxy",
		Part = Blocks.Galaxy,
		Probability = 33000000000,
		BaseColor = Color3.fromRGB(239, 184, 56),
		Creator = "BabyNeptunev, Idraumel",
		Description = "Read the name 💀"
	},
	Icetonium = {

		Name = "Icetonium",
		Part = Blocks.Icetonium,
		Probability = 53000,
		BaseColor = Color3.fromRGB(4, 175, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Snow = {

		Name = "Snow",
		Part = Blocks.Snow,
		Probability = 333,
		BaseColor = Color3.fromRGB(248, 248, 248),
		Creator = "BabyNeptunev",
		Description = ""
	},
	SparkleCrystal = {

		Name = "Sparkle Crystal",
		Part = Blocks.SparkleCrystal,
		Probability = 5000000,
		BaseColor = Color3.fromRGB(252, 250, 255),
		Creator = "nathaneland",
		Description = "A Glistening orb as white as snow"
	},
	NorthernStar = {

		Name = "Northern Star",
		Part = Blocks.NorthernStar,
		Probability = 633000,
		BaseColor = Color3.fromRGB(18, 238, 212),
		Creator = "nathaneland",
		Description = ""
	},
	Phlournium = {

		Name = "Phlournium",
		Part = Blocks.Phlournium,
		Probability = 250000000,
		BaseColor = Color3.fromRGB(255, 0, 191),
		Creator = "BabyNeptunev",
		Description = "A pink substance with its own gravitational pull"
	},
	CondensedBallOfMatterFromSpace = {

		Name = "Condensed Ball Of Matter From Space",
		Part = Blocks.CondensedBallOfMatterFromSpace,
		Probability = 2000000,
		BaseColor = Color3.fromRGB(16, 42, 220),
		Creator = "BabyNeptunev",
		Description = "A mass of unidentified matter extracted from a blackhole named the blackhole power house"
	},
	Grooveonium = {

		Name = "Grooveonium",
		Part = Blocks.Grooveonium,
		Probability = 110000000,
		BaseColor = Color3.fromRGB(255, 0, 291),
		Creator = "BabyNeptunev",
		Description = "Groovy"
	},
	GreenSparktite = {

		Name = "Green Sparktite",
		Part = Blocks.GreenSparktite,
		Probability = 3400000,
		BaseColor = Color3.fromRGB(0, 255, 127),
		Creator = "BabyNeptunev",
		Description = ""
	},
	BlackDiamond = {

		Name = "Black Diamond",
		Part = Blocks.BlackDiamond,
		Probability = 355000,
		BaseColor = Color3.fromRGB(27, 42, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Darkrite = {

		Name = "Darkrite",
		Part = Blocks.Darkrite,
		Probability = 35000,
		BaseColor = Color3.fromRGB(0, 32, 96),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Cinnabar = {

		Name = "Cinnabar",
		Part = Blocks.Cinnabar,
		Probability = 25000,
		BaseColor = Color3.fromRGB(117, 0, 0),
		Creator = "BabyNeptunev",
		Description = "Yummy??"
	},
	SpectralQuartz = {

		Name = "Spectral Quartz",
		Part = Blocks.SpectralQuartz,
		Probability = 222222,
		BaseColor = Color3.fromRGB(27, 42, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Tanzinite = {

		Name = "Tanzinite",
		Part = Blocks.Tanzinite,
		Probability = 110000,
		BaseColor = Color3.fromRGB(61, 21, 133),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Crystanite = {

		Name = "Crystanite",
		Part = Blocks.Crystanite,
		Probability = 400000,
		BaseColor = Color3.fromRGB(98, 37, 209),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Incineratium = {

		Name = "Incineratium",
		Part = Blocks.Incineratium,
		Probability = 150000,
		BaseColor = Color3.fromRGB(255, 0, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Blosum = {

		Name = "Blosum",
		Part = Blocks.Blosum,
		Probability = 790000,
		BaseColor = Color3.fromRGB(255, 102, 204),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Blacktite = {

		Name = "Blacktite",
		Part = Blocks.Blacktite,
		Probability = 661000,
		BaseColor = Color3.fromRGB(27, 42, 53),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Uranium = {

		Name = "Uranium",
		Part = Blocks.Uranium,
		Probability = 800000,
		BaseColor = Color3.fromRGB(0, 255, 0),
		Creator = "BabyNeptunev",
		Description = ""
	},
	Galaxite = {

		Name = "Galaxite",
		Part = Blocks.Galaxite,
		Probability = 999000,
		BaseColor = Color3.fromRGB(98, 37, 209),
		Creator = "BabyNeptunev",
		Description = "ripped from a galaxy"
	},
	Zoomfernum = {

		Name = "Zoomfernum",
		Part = Blocks.Zoomfernum,
		Probability = 2700000,
		BaseColor = Color3.fromRGB(255, 0, 0),
		Creator = "BabyNeptunev",
		Description = "A dangerous ore created in a mysterious lab"
	},
	Barrier = {

		Name = "Barrier",
		Part = Blocks.Barrier,
		Probability = 444001,
		BaseColor = Color3.fromRGB(255, 255, 0),
		Creator = "BabyNeptunev",
		Description = "An Magical Ore protecting itself from harm"
	},
	Snowsplistium = {

		Name = "Snowsplistium",
		Part = Blocks.Snowsplistium,
		Probability = 3600000,
		BaseColor = Color3.fromRGB(4, 175, 236),
		Creator = "BabyNeptunev",
		Description = ""
	},
	WaterCrystal = {

		Name = "WaterCrystal",
		Part = Blocks.WaterCrystal,
		Probability = 20000000,
		BaseColor = Color3.fromRGB(0, 0, 255),
		Creator = "BabyNeptunev",
		Description = "Refreshing"
	},
	Flare = {

		Name = "Flare",
		Part = Blocks.Flare,
		Probability = 6300000,
		BaseColor = Color3.fromRGB(255, 0, 0),
		Creator = "BabyNeptunev",
		Description = "Its Hot"
	},
	Terranium = {

		Name = "Terranium",
		Part = Blocks.Terranium,
		Probability = 7000000000,
		BaseColor = Color3.fromRGB(0, 255, 0),
		Creator = "BabyNeptunev",
		Description = "A peaceful concaction"
	},
	DawgCrystal = {

		Name = "DAWGCrystal",
		Part = Blocks["DAWG crystal"],
		Probability = 99999999999,
		BaseColor = Color3.fromRGB(163, 162, 165),
		Creator = "BabyNeptunev",
		Description = "Dev ore, its bad lol but if you get it you cool"
	},
	Ethernite = {

		Name = "Ethernite",
		Part = Blocks.Ethernite,
		Probability = 1111111,
		BaseColor = Color3.fromRGB(163, 162, 165),
		Creator = "BabyNeptunev",
		Description = "A mysterious ore found in the ether"
	},
	Photonite = {

		Name = "Photonite",
		Part = Blocks.Photonite,
		Probability = 2400000,
		BaseColor = Color3.fromRGB(202, 201, 200),
		Creator = "BabyNeptunev",
		Description = "A ore that reflects light like a prism but in a strange way"
	},
	Nebulite = {

		Name = "Nebulite",
		Part = Blocks.Nebulite,
		Probability = 798345,
		BaseColor = Color3.fromRGB(123, 0, 123),
		Creator = "BabyNeptunev",
		Description = "A useful ore in crafting"
	},
	LaserCrystal = {

		Name = "LaserCrystal",
		Part = Blocks.LaserCrystal,
		Probability = 55000,
		BaseColor = Color3.fromRGB(255, 102, 204),
		Creator = "BabyNeptunev",
		Description = "A Block that creates lasers trapped in a crystal"
	},
}

return BlockLib
