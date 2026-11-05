-- Withdraw (client effects) — handles the "Withdraw" move fired from the server.
-- Owns the dash locomotion (Velocity.Dash) + the slash VFX.
-- Place the "WithdrawSlash" VFX model as a child of this script.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")
local Players           = game:GetService("Players")

local LocalPlayer  = Players.LocalPlayer
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local Velocity     = require(ReplicatedStorage.Modules.Velocity2) -- TODO: your path

local activeSlashes = {}

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local character       = attacker
	local isLocalPlayer   = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- ===== Dash locomotion (only the owner drives it; replicates to others) =====
	if skillType == "dashback" and isLocalPlayer then
		print("Dashbackclient")

		-- Nanami Dashes[1] + { VelocityReplication = true, Style = "Sine" }
		Velocity.Dash(hrp, character.Humanoid, {
			Distance = -20, Duration = 0.35, Style = "Sine",
			VelocityReplication = true,
		})
	end

	if skillType == "dashforward" and isLocalPlayer then
		-- Nanami Dashes[2] + { VelocityReplication = true, LockDirection = true, Style = "Quad" }
		Velocity.Dash(hrp, character.Humanoid, {
			Distance = 25, Duration = 0.6, Style = "Quad",
			VelocityReplication = true, LockDirection = true,
		})
	end

	-- ===== Slash VFX (windup) =====
	if skillType == "vfx" then
		local slashModel = script.WithdrawSlash:Clone()
		local weldTo = character:FindFirstChild("Handle", true) or hrp   -- cleaver handle if you have one
		slashModel:PivotTo(weldTo.CFrame)

		local weld = Instance.new("Weld")
		weld.Part0, weld.Part1, weld.C0 = weldTo, slashModel.PrimaryPart, CFrame.new()
		weld.Parent = slashModel.PrimaryPart

		slashModel.Parent = workspace.World.Visuals
		activeSlashes[attacker] = slashModel

		VFXFunctions.EmitDescendants(slashModel.PrimaryPart.Back)        -- t=0
		local trail = weldTo:FindFirstChild("BladeTrail")
		if trail then trail.Enabled = true end

		task.delay(0.5, function()                                       -- t=0.5
			if slashModel.Parent then VFXFunctions.EmitDescendants(slashModel.PrimaryPart.Forward) end
		end)
		task.delay(0.9, function()                                       -- t=0.9
			if slashModel.Parent then
				local shine = slashModel.PrimaryPart.CleaverShine:Clone()
				shine.Parent = weldTo
				VFXFunctions.EmitDescendants(shine)
				Debris:AddItem(shine, 3)
			end
		end)
		task.delay(1.2, function() if trail then trail.Enabled = false end end)
	end

	-- ===== Impact =====
	if skillType == "hit" then
		local slashModel = activeSlashes[attacker]
		if slashModel then
			VFXFunctions.EmitDescendants(slashModel.Slash)
		end
		-- TODO: victim impact (Nanami's Attach.Emit(..,145)) at argumentData.Position
		-- TODO: play your unblocked-hit sound here
	end

	-- ===== Cleanup ("hangs in air" then despawn) =====
	if skillType == "cleanup" then
		local slashModel = activeSlashes[attacker]
		if slashModel then
			for _, p in slashModel:GetDescendants() do
				if p:IsA("Weld") then p:Destroy() end
				if p:IsA("BasePart") then p.Anchored = true end
			end
			Debris:AddItem(slashModel, 2)
			activeSlashes[attacker] = nil
		end
		local trail = character:FindFirstChild("BladeTrail", true)
		if trail then trail.Enabled = false end
	end
end