-- ServerStorage > SBGModules > SpecialDestruction   (ModuleScript, server only)
-- Called by DebreeService for whitelisted SpecialType models (see SPECIAL_TYPES there).
local SpecialDestruction = {}

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService") 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Remotes = ReplicatedStorage.Remotes
local Assets = ReplicatedStorage.Assets

local SoundHandler = require(ReplicatedStorage.Modules:WaitForChild("SoundHandler"))

-- The Dictionary of Custom Behaviors
local SpecialHandlers = {}

SpecialHandlers["Bookshelf"] = function(model, hitPos, player, params)
	local modelSize = model:GetExtentsSize()
	local effectCFrames = {}
	local effectSizes = {}
	local PivotToUse = model:GetPivot()
	
	local debrisParts = {}
	
	for _, child in model:GetChildren() do
		if child:IsA("BasePart") then
			local child:BasePart = child
			if math.random() > 0.1 then
				table.insert(effectCFrames, child.CFrame)
				table.insert(effectSizes, child.Size)
				child:Destroy()
				continue 
			end

			child.Anchored = false
			child.CollisionGroup = "NotTouchableVisualDestruction"
			child.Massless = true
			child.CanTouch = false
			child.CanCollide = true
			child.CanQuery = false
			child.EnableFluidForces = false
			child.AudioCanCollide = false
			child.CastShadow = false

			-- Fling the wooden planks outward
			local outward = (child.Position - hitPos).Unit
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			child.AssemblyLinearVelocity = outward * math.random(0, 10) + Vector3.new(0, math.random(0, 5), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

			child:SetNetworkOwner(player)

			table.insert(debrisParts, child)
		end
	end
	
	--SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.BookShelf)
	-- Scatter the Books
	local booksContainer = model:FindFirstChild("Books")
	if booksContainer then
		for _, descendant in booksContainer:GetDescendants() do
			if descendant:IsA("BasePart") then
				local descendant:BasePart = descendant

				if math.random() > .1 then
					descendant:Destroy()
					continue 
				end

				descendant.Anchored = false
				descendant.CanCollide = true
				descendant.CollisionGroup = "NotTouchableVisualDestruction"
				descendant.Massless = true
				descendant.CanTouch = false
				descendant.CanQuery = false
				descendant.EnableFluidForces = false
				descendant.AudioCanCollide = false
				descendant.CastShadow = false

				-- Give books slightly more velocity so they fly further than the heavy wood
				local outward = (descendant.Position - hitPos).Unit
				outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
				descendant.AssemblyLinearVelocity = outward * math.random(5, 10) + Vector3.new(0, math.random(1, 5), 0)
				descendant.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

				descendant:SetNetworkOwner(player)

				table.insert(debrisParts, descendant)
			end
		end
	end
	
	if #effectCFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Wood Object",
			EffectCFrames = effectCFrames, -- List of cframes. Better for preformance since its 1 remote with data.
			EffectSize = effectSizes,
		})
	end
	
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(10, 20) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
end

SpecialHandlers["Bottle Shelf"] = function(model, hitPos, player, params)
	local modelSize = model:GetExtentsSize()
	local effectCFrames = {}
	local effectSizes = {}
	local PivotToUse = model:GetPivot()

	local debrisParts = {}

	for _, child in model:GetChildren() do
		if child:IsA("BasePart") then
			local child:BasePart = child
			if math.random() > 0.5 then
				table.insert(effectCFrames, child.CFrame)
				table.insert(effectSizes, child.Size)
				child:Destroy()
				continue 
			end

			child.Anchored = false
			child.CollisionGroup = "NotTouchableVisualDestruction"
			child.Massless = true
			child.CanTouch = false
			child.CanCollide = true
			child.CanQuery = false
			child.EnableFluidForces = false
			child.AudioCanCollide = false
			child.CastShadow = false

			-- Fling the wooden planks outward
			local outward = (child.Position - hitPos).Unit
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			child.AssemblyLinearVelocity = outward * math.random(20, 40) + Vector3.new(0, math.random(5, 10), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

			child:SetNetworkOwner(player)

			table.insert(debrisParts, child)
		end
	end

	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.BookShelf)
	-- Scatter the Books
	local bottleContainer = model:FindFirstChild("Bottles")
	if bottleContainer then
		for _, descendant in bottleContainer:GetDescendants() do
			if descendant:IsA("Model") then
				local descendant:BasePart = descendant

				if math.random() > .1 then
					descendant:Destroy()
					continue 
				end

				descendant.Anchored = false
				descendant.CanCollide = true
				descendant.CollisionGroup = "NotTouchableVisualDestruction"
				descendant.Massless = true
				descendant.CanTouch = false
				descendant.CanQuery = false
				descendant.EnableFluidForces = false
				descendant.AudioCanCollide = false
				descendant.CastShadow = false

				-- Give books slightly more velocity so they fly further than the heavy wood
				local outward = (descendant.Position - hitPos).Unit
				outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
				descendant.AssemblyLinearVelocity = outward * math.random(5, 10) + Vector3.new(0, math.random(1, 5), 0)
				descendant.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

				descendant:SetNetworkOwner(player)

				table.insert(debrisParts, descendant)
			end
		end
	end

	if #effectCFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Wood Object",
			EffectCFrames = effectCFrames, -- List of cframes. Better for preformance since its 1 remote with data.
			EffectSize = effectSizes,
		})
	end

	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(10, 20) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
end

