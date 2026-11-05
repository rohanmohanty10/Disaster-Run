  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local CinematicClass = require(script.CinematicClass);
local FunctionUtils = require(script.CinematicClass.FunctionUtils);
local u1 = Random.new();

local function u4(p2, p3) -- Line: 33
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local function UseNumber(p5) -- Line: 37
    -- upvalues: u4 (copy)
    if typeof(p5) == "number" then
        return p5;
    end;

    return typeof(p5) ~= "NumberRange" and 0 or u4(p5.Min, p5.Max);
end;

local LocalPlayer = Players.LocalPlayer;

return function(p6, p7) -- Line: 49
    -- upvalues: Trove (copy), ParticleHandler (copy), CinematicClass (copy), UserInputService (copy), LocalPlayer (copy), FunctionUtils (copy), RunService (copy), TweenService (copy)
    if not (p7 and p7.Waypoints) then
        return;
    end;

    if #p7.Waypoints < 2 then
        warn("Need at least 2 waypoints");

        return;
    end;

    local u8 = Trove.new();
    local v9 = {};

    for i, v in p7.Waypoints do
        v9[i] = ParticleHandler.TranslateToCFrame(v);
    end;

    local v10 = p6.PrimaryPart and p6.PrimaryPart.CFrame or p6:GetPivot();
    local v11 = v10:ToObjectSpace(workspace.CurrentCamera.CFrame);

    if p7.StartOnCharacter then
        table.insert(v9, 1, v10 * v11);
    end;

    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    u8:Add(function() -- Line: 74
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    end);
    local v12 = CinematicClass.new(v9);
    u8:Add(v12);

    if p7.DisableUI then
        task.spawn(function() -- Line: 82
            -- upvalues: UserInputService (ref), LocalPlayer (ref), u8 (copy)
            if not UserInputService.TouchEnabled then
                local UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI");
                UI.Enabled = false;
                u8:Add(function() -- Line: 89
                    -- upvalues: UI (copy)
                    UI.Enabled = true;
                end);
            end;
        end);
    end;

    v12:BindToRenderStep("TestCinematic", Enum.RenderPriority.Camera.Value + 6, function(p13) -- Line: 96
        workspace.CurrentCamera.CFrame = p13;
    end);
    v12:Start({
        Duration = p7.Duration,
        EasingStyle = FunctionUtils.Math.EasingStyle[p7.EasingStyle or "Linear"],
        EasingDirection = FunctionUtils.Math.EasingDirection[p7.EasingDirection or "Out"]
    });
    v12.Signals.Ended:Wait();

    if p7.EndOnCharacter then
        local v14 = p7.EndDuration or 2;
        local v15 = Enum.EasingStyle[p7.EasingStyle or "Linear"];
        local v16 = Enum.EasingDirection[p7.EasingDirection or "Out"];
        local CFrame = workspace.CurrentCamera.CFrame;
        local v17 = 0;

        while v17 < v14 do
            v17 = v17 + RunService.RenderStepped:Wait();
            local v18 = math.clamp(v17 / v14, 0, 1);
            local v19 = p6.PrimaryPart and p6.PrimaryPart.CFrame or p6:GetPivot();
            workspace.CurrentCamera.CFrame = CFrame:Lerp(v19 * v11, TweenService:GetValue(v18, v15, v16));
        end;
    end;

    v12:Destroy();
    u8:Destroy();
end;