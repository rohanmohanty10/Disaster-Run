 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=89532403908041

-- ! Source from the asset above; the game may have edited it since.

--[=[
--[[
	InitLensFlare
	10/20/25
	@gluGPU
	
	Initiates the LensFlare Module.
--]]

local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local lensFlareDir = ReplicatedStorage.LensFlare
local LensFlare = require(lensFlareDir.Modules.LensFlare)
local Configuration = require(lensFlareDir.Configuration)

local camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer

local SUN_DISTANCE = 5000

local SUN_EXPOSURE_ADJUST = Configuration.SUN_EXPOSURE_ADJUSTMENT
local SUN_EXPOSURE_SMOOTH_TIME = Configuration.SUN_EXPOSURE_TIME

local SUN_BRIGHTNESS_THRESHOLD = Configuration.SUN_BRIGHTNESS_THRESHOLD
local SUN_ANGLE_THRESHOLD = Configuration.SUN_ANGLE_THRESHOLD

local up = vector.create(0, 1, 0)

-- Sun Lens Flare
local sunPart = Instance.new("Part")
sunPart.Anchored = true
sunPart.CanCollide = false
sunPart.CanQuery = false
sunPart.CanTouch = false
sunPart.Transparency = 0.5
sunPart.Size = vector.create(1, 1, 1)
sunPart.Name = "SunFlareTestPart"
sunPart.Parent = workspace

sunPart:SetAttribute("LensFlareStrength", 1)

local sunFlare = LensFlare.new(camera, "Default", sunPart)

local function updateColor()
	sunPart.Color = Lighting.ColorShift_Top
end

updateColor()
Lighting:GetPropertyChangedSignal("ColorShift_Top"):Connect(updateColor)

local function updateStrength()
	local sunAngle = Lighting:GetSunDirection().Y * 90
	local sunAlpha = math.clamp(sunAngle / SUN_ANGLE_THRESHOLD, 0, 1)
	local brightnessAlpha = math.clamp(Lighting.Brightness / SUN_BRIGHTNESS_THRESHOLD, 0, 1)
	local totalAlpha = sunAlpha * brightnessAlpha
	
	sunFlare.Enabled = totalAlpha > 0
	
	sunPart:SetAttribute("LensFlareStrength", totalAlpha)
end

updateStrength()
Lighting:GetPropertyChangedSignal("Brightness"):Connect(updateStrength)
Lighting:GetPropertyChangedSignal("ClockTime"):Connect(updateStrength)

RunService:BindToRenderStep("UpdateLensFlarePart", Enum.RenderPriority.Camera.Value + 9, function()
	sunPart.Position = camera.CFrame.Position + (Lighting:GetSunDirection() * SUN_DISTANCE)
end)

local alpha, vel = 0, 0
RunService:BindToRenderStep("UpdateExposure", Enum.RenderPriority.Camera.Value + 11, function(delta: number)
	Lighting.ExposureCompensation -= (alpha * SUN_EXPOSURE_ADJUST)
	alpha, vel = TweenService:SmoothDamp(alpha, sunFlare.Alpha^2, vel, SUN_EXPOSURE_SMOOTH_TIME, nil, delta)
	Lighting.ExposureCompensation += (alpha * SUN_EXPOSURE_ADJUST)
end)


local parts = {}
for _, part in CollectionService:GetTagged("LensFlare") do
	if part:IsA("BasePart") or part:IsA("Attachment") and not parts[part] then
		local flare = LensFlare.new(camera, part:GetAttribute("LensFlareStyle"), part)
		parts[part] = flare
	end
end

CollectionService:GetInstanceAddedSignal("LensFlare"):Connect(function(object: Instance)
	if object:IsA("BasePart") or object:IsA("Attachment") and not parts[object] then
		local flare = LensFlare.new(camera, object:GetAttribute("LensFlareStyle"), object)
		parts[object] = flare
	end
end)

CollectionService:GetInstanceRemovedSignal("LensFlare"):Connect(function(object: Instance)
	if parts[object] then
		parts[object]:Destroy()
		parts[object] = nil
	end
end)
]=]

 

