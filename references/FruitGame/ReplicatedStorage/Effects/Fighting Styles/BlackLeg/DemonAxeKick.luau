-- Sanji Kick Fire Trail Effect
-- Continuously spawns flame particles around a character's feet while active.

local FireTrailEffect = {}

--- Animates a single part outward with a scale + transparency tween.
--- Used to "shoot" both the core and flame parts of each fire shard forward.
--- @param part        BasePart  - The part to animate
--- @param travelDist  number    - How far forward (Z axis) the part moves
--- @param scaleMult   number    - How much to scale the part's X/Y size up
--- @param startSize   number    - The initial X and Y size before the tween
local function animateShard(part, travelDist, scaleMult, startSize)
	local targetSize = part.Size * scaleMult
	local originalZ  = part.Size.Z

	-- Snap to a small starting size, then tween outward
	part.Size = Vector3.new(startSize, startSize, originalZ)

	_G.tween(part, {
		0.1,                          -- duration
		"Quad",                       -- easing style
		Enum.EasingDirection.Out,
		0,                            -- delay
		false,                        -- reverses
		0                             -- repeat count
	}, {
		Size         = targetSize + Vector3.new(0.2, 0.2, 5),
		Transparency = 1,
		CFrame       = part.CFrame * CFrame.new(0, 0, -travelDist)
	})
end

--- Starts the looping fire trail effect on a character.
--- Runs every Heartbeat until the connection object is destroyed.
--- @param _          any    - Unused (self placeholder)
--- @param character  Model  - The character to emit fire around
--- @param tracker    Instance - When this leaves the game, the loop stops
function FireTrailEffect.start(_, character, tracker)
	-- Skip if the character is too far away to be worth rendering
	if _G.checkRenderDistance(character.HumanoidRootPart.Position) == false then
		return
	end

	while true do
		-- Randomly pick between two flame colors: pinkish-red or deep orange
		local flameColor = Color3.fromRGB(255, 114, 114)
		if math.random(1, 2) == 1 then
			flameColor = Color3.fromRGB(255, 81, 0)
		end

		-- Anchor point: slightly below the HumanoidRootPart
		local rootCFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0)

		-- Clone the fire shard model from the script
		local shard = script.Model:Clone()

		-- Randomize the shard's launch angle:
		--   pitch: tilted downward 30-50 degrees
		--   yaw:   slight side spread -15 to 15 degrees
		--   roll:  fully random spin
		--   offset: small random XY jitter, placed 4 studs in front
		local pitchDeg  = -math.random(30, 50)
		local yawDeg    = math.random(-15, 15)
		local spawnCF   = rootCFrame
			* CFrame.Angles(math.rad(pitchDeg), math.rad(yawDeg), math.random(-360, 360))
			* CFrame.new(
				math.random(-1000, 1000) / 1000,   -- X jitter: -1 to 1 studs
				math.random(-1000, 1000) / 1000,   -- Y jitter: -1 to 1 studs
				-4                                  -- 4 studs forward
			)
		shard:PivotTo(spawnCF)

		-- Randomize the shard's visual properties
		local scaleMult  = math.random(120, 150) / 100     -- 1.2x – 1.5x scale multiplier
		local startSize  = math.random(100, 200) / 1000    -- 0.1 – 0.2 stud starting thickness
		local lengthMult = math.random(900, 1100) / 1700   -- ~0.53 – 0.65 length scale

		-- Apply the length scale to the core (PrimaryPart) Z axis only
		local core = shard.PrimaryPart
		core.Size = Vector3.new(core.Size.X, core.Size.Y, core.Size.Z * lengthMult)

		-- Apply the same length scale to the inner flame mesh
		local flame = shard.Flame
		flame.Size  = Vector3.new(flame.Size.X, flame.Size.Y, flame.Size.Z * lengthMult)
		flame.CFrame = flame.CFrame * CFrame.new(0, 0, -0.75)  -- shift flame slightly forward

		shard.Parent = workspace.Effects

		-- Animate both parts outward simultaneously
		animateShard(core,  8, scaleMult, startSize)
		animateShard(flame, 8, scaleMult, startSize)

		-- Spawn a flat shockwave ring at the impact point (14 studs ahead, on the ground)
		local impactCFrame = core.CFrame
			* CFrame.new(0, 0, -14)
			* CFrame.Angles(math.pi / 2, math.random(-360, 360), 0)

		local shockwaveRadius = math.random(500, 1000) / 100   -- 5 – 10 studs

		_G.PlayEffect(
			"Shockwave2", nil,
			impactCFrame * CFrame.new(0, 1, 0),
			impactCFrame * CFrame.Angles(0, -math.pi, 0),
			BrickColor.new(flameColor),
			Vector3.new(shockwaveRadius, 0.3, shockwaveRadius),   -- start size
			Vector3.new(2, 0.3, 2),                               -- end size
			0.1, 0,
			Enum.EasingStyle.Back,
			flameColor,
			Enum.Material.Neon,
			"Rings"
		)

		-- Clean up the shard after the tween finishes
		_G.destroy(shard, 0.1)

		-- Emit a burst of small spheres around the character's feet
		_G.PlayEffect("Spheres", nil, {
			startSize = Vector3.new(0, 0, 0),
			xrange    = 6.67,    -- spread width
			yrange    = 8,       -- spread height
			zrange    = 6.67,    -- spread depth
			cf        = rootCFrame
				* CFrame.Angles(math.pi / 4, 0, 0)
				* CFrame.new(0, -3, 0),
			ti        = 0.2,     -- time to expand
			ti2       = 0.1,     -- time to fade
			range     = 0,
			minThick  = 0.2,
			maxThick  = 5,
			part      = nil,
			color     = flameColor,
			am        = 1        -- amount (1 sphere)
		})

		-- Wait one physics frame before spawning the next shard
		game["Run Service"].Heartbeat:Wait()

		-- Stop the loop if the tracker instance has been removed from the game
		if not tracker:IsDescendantOf(game) then
			return
		end
	end
end

return FireTrailEffect