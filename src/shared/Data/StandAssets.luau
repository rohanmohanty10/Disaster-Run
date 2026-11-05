--!strict
-- Animation, sound and image ids for the stand Runner kits (Sticky Fingers, Scary Monsters,
-- Red Hot Chili Pepper, King Crimson, Made in Heaven). Lives at ReplicatedStorage.Shared.Data.StandAssets.
-- The matching UI / screen-effect models are in ReplicatedStorage.Assets.Stands (src/assets/Stands).
--
-- Where the ids come from:
--   UniverseGame: references/UniverseGame/ReplicatedStorage/ReplicatedStorage/ReplicatedModules/StatsFolder/
--                 <Stand>/<Stand>/Animations.luau and Sounds.luau (Sticky Fingers keeps them inline
--                 in Sticky Fingers.luau). King Crimson's time-skip frames come from the
--                 TimeSkipEffect ScreenGui in references/UniverseGame/UI.
--   StandGame:    only the charge-bar guis survived the extraction (its server scripts and
--                 stand models weren't saved), so Red Hot Chili Pepper and Scary Monsters have no
--                 animation or sound ids yet. Their skill numbers follow StandGame's
--                 CombatStyleLibrary ("Dino Dash", "Electric Discharge").
--
-- IMPORTANT: Roblox only plays an animation in a game owned by the account or group that
-- uploaded it. These animations belong to the reference games, so re-upload them under the
-- Disaster Run owner and swap the ids before relying on them (see AnimationConfig.luau).
-- Sounds play only if the uploader made them public; test each one in Studio.

local StandAssets = {}

StandAssets.MadeInHeaven = {
	Source = "UniverseGame / StatsFolder/Made In Heaven",
	Animations = {
		MadeInHeaven = "rbxassetid://13110202201", -- the ultimate (time acceleration) pose
		GodlySpeed = "rbxassetid://13110057999", -- ForwardAccel1
		GodlySpeedLeft = "rbxassetid://13110059106", -- LeftAccel
		GodlySpeedRight = "rbxassetid://13110059920", -- RightAccel
		GodlySpeedBack = "rbxassetid://13110061695", -- BackwardAccel
		HandOfDestiny = "rbxassetid://13106665302",
		Summon = "rbxassetid://13104217063",
		Run = "rbxassetid://13104202088",
		SummonedRun = "rbxassetid://13104204244",
		Idle = "rbxassetid://13104212811",
	},
	Sounds = {
		MadeInHeaven = "rbxassetid://13289142683",
		TimeAccelStart = "rbxassetid://13288864064", -- TimeAccelPreloop
		TimeAccelLoop = "rbxassetid://13288863759",
		GodlySpeed = "rbxassetid://13137412106",
		GodlySpeedVoiceline = "rbxassetid://13288865423",
		HandOfDestiny = "rbxassetid://13288865538",
		HandOfDestinyHit = "rbxassetid://13289128441",
		Summon = "rbxassetid://13137418555",
	},
}

StandAssets.KingCrimson = {
	Source = "UniverseGame / StatsFolder/King Crimson",
	Animations = {
		TimeErase = "rbxassetid://11108625453",
		Epitaph = "rbxassetid://10938395302",
		Run = "rbxassetid://10914799131",
		Idle = "rbxassetid://10907211857",
		SummonedIdle = "rbxassetid://10907242780",
	},
	Sounds = {
		TimeErase = "rbxassetid://11107378240",
		TimeEraseVoiceline = "rbxassetid://11107377344",
		TimeEraseAmbient = "rbxassetid://11107378816",
		TimeEraseEnd = "rbxassetid://11107390542",
		Timeskip = "rbxassetid://11107395117", -- TimeSkipTeleport
		Summon = "rbxassetid://11157563353",
	},
	-- Assets.Stands.KingCrimson.TimeSkipEffect plays these frames on screen during Time Erase.
	TimeSkipFrames = {
		"rbxassetid://4573462670", "rbxassetid://4573463247", "rbxassetid://4573464191",
		"rbxassetid://4573465237", "rbxassetid://4573466633", "rbxassetid://4573467848",
		"rbxassetid://4573468665", "rbxassetid://4573469255", "rbxassetid://4573469861",
		"rbxassetid://4573470481", "rbxassetid://4573472230", "rbxassetid://4573472712",
		"rbxassetid://4573473408", "rbxassetid://4573474618", "rbxassetid://4573475743",
		"rbxassetid://4573476483", "rbxassetid://4573476928", "rbxassetid://4573477493",
	},
}

StandAssets.StickyFingers = {
	Source = "UniverseGame / StatsFolder/Sticky Fingers/Sticky Fingers.luau",
	Animations = {
		ZipperGlideStart = "rbxassetid://14762901561",
		ZipperGlideLoop = "rbxassetid://14762902977",
		PocketDimensionStart = "rbxassetid://14954135419",
		PocketDimensionEnd = "rbxassetid://14954136159",
		ZipperOpenRight = "rbxassetid://14892281159",
		ZipperOpenLeft = "rbxassetid://14892300330",
		Run = "rbxassetid://14811456355",
		Idle = "rbxassetid://13785536286",
	},
	Sounds = {
		ZipperGlide = "rbxassetid://14978486698",
		PocketDimension = "rbxassetid://14978486497",
		PocketDimensionWarp = "rbxassetid://14978486615",
		PocketDimensionVoiceline = "rbxassetid://14978486554",
		Summon = "rbxassetid://14978343936",
	},
}

StandAssets.RedHotChiliPepper = {
	Source = "StandGame / Objects/Bars/Electric_Charge Gui",
	Animations = {}, -- not in the extraction
	Sounds = {}, -- not in the extraction
	-- Assets.Stands.RedHotChiliPepper.ElectricChargeBar: a charge-meter gui (its script is disabled).
}

StandAssets.ScaryMonsters = {
	Source = "StandGame / Objects/Bars/Dino_Full_Form Gui",
	Animations = {}, -- not in the extraction
	Sounds = {}, -- not in the extraction
	-- Assets.Stands.ScaryMonsters.DinoFormBar: a form-meter gui (its script is disabled).
}

return StandAssets
