-- Zoro — Fourth Ability (client effects)
--
-- "teleport": Zoro blinks behind the enemy. A Teleport effect where he left and one where he lands.
-- "enemyAir": the counter's hit lands. The Slash on Zoro, and the enemy's flight effect (wind +
--             trailing rings until they land) from KnockbackFX, shared with every knockback so it
--             never stacks.
--
-- Runs on every client (the server FireAllClients'), so everything in here is local: each
-- machine builds its own copy of the effect.
--
-- SETUP: inside this ModuleScript, "Slash" (Model, PrimaryPart Root) and "Teleport" (Model).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local KnockbackFX     = require(ReplicatedStorage.Modules.ClientEffects.KnockbackFX)

local MAX_DISTANCE = 250 -- effects farther than this from the camera are skipped

local BEAM_OPEN  = TweenInfo.new(0.2)
local BEAM_CLOSE = TweenInfo.new(0.3)

local function VisualsFolder(): Instance
	local World = workspace:FindFirstChild("World")
	return World and World:FindFirstChild("Visuals") or workspace
end

local function Near(Position: Vector3): boolean
	local Camera = workspace.CurrentCamera
	return not Camera or (Position - Camera.CFrame.Position).Magnitude < MAX_DISTANCE
end

-- clones an effect, puts it at CF and plays every particle in it once
local function Burst(Template: Model, CF: CFrame, Lifetime: number): Model
	local Effect = Template:Clone()
	for _, Descendant in Effect:GetDescendants() do
		if Descendant:IsA("BasePart") then
			Descendant.Anchored = true
			Descendant.CanCollide = false
			Descendant.CanQuery = false
			Descendant.CanTouch = false
		end
	end
	Effect:PivotTo(CF)
	Effect.Parent = VisualsFolder()
	EffectUtilities.Emit(Effect)
	EffectUtilities.Debris(Effect, Lifetime)
	return Effect
end

-- the slash's beams open up, hold for their EmitDuration attribute, then close
local function PlayBeams(Effect: Model)
	for _, Descendant in Effect:GetDescendants() do
		if Descendant:IsA("Beam") then
			local Width0, Width1 = Descendant.Width0, Descendant.Width1
			Descendant.Width0, Descendant.Width1 = 0, 0
			Descendant.Enabled = true
			TweenService:Create(Descendant, BEAM_OPEN, { Width0 = Width0, Width1 = Width1 }):Play()
			task.delay(Descendant:GetAttribute("EmitDuration") or 0.25, function()
				if Descendant.Parent then
					TweenService:Create(Descendant, BEAM_CLOSE, { Width0 = 0, Width1 = 0 }):Play()
				end
			end)
		end
	end
end

return function(argumentData: any)
	local skillType = argumentData.SkillType
	local attacker: Model? = argumentData.Attacker
	local target: Model = argumentData.Target

	if skillType == "enemyAir" then
		-- the hit: the slash on Zoro...
		local HumRP = attacker and attacker:FindFirstChild("HumanoidRootPart")
		local SlashTemplate = script:FindFirstChild("Slash")
		if HumRP and SlashTemplate and Near(HumRP.Position) then
			PlayBeams(Burst(SlashTemplate, HumRP.CFrame, 2))
		end
		-- ...and the enemy's flight effect until they land
		KnockbackFX.Force(target)

	elseif skillType == "teleport" then
		-- one burst where Zoro left, one where he lands, both facing the way he went
		local Origin: Vector3? = argumentData.Origin
		local Destination: Vector3? = argumentData.Destination
		local TeleportTemplate = script:FindFirstChild("Teleport")
		if not (Origin and Destination and TeleportTemplate) or not (Near(Origin) or Near(Destination)) then
			return
		end
		local Travel = Vector3.new(Destination.X - Origin.X, 0, Destination.Z - Origin.Z)
		local Facing = if Travel.Magnitude > 0.01 then Travel.Unit else Vector3.new(0, 0, -1)
		Burst(TeleportTemplate, CFrame.lookAlong(Origin, Facing), 2)
		Burst(TeleportTemplate, CFrame.lookAlong(Destination, Facing), 2)

	elseif skillType == "start" then
		-- hook for your startup VFX.

	end
end
