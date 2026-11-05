-- Client LocalScript

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local ReticleController = require(ReplicatedStorage.Modules:WaitForChild("ReticleController"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local HoldAimStart = Remotes:WaitForChild("HoldAimStart")

-- SETTINGS
local WindSoundEnabled = true

-- TEMPLATE INSTANCES (must exist under this LocalScript)
local BodyVelocityTemplate = script:WaitForChild("BodyVelocity")
local BodyGyroTemplate = script:WaitForChild("BodyGyro")

local player = Players.LocalPlayer
local character = script.Parent
local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local Camera = workspace.CurrentCamera

-- Create / clone movers once
local BodyVelocity = BodyVelocityTemplate:Clone()
local v3 = BodyGyroTemplate:Clone()
BodyVelocity.MaxForce = Vector3.zero  -- translation disabled
BodyVelocity.Velocity = Vector3.zero
BodyVelocity.Parent = character
v3.Parent = character
BodyVelocity.Parent = character

-- Wind sound
--local Sound1 = Instance.new("Sound")
--Sound1.Parent = hrp
--Sound1.SoundId = "rbxassetid://3308152153"
--Sound1.Name = "Sound1"
--if not WindSoundEnabled then
--	Sound1.Volume = 0
--end

-- State
local Flying = false
local flyMoving = Instance.new("BoolValue")
flyMoving.Name = "Flymoving"
flyMoving.Value = false
flyMoving.Parent = script

local renderConn: RBXScriptConnection? = nil

local function getMoveVectorCameraRelative()
	if humanoid.MoveDirection == Vector3.zero then
		return Vector3.zero
	end

	-- Same logic as your u2()
	local cam = Camera.CFrame
	local flatLook = Vector3.new(cam.LookVector.X, 0, cam.LookVector.Z)
	local camFlatCF = CFrame.new(cam.Position, cam.Position + flatLook)

	local objSpace = camFlatCF:VectorToObjectSpace(humanoid.MoveDirection)
	local worldPoint = (cam * CFrame.new(objSpace)).Position
	local v12 = worldPoint - cam.Position

	if v12.Magnitude < 1e-6 then
		return Vector3.zero
	end
	return v12.Unit
end

local function applyFlyingEnabled(enabled: boolean)
	if enabled == Flying then return end
	Flying = enabled

	if Flying then
		humanoid.PlatformStand = true
		
		BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9) 
		BodyVelocity.Velocity = Vector3.zero
		-- Start
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)

		if hrp:FindFirstChild("Running") then
			hrp.Running.Volume = 0
		end

		BodyVelocity.Parent = hrp
		v3.Parent = hrp

		if renderConn then renderConn:Disconnect() end
		renderConn = RunService.RenderStepped:Connect(function()
			if not Flying then return end

			-- 1. CRITICAL: Stop the Humanoid from trying to stand up
			humanoid.PlatformStand = true
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)

			-- 2. GET CAMERA DIRECTION
			local camCF = Camera.CFrame
			local pos = hrp.Position

			-- 3. THE FIX: Clamp the "Up/Down" tilt
			-- We prevent the player from looking EXACTLY 90 degrees up or down.
			-- Looking at 89.9 degrees prevents the "Gimbal Lock" math error that causes vibration.
			local lookDirection = camCF.LookVector
			if math.abs(lookDirection.Y) > 0.999 then
				-- If looking too far up/down, we nudge it slightly
				lookDirection = Vector3.new(lookDirection.X, math.sign(lookDirection.Y) * 0.999, lookDirection.Z).Unit
			end

			-- 4. APPLY LERPED ROTATION
			-- Using a high P/D value (like we discussed) with a direct CFrame
			v3.CFrame = CFrame.lookAt(pos, pos + lookDirection)
		end)
	else
		Flying = false
		if renderConn then 
			renderConn:Disconnect()
			renderConn = nil 
		end

		humanoid.PlatformStand = false
		-- Stop
		--flyMoving.Value = false
		BodyVelocity.MaxForce = Vector3.zero
		BodyVelocity.Velocity = Vector3.zero
		
		BodyVelocity.Parent = nil
		v3.Parent = nil


		humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

		if hrp:FindFirstChild("Running") then
			hrp.Running.Volume = 0.65
		end

		--BodyVelocity.Parent = character
		--v3.Parent = character
		--Sound1:Stop()
	end
end

--flyMoving.Changed:Connect(function(moving)
--	if moving then
--		TweenService:Create(Camera, TweenInfo.new(0.5), { FieldOfView = 100 }):Play()
--		hoverTrack:Stop()
--		Sound1:Play()
--		flyTrack:Play()
--	else
--		TweenService:Create(Camera, TweenInfo.new(0.5), { FieldOfView = 70 }):Play()
--		flyTrack:Stop()
--		Sound1:Stop()
--		hoverTrack:Play()
--	end
--end)

HoldAimStart.OnClientEvent:Connect(function(action: string, data)
	if action == "Start" then
		applyFlyingEnabled(true)
		ReticleController.Start(player.Character)
	elseif action == "Stop" then
		applyFlyingEnabled(false)
		ReticleController.Stop()
	elseif action == "Dive" then
		applyFlyingEnabled(false) -- disable hover

		local diveDir
		if data.ForceDirection then
			diveDir = data.ForceDirection
		else
			diveDir = hrp.CFrame.LookVector.Unit -- fallback
		end

		local diveVel = diveDir * data.DiveSpeed

		local diveBV = Instance.new("BodyVelocity")
		diveBV.Name = "DiveBV"
		diveBV.MaxForce = Vector3.new(100000, 100000, 100000)
		diveBV.Velocity = diveVel
		diveBV.Parent = hrp


		-- Server tells you when to destroy it via another remote/attribute
	elseif action == "DestroyDiveBV" then
		local bv = hrp:FindFirstChild("DiveBV")
		if bv then
			bv:Destroy()
		end
		hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

	end

end)