local CollectionService = game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LensFlare = ReplicatedStorage.LensFlare;
local LensFlare2 = require(LensFlare.Modules.LensFlare);
local Configuration = require(LensFlare.Configuration);
local workspace_CurrentCamera = workspace.CurrentCamera;
local _ = Players.LocalPlayer;
local SUN_EXPOSURE_ADJUSTMENT = Configuration.SUN_EXPOSURE_ADJUSTMENT;
local SUN_EXPOSURE_TIME = Configuration.SUN_EXPOSURE_TIME;
local SUN_BRIGHTNESS_THRESHOLD = Configuration.SUN_BRIGHTNESS_THRESHOLD;
local SUN_ANGLE_THRESHOLD = Configuration.SUN_ANGLE_THRESHOLD;
local Part = Instance.new("Part");
Part.Anchored = true;
Part.CanCollide = false;
Part.CanQuery = false;
Part.CanTouch = false;
Part.Transparency = 0.5;
Part.Size = Vector3.new(1, 1, 1);
Part.Name = "SunFlareTestPart";
Part.Parent = workspace;
Part:SetAttribute("LensFlareStrength", 1);
local u1 = LensFlare2.new(workspace_CurrentCamera, "Default", Part);
Part.Color = Lighting.ColorShift_Top;
Lighting:GetPropertyChangedSignal("ColorShift_Top"):Connect(function() -- Line: 48, Name: updateColor
    -- upvalues: Part (copy), Lighting (copy)
    Part.Color = Lighting.ColorShift_Top;
end);

local function updateStrength() -- Line: 55
    -- upvalues: Lighting (copy), SUN_ANGLE_THRESHOLD (copy), SUN_BRIGHTNESS_THRESHOLD (copy), u1 (copy), Part (copy)
    local v2 = Lighting:GetSunDirection().Y * 90 / SUN_ANGLE_THRESHOLD;
    local v3 = math.clamp(v2, 0, 1) * math.clamp(Lighting.Brightness / SUN_BRIGHTNESS_THRESHOLD, 0, 1);
    u1.Enabled = v3 > 0;
    Part:SetAttribute("LensFlareStrength", v3);
end;

local v4 = Lighting:GetSunDirection().Y * 90 / SUN_ANGLE_THRESHOLD;
local v5 = math.clamp(v4, 0, 1) * math.clamp(Lighting.Brightness / SUN_BRIGHTNESS_THRESHOLD, 0, 1);
u1.Enabled = v5 > 0;
Part:SetAttribute("LensFlareStrength", v5);
Lighting:GetPropertyChangedSignal("Brightness"):Connect(updateStrength);
Lighting:GetPropertyChangedSignal("ClockTime"):Connect(updateStrength);
RunService:BindToRenderStep("UpdateLensFlarePart", Enum.RenderPriority.Camera.Value + 9, function() -- Line: 70
    -- upvalues: Part (copy), workspace_CurrentCamera (copy), Lighting (copy)
    Part.Position = workspace_CurrentCamera.CFrame.Position + Lighting:GetSunDirection() * 5000;
end);
local u6 = 0;
local u7 = 0;
RunService:BindToRenderStep("UpdateExposure", Enum.RenderPriority.Camera.Value + 11, function(p8: number) -- Line: 75
    -- upvalues: Lighting (copy), u6 (ref), SUN_EXPOSURE_ADJUSTMENT (copy), u7 (ref), TweenService (copy), u1 (copy), SUN_EXPOSURE_TIME (copy)
    local v9 = Lighting;
    v9.ExposureCompensation = v9.ExposureCompensation - u6 * SUN_EXPOSURE_ADJUSTMENT;
    local v10, v11 = TweenService:SmoothDamp(u6, u1.Alpha ^ 2, u7, SUN_EXPOSURE_TIME, nil, p8);
    u6 = v10;
    u7 = v11;
    local v12 = Lighting;
    v12.ExposureCompensation = v12.ExposureCompensation + u6 * SUN_EXPOSURE_ADJUSTMENT;
end);
local u13 = {};

for _, v in CollectionService:GetTagged("LensFlare") do
    if v:IsA("BasePart") or v:IsA("Attachment") and not u13[v] then
        u13[v] = LensFlare2.new(workspace_CurrentCamera, v:GetAttribute("LensFlareStyle"), v);
    end;
end;

CollectionService:GetInstanceAddedSignal("LensFlare"):Connect(function(p14: userdata) -- Line: 90
    -- upvalues: u13 (copy), LensFlare2 (copy), workspace_CurrentCamera (copy)
    if p14:IsA("BasePart") or p14:IsA("Attachment") and not u13[p14] then
        u13[p14] = LensFlare2.new(workspace_CurrentCamera, p14:GetAttribute("LensFlareStyle"), p14);
    end;
end);
CollectionService:GetInstanceRemovedSignal("LensFlare"):Connect(function(p15: userdata) -- Line: 97
    -- upvalues: u13 (copy)
    if u13[p15] then
        u13[p15]:Destroy();
        u13[p15] = nil;
    end;
end);