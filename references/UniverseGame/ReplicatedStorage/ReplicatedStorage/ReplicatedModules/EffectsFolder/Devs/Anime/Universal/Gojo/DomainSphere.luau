  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = ReplicatedStorage["Client Assets"];
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local u2 = {};
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local Trove = require(ReplicatedModules.KnitPackage.Trove);

return function(p3, u4) -- Line: 13
    -- upvalues: u2 (copy), Trove (copy), u1 (copy), TweenService (copy), RunService (copy), EffectsHandler (copy)
    if u2[p3] then
        u2[p3]:Destroy();
        u2[p3] = nil;

        return;
    end;

    if typeof(u4) ~= "CFrame" then
        return;
    end;

    local v5 = Trove.new();
    v5:AttachToInstance(p3);
    local u6 = u1.Gojo.DESphere:Clone();
    u6.CFrame = u4;
    u6.Parent = workspace.Effects;
    local u7 = v5:Clone(u1.Gojo.FXSphere);
    u7.CFrame = u4;
    u7.Parent = workspace.Effects;
    task.delay(1, u7.Destroy, u7);
    TweenService:Create(u7, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Transparency = 0,
        Size = u6.Size + Vector3.new(1, 1, 1)
    }):Play();
    task.delay(0.5, function() -- Line: 37
        -- upvalues: u6 (copy), TweenService (ref), u7 (copy)
        u6.Transparency = 0;
        TweenService:Create(u7, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = u6.Size + Vector3.new(10, 10, 10)
        }):Play();
    end);
    v5:Connect(RunService.RenderStepped, function() -- Line: 42
        -- upvalues: u6 (copy)
        local v8 = u6;
        v8.Orientation = v8.Orientation + Vector3.new(0.1, 0, 0.1);
    end);
    v5:Add(function() -- Line: 46
        -- upvalues: u6 (copy), EffectsHandler (ref), u4 (copy), TweenService (ref)
        if u6:IsDescendantOf(game) then
            task.delay(1, function() -- Line: 48
                -- upvalues: u6 (ref), EffectsHandler (ref), u4 (ref)
                u6:Destroy();
                EffectsHandler.CallEffect("Domain Shatter", u4);
            end);
            TweenService:Create(u6, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Color = Color3.new(1, 1, 1)
            }):Play();
            u6.Material = Enum.Material.Neon;
            local v9 = next;
            local v10, v11 = u6:GetChildren();

            for _, v in v9, v10, v11 do
                if v:IsA("Decal") then
                    TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Transparency = 0
                    }):Play();
                end;
            end;
        end;
    end);
    u2[p3] = v5;
end;