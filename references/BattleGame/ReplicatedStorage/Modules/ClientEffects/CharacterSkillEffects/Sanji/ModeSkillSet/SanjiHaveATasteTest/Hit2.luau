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
		local root = character.PrimaryPart
		--if _G.checkRenderDistance(root.Position) == false then
		--	return
		--end

		-- Ground beneath the character, used to tint the forward-kick dust later.
		--local floorPart = VFX.getRayFloor(root.CFrame, 10)


		local highKickPivot = root.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(180))
		local Hit1    = script["Hit2"]:Clone()
		Hit1:PivotTo(highKickPivot)
		Hit1.Parent = workspace.World.Visuals

		--Emit(Hit1.Main:GetDescendants(), false, 0.35)
		--Emit(Hit1.Emit:GetDescendants(), true)

		-- Rise 20 studs over 0.35s. (The original had a yaw spin here too, but it
		-- was multiplied by 0, so it never actually rotated.)
		animateFor(0.35, function(elapsed)
			local alpha = TweenService:GetValue(elapsed / 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			Hit1:PivotTo(highKickPivot + Vector3.new(0, 0, 0 * alpha))
		end)


		TweenCreate(Hit1.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Scale = Hit1.Mesh.Scale * Vector3.new(1.5, 1.8, 1.8),
		})
		TweenCreate(Hit1.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Color3       = Hit1.Decal.Color3:Lerp(Color3.new(1, 0.886275, 0.0196078), 0.25),
			Transparency = 1,
		})

		Ess.Destroy(Hit1, .5)

		local highKickPivot = root.CFrame * CFrame.new(0, 0, -2) -- * CFrame.Angles(math.rad(90), math.rad(0), math.rad(180))
		local Part    = script["TestPart2"]:Clone()
		Part:PivotTo(highKickPivot)
		Part.Parent = workspace.World.Visuals

		Emit(Part:GetDescendants(), true, false)
		Ess.Destroy(Part, 2)
	end,
}