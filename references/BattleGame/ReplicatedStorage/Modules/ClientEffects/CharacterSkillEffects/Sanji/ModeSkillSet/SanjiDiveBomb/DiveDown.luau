-- Client VFX for the "Immortal Thistle" move (Phoenix form).
-- Normal cast: play the thistle animation + spawn the effect pinned to the character.
-- If the target was Blocking: grab the already-spawned thistle effect and fade it out.
-- Never renders on the owning player's own screen.
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local VFX        = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Emit = VFX.Emit
local Ess  = Essentials
local TweenCreate = Essentials.Tween

-- BoatTween: required here because we tween a ParticleEmitter's Transparency
-- (NumberSequence) and Speed (NumberRange) with the custom "EntranceExpressive"
-- easing — none of which stock TweenService / Essentials.Tween can handle.
local BoatTween = Essentials.tween --BoatTween_upvrGPO  -- ⚠ see note below — this is nil in your current file

local function animateFor(duration: number, onUpdate: (number) -> ())
	local startTime = tick()
	local conn = RunService.RenderStepped:Connect(function()
		onUpdate(tick() - startTime)
	end)
	Ess.Destroy(conn, duration)
end

return {
	start = function(_, character, data)
		-- if _G.checkRenderDistance(character.PrimaryPart.Position) == false then return end

		-- Skip the owner's own client (they get a first-person version elsewhere).
		--if player and game.Players.LocalPlayer == player then
		--	return
		--end

		local root             = character.PrimaryPart
		local humanoid         = character:FindFirstChild("Humanoid")
		local characterEffects = character:FindFirstChild("CharacterEffects")
		
		-- Normal: play the anim and spawn a fresh thistle pinned to the character.

		--local thistleFx = script["Immortal Thistle"]:Clone()
		--thistleFx.Parent = characterEffects
		--Emit(thistleFx:GetDescendants(), false)

		--thistleFx.Hold.RigidConstraint.Attachment1 = root.RootRigAttachment
		
		local root = character.PrimaryPart

		local Swirl = script["Swirl"]:Clone()
		Swirl.Anchored   = false
		Swirl.CanCollide = false
		Swirl.Massless   = true

		-- 1. Grab the pure forward direction of the character's root
		local forward = root.CFrame

		-- 2. Mathematically force the dive angle, position, and mesh fix
		Swirl.CFrame = forward
			* CFrame.Angles(math.rad(-45), 0, 0) -- Tilt it down 45 degrees (adjust this number if you want it steeper/flatter)
			* CFrame.new(0, -1, -4)              -- Push it 3 studs forward and 1 stud down relative to the tilt
			* CFrame.Angles(0, math.rad(-90), 0) -- Fix the mesh's axis so it doesn't face sideways
		
		Swirl.Parent = workspace.World.Visuals
		-- 3. Weld it safely to the root
		local weld = Instance.new("WeldConstraint")
		weld.Part0  = root
		weld.Part1  = Swirl
		weld.Parent = Swirl



		--Emit(highKickFx.Main:GetDescendants(), false, 0.35)
		--Emit(highKickFx.Emit:GetDescendants(), true)

		-- Rise 20 studs over 0.35s. (The original had a yaw spin here too, but it
		-- was multiplied by 0, so it never actually rotated.)
		--local diveDir = (data and data.Direction) --or root.CFrame.LookVector
		--local SWIRL_TRAVEL = 100

		--animateFor(.35, function(elapsed)
		--	local alpha = TweenService:GetValue(elapsed / 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		--	Swirl:PivotTo(swirlPivot + diveDir * (SWIRL_TRAVEL * alpha))
		--end)

		--animateFor(0.35, function(elapsed)
		--	local alpha = TweenService:GetValue(elapsed / 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		--	Swirl:PivotTo(swirlPivot + Vector3.new(0, 20 * alpha, 0))
		--end)

		
		TweenCreate(Swirl.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			--Scale = Swirl.Mesh.Scale * Vector3.new(1.45, 1.8, 1.8),
			Scale = Swirl.Mesh.Scale * Vector3.new(.1, .1, .1),
		})
		
		for _, decal in Swirl:GetChildren() do
			if decal:IsA("Decal") then
				TweenCreate(decal, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Color3       = decal.Color3:Lerp(Color3.new(0, 0.112947, 0.643259), 0.25),
					Transparency = 1,
				})
			end
		end
		
		Ess.Destroy(Swirl, .4)
		
	end,
}