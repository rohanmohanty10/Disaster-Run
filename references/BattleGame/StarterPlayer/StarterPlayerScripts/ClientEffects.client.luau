--Client Effects
--We put this script into here cause we don't want the script to always reload whenever a play dies. So it will be placed into the player's folder in studios.


local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local modules = replicatedStorage:WaitForChild("Modules")
local fxModule = require(replicatedStorage.Modules.ClientEffects.VfxHandler:WaitForChild("Effects"))
local remotes = replicatedStorage:WaitForChild("Remotes")
local CameraShaker = require(modules:WaitForChild("CameraShaker"))
local Settings = require(modules:WaitForChild("Settings"))



local cachedEffects = {}

for _, module in modules.ClientEffects:GetDescendants() do
	if module:IsA("ModuleScript") then
		-- Use pcall to attempt the require
		local success, result = pcall(require, module)

		if success then
			cachedEffects[module.Name] = result
		else
			warn(string.format("Failed to cache [%s]: %s", module.Name, result))
		end
	end
end

remotes.ClientEffects.OnClientEvent:Connect(function(action: string, argumentData: any)
	local foundEffect = cachedEffects[action] --Action being the paramater that was passed. Could be Default hit effect or block effect, or blockbroken. 
	if not foundEffect then return end
	
	task.spawn(function()
		local success, err = pcall(foundEffect, argumentData)
		if not success then
			warn("Effect '" .. action .. "' failed: " .. err)
		end
	end)
end)

--[[
remotes.CameraShake.OnClientEvent:Connect(function(preset)
	if Settings.Get("LowCameraShakeMode") then
		return
	end
	
	local Camera = game.workspace.Camera

	local function ShakeCamera(shakeCf)
		Camera.CFrame = Camera.CFrame * shakeCf
	end

	-- Create CameraShaker instance:
	local renderPriority = Enum.RenderPriority.Camera.Value + 1
	local camShake = CameraShaker.new(renderPriority, ShakeCamera)

	camShake:Start()
	--local presetName = CameraShaker.Presets
	if preset then
		camShake:Shake(CameraShaker.Presets[preset])
	else
		camShake:Shake(CameraShaker.Presets.Bump)
	end
end)

remotes.Impact.OnClientEvent:Connect(function(s1,s2,sp,dr,pos,rot,cf) --In Client Effects
	fxModule:Impact(s1,s2,sp,dr,pos,rot,cf)
	--print("ImpactDone")
end)

remotes:WaitForChild("Shockwave").OnClientEvent:Connect(function(cf,radisu,endrad, startwidth, endwidth, startspeed, endspeed, pop, endt, midtarns, duratio)
	fxModule:ShockWave(cf, radisu, endrad, startwidth, endwidth, startspeed, endspeed, pop, endt, midtarns, duratio)
	--print("ShockWaveDone")
end)

local cam = workspace.CurrentCamera

remotes.ChangeCameraCFrame.OnClientEvent:Connect(function(newCFrame: CFrame)
	cam.CFrame = newCFrame
end)
]]
