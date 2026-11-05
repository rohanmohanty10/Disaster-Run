local TornadoRockModule = {}

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Config = {
	SpawnInterval    = 0.1,
	RocksPerInterval = 3,
	MinRadius        = 5,
	MaxRadius        = 15,
	SpawnHeight      = 0,
	UpwardSpeed      = 40,
	RotationSpeed    = -250,
	SpinSpeed        = 700,
	MaxHeight        = 25,
	RockSize         = Vector3.new(1, 1, 1),
	RandomSizeScale  = NumberRange.new(0.2, 1),
}

-- Creates a single anchored rock part at the given position with a random size and rotation
local function createRock(position)
	local sizeScale = math.random() * (Config.RandomSizeScale.Max - Config.RandomSizeScale.Min) + Config.RandomSizeScale.Min

	local rock = Instance.new("Part")
	rock.Name       = "TornadoRock"
	rock.Size       = Config.RockSize * sizeScale
	rock.CastShadow = false
	rock.Anchored   = true
	rock.CanCollide = false

	local randomRotation = CFrame.Angles(
		math.rad(math.random(0, 360)),
		math.rad(math.random(0, 360)),
		math.rad(math.random(0, 360))
	)
	rock.CFrame = CFrame.new(position) * randomRotation
	rock.Parent = workspace.World.Debris

	return rock
end

-- Animates a rock spiraling upward around the tornado center, then shrinks and destroys it
local function animateRock(rock, tornadoCenter, startPosition)
	-- Pick a random orbit angle and radius
	local orbitAngle = math.random() * 360
	local orbitRadius = math.random(Config.MinRadius, Config.MaxRadius)

	-- Pick random per-axis spin directions
	local spinX = math.random() * 360
	local spinY = math.random() * 360
	local spinZ = math.random() * 360
	local dirX = math.random() < 0.5 and -1 or 1
	local dirY = math.random() < 0.5 and -1 or 1
	local dirZ = math.random() < 0.5 and -1 or 1

	local shrinkThreshold = tornadoCenter.Y + 0.75 * Config.MaxHeight
	local hasShrunk = false
	local currentPosition = startPosition

	while currentPosition.Y < tornadoCenter.Y + Config.MaxHeight do
		local dt = RunService.Heartbeat:Wait()

		-- Orbit around the tornado center
		orbitAngle = (orbitAngle + Config.RotationSpeed * dt) % 360
		local angleRad = math.rad(orbitAngle)

		currentPosition = Vector3.new(
			tornadoCenter.X + orbitRadius * math.cos(angleRad),
			currentPosition.Y + Config.UpwardSpeed * dt,
			tornadoCenter.Z + orbitRadius * math.sin(angleRad)
		)

		-- Spin the rock on all three axes
		spinX = (spinX + Config.SpinSpeed * dt * dirX) % 360
		spinY = (spinY + Config.SpinSpeed * dt * dirY) % 360
		spinZ = (spinZ + Config.SpinSpeed * dt * dirZ) % 360

		rock.CFrame = CFrame.new(currentPosition) * CFrame.Angles(
			math.rad(spinX),
			math.rad(spinY),
			math.rad(spinZ)
		)

		-- Once the rock reaches 75% of max height, start shrinking it
		if not hasShrunk and currentPosition.Y >= shrinkThreshold then
			local shrinkTween = TweenService:Create(rock, TweenInfo.new(0.25), {
				Size = Vector3.new(0, 0, 0)
			})
			shrinkTween:Play()
			shrinkTween.Completed:Connect(function()
				rock:Destroy()
			end)
			hasShrunk = true
		end
	end

	-- Fallback destroy if shrink tween never triggered
	if not hasShrunk then
		rock:Destroy()
	end
end

-- Main loop: spawns rocks around the tornado anchor part until the stop signal is removed
function TornadoRockModule.startTornado(_, anchorPart, stopSignal)
	local lastSpawnTime = 0

	while anchorPart and anchorPart.Parent and (not stopSignal or stopSignal:IsDescendantOf(game)) do
		if tick() - lastSpawnTime >= Config.SpawnInterval then

			for _ = 1, Config.RocksPerInterval do
				-- Pick a random spawn point around the tornado's base
				local spawnAngle = math.rad(math.random() * 360)
				local spawnRadius = math.random(Config.MinRadius, Config.MaxRadius)
				local center = anchorPart.Position

				local spawnOffset = Vector3.new(
					spawnRadius * math.cos(spawnAngle),
					Config.SpawnHeight,
					spawnRadius * math.sin(spawnAngle)
				)
				local spawnPoint = center + spawnOffset

				---- Raycast downward to find the floor
				--local hitFloor, floorPosition = _G.getRayFloor(CFrame.new(spawnPoint), 15 + Config.SpawnHeight)
				local hitFloor, floorPosition = shared.getRayFloor(CFrame.new(spawnPoint), 15 + Config.SpawnHeight)


				if hitFloor then
					local rock = createRock(floorPosition)
					
					--_G.matchMaterial(rock, hitFloor)
					shared.matchMaterial(rock, hitFloor)

					coroutine.wrap(function()
						animateRock(rock, anchorPart.Position, floorPosition)
					end)()
				end
			end

			lastSpawnTime = tick()
		end

		task.wait()
	end
end

return TornadoRockModule