-- SlashModule (put this inside the SlashModule script)
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local rng = Random.new()
local camera = workspace.CurrentCamera

local SLASH_FRAMES = {
	"rbxassetid://14032611623",
	"rbxassetid://14032611330",
	"rbxassetid://14032611036",
	"rbxassetid://14032610801",
	"rbxassetid://14032610574",
	"rbxassetid://14032610361",
	"rbxassetid://14032610154",
	"rbxassetid://14032609981",
	"rbxassetid://14032609839",
	"rbxassetid://14032609649",
	"rbxassetid://14032609392",
}

local groundRayParams = RaycastParams.new()
groundRayParams.FilterType = Enum.RaycastFilterType.Include
groundRayParams.FilterDescendantsInstances = { workspace.World.Map }

local SlashModule = {}

local function playTween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t.Completed:Once(function() t:Destroy() end)
	t:Play()
	return t
end

local function emitParticles(obj)
	for _, child in obj:GetDescendants() do
		if child:IsA("ParticleEmitter") then
			child:Emit(child:GetAttribute("EmitCount") or 1)
		elseif child:IsA("PointLight") then
			local t = TweenService:Create(child,
				TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true, 0),
				{ Brightness = 2 })
			t.Completed:Once(function() t:Destroy() end)
			t:Play()
		end
	end
end

local function spawnSlashDecalPair(cache, hakiColor, spawnCFrame)
	local slash1 = cache.Slash:Clone()
	Debris:AddItem(slash1, 3)
	slash1.CFrame = spawnCFrame
	slash1.Decal.Color3 = hakiColor
	slash1.Parent = workspace.World.Visuals

	local slash2 = cache.Slash2:Clone()
	Debris:AddItem(slash2, 3)
	slash2.CFrame = spawnCFrame
	slash2.Parent = workspace.World.Visuals

	--slash1.Size = Vector3.new(20, 20, 20)
	--slash2.Size = Vector3.new(20, 20, 20)

	local decal1 = slash1:FindFirstChildOfClass("Decal")
	if decal1 then
		coroutine.wrap(function()
			for i = 1, #SLASH_FRAMES do
				decal1.Texture = SLASH_FRAMES[i]
				task.wait(1 / 40)
			end
			decal1.Texture = ""
		end)()
	end

	local decal2 = slash2:FindFirstChildOfClass("Decal")
	if decal2 then
		coroutine.wrap(function()
			for i = 1, #SLASH_FRAMES do
				decal2.Texture = SLASH_FRAMES[i]
				task.wait(1 / 35)
			end
			decal2.Texture = ""
		end)()
	end

	playTween(slash1, TweenInfo.new(0.4), { CFrame = slash1.CFrame * CFrame.new(-10, 0, 0) })
	playTween(slash1.Mesh, TweenInfo.new(0.4), { Scale = Vector3.new(-24, -12, -24) })
	playTween(slash2, TweenInfo.new(0.425), { CFrame = slash1.CFrame * CFrame.new(-9, 0, 0) })
	playTween(slash2.Mesh, TweenInfo.new(0.425), { Scale = Vector3.new(-22, -11, -22) })
end

local function spawnGroundDebris(cache, worldPos)
	local hit = workspace:Raycast(worldPos, Vector3.new(0, -100, 0), groundRayParams)
	if not hit then return end

	local size = rng:NextNumber(2.5, 10)
	local chunk = Instance.new("Part")
	Debris:AddItem(chunk, 4)
	chunk.CastShadow = false
	chunk.Size = Vector3.new(size, size * 0.5, size)
	chunk.CFrame = CFrame.new(hit.Position, hit.Position + hit.Normal) * CFrame.Angles(-math.pi / 2, 0, 0)
	local basePos = chunk.CFrame * CFrame.new(0, -chunk.Size.Y * 0.3, 0)
	chunk.CFrame = basePos * CFrame.Angles(
		math.rad(math.random(-15, 15)),
		math.rad(math.random(-15, 15)),
		math.rad(math.random(-15, 15))
	)
	chunk.Anchored = true
	chunk.CanCollide = false
	chunk.Color = hit.Instance.Color
	chunk.Material = hit.Instance.Material
	chunk.Parent = workspace.World.Visuals

	task.delay(0.45, function()
		for _, particle in cache.Particles:GetChildren() do
			local clone = particle:Clone()
			Debris:AddItem(clone, 2)
			clone.Parent = chunk
		end
		emitParticles(chunk)
		TweenService:Create(chunk, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			CFrame = chunk.CFrame * CFrame.new(0, math.random(5, 25), 0)
		}):Play()
		task.wait(0.15)
		TweenService:Create(chunk, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = chunk.CFrame * CFrame.new(0, 7.5, 0)
		}):Play()
		task.wait(0.75)
		chunk.Anchored = false
		chunk.CanCollide = true
		task.wait(2)
		TweenService:Create(chunk, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new()
		}):Play()
	end)