SpecialHandlers["Bed"] = function(model, hitPos, player, params)
	local modelSize = model:GetExtentsSize()
	local effectCFrames = {}
	local effectSizes = {}
	local PivotToUse = model:GetPivot()
	
	local debrisParts = {}

	for _, child in model:GetChildren() do
		if child:IsA("BasePart") then
			local child:BasePart = child
			if math.random() > 0.5 then
				table.insert(effectCFrames, child.CFrame)
				table.insert(effectSizes, child.Size)
				child:Destroy()
				continue 
			end

			child.Anchored = false
			child.CanCollide = true
			child.CollisionGroup = "TouchableDebris"
			child.Massless = true
			child.CanTouch = false
			child.CanQuery = false
			child.EnableFluidForces = false
			child.CastShadow = false

			-- Fling the wooden planks outward
			local outward = (child.Position - hitPos).Unit
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			child.AssemblyLinearVelocity = outward * math.random(10, 25) + Vector3.new(0, math.random(15, 30), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

			child:SetNetworkOwner(player)

			table.insert(debrisParts, child)
		end
	end

	-- Batched Processing
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	if #effectCFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Wood Object",
			EffectCFrames = effectCFrames, -- List of cframes. Better for preformance since its 1 remote with data.
			EffectSize = effectSizes,
		})
	end

	local sounds = {
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["1"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["2"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["3"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["4"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["5"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["6"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["7"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["8"],
	}

	SoundHandler:AddSound(sounds[math.random(1, #sounds)], PivotToUse)
end

SpecialHandlers["Lamp Post"] = function(model, hitPos, player, params)
	local debrisParts = {}
	
	for _, child in model:GetChildren() do
		if child:IsA("MeshPart") and child.Name then
			local child:MeshPart = child
			if child.Name == "Cylinder_Cylinder" or child.Name == "Cylinder.002_Cylinder.002" then
				local DIM_TIME = 2.5
				local info = TweenInfo.new(DIM_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				local light = child:FindFirstChildWhichIsA("SpotLight", true)          -- SpotLight/PointLight/etc
				local wisp  = child:FindFirstChildWhichIsA("ParticleEmitter", true) -- WispSpread

				if light then
					TweenService:Create(light, info, { Brightness = 0, Range = 0 }):Play()
				end

				-- optional: if the mesh itself glows (Neon), fade it too
				task.delay(math.random() * 1.5 + 1, function()
					TweenService:Create(child, info, { Transparency = 1 }):Play()
					if wisp then
						wisp.Enabled = false -- stops new particles; existing ones fade out on their own
					end
				end)
			end

			child.Anchored = false
			child.CanCollide = true
			child.CollisionGroup = "TouchableDebris"

			child.Massless = true
			child.CanTouch = false
			child.CanQuery = false
			child.EnableFluidForces = false
			child.CastShadow = true

			-- Fling the wooden planks outward
			local outward = (child.Position - hitPos).Unit
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

			local owner = (player and player.Parent) and player or nil
			if child:CanSetNetworkOwnership() then
				child:SetNetworkOwner(owner)
			end

			-- Store for batching
			table.insert(debrisParts, child)
		end
	end

	-- Batched Processing
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	shared.fireTo(ReplicatedStorage.Remotes.Replicate.Set, { player }, { "ShakeCamera", { Intensity = 2} })

	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Lamp Post"][math.random(1, 5)], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Lamp Post"].Impact1, model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Lamp Post"].Impact2, model:GetPivot())
end

SpecialHandlers["Small Lamp Post"] = function(model, hitPos, player, params)
	local debrisParts = {}
	
	for _, child in model:GetChildren() do
		if child:IsA("MeshPart") and child.Name then
			local child:MeshPart = child
			if child.Name == "Cylinder.001_light" then
				local DIM_TIME = 2.5
				local info = TweenInfo.new(DIM_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				local light = child:FindFirstChildWhichIsA("SpotLight", true)          -- SpotLight/PointLight/etc
				local wisp  = child:FindFirstChildWhichIsA("ParticleEmitter", true) -- WispSpread

				if light then
					TweenService:Create(light, info, { Brightness = 0, Range = 0 }):Play()
				end

				task.delay(math.random() * 1.5 + 1, function()
					TweenService:Create(child, info, { Transparency = 1 }):Play()
					if wisp then
						wisp.Enabled = false 
					end
				end)
			end

			child.Anchored = false
			child.CanCollide = true
			child.CollisionGroup = "TouchableDebris"

			child.Massless = true
			child.CanTouch = false
			child.CanQuery = false
			child.EnableFluidForces = false
			child.CastShadow = true

			local outward = (child.Position - hitPos).Unit
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

			--child:SetNetworkOwner(player)

			-- Store for batching
			table.insert(debrisParts, child)
		end
	end

	-- Batched Processing
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	task.delay(.05, function()
		SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Small Lamp Post"]["Glass"..math.random(1, 4)], model:GetPivot())
	end)
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Small Lamp Post"].Impact1, model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Small Lamp Post"].Impact2, model:GetPivot())
	--SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Lamp Post"][math.random(1, 5)], model:GetPivot())
	--SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Lamp Post"].Impact1, model:GetPivot())
	--SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Lamp Post"].Impact2, model:GetPivot())
end

SpecialHandlers["Chandelier"] = function(model, hitPos, player, params)
	local debrisParts = {}

	-- Grab this BEFORE destroying anything: every candle inside "Lights" is also
	-- named "Model", and we must not let the "Model" kill-rule below nuke them.
	local lightsContainer = model:FindFirstChild("Lights", true)

	--=========================================================================
	-- 1) ALWAYS destroyed — no fling, no chance.
	--    "Model" / "Chain / Chandelier Ring" / "Light" are DIRECT children, so we
	--    only match direct children (candles named "Model" live under Lights and
	--    are safe). "Cones" is nested, so find + destroy that whole group by name.
	--=========================================================================
	local KILL_DIRECT = {
		["Model"] = true,
		["Chain / Chandelier Ring"] = true,
		["Light"] = true,
	}

	for _, child in model:GetChildren() do
		if KILL_DIRECT[child.Name] then
			child:Destroy()
		end
	end

	local cones = model:FindFirstChild("Cones", true)
	if cones then
		cones:Destroy()
	end

	--=========================================================================
	-- 2) Candles (inside "Lights"): each is a 2-piece Model. Weld the pieces so
	--    the candle flies as ONE rigid chunk, then fling it as a single assembly.
	--    Chance to just poof the whole candle instead (tune CANDLE_POOF_CHANCE).
	--=========================================================================
	local CANDLE_POOF_CHANCE = 0.5

	if lightsContainer then
		for _, candle in lightsContainer:GetChildren() do
			if not candle:IsA("Model") then
				continue
			end

			if math.random() < CANDLE_POOF_CHANCE then
				candle:Destroy()
				continue
			end

			local parts = {}
			for _, p in candle:GetDescendants() do
				if p:IsA("BasePart") then
					table.insert(parts, p)
				end
			end
			if #parts == 0 then
				continue
			end

			-- One part carries the mass; weld the others rigidly to it.
			local root = candle.PrimaryPart or parts[1]

			for _, p in parts do
				p.Anchored = false
				p.CanCollide = true
				p.CollisionGroup = "NotTouchableVisualDestruction"
				p.CanTouch = false
				p.CanQuery = false
				p.EnableFluidForces = false
				p.CastShadow = false

				if p ~= root then
					local weld = Instance.new("WeldConstraint")
					weld.Part0 = root
					weld.Part1 = p
					weld.Parent = root
					p.Massless = true -- only the root carries mass for the assembly
				end
			end

			-- Fling the WHOLE assembly once, through the root.
			local outward = root.Position - hitPos
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			root.AssemblyLinearVelocity = outward * math.random(15, 25) + Vector3.new(0, math.random(5, 15), 0)
			root.AssemblyAngularVelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))

			local owner = (player and player.Parent) and player or nil
			if root:CanSetNetworkOwnership() then
				root:SetNetworkOwner(owner)
			end

			for _, p in parts do
				table.insert(debrisParts, p)
			end
		end
	end

	--=========================================================================
	-- 3) The rest (Ring, Chain, Hang, frame): your normal fling-with-a-chance.
	--    Candles are skipped here — handled above.
	--=========================================================================
	for _, child in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end
		if lightsContainer and child:IsDescendantOf(lightsContainer) then
			continue
		end

		if math.random() > 1 then
			child:Destroy()
			continue
		end

		child.Anchored = false
		child.CanCollide = true
		child.CollisionGroup = "TouchableDebris"
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false
		child.CastShadow = true

		local outward = child.Position - hitPos
		outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
		child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
		child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

		local owner = (player and player.Parent) and player or nil
		if child:CanSetNetworkOwnership() then
			child:SetNetworkOwner(owner)
		end

		table.insert(debrisParts, child)
	end

	--=========================================================================
	-- 4) Standard batched anchor + shrink-out cleanup (same as your other handlers)
	--=========================================================================
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end

	--=========================================================================
	-- 5) Sound (kept from your current handler)
	--=========================================================================
	task.delay(.05, function()
		SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Small Lamp Post"]["Glass"..math.random(1, 4)], model:GetPivot())
	end)
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Small Lamp Post"].Impact1, model:GetPivot())
end

SpecialHandlers["Weapon"] = function(model, hitPos, player, params)
	-- Weapons don't break. Every part in the model gets welded into ONE rigid
	-- assembly, unanchored, and given a small shove so it topples off the wall
	-- and falls. Nothing scatters, shrinks, or gets destroyed — the reset inside
	-- SpecialDestruction.process removes the clone when timeToReset expires.

	local parts = {}
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") then
			table.insert(parts, d)
		end
	end
	if #parts == 0 then
		return
	end

	-- Root = the part that carries the assembly's mass. Prefer an explicit
	-- PrimaryPart; otherwise the largest VISIBLE part, so we never root the
	-- weapon on an invisible hitbox/handle part.
	local root = model.PrimaryPart
	if not root then
		local bestVolume = -1
		for _, p in parts do
			if p.Transparency < 1 then
				local volume = p.Size.X * p.Size.Y * p.Size.Z
				if volume > bestVolume then
					bestVolume = volume
					root = p
				end
			end
		end
		if not root then
			root = parts[1]
		end
	end

	for _, p in parts do
		p.Anchored = false
		-- Only visible geometry collides, so an invisible hitbox part can't prop
		-- the weapon up off the floor.
		p.CanCollide = (p.Transparency < 1)
		p.CollisionGroup = "NotTouchableVisualDestruction"
		p.CanTouch = false
		p.CanQuery = false
		p.EnableFluidForces = false
		p.CastShadow = true

		if p ~= root then
			-- Rigidly bind every piece to the root so the weapon moves as one
			-- object. Harmless if the model was already welded.
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = root
			weld.Part1 = p
			weld.Parent = root
			p.Massless = true -- only the root contributes mass to the assembly
		end
	end

	-- Guarantee something collides, or it drops through the floor.
	if not root.CanCollide then
		root.CanCollide = true
	end

	-- A nudge off the wall, NOT a fling. Gravity does the rest.
	local outward = root.Position - hitPos
	outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
	root.AssemblyLinearVelocity = outward * math.random(3, 7) + Vector3.new(0, math.random(1, 3), 0)
	root.AssemblyAngularVelocity = Vector3.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3))

	local owner = (player and player.Parent) and player or nil
	if root:CanSetNetworkOwnership() then
		root:SetNetworkOwner(owner)
	end

	-- Once it's settled, freeze it so it can't be kicked around and stops
	-- burning physics until the reset fires.
	task.delay(5, function()
		for _, p in parts do
			if p and p.Parent then
				p.Anchored = true
			end
		end
	end)

	-- PLACEHOLDER sound — this is your wood-object clatter. Swap it for a metal
	-- clang once you have one; the path just needs to exist.
	--SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects[tostring(math.random(1, 8))], model:GetPivot())
