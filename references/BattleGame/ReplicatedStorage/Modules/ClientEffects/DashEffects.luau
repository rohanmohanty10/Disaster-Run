--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)

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

	if skillType == "groundRocks" then
		local RootPart = attacker.HumanoidRootPart
		local Torso = attacker.Torso

		local function GetPosition()
			local CF = CFrame.lookAlong(Torso.Position, RootPart.CFrame.LookVector) * CFrame.new(0, 0, -1.5)

			return (CF.Position + (Vector3.yAxis * 1.5))
		end
		
		task.spawn(function()
			local CraterDirection = Vector3.yAxis * -15


			for Index = 1, 8 do
				local Position = GetPosition()

				task.spawn(RockHandler.Rockst, Position, CraterDirection, {
					Size = {0.1, 0.3},
					Count = 5,
					Velocity = 0,
					--SpawnVariance = 0.5;
				})

				--RockHandler.Rocks("Dragged", Position)
				--Smoke(Torso, 7.5, 1.5)
				--local Presets = require(ReplicatedStorage.Modules.ClientEffects.RockHandler.Presets)
				--task.spawn(RockHandler., Position, CraterDirection, {
				--	Size = {0.1, 0.3},
				--	Count = 5,
				--	Velocity = 0,
				--	--SpawnVariance = 0.5;
				--})

				task.wait(0.05)
			end
		end)
		
		--local function GetCFrame()
		--	-- oriented to the (flattened) dash direction so the "Forward Dash" preset's
		--	-- left/right side-offset straddles the movement instead of world X
		--	local look = RootPart.CFrame.LookVector
		--	local flatLook = Vector3.new(look.X, 0, look.Z)
		--	flatLook = flatLook.Magnitude > 1e-4 and flatLook.Unit or RootPart.CFrame.LookVector
		--	return CFrame.lookAlong(Torso.Position + flatLook * -1.5, flatLook)
		--end
		
		--task.spawn(function()
		--	for Index = 1, 10 do
		--		--RockHandler.Rocks("Forward Dash", GetCFrame())
		--		RockHandler.Rocks("Forward Dash", RootPart)
		--		task.wait(0.05)
		--	end
		--end)
	end
	
	if skillType == "side dash rocks" then
		local RootPart = attacker.HumanoidRootPart
		local Torso = attacker.Torso
		local Direction = argumentData.Direction or "Right"

		local sign = (Direction == "Left") and -1 or 1

		local function GetPosition()
			-- Flattened so a slope or ragdoll tilt doesn't skew the offset.
			local look = RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
			look = look.Magnitude > 1e-4 and look.Unit or RootPart.CFrame.LookVector

			local CF = CFrame.lookAlong(Torso.Position, look) * CFrame.new(1.5 * sign, 0, 0)
			return CF.Position + Vector3.yAxis * 1.5
		end
		
		task.spawn(function()
			for _ = 1, 10 do
				if not attacker:GetAttribute("SideDashing") then break end
				if not RootPart.Parent then break end
				
				local CraterDirection = Vector3.yAxis * -5
				RockHandler.Rocks("Side Dash", RootPart)
				--RockHandler.Rocks("Blue Pull", RootPart)
				--task.spawn(RockHandler.Rockst, GetPosition(), Vector3.yAxis * -5, {
				--	Size = { 0.1, 0.3 },
				--	Count = 5,
				--	Velocity = 0,
				--})

				task.wait(0.05)
			end
		end)
	end
	
end