end

function SlashModule.Play(cache, character, atkCFrame, isLocalPlayer)
	local hakiColor = Color3.new(0.384314, 0.054902, 0.654902) 
	--local hakiColor = Color3.new(0.129412, 0.866667, 0.301961) 

	task.spawn(function()
		local dustCloud = cache.DustGround:Clone()
		Debris:AddItem(dustCloud, 3)
		dustCloud.CFrame = atkCFrame * CFrame.new(0, -2.9, -50)
		dustCloud.Parent = workspace.World.Visuals
		emitParticles(dustCloud)

		local dashMesh = cache.DashMesh:Clone()
		Debris:AddItem(dashMesh, 0.5)
		dashMesh.CFrame = atkCFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(0, math.pi, 0)
		dashMesh.Color = hakiColor
		dashMesh.Parent = workspace.World.Visuals

		local mainSlash = cache.MainSlash:Clone()
		Debris:AddItem(mainSlash, 0.5)
		mainSlash.CFrame = atkCFrame * CFrame.new(0, 0, -10)
		mainSlash.Color = hakiColor
		mainSlash.Parent = workspace.World.Visuals

		local windRing = cache.Wind:Clone()
		Debris:AddItem(windRing, 0.2)
		windRing.CFrame = atkCFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(math.pi / 2, math.rad(math.random(-360, 360)), 0)
		windRing.Parent = workspace.World.Visuals

		local shock = cache.Shock:Clone()
		Debris:AddItem(shock, 3)
		shock.CFrame = atkCFrame * CFrame.Angles(-math.pi / 2, 0, 0)
		shock.Parent = workspace.World.Visuals

		local whiteMesh = cache.WhiteMesh:Clone()
		Debris:AddItem(whiteMesh, 3)
		whiteMesh.CFrame = atkCFrame * CFrame.new(0, 0, 15) * CFrame.Angles(math.pi / 2, 0, 0)
		whiteMesh.Decal.Color3 = hakiColor
		whiteMesh.Parent = workspace.World.Visuals

		local sw1 = cache.Shockwave:Clone()
		Debris:AddItem(sw1, 3)
		sw1.CFrame = atkCFrame * CFrame.new(-5, 0, -55) * CFrame.Angles(0, math.rad(70), 0)
		sw1.Parent = workspace.World.Visuals

		local sw2 = cache.Shockwave:Clone()
		Debris:AddItem(sw2, 3)
		sw2.CFrame = atkCFrame * CFrame.new(5, 0, -55) * CFrame.Angles(0, math.rad(110), 0)
		sw2.Color = hakiColor
		sw2.Parent = workspace.World.Visuals

		local sw3 = cache.Shockwave2:Clone()
		Debris:AddItem(sw3, 3)
		sw3.CFrame = atkCFrame * CFrame.new(-10, 10, -2.5) * CFrame.Angles(0, math.rad(70), 0)
		sw3.Color = hakiColor
		sw3.Parent = workspace.World.Visuals

		local sw4 = cache.Shockwave2:Clone()
		Debris:AddItem(sw4, 3)
		sw4.CFrame = atkCFrame * CFrame.new(10, 10, -2.5) * CFrame.Angles(0, math.rad(110), 0)
		sw4.Color = hakiColor
		sw4.Parent = workspace.World.Visuals

		local greyFin1 = cache.Shockwave2:Clone()
		Debris:AddItem(greyFin1, 3)
		greyFin1.BrickColor = BrickColor.new("Medium stone grey")
		greyFin1.CFrame = atkCFrame * CFrame.new(-5, 0, -55) * CFrame.Angles(0, math.rad(80), 0)
		greyFin1.Parent = workspace.World.Visuals

		local greyFin2 = cache.Shockwave2:Clone()
		Debris:AddItem(greyFin2, 3)
		greyFin2.BrickColor = BrickColor.new("Medium stone grey")
		greyFin2.CFrame = atkCFrame * CFrame.new(5, 0, -55) * CFrame.Angles(0, math.rad(100), 0)
		greyFin2.Parent = workspace.World.Visuals

		local whiteMesh2 = cache.WhiteMesh2:Clone()
		Debris:AddItem(whiteMesh2, 3)
		whiteMesh2.CFrame = atkCFrame * CFrame.Angles(0, -math.pi / 2, 0)
		whiteMesh2.Parent = workspace.World.Visuals

		local slashLine1 = cache.MainSlash:Clone()
		Debris:AddItem(slashLine1, 3)
		slashLine1.CFrame = atkCFrame * CFrame.new(0, -2.9, -25) * CFrame.Angles(0, math.rad(70), 0)
		slashLine1.Size = Vector3.new(0, 1, 1)
		slashLine1.Color = hakiColor
		slashLine1.Parent = workspace.World.Visuals

		local slashLine2 = cache.MainSlash:Clone()
		Debris:AddItem(slashLine2, 3)
		slashLine2.CFrame = atkCFrame * CFrame.new(0, -2.9, 0) * CFrame.Angles(0, math.rad(110), 0)
		slashLine2.Size = Vector3.new(0, 1, 1)
		slashLine2.Color = hakiColor
		slashLine2.Parent = workspace.World.Visuals

		local windSwave = cache.WindSwave:Clone()
		Debris:AddItem(windSwave, 3)
		windSwave.CFrame = atkCFrame * CFrame.Angles(-math.pi / 2, 0, 0)
		windSwave.Parent = workspace.World.Visuals

		local sw3InitCFrame = sw3.CFrame
		local sw4InitCFrame = sw4.CFrame

		playTween(sw3, TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new(60, 12.5, 0.05), CFrame = sw3InitCFrame * CFrame.new(30, -10, 0),
		})
		playTween(sw4, TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new(60, 12.5, 0.05), CFrame = sw4InitCFrame * CFrame.new(30, -10, 0),
		})
		playTween(slashLine1, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = Vector3.new(50, 0.75, 0.75),
			CFrame = atkCFrame * CFrame.new(0, -2.9, -25) * CFrame.Angles(0, math.rad(70), 0),
		})
		playTween(slashLine2, TweenInfo.new(0.125, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = Vector3.new(50, 0.75, 0.75),
			CFrame = atkCFrame * CFrame.new(0, -2.9, -25) * CFrame.Angles(0, math.rad(110), 0),
		})
		playTween(windSwave, TweenInfo.new(0.075, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = Vector3.new(27.5, 5, 27.5), CFrame = windSwave.CFrame * CFrame.new(0, -2.5, 0), Transparency = 0.6,
		})

		task.delay(0.075, function()
			playTween(sw3, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Size = Vector3.new(0, 0, 0.05), CFrame = sw3InitCFrame * CFrame.new(60, -14, 0),
			})
			playTween(sw4, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Size = Vector3.new(0, 0, 0.05), CFrame = sw3InitCFrame * CFrame.new(60, -14, 0),
			})
			playTween(windSwave, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = Vector3.new(35, 0, 35), Transparency = 1, CFrame = windSwave.CFrame * CFrame.new(0, -10, 0),
			})
			task.wait(1)
			playTween(slashLine1, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Transparency = 1, Color = Color3.new(0, 0, 0),
			})
			playTween(slashLine2, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Transparency = 1, Color = Color3.new(0, 0, 0),
			})
		end)

		playTween(sw1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new(30, 7.5, 0.05), CFrame = sw1.CFrame * CFrame.new(-15, 3, 0), Transparency = 1,
		})
		playTween(sw2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new(30, 7.5, 0.05), CFrame = sw2.CFrame * CFrame.new(-15, 3, 0), Transparency = 1,
		})
		playTween(greyFin1, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = Vector3.new(75, 5, 0), CFrame = greyFin1.CFrame * CFrame.new(-37.5, 0, -2.5), Transparency = 1,
		})
		playTween(greyFin2, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = Vector3.new(75, 5, 0), CFrame = greyFin2.CFrame * CFrame.new(-37.5, 0, 2.5), Transparency = 1,
		})
		playTween(windRing, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = Vector3.new(5, 30, 5), CFrame = windRing.CFrame * CFrame.new(0, -50, 0), Transparency = 1,
		})
		playTween(dashMesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = Vector3.new(10, 10, 60), CFrame = dashMesh.CFrame * CFrame.new(0, 0, 40),
		})
		playTween(mainSlash, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = Vector3.new(1, 1, 30), CFrame = mainSlash.CFrame * CFrame.new(0, 0, -50),
		})
		playTween(shock, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = Vector3.new(15, 45, 15),
			CFrame = atkCFrame * CFrame.new(0, 0, -12.5) * CFrame.Angles(-math.pi / 2, math.pi / 4, 0),
		})
		playTween(whiteMesh.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Scale = Vector3.new(-1.325, 0.5, 0.5),
		})
		playTween(whiteMesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			CFrame = atkCFrame * CFrame.new(0, 0, -30) * CFrame.Angles(math.pi / 2, 0, -math.pi / 2),
		})
		playTween(whiteMesh2, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			CFrame = whiteMesh2.CFrame * CFrame.Angles(2 * math.pi / 3, 0, 0),
		})
		playTween(whiteMesh2.Mesh, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = Vector3.new(0.2, 0.8, 0.8),
		})
		playTween(whiteMesh2.Decal, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Transparency = 1,
		})

		task.delay(0.1, function()
			playTween(dashMesh, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Size = Vector3.new(0, 0, 30), CFrame = dashMesh.CFrame * CFrame.new(0, 0, 10),
			})
			playTween(mainSlash, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Size = Vector3.new(0, 0, 0), CFrame = mainSlash.CFrame * CFrame.new(0, 0, -12.5),
			})
			playTween(shock, TweenInfo.new(1.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = Vector3.new(15, 60, 15),
				CFrame = atkCFrame * CFrame.new(0, 0, -30) * CFrame.Angles(-math.pi / 2, 2 * math.pi / 3, 0),
				Transparency = 1,
			})
			playTween(whiteMesh.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Scale = Vector3.new(-1.325, 0, 0),
			})
		end)

		--spawnSlashDecalPair(cache, hakiColor, atkCFrame * CFrame.new(0, 0, -35) * CFrame.Angles(0, -math.pi / 2, 0) * CFrame.Angles(-math.rad(15), 0, 0))
		--spawnSlashDecalPair(cache, hakiColor, atkCFrame * CFrame.new(0, 0, -34) * CFrame.Angles(0, -math.pi / 2, 0) * CFrame.Angles(math.rad(15), 0, 0))
		spawnSlashDecalPair(cache, hakiColor, atkCFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.pi/2, 0) * CFrame.Angles(-math.rad(15), 0, 0))
		spawnSlashDecalPair(cache, hakiColor, atkCFrame * CFrame.new(0, 0, -6) * CFrame.Angles(0, math.pi/2, 0) * CFrame.Angles(math.rad(15), 0, 0))
		
		
		local impactCenter = atkCFrame * CFrame.new(0, 0, -30)
		--for _ = 1, 15 do
		--	local randomPos = (impactCenter * CFrame.new(math.random(-15, 15), 0, math.random(-15, 45))).Position
		--	spawnGroundDebris(cache, randomPos)
		--end

		task.wait(0.4)
		if isLocalPlayer then
			task.spawn(function()
				game.Lighting.ColorCorrection.Enabled = false
				local bwFilter = cache.BW:Clone()
				bwFilter.Parent = camera
				bwFilter.Enabled = true
				task.wait(0.1)
				bwFilter:Destroy()
				game.Lighting.ColorCorrection.Enabled = true
			end)
		end

		task.wait(0.1)
		local floorEffect = cache.FloorEffect:Clone()
		Debris:AddItem(floorEffect, 3)
		floorEffect.CFrame = impactCenter * CFrame.new(0, -2.9, 0)
		floorEffect.Parent = workspace.World.Visuals
		emitParticles(floorEffect)
	end)
end

return SlashModule