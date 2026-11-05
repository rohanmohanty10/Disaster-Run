--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Emit        = VFX.Emit
local TweenCreate = Essentials.Tween     -- re-exported from Essentials
local Ess         = Essentials           -- if you also used Ess.Destroy: VFX.Destroy works

local function animateFor(duration: number, onUpdate: (number) -> ())
	local startTime = tick()
	local conn = RunService.RenderStepped:Connect(function()
		onUpdate(tick() - startTime)
	end)
	Ess.Destroy(conn, duration)
end

local function WeldTo(effect: Instance, target: BasePart, offset: CFrame?): Weld?
	offset = offset or CFrame.new()

	-- pick a root part for the weld chain
	local root = (effect:IsA("BasePart") and effect)
		or (effect:IsA("Model") and (effect.PrimaryPart or effect:FindFirstChildWhichIsA("BasePart", true)))

	if not root then
		warn("WeldTo: no BasePart in", effect:GetFullName())
		return nil
	end

	-- rigidly bind every part to the root, then unanchor + make massless/non-colliding
	for _, part in effect:GetDescendants() do
		if part:IsA("BasePart") and part ~= root then
			local c = Instance.new("WeldConstraint")
			c.Part0, c.Part1 = root, part
			c.Parent = root
			part.Anchored   = false
			part.CanCollide = false
			part.Massless   = true
		end
	end
	root.Anchored   = false
	root.CanCollide = false
	root.Massless   = true

	-- attach root to the target; C0 is the local offset you can animate
	local weld = Instance.new("Weld")
	weld.Part0, weld.Part1 = target, root
	weld.C0 = offset
	weld.Parent = root

	return weld
