--!strict
-- Client UI settings. Swap the sound ids for your own uploads.

local UIConfig = {}

-- Built-in Roblox sounds as placeholders (rbxasset:// files ship with every client).
UIConfig.Sounds = {
	Tick = "rbxasset://sounds/button.wav", -- each name flashing past in the reel
	Reveal = "rbxasset://sounds/electronicpingshort.wav", -- normal result
	Dramatic = "rbxasset://sounds/electronicpingshort.wav", -- Mythical / Secret reveal
	Click = "rbxasset://sounds/button.wav",
}

-- Lock icon images used by the vault slots.
UIConfig.LockImages = {
	Locked = "rbxassetid://80913328536988",
	Unlocked = "rbxassetid://79577024969254",
}

-- Where the vault showcase stage is built (far from the map, client-only).
UIConfig.StageOrigin = Vector3.new(0, 2500, 0)

-- The design resolution strokes were drawn at; strokes scale from it.
UIConfig.DesignResolution = Vector2.new(1616, 880)

return UIConfig
