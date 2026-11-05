-- Client VFX sequence for the "Crane Talon" kick.
-- Three timed phases of effects spawned around the character:
--   1. High Kick    - a swirl that rises and fades        (sound: CraneTalonA)
--   2. Crane Talons  - spinning talons + a swirl ring       (sounds: CraneTalonB, CraneTalonC)
--   3. Forward Kick  - a streak that sweeps forward + fades  (tinted to the ground color)
-- Only runs when the character is within render distance.

local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Helpers provided by the effects framework.
local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Emit        = VFX.Emit
local TweenCreate = Essentials.Tween     -- re-exported from Essentials
local Ess         = Essentials           -- if you also used Ess.Destroy: VFX.Destroy works



local TALON_TILT = CFrame.Angles(0, 0, math.rad(12)) -- slight roll on the talons/swirls

-- Drives `onUpdate(elapsed)` every render frame for `duration` seconds,
-- then auto-disconnects (matches the Ess.Destroy(conn, duration) idiom).
local function animateFor(duration: number, onUpdate: (number) -> ())
	local startTime = tick()
	local conn = RunService.RenderStepped:Connect(function()
		onUpdate(tick() - startTime)
	end)
	Ess.Destroy(conn, duration)
end

return {
	start = function(_, character, _, _) -- (caller, character, ...); only the character is used
		local root = character.PrimaryPart
		--if _G.checkRenderDistance(root.Position) == false then
		--	return
		--end

		-- Ground beneath the character, used to tint the forward-kick dust later.
		local floorPart = VFX.getRayFloor(root.CFrame, 10)

		--------------------------------------------------------------------
		-- Phase 1 - High Kick: a swirl that floats upward and fades out
		--------------------------------------------------------------------
		--_G.PlaySound(root, script.CraneTalonA)
		--task.wait(0.485)

		local highKickPivot = root.CFrame * CFrame.new(0, 5.5, 0)
		local highKickFx    = script["High Kick"]:Clone()
		highKickFx:PivotTo(highKickPivot)
		highKickFx.Parent = workspace.World.Visuals

		Emit(highKickFx.Main:GetDescendants(), false, 0.35)
		Emit(highKickFx.Emit:GetDescendants(), true)

		-- Rise 20 studs over 0.35s. (The original had a yaw spin here too, but it
		-- was multiplied by 0, so it never actually rotated.)
		animateFor(0.35, function(elapsed)
			local alpha = TweenService:GetValue(elapsed / 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			highKickFx:PivotTo(highKickPivot + Vector3.new(0, 20 * alpha, 0))
		end)

		for _, swirl in highKickFx:GetChildren() do
			if swirl:IsA("BasePart") and swirl.Name:match("Swirl") then
				TweenCreate(swirl.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = swirl.Mesh.Scale * Vector3.new(1.45, 1.8, 1.8),
				})
				TweenCreate(swirl.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Color3       = swirl.Decal.Color3:Lerp(Color3.new(0, 0.112947, 0.643259), 0.25),
					Transparency = 1,
				})
			end
		end
		Ess.Destroy(highKickFx, 1.2)

		--------------------------------------------------------------------
		-- Phase 2 - Crane Talons: spinning talons + swirl ring
		--------------------------------------------------------------------
		--_G.PlaySound(root, script.CraneTalonB)
		--task.wait(0.33)

		local baseCFrame = root.CFrame
		local spinBase   = baseCFrame * TALON_TILT

		local talonsFx = script["Crane Talons"]:Clone()
		talonsFx.CFrame = baseCFrame * CFrame.Angles(0, math.rad(90), math.rad(90)) * TALON_TILT
		talonsFx.Parent = workspace.World.Visuals
		Emit(talonsFx.Attachment:GetChildren(), false, 0.2)
		Emit(talonsFx:GetChildren(), false, 0.1)

		local swirlsFx = script.Swirls:Clone()
		swirlsFx:PivotTo(baseCFrame * CFrame.Angles(0, -math.rad(45), 0) * TALON_TILT)
		swirlsFx.Parent = workspace.World.Visuals

		-- Spin both for 0.35s; the talons spin ~2x faster than the swirl ring.
		-- ceil() makes the rotation step in ~1-radian increments (a ratchet look).
		animateFor(0.35, function(elapsed)
			local swirlAngle = -math.abs(math.ceil(elapsed * 100 % 360))
			swirlsFx:PivotTo(spinBase * CFrame.Angles(0, swirlAngle, 0))

			local talonAngle = -math.abs(math.ceil(elapsed * 200 % 360))
			talonsFx.CFrame = spinBase * CFrame.fromOrientation(0, talonAngle, math.rad(90))
		end)

		for _, swirl in swirlsFx:GetChildren() do
			TweenCreate(swirl.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Scale = Vector3.new(4, 1.5, 4),
			})
			TweenCreate(swirl.Decal, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Color3       = Color3.new(0.040589, 0.335668, 0.597101),
				Transparency = 1,
			})
		end

		task.delay(0.85, function()
			swirlsFx:Destroy()
			task.wait(0.45)
			talonsFx:Destroy()
		end)

		task.delay(0.2, function()
			--_G.PlaySound(root, script.CraneTalonC)
		end)
	end,
}