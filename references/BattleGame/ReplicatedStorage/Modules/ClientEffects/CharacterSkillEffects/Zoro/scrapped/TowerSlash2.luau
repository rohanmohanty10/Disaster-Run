-- TacticalAnalysis (client effects) — core dash/attack, no finisher.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")
local Players           = game:GetService("Players")

local LocalPlayer  = Players.LocalPlayer
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local Velocity     = require(ReplicatedStorage.Modules.Velocity2) -- TODO: your path

local activeSlashes = {}

local IndestructibleParams = RaycastParams.new()
IndestructibleParams.FilterType = Enum.RaycastFilterType.Include
IndestructibleParams.FilterDescendantsInstances = { workspace.World.Map["Indestructible Map"] }
IndestructibleParams.RespectCanCollide = true

local WALL_BUFFER = 5

local function clampDashDistance(hrp, dir, maxDist)
	local result = workspace:Raycast(hrp.Position, dir * maxDist, IndestructibleParams)
	if result then
		return math.max(result.Distance - WALL_BUFFER, 0)
	end
	return maxDist
end

local function flatForward(hrp)
	local lv = hrp.CFrame.LookVector
	return Vector3.new(lv.X, 0, lv.Z).Unit
end

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local character       = attacker
	local isLocalPlayer   = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- ===== Dashes (owner only; replicate to others) =====
	if skillType == "dash1" and isLocalPlayer then
		local dir = flatForward(hrp)                                -- NEW
		Velocity.Dash(hrp, character.Humanoid, {
			Distance = clampDashDistance(hrp, dir, 10),             -- CHANGED: was 10
			Duration = 0.4, Style = "Sine",
			VelocityReplication = true, LockDirection = true,
		})
	end

	if skillType == "dash2" and isLocalPlayer then
		local dir = flatForward(hrp)                                -- NEW: compute once, use for both
		Velocity.Dash(hrp, character.Humanoid, {
			Distance = clampDashDistance(hrp, dir, 45),             -- CHANGED: was 45
			Duration = .8, Style = "Exponential",
			VelocityReplication = true, ForceDirection = dir,       -- CHANGED: was flatForward(hrp)
		})
	end

	-- ===== Windup VFX =====
	if skillType == "vfx" then
		print("tactvfx")
		
		local slashModel = script.Dash:Clone()
		slashModel.Parent = workspace.World.Visuals

		slashModel:PivotTo(character.HumanoidRootPart.CFrame)-- * CFrame.new(0,10,0))
		VFXFunctions.EmitDescendants(slashModel)
		
		
		--task.wait(.2)
		local function attachSlash(template, offsetCFrame)
			local slash = template:Clone()
			-- unanchor every part so the weld can move them
			for _, p in slash:GetDescendants() do
				if p:IsA("BasePart") then p.Anchored = false end
			end
			slash.Parent = workspace.World.Visuals
			slash:PivotTo(hrp.CFrame * offsetCFrame)

			-- weld the model's root part to the HRP
			local root = slash.PrimaryPart or slash:FindFirstChildWhichIsA("BasePart", true)
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = hrp
			weld.Part1 = root
			weld.Parent = root

			VFXFunctions.EmitDescendants(slash)
			Debris:AddItem(slash, 2)
			return slash
		end

		-- rotated 90°, the two slashes sit 1 stud apart (±0.5 on X)
		local rot = CFrame.Angles(0, 0, math.rad(90))
		attachSlash(script.Slash2, CFrame.new(2, 0, 0) * rot)
		attachSlash(script.Slash2, CFrame.new( 4, 0, 0) * rot)
	end
	
	if skillType == "EnemyHit" then
		local slashModel = script.SlashHit:Clone()
		slashModel.Parent = workspace.World.Visuals

		slashModel:PivotTo(character.HumanoidRootPart.CFrame)-- * CFrame.new(0,10,0))
		VFXFunctions.EmitDescendants(slashModel)
	end

	-- ===== First hit (slash burst) =====
	if skillType == "hit1" then
		--print("HIt1")

		local slow = script.slash:Clone()
		slow.Parent = workspace.World.Visuals
		slow.Slash:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 0, math.rad(0)))
		slow.SlashHit:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4)* CFrame.Angles(0, 0, math.rad(0)))
		slow.SlashHitTime:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4)* CFrame.Angles(0, 0, math.rad(0)))

		--VFXFunctions.EmitEffects(slow)
		VFXFunctions.EmitDescendants(slow.Slash)
		VFXFunctions.EmitDescendants(slow.SlashHit)
		VFXFunctions.EmitDescendants(slow.SlashHitTime)
		
		
		local slow2 = script.slash:Clone()
		slow2.Parent = workspace.World.Visuals
		slow2.Slash:PivotTo(hrp.CFrame * CFrame.new(0, -1, -4)* CFrame.Angles(0, 0, math.rad(0)))
		slow2.SlashHit:PivotTo(hrp.CFrame * CFrame.new(0, -1, -4)* CFrame.Angles(0, 0, math.rad(0)))
		slow2.SlashHitTime:PivotTo(hrp.CFrame * CFrame.new(0, -1, -4)* CFrame.Angles(0, 0, math.rad(0)))

		--VFXFunctions.EmitEffects(slow)
		VFXFunctions.EmitDescendants(slow2.Slash)
		VFXFunctions.EmitDescendants(slow2.SlashHit)
		VFXFunctions.EmitDescendants(slow2.SlashHitTime)
	end

	-- ===== Lunge hit (cursed slash) =====
	if skillType == "hit2" then
		-- TODO: spawn TacticalAnalysisUnblocked VFX at the hit, emit CursedHit/CursedDash,
		--       enable blade trail briefly, play the impact sound.
	end

	-- ===== Cleanup =====
	if skillType == "cleanup" then
		
	end
end