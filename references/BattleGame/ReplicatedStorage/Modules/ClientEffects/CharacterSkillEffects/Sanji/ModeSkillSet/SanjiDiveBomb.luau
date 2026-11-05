local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris            = game:GetService("Debris")
local TS                = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local Lighting          = game:GetService("Lighting")

local LocalPlayer  = Players.LocalPlayer
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local BoatTween    = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)
local Velocity     = require(ReplicatedStorage.Modules.Velocity2)
local MilkVFX      = require(ReplicatedStorage.Modules.ClientEffects.RandomModules2.VFXLibrary)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)


local currentCamera = workspace.CurrentCamera

-- ============================================================================
--  HELPERS
-- ============================================================================

-- Emits every child in `container` that has a "Start" child (mesh-emit pattern).
local function emitMeshGroup(cframe, container)
	for _, meshEffect in container:GetChildren() do
		if meshEffect:FindFirstChild("Start") then
			MilkVFX.mesh_emit.EmitAt(cframe, meshEffect)
		end
	end
end


local function spawnParticle(parent, template, lifetime, weld)
	local clone = template:Clone()
	clone.Parent = parent
	if weld then
		local weldInstance = Instance.new("Weld")
		weldInstance.Part0 = parent
		weldInstance.Part1 = clone
		weldInstance.Parent = clone
	end
	MilkVFX.Particles.enableParticles(clone)
	if lifetime then
		task.delay(lifetime, MilkVFX.Particles.disableParticles, clone)
		task.delay(lifetime + 1, clone.Destroy, clone)
	end
	return clone
end

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Emit        = VFX.Emit
local TweenCreate = Essentials.Tween     -- re-exported from Essentials
local Ess         = Essentials           -- if you also used Ess.Destroy: VFX.Destroy works

-- ============================================================================
return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local victim: Model   = argumentData.Victim
	local isLocalPlayer   = LocalPlayer.Character == attacker
	local isVictim        = victim and LocalPlayer.Character == victim

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- ================================================================
	--  slashStart
	-- ================================================================
	if skillType == "Jump" then
		local JumpUpMesh = require(script.JumpUpMesh)
		
		JumpUpMesh.start(nil, attacker)
	end
	
	if skillType == "DiveStart" then
		local DiveDown = require(script.DiveDown)
		local Trail = require(script.Trail)

		DiveDown.start(nil, attacker, argumentData)
		Trail.start(nil, attacker, argumentData)
	end
	
	if skillType == "GroundVFX" then
		local ExplosionGroundMarks = script["ExplosionGroundMarks"]:Clone()
		ExplosionGroundMarks.Anchored   = true
		ExplosionGroundMarks.CanCollide = false
		ExplosionGroundMarks.Massless   = true
		
		local Explosion = script["Explosion"]:Clone()
		Explosion.Anchored   = true
		Explosion.CanCollide = false
		Explosion.Massless   = true 

		-- handle either a CFrame or a Vector3 coming in
		local givenCF = typeof(argumentData.Position) == "CFrame"
			and argumentData.Position
			or CFrame.new(argumentData.Position)

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Include
		rayParams.FilterDescendantsInstances = { workspace.World.Map.Destroyable:WaitForChild("Map"):WaitForChild("Floor") or workspace.World.Map:WaitForChild("Indestructible Map")}
		rayParams.IgnoreWater = true

		local origin = givenCF.Position + Vector3.new(0, 5, 0)          -- start slightly above
		local hit = workspace:Raycast(origin, Vector3.new(0, -1000, 0), rayParams)

		if hit then
			ExplosionGroundMarks.CFrame = givenCF.Rotation + hit.Position - Vector3.new(0, ExplosionGroundMarks.Size.Y / 2, 0)
			Explosion.CFrame = givenCF.Rotation + hit.Position - Vector3.new(0, Explosion.Size.Y / 2, 0)
		else
			ExplosionGroundMarks.CFrame = givenCF
			Explosion.CFrame = givenCF
		end

		ExplosionGroundMarks.Parent = workspace.World.Visuals
		Explosion.Parent = workspace.World.Visuals
		
		Emit(Explosion:GetDescendants(), true)
		
		task.spawn(function()
			task.wait(1.5)
			local FADE = 3   -- seconds to fade out
			local fadeInfo = TweenInfo.new(FADE, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			local function fade(inst)
				if inst:IsA("Decal") then
					TweenCreate(inst, fadeInfo, { Transparency = 1 })
				elseif inst:IsA("BasePart") and inst.Transparency < 1 then
					TweenCreate(inst, fadeInfo, { Transparency = 1 })
				elseif inst:IsA("Light") then              -- PointLight / SpotLight / SurfaceLight And has a custom tween time to make it disappear quicker
					TweenCreate(inst, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Range = 0, Brightness = 0 })
				end
			end

			fade(ExplosionGroundMarks)                              -- the part itself, if it's visible
			for _, inst in ExplosionGroundMarks:GetDescendants() do -- any decals / sub-parts
				fade(inst)
			end
			
			fade(Explosion)
			for _, inst in Explosion:GetDescendants() do
				fade(inst)
			end
			
			Ess.Destroy(ExplosionGroundMarks, FADE)                 -- remove it exactly when the fade ends
			Ess.Destroy(Explosion, FADE)
		end)
	end

end