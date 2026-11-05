local RunService = game:GetService("RunService")

-- Effect framework helpers (the original leaked Emit/Tween/BeamToggle as globals — made local here)
local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Essentials = Essentials
local Emit       = VFX.Emit
local Tween      = Essentials.Tween
local BeamToggle = Essentials.BeamToggle

--local Bezier = require(script.Bezier)

return {
	start = function(_, character, data)
		-- Bail if the caster is too far from the local player to be worth rendering.
		--if _G.checkRenderDistance(character.PrimaryPart.Position) == false then
		--	return
		--end

		local debris   = {}            -- everything we spawn, torn down at the end
		local rng      = Random.new()
		local root     = character.PrimaryPart
		local originCF = root.CFrame   -- caster pose, captured once at cast time
		local diveDir = data.Direction

		-- ── Arrow projectile (kept hidden until it launches at 1.1s) ─────────
		local arrow = script.arrow:Clone()
		table.insert(debris, arrow)
		arrow.CFrame = originCF * CFrame.new(0, 0, -2)		
		arrow.Parent = workspace.World.Visuals

		-- Follow the caster instead of tweening off in a straight world line.
		local follow = character:FindFirstChild("HumanoidRootPart") or root
		local OFFSET = CFrame.new(0, -4, -2) -- where it sits relative to the torso/HRP — tweak to taste
		
		
		local beamLengths = {}
		for _, beam in arrow:GetDescendants() do
			if beam:IsA("Beam") and beam.Attachment0 and beam.Attachment1 then
				beamLengths[beam] = (beam.Attachment1.WorldPosition - beam.Attachment0.WorldPosition).Magnitude
			end
		end
		
		local trailWidths = {}
		for _, tr in arrow:GetDescendants() do
			if tr:IsA("Trail") and tr.Attachment0 and tr.Attachment1 then
				trailWidths[tr] = (tr.Attachment0.WorldPosition - tr.Attachment1.WorldPosition).Magnitude
			end
		end


		local followConn
		followConn = RunService.RenderStepped:Connect(function()
			if not (arrow.Parent and follow and follow.Parent) then
				followConn:Disconnect()
				return
			end
			arrow.CFrame = follow.CFrame * OFFSET -- move/rotate the arrow first

			-- Then aim every beam along the WORLD dive direction (matches the trail).
			for beam, length in beamLengths do
				if beam.Parent and beam.Attachment0 and beam.Attachment1 then
					beam.Attachment0.WorldPosition = follow.Position
					beam.Attachment1.WorldPosition = beam.Attachment0.WorldPosition - diveDir * length
				end
			end
			
			local widthAxis = diveDir:Cross(Vector3.yAxis)
			widthAxis = widthAxis.Magnitude > 0 and widthAxis.Unit or Vector3.xAxis
			for tr, width in trailWidths do
				if tr.Parent and tr.Attachment0 and tr.Attachment1 then
					local half = widthAxis * (width * 0.5)
					tr.Attachment0.WorldPosition = follow.Position + half
					tr.Attachment1.WorldPosition = follow.Position - half
				end
			end

		end)
		table.insert(debris, followConn)


		-- Once it has followed for a bit, kill its emitters and clean up.
		task.delay(0.75, function()
			followConn:Disconnect()
			for _, fx in arrow:GetDescendants() do
				if fx:IsA("Trail") or fx:IsA("Beam") or fx:IsA("ParticleEmitter") then
					fx.Enabled = false
				end
			end
			task.wait(1)
			Essentials.Destroy(debris, 0)
		end)
		
		-- ── Launch at 1.1s: arrow flies forward, dust + burst sounds ─────────
		--task.delay(1.1, function()
		--	arrow.Parent = workspace.World.Visuals
		--	Tween(arrow, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
		--		CFrame = arrow.CFrame * CFrame.new(0, 0, -120),
		--	})

		--	-- Once it has flown, kill its emitters and clean up the whole effect.
		--	task.delay(0.75, function()
		--		for _, fx in arrow:GetDescendants() do
		--			if fx:IsA("Trail") or fx:IsA("Beam") or fx:IsA("ParticleEmitter") then
		--				fx.Enabled = false
		--			end
		--		end
		--		task.wait(1)
		--		Essentials.Destroy(debris, 0)
		--	end)

		--	--_G.PlaySound(root, sounds["Fire Burst 4 (SFX)"],        { TimePosition = 1.5 }, true)
		--	--_G.PlaySound(root, sounds["Whoosh Explosion 7 (SFX)"],  { TimePosition = 0.6 }, true)

		--	-- Dust kicked up behind and in front of the launch point.
		--	--local backDust = script.backDust:Clone()
		--	--table.insert(debris, backDust)
		--	--backDust.CFrame = originCF * CFrame.new(0, -2, 0) * CFrame.Angles(0, math.pi, 0)
		--	--backDust.Parent = workspace.Effects
		--	--Emit(backDust:GetDescendants(), true)

		--	--local frontDust = script.frontDust:Clone()
		--	--table.insert(debris, frontDust)
		--	--frontDust.CFrame = originCF * CFrame.new(0, -2, 0)
		--	--frontDust.Parent = workspace.Effects
		--	--Emit(frontDust:GetDescendants(), true)
		--end)

		-- ── Charge glow (arrow + diamond) under the caster ───────────────────
		--local arrowCharge = script.arrowCharge:Clone()
		--table.insert(debris, arrowCharge)

		--local diamondCharge = script.diamondCharge:Clone()
		--diamondCharge.CFrame = originCF * CFrame.new(0, 0, -3) + Vector3.new(0, -2.15, 0)
		--arrowCharge.CFrame   = diamondCharge.CFrame * CFrame.Angles(0, 0, math.pi / 2)
		--arrowCharge.Parent   = workspace.Effects
		--diamondCharge.Parent = arrowCharge

		---- Fade the charge lights out as the launch fires.
		--task.delay(1.1, function()
		--	local fade = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		--	Tween(arrowCharge.Attachment.second, fade, { Brightness = 0, Range = 4 })
		--	Tween(arrowCharge.Attachment.first,  fade, { Brightness = 0, Range = 15 })
		--	Emit(arrowCharge:GetDescendants(), false)
		--end)

		--_G.PlaySound(root, sounds["Magic Whooshes Growly Magic Whooshes Airy Gu (SFX)"], nil, true)
		--_G.PlaySound(root, sounds["Magic Transformation 3 (SFX)"], nil, true)
		--_G.PlaySound(root, sounds["Magic Rumbling Decay 2 (SFX)"], nil, true)

		---- ── Feathers that swirl in along curved bezier paths ─────────────────
		---- Offsets are relative to each feather's spawn CFrame. Note: indices 1 and 4
		---- are unused — the curve's 4 control points are the feather start, [2], [3],
		---- and the caster target.
		--local controlOffsets = {
		--	CFrame.new(),
		--	CFrame.new(0, 0, -10),
		--	CFrame.new(7, 5, -20),
		--	CFrame.new(0, 0, -60),
		--}

		--for _ = 1, 10 do
		--	local featherDebris = {}
		--	local feather = script.Feather:Clone()
		--	table.insert(featherDebris, feather)
		--	BeamToggle(feather:GetChildren(), false)

		--	local target = originCF * CFrame.new(0, 0, -3)                          -- where feathers converge
		--	local spun   = target * CFrame.Angles(0, 2 * math.pi * math.random(), 0) -- random yaw around caster
		--	local pitch  = rng:NextNumber(0, 90)

		--	-- Spawn point: tilt up by a random pitch, push out 30 studs, then face the target.
		--	local spawnPos = (spun * CFrame.Angles(math.rad(pitch), 0, 0) * CFrame.new(0, 30, 0)).Position
		--	local startCF  = CFrame.new(spawnPos, target.Position) * CFrame.Angles(0, 0, math.pi * math.random())

		--	local control1 = startCF * controlOffsets[2]
		--	local control2 = startCF * controlOffsets[3]

		--	feather.CFrame = startCF
		--	feather.Parent = workspace.Effects
		--	BeamToggle(feather:GetChildren(), true)

		--	local startTime  = tick()
		--	local currentPos = startCF.Position
		--	local curve = Bezier.new(startCF.Position, control1.Position, control2.Position, target.Position)

		--	local conn
		--	conn = RunService.RenderStepped:Connect(function()
		--		local progress = (tick() - startTime) / 0.55
		--		local nextPos  = curve:Get(progress, 1)
		--		feather.CFrame = CFrame.new(currentPos, nextPos) -- always face direction of travel
		--		if progress >= 1 then
		--			Essentials.Destroy(conn, 0)             -- stop updating this feather
		--			Essentials.Destroy(featherDebris, 0.45) -- remove it shortly after
		--		end
		--		currentPos = nextPos
		--	end)

		--	task.wait(0.035) -- stagger the 10 feathers
		--end
	end,
}