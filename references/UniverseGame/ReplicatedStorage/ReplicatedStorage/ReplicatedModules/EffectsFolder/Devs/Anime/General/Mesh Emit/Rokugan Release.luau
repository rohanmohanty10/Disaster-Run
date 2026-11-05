  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Random.new();

return function(u2) -- Line: 9
    -- upvalues: EffectsHandler (copy), u1 (copy), TweenService (copy)
    task.spawn(function() -- Line: 10
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (ref), TweenService (ref)
        local CallEffect = EffectsHandler.CallEffect;
        local Mesh2 = script.Mesh2;
        local Angles = CFrame.Angles;
        local v3 = u1:NextNumber(-360, 360);
        local v4 = CallEffect("MeshFlipbook", Mesh2, u2 * Angles(0, math.rad(v3), 0), script.texture["10"], u1:NextNumber(25, 35), workspace.Effects, Color3.fromRGB(0, 1000, 2555), 0.2);
        v4:FindFirstChild("Mesh").Scale = Vector3.new(2, 2, 2);
        TweenService:Create(v4:FindFirstChild("Mesh"), TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = Vector3.new(3, 6, 3)
        }):Play();
        EffectsHandler.Wait(0.1);
        TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v4.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, -10, 0)
        }):Play();
    end);
    task.spawn(function() -- Line: 33
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (ref), TweenService (ref)
        local CallEffect = EffectsHandler.CallEffect;
        local Mesh2 = script.Mesh2;
        local Angles = CFrame.Angles;
        local v5 = u1:NextNumber(-360, 360);
        local v6 = CallEffect("MeshFlipbook", Mesh2, u2 * Angles(0, math.rad(v5), 0), script.texture["10"], u1:NextNumber(25, 35), workspace.Effects, Color3.fromRGB(2555, 0, 1000), 0.2);
        TweenService:Create(v6:FindFirstChild("Mesh"), TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = Vector3.new(4, 5, 4)
        }):Play();
        EffectsHandler.Wait(0.1);
        TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v6.CFrame * CFrame.new(0, 20, 0) * CFrame.Angles(0, -10, 0)
        }):Play();
    end);
    task.spawn(function() -- Line: 55
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (ref), TweenService (ref)
        local CallEffect = EffectsHandler.CallEffect;
        local Mesh2 = script.Mesh2;
        local Angles = CFrame.Angles;
        local v7 = u1:NextNumber(-360, 360);
        local v8 = CallEffect("MeshFlipbook", Mesh2, u2 * Angles(0, math.rad(v7), 0), script.texture["16"], u1:NextNumber(25, 35), workspace.Effects, Color3.fromRGB(2555, 0, 1000), 0.2);
        TweenService:Create(v8:FindFirstChild("Mesh"), TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = Vector3.new(2, 6, 2)
        }):Play();
        EffectsHandler.Wait(0.1);
        TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v8.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(0, -12, 0)
        }):Play();
    end);
    task.spawn(function() -- Line: 77
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (ref), TweenService (ref)
        local CallEffect = EffectsHandler.CallEffect;
        local Mesh2 = script.Mesh2;
        local Angles = CFrame.Angles;
        local v9 = u1:NextNumber(-360, 360);
        local v10 = CallEffect("MeshFlipbook", Mesh2, u2 * Angles(0, math.rad(v9), 0), script.texture["15"], u1:NextNumber(15, 25), workspace.Effects, Color3.fromRGB(0, 1000, 2555), 0.2);
        TweenService:Create(v10:FindFirstChild("Mesh"), TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = Vector3.new(5, 3, 5)
        }):Play();
        EffectsHandler.Wait(0.1);
        TweenService:Create(v10, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v10.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, -60, 0)
        }):Play();
    end);
    task.spawn(function() -- Line: 99
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (ref), TweenService (ref)
        local CallEffect = EffectsHandler.CallEffect;
        local Mesh2 = script.Mesh2;
        local Angles = CFrame.Angles;
        local v11 = u1:NextNumber(-360, 360);
        local v12 = CallEffect("MeshFlipbook", Mesh2, u2 * Angles(0, math.rad(v11), 0), script.texture["16"], 18, workspace.Effects, Color3.fromRGB(2555, 2555, 2555), 0.85);
        v12:FindFirstChild("Mesh").Scale = Vector3.new(1, 3, 1);
        TweenService:Create(v12:FindFirstChild("Mesh"), TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(7, 6, 7)
        }):Play();
        TweenService:Create(v12:FindFirstChild("Decal"), TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        EffectsHandler.Wait(0.1);
        TweenService:Create(v12, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v12.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 1.7453292519943295, 0)
        }):Play();
    end);
    task.spawn(function() -- Line: 125
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (ref), TweenService (ref)
        local CallEffect = EffectsHandler.CallEffect;
        local Mesh2 = script.Mesh2;
        local Angles = CFrame.Angles;
        local v13 = u1:NextNumber(-360, 360);
        local v14 = CallEffect("MeshFlipbook", Mesh2, u2 * Angles(0, math.rad(v13), 0), script.texture["16"], 20, workspace.Effects, Color3.fromRGB(2555, 2555, 2555), 0.85);
        v14:FindFirstChild("Mesh").Scale = Vector3.new(1, 3, 1);
        TweenService:Create(v14:FindFirstChild("Mesh"), TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(3, 10, 3)
        }):Play();
        TweenService:Create(v14:FindFirstChild("Decal"), TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        EffectsHandler.Wait(0.1);
        TweenService:Create(v14, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v14.CFrame * CFrame.new(0, 20, 0) * CFrame.Angles(0, 1.7453292519943295, 0)
        }):Play();
    end);
end;