end

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local function applyFacingCFrame(sourceFolder, cloneFolder, facingCFrame)
		local rootPart = cloneFolder:FindFirstChildWhichIsA("BasePart", true)
		local rootCFrame = rootPart.CFrame
		for _, v in ipairs(cloneFolder:GetDescendants()) do
			if v:IsA("BasePart") then
				local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
				v.CFrame = facingCFrame * relativeOffset
			end
		end
	end

	local function getFacingCFrame(torso, offset)
		local look = torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
	end

	local function emitClone(clone)
		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				local duration = v:GetAttribute("EmitDuration")
				if duration then
					v.Enabled = true
					task.delay(duration, function()
						v.Enabled = false
					end)
				end
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end
	end

	if skillType == "FireLegMoutonKickStartup" then
		local names = {"FireLegBottom", "FireLegTop", "FireLegRightLowerLeg"}

		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)

		task.spawn(function()
			for _, name in pairs(names) do
				local part = attacker["Right Leg"]:FindFirstChild(name)
				if part then
					local tween = TS:Create(part, tweenInfo, {Transparency = 0})
					tween:Play()
				end
			end
		end)

		VFXFunctions.EnableDescendants(attacker["Right Leg"].FireLegRightLowerLeg)
		VFXFunctions.DisableDescendants(attacker["Right Leg"].FireLegRightLowerLeg.Glare, true)

	end

	if skillType == "FireLegMoutonKickDestroy" then

		local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
		local names = {"FireLegBottom", "FireLegTop", "FireLegRightLowerLeg"}
		task.spawn(function()
			for _, name in pairs(names) do
				local part = attacker["Right Leg"]:FindFirstChild(name)
				if part then
					local tween = TS:Create(part, tweenInfo, {Transparency = 1})
					tween:Play()

				end
			end
		end)

		VFXFunctions.DisableDescendants(attacker["Right Leg"].FireLegRightLowerLeg, false)

	end

	if skillType == "finisherHit" then
		local Torso = attacker:FindFirstChild("Torso") or hrp
		local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Finisher

		local facingCFrame = getFacingCFrame(hrp)

		local clone = source:Clone()
		clone.Parent = workspace.World.Visuals

		clone.SlideCut.CFrame = facingCFrame * CFrame.new(1.05, 1, -2.9) * CFrame.Angles(math.rad(11), math.rad(168), 0)	

		for _, v in ipairs(clone.SlideCut:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end

		Debris:AddItem(clone, 5)
		print("finisherHitEffects")
	end
	
	if skillType == "HitEffect" then
		local Torso = argumentData.Target:FindFirstChild("Torso") or hrp
		local source = ReplicatedStorage.Assets.Effects.Sanji.ModeAbilities.ModeM1s

		local clone = source:Clone()

		for _, v in ipairs(clone:GetDescendants()) do
			v.Parent = Torso
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
			Debris:AddItem(v, 1.5)
		end

		Debris:AddItem(clone, 1.5)
	end
	
	--if skillType == "AwakeningEffects" then
	--	local TwisterPivot = hrp.CFrame * CFrame.new(.4, -2, 0)
	--	local Twister      = script["Twister"]:Clone()
	--	Twister:PivotTo(TwisterPivot)
	--	Twister.Parent = workspace.World.Visuals

	--	Twister.Material     = Enum.Material.Neon
	--	Twister.Color        = Color3.new(1, 1, 1)
	--	Twister.Transparency = 1

	--	local startSize  = Twister.Size
	--	-- half the height gained from the 5x Y scale, so the base stays planted
	--	local SCALE_LIFT = (startSize.Y * 5 - startSize.Y) * 0.5

	--	-- non-blocking tweens (fire immediately, run in parallel)
	--	TweenCreate(Twister, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
	--		Color = Color3.fromRGB(255, 131, 7),
	--	})
	--	task.delay(2, function()
	--		TweenCreate(Twister, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
	--			Color = Color3.fromRGB(255, 100, 7),
	--		})
	--	end)
		
	--	TweenCreate(Twister, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
	--		Size = startSize * Vector3.new(2, 4.5, 2),
	--	})
	--	task.delay(.2, function()
	--		TweenCreate(Twister, TweenInfo.new(.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
	--			Transparency = 0,
	--		})
	--	end)

	--	-- ONE loop owns the pivot: spin over 3s + lift over the first 1s (matches the Size tween)
	--	local TURNS = 7
	--	task.spawn(function()
	--		animateFor(3.5, function(elapsed)
	--			local spinAlpha = TS:GetValue(elapsed / 3.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	--			local liftAlpha = TS:GetValue(math.min(elapsed, 3), Enum.EasingStyle.Linear, Enum.EasingDirection.In)
	--			local spun      = TwisterPivot * CFrame.Angles(0, math.rad(360 * TURNS) * spinAlpha, 0)
	--			Twister:PivotTo(spun + Vector3.new(0, SCALE_LIFT * liftAlpha, 0))
	--		end)
	--	end)

	--	Ess.Destroy(Twister, 3.5)
		
	--	-- VFX which moves upwards (swirls which go up.)
	--	local spinVFXPivot = hrp.CFrame * CFrame.new(.4, -3, 0)
	--	local spinVFX    = script["spinVFX"]:Clone()
	--	spinVFX:PivotTo(spinVFXPivot)
	--	spinVFX.Parent = workspace.World.Visuals
		
	--	local emitters = {}
	--	for _, obj in spinVFX:GetDescendants() do
	--		if obj:IsA("ParticleEmitter") then
	--			table.insert(emitters, { emitter = obj, baseSize = obj.Size })
	--		end
	--	end

	--	local function scaleSequence(seq, mult)
	--		local keypoints = {}
	--		for _, kp in seq.Keypoints do
	--			table.insert(keypoints, NumberSequenceKeypoint.new(kp.Time, kp.Value * mult, kp.Envelope * mult))
	--		end
	--		return NumberSequence.new(keypoints)
	--	end
		
	--	animateFor(3, function(elapsed)
	--		local alpha = TS:GetValue(elapsed / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	--		local mult  = 1 + alpha * (2 - 1) -- 1x -> 2x; change the 2 for a bigger/smaller end size

	--		for _, data in emitters do
	--			data.emitter.Size = scaleSequence(data.baseSize, mult)
	--		end
	--		spinVFX:PivotTo(spinVFXPivot + Vector3.new(0, 4 * alpha, 0))
	--	end)
		
	--	Ess.Destroy(spinVFX, 3)
		
	--	-- Dust stuff
	--	task.delay(.2, function()
	--		local DustPivot = hrp.CFrame * CFrame.new(.4, -3, 0)
	--		local Dust    = script["Dust"]:Clone()
	--		Dust:PivotTo(DustPivot)
	--		Dust.Parent = workspace.World.Visuals
	--		Emit(Dust:GetDescendants(), false, 3)
			
	--		local emitters2 = {}
	--		for _, obj in Dust:GetDescendants() do
	--			if obj:IsA("ParticleEmitter") then
	--				table.insert(emitters2, { emitter = obj, baseSize = obj.Size })
	--			end
	--		end
			
	--		animateFor(2.6, function(elapsed)
	--			local alpha = TS:GetValue(elapsed / 2.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
	--			local mult  = 1 + alpha * (2 - 1) -- 1x -> 2x; change the 2 for a bigger/smaller end size

	--			for _, data in emitters do
	--				data.emitter.Size = scaleSequence(data.baseSize, mult)
	--			end
	--		end)

	--		Ess.Destroy(Dust, 3)
	--	end)
		
	--	-- Base swirls which stay the same and consistant.
	--	local BaseSwirlsPivot = hrp.CFrame * CFrame.new(0, -2.5, 0)
	--	local BaseSwirls    = script["BaseSwirls"]:Clone()
	--	BaseSwirls:PivotTo(BaseSwirlsPivot)
	--	BaseSwirls.Parent = workspace.World.Visuals
	--	Emit(BaseSwirls:GetDescendants(), false, 3)
	--	Ess.Destroy(BaseSwirls, 3)
	--end
	
	if skillType == "AwakeningEffects" then
		-- Twister (animated → weld + animate C0) ------------------
		local TwisterOffset = CFrame.new(.4, -2, 0)
		local Twister       = script["Twister"]:Clone()
		Twister.Parent = workspace.World.Visuals

		Twister.Material     = Enum.Material.Neon
		Twister.Color        = Color3.new(1, 1, 1)
		Twister.Transparency = 1

		local startSize  = Twister.Size
		local Y_SCALE    = 4.5
		local SCALE_LIFT = startSize.Y * (Y_SCALE - 1) * 0.5 -- half the height gained

		local twisterWeld = WeldTo(Twister, hrp, TwisterOffset)

		TweenCreate(Twister, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Color = Color3.fromRGB(255, 131, 7),
		})
		task.delay(2, function()
			TweenCreate(Twister, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Color = Color3.fromRGB(255, 100, 7),
			})
		end)
		TweenCreate(Twister, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = startSize * Vector3.new(2, Y_SCALE, 2),
		})
		task.delay(.2, function()
			TweenCreate(Twister, TweenInfo.new(.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Transparency = 0,
			})
		end)

		local TURNS = 7
		task.spawn(function()
			animateFor(3.5, function(elapsed)
				local spinAlpha = TS:GetValue(elapsed / 3.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				local liftAlpha = TS:GetValue(math.min(elapsed, 3) / 3, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
				twisterWeld.C0 = TwisterOffset
					* CFrame.Angles(0, math.rad(360 * TURNS) * spinAlpha, 0)
					+ Vector3.new(0, SCALE_LIFT * liftAlpha, 0)
			end)
		end)
		Ess.Destroy(Twister, 3.5)

		-- spinVFX (animated → weld + animate C0) ------------------
		local spinVFXOffset = CFrame.new(.4, -3, 0)
		local spinVFX       = script["spinVFX"]:Clone()
		spinVFX.Parent = workspace.World.Visuals
		local spinWeld = WeldTo(spinVFX, hrp, spinVFXOffset)

		local emitters = {}
		for _, obj in spinVFX:GetDescendants() do
			if obj:IsA("ParticleEmitter") then
				table.insert(emitters, { emitter = obj, baseSize = obj.Size })
			end
		end

		local function scaleSequence(seq, mult)
			local keypoints = {}
			for _, kp in seq.Keypoints do
				table.insert(keypoints, NumberSequenceKeypoint.new(kp.Time, kp.Value * mult, kp.Envelope * mult))
			end
			return NumberSequence.new(keypoints)
		end

		task.spawn(function()
			animateFor(3, function(elapsed)
				local alpha = TS:GetValue(elapsed / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				local mult  = 1 + alpha * (2 - 1)
				for _, data in emitters do
					data.emitter.Size = scaleSequence(data.baseSize, mult)
				end
				spinWeld.C0 = spinVFXOffset + Vector3.new(0, 4 * alpha, 0)
			end)
		end)
		Ess.Destroy(spinVFX, 3)

		-- Dust (static position → just weld) ----------------------
		task.delay(.2, function()
			local Dust = script["Dust"]:Clone()
			Dust.Parent = workspace.World.Visuals
			WeldTo(Dust, hrp, CFrame.new(.4, -3, 0))
			Emit(Dust:GetDescendants(), false, 3)

			local emitters2 = {}
			for _, obj in Dust:GetDescendants() do
				if obj:IsA("ParticleEmitter") then
					table.insert(emitters2, { emitter = obj, baseSize = obj.Size })
				end
			end

			task.spawn(function()
				animateFor(2.6, function(elapsed)
					local alpha = TS:GetValue(elapsed / 2.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
					local mult  = 1 + alpha * (2 - 1)
					for _, data in emitters2 do -- was 'emitters' (bug: scaled the wrong effect)
						data.emitter.Size = scaleSequence(data.baseSize, mult)
					end
				end)
			end)
			Ess.Destroy(Dust, 3)
		end)

		-- BaseSwirls (static → just weld) -------------------------
		local BaseSwirls = script["BaseSwirls"]:Clone()
		BaseSwirls.Parent = workspace.World.Visuals
		WeldTo(BaseSwirls, hrp, CFrame.new(0, -2.5, 0))
		Emit(BaseSwirls:GetDescendants(), false, 3)
		Ess.Destroy(BaseSwirls, 3)
	end
	
	if skillType == "FinalFlameExplosion" then
		local FinalVFXPivot = hrp.CFrame * CFrame.new(.4, -3, 0)
		local FinalVFX    = script["FinalVFX"]:Clone()
		FinalVFX:PivotTo(FinalVFXPivot)
		FinalVFX.Parent = workspace.World.Visuals

		Emit(FinalVFX:GetDescendants(), true)
		Ess.Destroy(FinalVFX, 3)
	end
end