end



SpecialHandlers["Tree"] = function(model: Model, hitPos, player: Player, params)
	-- Tunables for the leaf-voxel fling. Hard caps so one big leaf chunk can't
	-- synchronously spawn hundreds of physics bodies in a single hit.
	local LEAF_VOXEL_MIN_SIZE = 3
	--local LEAF_VOXEL_MAX_DEPTH = 3
	local LEAF_VOXEL_MAX_PIECES = 8

	-- Depth-limited split via VoxBreaker:Divide (not VoxelizePart — see above).
	-- TimeToReset is always -1: VoxBreaker never schedules its own reset/cache-return,
	-- fireLeafPiece owns each piece's whole lifecycle instead.
	--local function voxelizeLeaf(leafPart: BasePart, parentForHolder: Instance): {BasePart}
	--	if leafPart.Size.X <= LEAF_VOXEL_MIN_SIZE
	--		and leafPart.Size.Y <= LEAF_VOXEL_MIN_SIZE
	--		and leafPart.Size.Z <= LEAF_VOXEL_MIN_SIZE then
	--		return { leafPart }
	--	end

	--	local pieces: {BasePart} = { leafPart }
	--	local voxelHolder: Instance? = nil

	--	for _ = 1, LEAF_VOXEL_MAX_DEPTH do
	--		local nextPieces = {}
	--		local dividedAny = false

	--		for _, piece in pieces do
	--			if not piece.Parent then
	--				continue
	--			end

	--			if piece.Size.X <= LEAF_VOXEL_MIN_SIZE
	--				and piece.Size.Y <= LEAF_VOXEL_MIN_SIZE
	--				and piece.Size.Z <= LEAF_VOXEL_MIN_SIZE then
	--				table.insert(nextPieces, piece)
	--				continue
	--			end

	--			local children = VoxBreaker:Divide(piece, LEAF_VOXEL_MIN_SIZE, nil, -1)
	--			dividedAny = true
	--			if voxelHolder == nil and children[1] then
	--				voxelHolder = children[1].Parent
	--			end
	--			for _, c in children do
	--				table.insert(nextPieces, c)
	--			end
	--		end

	--		pieces = nextPieces
	--		if not dividedAny or #pieces >= LEAF_VOXEL_MAX_PIECES then
	--			break
	--		end
	--	end

	--	leafPart:Destroy() -- VoxBreaker only hid it (Transparency/CanCollide); we don't want the husk
	--	if voxelHolder then
	--		voxelHolder.Parent = parentForHolder -- otherwise this sits under workspace.World.Voxel forever
	--	end

	--	return pieces
	--end
	
	local function voxelizeLeaf(leafPart: BasePart, parentForHolder: Instance): {BasePart}
		local s = leafPart.Size
		local largest = math.max(s.X, s.Y, s.Z)
		if largest <= LEAF_VOXEL_MIN_SIZE
			or not (leafPart:IsA("Part") and leafPart.Shape == Enum.PartType.Block) then
			return { leafPart }
		end

		-- Plain grid split (this game has no Shatterbox): one clone of the leaf per cell
		local grid = math.max(LEAF_VOXEL_MIN_SIZE, largest / 2)
		local nx = math.max(1, math.floor(s.X / grid))
		local ny = math.max(1, math.floor(s.Y / grid))
		local nz = math.max(1, math.floor(s.Z / grid))
		local step = Vector3.new(s.X / nx, s.Y / ny, s.Z / nz)
		local cf = leafPart.CFrame
		local pieces = {}
		for ix = 0, nx - 1 do
			for iy = 0, ny - 1 do
				for iz = 0, nz - 1 do
					if #pieces >= LEAF_VOXEL_MAX_PIECES then break end
					local piece = leafPart:Clone()
					piece.Size = step
					piece.CFrame = cf * CFrame.new(
						-s.X / 2 + (ix + 0.5) * step.X,
						-s.Y / 2 + (iy + 0.5) * step.Y,
						-s.Z / 2 + (iz + 0.5) * step.Z
					)
					piece.Parent = leafPart.Parent
					table.insert(pieces, piece)
				end
			end
		end
		leafPart:Destroy()
		return pieces
	end
	
	local debrisParts = {}
	
	-- Same physics + linger + shrink-out the old single-piece Leaves fling used, per voxel.
	local function fireLeafPiece(part: BasePart, hitPos: Vector3, player: Player)
		part.Size = Vector3.new(math.max(0.05, part.Size.X - 1), math.max(0.05, part.Size.Y - 1), math.max(0.05, part.Size.Z - 1))
		part.CollisionGroup = "NotTouchableVisualDestruction"
		part.Anchored = false
		part.CanCollide = true
		part.Massless = true
		part.CanTouch = false
		part.CanQuery = false
		part.EnableFluidForces = false
		part.CastShadow = false

		local delta = part.Position - hitPos
		local outward = if delta.Magnitude > 0.001 then delta.Unit else Vector3.new(0, 1, 0)
		part.AssemblyLinearVelocity = outward * math.random(5, 10) + Vector3.new(0, math.random(2, 5), 0)
		part.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

		local owner = (player and player.Parent) and player or nil
		if part:CanSetNetworkOwnership() then
			part:SetNetworkOwner(owner)
		end
		table.insert(debrisParts, part)
	end
	
	local sections = {
		Trunk = { CFrames = {}, Sizes = {} },
		Leaves = { CFrames = {}, Sizes = {} },
	}
	
	local leafPieces: {BasePart} = {}
	local leafParts: {BasePart} = {}
	
	for _, child in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end

		local sectionName = child.Parent and child.Parent.Name
		local section = sections[sectionName]

		if section == nil then
			continue 
		end		

		if sectionName == "Leaves" then
			table.insert(leafParts, child)
			table.insert(section.CFrames, child.CFrame)
			table.insert(section.Sizes, child.Size)
			continue
		end

		-- Not TouchableDebris: these are attacker-owned, and that group collides with Players
		child.CollisionGroup = "NotTouchableVisualDestruction"
		child.Anchored = false
		child.CanCollide = true
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false
		if sectionName == "Trunk" then
			child.CastShadow = true
		else
			child.CastShadow = false
		end

		local delta = child.Position - hitPos
		local outward = if delta.Magnitude > 0.001 then delta.Unit else Vector3.new(0, 1, 0)

		child.AssemblyLinearVelocity = outward * math.random(15, 25) + Vector3.new(0, math.random(5, 10), 0)
		child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

		local owner = (player and player.Parent) and player or nil
		if child:CanSetNetworkOwnership() then
			child:SetNetworkOwner(owner)
		end
		table.insert(debrisParts, child)
	end
	
	local VOXELIZED_LEAF_COUNT = 2

	table.sort(leafParts, function(a, b)
		local va = a.Size.X * a.Size.Y * a.Size.Z
		local vb = b.Size.X * b.Size.Y * b.Size.Z
		return va > vb
	end)

	for i, leaf in leafParts do
		if i <= VOXELIZED_LEAF_COUNT then
			for _, voxel in voxelizeLeaf(leaf, model) do
				table.insert(leafPieces, voxel)
			end
		else
			leaf:Destroy()
		end
	end

	for _, piece in leafPieces do
		fireLeafPiece(piece, hitPos, player)
	end
	
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	if #sections.Trunk.CFrames > 0 or #sections.Leaves.CFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Tree",
			Sections = sections,
		})
	end
	
	shared.fireTo(ReplicatedStorage.Remotes.Replicate.Set, { player }, { "ShakeCamera", { Intensity = 1.5} })
	
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Tree["General"], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Tree["Impact2"], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Tree"]["tree"..math.random(1, 5)], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Tree"]["Leaves"], model:GetPivot() * CFrame.new(0, 5, 0))
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Tree"]["leaves"], model:GetPivot() * CFrame.new(0, 5, 0))


	local sounds = {
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["1"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["2"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["3"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["4"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["5"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["6"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["7"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["8"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["9"],
	}

	-- shuffle to pick 3 random different ones
	for i = #sounds, 2, -1 do
		local j = math.random(1, i)
		sounds[i], sounds[j] = sounds[j], sounds[i]
	end

	-- play the first 3 after shuffle with random volume between 0.25 and 0.6
	for i = 1, 3 do
		-- volume goes on the clone, not the shared template in ReplicatedStorage
		local played = SoundHandler:AddSound(sounds[i], model:GetPivot() * CFrame.new(0, 5, 0))
		if played then
			played.Volume = 0.6 + math.random() * 0.25
		end
	end
end

SpecialHandlers["Palm Tree"] = function(model: Model, hitPos, player: Player, params)
	local sections = {
		Trunk = { CFrames = {}, Sizes = {} },
		Leaves = { CFrames = {}, Sizes = {} },
	}

	local debrisParts = {}
	
	for _, child in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end

		local sectionName = child.Parent and child.Parent.Name
		local section = sections[sectionName]

		if section == nil then
			continue -- part isn't under Leaves or Trunk; skip entirely
		end

		if sectionName == "Leaves" then
			--most leaves vanish in a puff, the rest get flung
			if math.random() > .3 then
				table.insert(section.CFrames, child.CFrame)
				table.insert(section.Sizes, child.Size)
				child:Destroy()
				continue
			end
		else
			-- trunk chunks all fling; about half get a dust puff at their break point
			if math.random() > .2 then
				table.insert(section.CFrames, child.CFrame)
				table.insert(section.Sizes, child.Size)
			end
		end

		-- shared fling logic (unchanged from your current handler)

		if sectionName == "Leaves" then
			child.CollisionGroup = "NotTouchableVisualDestruction"
			child.CastShadow = false
		else
			child.CollisionGroup = "TouchableDebris"
			child.CastShadow = true
		end
		child.Anchored = false
		child.CanCollide = true
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false

		local delta = child.Position - hitPos
		local outward = if delta.Magnitude > 0.001 then delta.Unit else Vector3.new(0, 1, 0)

		if sectionName == "Leaves" then
			child.AssemblyLinearVelocity = outward * math.random(5, 10) + Vector3.new(0, math.random(2, 5), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))
		else
			child.AssemblyLinearVelocity = outward * math.random(10, 15) + Vector3.new(0, math.random(0, 5), 0)
			child.AssemblyAngularVelocity = Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
		end
		
		local owner = (player and player.Parent) and player or nil
		if child:CanSetNetworkOwnership() then
			child:SetNetworkOwner(owner)
		end
		
		table.insert(debrisParts, child)
	end
	
	if #debrisParts > 0 then
		-- 1. Batched Anchoring Thread
		task.delay(4, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		-- 2. Batched Shrinking: Process in chunks of 5
		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			-- Extract up to 5 parts for this specific group
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			-- Generate one random timeline for this entire chunk
			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	if #sections.Trunk.CFrames > 0 or #sections.Leaves.CFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Tree",
			Sections = sections,
		})
	end
	
	shared.fireTo(ReplicatedStorage.Remotes.Replicate.Set, { player }, { "ShakeCamera", { Intensity = 2} })
	
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Tree"]["Impact2"], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Palm Tree"]["General"], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Palm Tree"]["palm"..math.random(1, 5)], model:GetPivot())
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction["Palm Tree"]["leaves"], model:GetPivot() * CFrame.new(0, 7, 0))

	local sounds = {
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["1"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["2"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["3"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["4"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["5"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["6"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["7"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["8"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["9"],
	}

	-- shuffle to pick 3 random different ones
	for i = #sounds, 2, -1 do
		local j = math.random(1, i)
		sounds[i], sounds[j] = sounds[j], sounds[i]
	end

	-- play the first 3 after shuffle with random volume between 0.25 and 0.6
	for i = 1, 3 do
		sounds[i].Volume = 0.6 + math.random() * 0.25
		SoundHandler:AddSound(sounds[i], model:GetPivot() * CFrame.new(0, 5, 0))
	end
end

SpecialHandlers["Bush"] = function(model :Model, hitPos, player: Player, params)
	local effectCFrames = {}
	local effectSizes = {}
	local PivotToUse = model:GetPivot()
	
	local debrisParts = {}

	for _, child: BasePart in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end

		if child.Name ~= "Bush" then
			continue
		end

		if math.random() > .3 then
			table.insert(effectCFrames, child.CFrame)
			table.insert(effectSizes, child.Size)
			child:Destroy()
			continue
		end

		child.Anchored = false
		child.CanCollide = true
		child.CollisionGroup = "NotTouchableVisualDestruction"
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false
		child.CastShadow = false

		-- normalize the RAW delta, then fall back if it's ~zero
		local delta = child.Position - hitPos
		local outward = if delta.Magnitude > 0.001 then delta.Unit else Vector3.new(0, 1, 0)

		child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
		child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

		child:SetNetworkOwner(player)

		-- 2. Add to our survival table instead of running an individual task.delay
		table.insert(debrisParts, child)
	end
	
	if #debrisParts > 0 then
		-- Batched Anchoring: Anchor everything at once after 3.5 seconds
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		-- Batched Shrinking: Process in chunks of 5
		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			-- Extract up to 5 parts for this specific group
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			-- Generate one random timeline for this entire chunk
			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	if #effectCFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Bush",
			EffectCFrames = effectCFrames,
			EffectSizes = effectSizes,
		})
	end
	
	local sounds = {
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["1"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["2"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["3"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["4"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["5"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["6"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["7"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["8"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["9"],
	}

	-- shuffle to pick 3 random different ones
	for i = #sounds, 2, -1 do
		local j = math.random(1, i)
		sounds[i], sounds[j] = sounds[j], sounds[i]
	end

	-- play the first 3 after shuffle with random volume between 0.25 and 0.6
	for i = 1, 3 do
		sounds[i].Volume = 0.6 + math.random() * 0.25
		SoundHandler:AddSound(sounds[i], PivotToUse)
	end
	
	SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.Bush["Bush New"], PivotToUse)
end

SpecialHandlers["Wood Object"] = function(model: Model, hitPos, player, params)
	local modelSize = model:GetExtentsSize()
	local effectCFrames = {}
	local effectSizes = {}
	local PivotToUse = model:GetPivot()
	
	-- Survivor parts
	local debrisParts = {}
	
	for _, child: BasePart in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end

		if math.random() > .5 then
			table.insert(effectCFrames, child.CFrame)
			table.insert(effectSizes, child.Size)
			child:Destroy()
			continue
		end


		child.Anchored = false
		child.CanCollide = true
		child.CollisionGroup = "NotTouchableVisualDestruction"
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false
		child.CastShadow = false

		

		-- normalize the RAW delta, then fall back if it's ~zero
		local delta = child.Position - hitPos
		local outward = if delta.Magnitude > 0.001 then delta.Unit else Vector3.new(0, 1, 0)

		child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
		child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))
		
		
		if child:CanSetNetworkOwnership() then
			child:SetNetworkOwner(player)
		end
		table.insert(debrisParts, child)
	end
	
	if #debrisParts > 0 then
		-- Batched Anchoring Thread
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		-- Batched Shrinking: Process in chunks of 5
		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			-- Extract up to 5 parts for this specific group
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			-- Generate one random timeline for this entire chunk
			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
	
	if #effectCFrames > 0 then
		ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
			SkillType = "Wood Object",
			EffectCFrames = effectCFrames, -- List of cframes. Better for preformance since its 1 remote with data.
			EffectSize = effectSizes,
		})
	end
	
	local sounds = {
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["1"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["2"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["3"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["4"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["5"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["6"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["7"],
		ReplicatedStorage.Assets.Sounds.Impact.SpecialDestruction.WoodObjects["8"],
	}

	
	SoundHandler:AddSound(sounds[math.random(1, #sounds)], PivotToUse)
end

SpecialHandlers["Weapon Barrel"] = function(model, hitPos, player, params)
	local debrisParts = {}

	-- Welds every BasePart under `container` into ONE rigid assembly.
	-- Returns the root (the part carrying the mass) and the full part list.
	local function weldIntoOneAssembly(container)
		local parts = {}
		for _, d in container:GetDescendants() do
			if d:IsA("BasePart") then
				table.insert(parts, d)
			end
		end
		if #parts == 0 then
			return nil, parts
		end

		-- Prefer an explicit PrimaryPart, else the largest VISIBLE part, so we
		-- never root the sword on an invisible helper/hitbox part.
		local root = container:IsA("Model") and container.PrimaryPart or nil
		if not root then
			local bestVolume = -1
			for _, p in parts do
				if p.Transparency < 1 then
					local volume = p.Size.X * p.Size.Y * p.Size.Z
					if volume > bestVolume then
						bestVolume = volume
						root = p
					end
				end
			end
			root = root or parts[1]
		end

		for _, p in parts do
			p.Anchored = false
			p.CanCollide = (p.Transparency < 1)
			p.CollisionGroup = "NotTouchableVisualDestruction"
			p.CanTouch = false
			p.CanQuery = false
			p.EnableFluidForces = false
			p.CastShadow = true

			if p ~= root then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = root
				weld.Part1 = p
				weld.Parent = root
				p.Massless = true -- only the root contributes mass to the assembly
			end
		end

		if not root.CanCollide then
			root.CanCollide = true
		end

		return root, parts
	end

	--=====================================================================
	-- 1) Swords live at: Barrel > WeaponStack > Model > (one Model per sword,
	--    named either "Model" or "Sword"). Some hold 9+ meshes, so each sword
	--    is welded into a single rigid piece before it's flung.
	--    NOTE: non-recursive FindFirstChild on purpose — the swords themselves
	--    are named "Model", so a recursive search would grab the wrong node.
	--=====================================================================
	local weaponStack = model:FindFirstChild("WeaponStack")
	local swordContainers = {}
	if weaponStack then
		for _, name in { "Swords1", "Swords2" } do
			local container = weaponStack:FindFirstChild(name)
			if container then
				table.insert(swordContainers, container)
			end
		end
	end

	for _, container in swordContainers do
		for _, sword in container:GetChildren() do
			if not sword:IsA("Model") then
				continue
			end

			-- Cull half before doing any weld work.
			if math.random() < 0.5 then
				sword:Destroy()
				continue
			end

			local root, parts = weldIntoOneAssembly(sword)
			if not root then
				continue
			end

			-- Burst up and out of the barrel.
			local outward = root.Position - hitPos
			outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
			root.AssemblyLinearVelocity = outward * math.random(10, 20) + Vector3.new(0, math.random(15, 25), 0)
			root.AssemblyAngularVelocity = Vector3.new(math.random(-8, 8), math.random(-8, 8), math.random(-8, 8))

			local owner = (player and player.Parent) and player or nil
			if root:CanSetNetworkOwnership() then
				root:SetNetworkOwner(owner)
			end

			for _, p in parts do
				table.insert(debrisParts, p)
			end
		end
	end
	--=====================================================================
	-- 2) The barrel itself (Barrel_Open, Part): normal fling with a chance to
	--    poof. Swords are skipped — handled above.
	--=====================================================================
	local effectCFrames = {}
	local effectSizes = {}

	for _, child in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end
		local inSwordContainer = false
		for _, container in swordContainers do
			if child:IsDescendantOf(container) then
				inSwordContainer = true
				break
			end
		end
		if inSwordContainer then
			continue
		end
		
		if child.Name == "Part" then
			table.insert(effectCFrames, child.CFrame)
			table.insert(effectSizes, child.Size)
			child:Destroy()
			continue
		end
		
		if math.random() > 0.5 then
			table.insert(effectCFrames, child.CFrame)
			table.insert(effectSizes, child.Size)
			child:Destroy()
			continue
		end
		
		child.Anchored = false
		child.CanCollide = true
		child.CollisionGroup = "TouchableDebris"
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false
		child.CastShadow = false

		local outward = child.Position - hitPos
		outward = if outward.Magnitude > 0.001 then outward.Unit else Vector3.new(0, 1, 0)
		child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
		child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))

		local owner = (player and player.Parent) and player or nil
		if child:CanSetNetworkOwnership() then
			child:SetNetworkOwner(owner)
		end

		table.insert(debrisParts, child)
	end

	--=====================================================================
	-- 3) Batched anchor + shrink-out (same as your other handlers)
	--=====================================================================
	if #debrisParts > 0 then
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end
end

SpecialHandlers["Metal Object"] = function(model: Model, hitPos, player, params)
	local modelSize = model:GetExtentsSize()
	local effectCFrames = {}
	local effectSizes = {}
	local PivotToUse = model:GetPivot()

	-- Survivor parts
	local debrisParts = {}

	for _, child: BasePart in model:GetDescendants() do
		if not child:IsA("BasePart") then
			continue
		end

		if math.random() > .5 then
			table.insert(effectCFrames, child.CFrame)
			table.insert(effectSizes, child.Size)
			child:Destroy()
			continue
		end


		child.Anchored = false
		child.CanCollide = true
		if child.Size.X >= 1 and child.Size.Y >= 1 and child.Size.Z >= 1 then
			child.CollisionGroup = "TouchableDebris"
		else
			child.CollisionGroup = "NotTouchableVisualDestruction"
		end
		child.Massless = true
		child.CanTouch = false
		child.CanQuery = false
		child.EnableFluidForces = false
		child.CastShadow = false



		-- normalize the RAW delta, then fall back if it's ~zero
		local delta = child.Position - hitPos
		local outward = if delta.Magnitude > 0.001 then delta.Unit else Vector3.new(0, 1, 0)

		child.AssemblyLinearVelocity = outward * math.random(20, 35) + Vector3.new(0, math.random(5, 15), 0)
		child.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))


		child:SetNetworkOwner(player)
		table.insert(debrisParts, child)
	end

	if #debrisParts > 0 then
		-- Batched Anchoring Thread
		task.delay(3.5, function()
			for _, part in debrisParts do
				if part and part.Parent then
					part.Anchored = true
				end
			end
		end)

		-- Batched Shrinking: Process in chunks of 5
		local chunkSize = 5
		local goalProperties = {Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1}

		for i = 1, #debrisParts, chunkSize do
			-- Extract up to 5 parts for this specific group
			local chunk = {}
			for j = i, math.min(i + chunkSize - 1, #debrisParts) do
				table.insert(chunk, debrisParts[j])
			end

			-- Generate one random timeline for this entire chunk
			local groupLingerTime = math.random(70, 100) / 10
			local groupShrinkDuration = math.random(5, 12) / 10
			local sharedTweenInfo = TweenInfo.new(groupShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			task.delay(groupLingerTime, function()
				for _, part in chunk do
					if part and part.Parent then
						TweenService:Create(part, sharedTweenInfo, goalProperties):Play()
						Debris:AddItem(part, groupShrinkDuration)
					end
				end
			end)
		end
	end

	--if #effectCFrames > 0 then
	--	ReplicatedStorage.Remotes.ClientEffects:FireAllClients("DestructionEffects", {
	--		SkillType = "Wood Object",
	--		EffectCFrames = effectCFrames, -- List of cframes. Better for preformance since its 1 remote with data.
	--		EffectSize = effectSizes,
	--	})
	--end

	local sounds = {
		ReplicatedStorage.Assets.Sounds.Impact.Enviroment.MetalImpact.Impact1,
		ReplicatedStorage.Assets.Sounds.Impact.Enviroment.MetalImpact.Impact2,
		--ReplicatedStorage.Assets.Sounds.Impact.Enviroment.MetalImpact.Impact3,
		--ReplicatedStorage.Assets.Sounds.Impact.Enviroment.MetalImpact.Impact4,
		ReplicatedStorage.Assets.Sounds.Impact.Enviroment.MetalImpact.Impact5,
	}


	SoundHandler:AddSound(sounds[math.random(1, #sounds)], PivotToUse)
end

-- The Execution Function
local function hideModel(model)
	for _, desc in model:GetDescendants() do
		if desc:IsA("BasePart") then
			-- Save original states if we haven't already
			if desc:GetAttribute("__OrigTrans") == nil then
				desc:SetAttribute("__OrigTrans", desc.Transparency)
				desc:SetAttribute("__OrigCollide", desc.CanCollide)
				desc:SetAttribute("__OrigQuery", desc.CanQuery)
			end
			
			desc.Transparency = 1
			desc.CanCollide = false
			desc.CanQuery = false 
			
		-- Optional: Hide Textures and Decals so they don't float in mid-air!
		elseif desc:IsA("Texture") or desc:IsA("Decal") then
			if desc:GetAttribute("__OrigTrans") == nil then
				desc:SetAttribute("__OrigTrans", desc.Transparency)
			end
			desc.Transparency = 1
		
		elseif desc:IsA("ParticleEmitter") or desc:IsA("SpotLight") then
			if desc:GetAttribute("__OrigEnabled") == nil then
				desc:SetAttribute("__OrigEnabled", desc.Enabled)
			end
			
			if desc:IsA("ParticleEmitter") or desc:IsA("Trail") then
				desc:Clear()
			end
			desc.Enabled = false
			
		end
	end
end

-- Helper to unhide a model using its saved states
local function restoreModel(model)
	for _, desc in model:GetDescendants() do
		if desc:IsA("BasePart") or desc:IsA("Texture") or desc:IsA("Decal") then
			local origTrans = desc:GetAttribute("__OrigTrans")
			if origTrans ~= nil then
				desc.Transparency = origTrans
			end
			
			if desc:IsA("BasePart") then
				local origCollide = desc:GetAttribute("__OrigCollide")
				if origCollide ~= nil then
					desc.CanCollide = origCollide
				end
				local origQuery = desc:GetAttribute("__OrigQuery")
				if origQuery ~= nil then
					desc.CanQuery = origQuery
				end
			end
		
		elseif desc:IsA("ParticleEmitter") or desc:IsA("SpotLight") then
			local origEnabled = desc:GetAttribute("__OrigEnabled")
			if origEnabled ~= nil then
				desc.Enabled = origEnabled
			end
		end
	end
end


function SpecialDestruction.process(model, hitPos, player, timeToReset, params)
	--print("processing")
	params = params or {}
	-- Prevent double-triggering on the original model
	if model:GetAttribute("IsDestroyed") then return end
	model:SetAttribute("IsDestroyed", true)
	
	if params.DestroyAll then
		hideModel(model)
		task.delay(timeToReset or 20, function()
			if model and model.Parent then
				restoreModel(model)
				model:SetAttribute("IsDestroyed", nil)
			end
		end)
		return
	end
	
	local specialType = model:GetAttribute("SpecialType")
	local handlerLogic = SpecialHandlers[specialType]

	if handlerLogic then
		
		-- 1. Hide the original model safely
		hideModel(model)
		
		-- 2. Create the fake clone
		local fakeModel = model:Clone()
		
		-- Clean up tracking attributes on the clone so it doesn't get confused
		fakeModel:SetAttribute("IsDestroyed", nil) 
		
		-- 3. Unhide the fake clone so we can see it break!
		restoreModel(fakeModel)
		fakeModel.Parent = workspace.World.Debris -- Throw it in your debris folder
		
		for _, descendant in fakeModel:GetDescendants() do
			if descendant:IsA("BasePart") or descendant:IsA("Bone") then
				CollectionService:RemoveTag(descendant, "WindShake")
			end
		end

		-- 4. Schedule the Reset FIRST, so a handler error can't leave the model hidden forever
		task.delay(timeToReset or 20, function()
			-- Destroy whatever is left of the fake model
			if fakeModel then fakeModel:Destroy() end
			
			-- Unhide the original model
			if model and model.Parent then
				restoreModel(model)
				model:SetAttribute("IsDestroyed", nil)
			end
		end)
		
		-- 5. Break the fake model! pcall'd so a broken handler can't abort the caller (DebreeService / the move)
		local ok, err = pcall(handlerLogic, fakeModel, hitPos, player, params)
		if not ok then
			warn("[SpecialDestruction] " .. tostring(specialType) .. " handler failed: " .. tostring(err))
		end
	else
		warn("[SpecialDestruction] No handler found for type: " .. tostring(specialType))
		model:SetAttribute("IsDestroyed", nil) -- reset the flag if it failed
	end
end

return SpecialDestruction