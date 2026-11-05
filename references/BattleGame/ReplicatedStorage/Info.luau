return {	
	UFWrequirement = 500,
	
	Passes = {
		VIP        = 2064380272, -- 160 Robux
		MoreEmotes = 2063706242, -- 80 Robux
		SecondPage = 2063782093, -- 80 Robux
		EarlyAccess = 2064411304, -- 399 Robux, plays characters marked isEA
		["Private Servers+"] = 2067295884, -- 300 Robux, Private Server customization.
	},

	Gifts = {
		VipGift         = 3726822224, -- 160 Robux, gives VIP
		MoreEmoteGift   = 3726822535, -- 80 Robux, gives MoreEmotes
		SecondPageGift  = 3726822706, -- 80 Robux, gives SecondPage
		SniperGift      = 3726824606, -- 25 Robux, gives Sniper
		ColaBombGift    = 3726824724, -- 15 Robux, gives Cola Bomb
		SupplyCrateGift = 3726824861, -- 15 Robux, gives Marine Supply Crate
	},

	Products = {
		["Random Emote"]     = 3726828982, -- 25 Robux, 1 spin
		["Random Emote x5"]  = 3726829153, -- 125 Robux, 5 spins
		["Random Emote x10"] = 3726829343, -- 250 Robux, 10 spins

		-- Gold packs
		["500 Gold"]    = 3726822913, -- 40 Robux, 5,600 Gold
		["1500 Gold"]   = 3726823015, -- 104 Robux, 14,560 Gold
		["3000 Gold"]   = 3726823234, -- 192 Robux, 26,880 Gold
		["5000 Gold"]   = 3726823673, -- 320 Robux, 44,800 Gold
		["12000 Gold"]  = 3726823879, -- 640 Robux, 89,600 Gold
		["30000 Gold"]  = 3726824006, -- 1440 Robux, 201,600 Gold

		["Sniper"]              = 3726824171, -- 25 Robux
		["Cola Bomb"]           = 3726824315, -- 15 Robux
		["Marine Supply Crate"] = 3726824451, -- 15 Robux
	},

	Donations = {
		["Donate 2"]       = 3726937716,
		["Donate 3"]       = 3726937958,
		["Donate 5"]       = 3726938029,
		["Donate 10"]      = 3726938228,
		["Donate 50"]      = 3726938256,
		["Donate 100"]     = 3726938270,
		["Donate 500"]     = 3726938293,
		["Donate 1000"]    = 3726938518,
		["Donate 5000"]    = 3726939412,
		["Donate 10000"]   = 3726939463,
		["Donate 50000"]   = 3726939584,
		["Donate 100000"]  = 3726939600,
		["Donate 500000"]  = 3726939730,
		["Donate 1000000"] = 3726939760,
	},
	
	Movesets = {
		
		["Zoro"] = {
			Base = {
				[1] = {Name = ""},
				[2] = {Name = ""},
				[3] = {Name = ""},
				[4] = {Name = ""},
			},
			Ultimate = {
				[1] = {Name = "", Holdable = false},
				[2] = {Name = "", Holdable = false},
				[3] = {Name = "", Holdable = false},
				[4] = {Name = "", Holdable = false},
			},
			Indicator = {
				Sound = "rbxassetid://131390520971848", 
				Volume = 1
			},
			Glow = Color3.fromRGB(144, 255, 103),
			AwakeningBarColor = Color3.fromRGB(11, 103, 30),
			Order = 1,
			Icon = 96895914460177,
			UltimateTime = 0,
			UltimateName = "Zoro!!",
			Admin = false,
			isEA = false,
		},
		
		["Sanji"] = {
			Base = {
				[1] = {Name = "Muton Kick"},
				[2] = {Name = ""},
				[3] = {Name = ""},
				[4] = {Name = ""},
			},
			Ultimate = {
				[1] = {Name = ""},
				[2] = {Name = ""},
				[3] = {Name = "Dive", Holdable = true},
				[4] = {Name = ""},
			},
			Indicator = {
				Sound = "rbxassetid://131390520971848", 
				Volume = 1
			},
			Glow = Color3.fromRGB(232, 72, 75),
			AwakeningBarColor = Color3.fromRGB(232, 119, 39),
			Order = 2,
			Icon = 123450382198212,
			UltimateTime = 200,
			UltimateName = "Diable Jambe",
			Admin = false,
			isEA = false,
		},
		
		["BlackBeard"] = {
			Base = {
				[1] = {Name = ""},
				[2] = {Name = ""},
				[3] = {Name = ""},
				[4] = {Name = ""},
			},
			Indicator = {
				Sound = "rbxassetid://131390520971848", 
				Volume = 1
			},
			Glow = Color3.fromRGB(114, 58, 255),
			AwakeningBarColor = Color3.fromRGB(33, 17, 74),
			Order = 3,
			Icon = 96476859090225,
			UltimateTime = 0,
			UltimateName = "Liberation!!",
			Admin = false,
			isEA = false,
		},
		
		["WhiteBeard"] = {
			Base = {
				[1] = {Name = ""},
				[2] = {Name = ""},
				[3] = {Name = ""},
				[4] = {Name = ""},
			},
			Indicator = {
				Sound = "rbxassetid://131390520971848", 
				Volume = 1
			},
			Glow = Color3.fromRGB(167, 255, 242),
			AwakeningBarColor = Color3.fromRGB(175, 244, 255),
			Order = 4,
			Icon = 96476859090225,
			UltimateTime = 0,
			UltimateName = "Seaquake!!",
			Admin = false,
			isEA = true, -- Early Access pass only
		},
		
		["Crocodile"] = {
			Base = {
				[1] = {Name = ""},
				[2] = {Name = ""},
				[3] = {Name = ""},
				[4] = {Name = ""},
			},
			Indicator = {
				Sound = "rbxassetid://131390520971848", 
				Volume = 1
			},
			Glow = Color3.fromRGB(255, 232, 147),
			AwakeningBarColor = Color3.fromRGB(220, 202, 101),
			Order = 5,
			Icon = 96476859090225,
			UltimateTime = 0,
			UltimateName = "Spada!!",
			Admin = false,
			isEA = false,
		},
	},
	
	EmoteRarities = {
		Common = { Color = Color3.fromRGB(170, 170, 170), Weight = 55 },
		Rare = { Color = Color3.fromRGB(102, 240, 255), Weight = 27.5 },
		Epic = { Color = Color3.fromRGB(129, 26, 255), Weight = 15 },
		Legendary = { Color = Color3.fromRGB(255, 232, 62), Weight = 2 },
		Mythic = { Color = Color3.fromRGB(255, 33, 33), Weight = .5 },
		--Secret = { Color = Color3.fromRGB(0, 0, 0), Weight = 0.1 },
	},
	
	GetSerial = function(Object)
		local Serial1 = Random.new():NextInteger(-10000000000, 10000000000)
		local Serial2 = math.floor(Object.Position.X) + math.floor(Object.Position.Y) + math.floor(Object.Position.Z)
		local Serial3 = math.random(-100, 100)
		local Serial4 = ""
		
		for _ = 1, Random.new():NextNumber(1, 5) do
			local RandomNumber = string.char(math.random(97, 122))
			if math.random(1, 2) == 1 then
				RandomNumber = RandomNumber:upper()
			end
			
			Serial4 = Serial4 .. RandomNumber
		end
		
		if math.random(1, 2) == 1 then
			return tostring(Serial1 + Serial2 + Serial3) .. Serial4
		else
			return Serial4 .. tostring(Serial1 + Serial2 + Serial3)
		end
	end,
	
	UpdateLog = [[

	]],
}