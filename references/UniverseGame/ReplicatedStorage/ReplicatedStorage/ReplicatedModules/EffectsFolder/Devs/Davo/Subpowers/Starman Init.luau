  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local u1 = TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u3 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

return function(u4, u5) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u3 (copy), u1 (copy), u2 (copy)
    local v6 = -3.5;
    local u7 = AssetHandler.CloneAsset(u5 and "Models/UT_Heart" or "Models/StarHolder", {
        AbilityName = "Davo_SubPower"
    });
    local v8;

    if u5 then
        v8 = u7.Root or u7;
    else
        v8 = u7;
    end;

    ParticleHandler.EnableAllParticles(u7, false);
    local HumanoidRootPart = u4.HumanoidRootPart;

    if u5 then
        u4:SetAttribute("ChromaUnusual", true);
        ParticleHandler.Chromaify(v8.Left, {
            Character = u4
        });
        ParticleHandler.Chromaify(v8.Right, {
            Character = u4
        });
    end;

    u7.Parent = workspace.Effects;
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, v6 - 1, 0);
    ParticleHandler.EnableAllParticles(u7, true);

    while HumanoidRootPart do
        if v6 >= 3.5 then
            v6 = 3.5;
            break;
        end;

        v6 = v6 + 0.165 * (task.wait() * 60);
        v8.CFrame = HumanoidRootPart.CFrame * (CFrame.Angles(0, math.rad(v6 * 100), 0) * CFrame.new(0, v6, -3));
    end;

    if not HumanoidRootPart then
        return;
    end;

    local u9 = TweenService:Create(v8, u3, {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, v6, 0)
    });
    local u10 = TweenService:Create(v8, u1, {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, v6 + 0.75, 0)
    });
    local u11 = TweenService:Create(v8, u2, {
        CFrame = HumanoidRootPart.CFrame
    });
    u9:Play();
    u9.Completed:Once(function() -- Line: 59
        -- upvalues: u9 (copy), u10 (copy)
        u9:Cancel();
        u10:Play();
    end);
    u10.Completed:Once(function() -- Line: 63
        -- upvalues: u10 (copy), u11 (copy)
        u10:Clone();
        u11:Play();
    end);
    u11.Completed:Once(function() -- Line: 67
        -- upvalues: u7 (copy), u5 (copy), u4 (copy)
        u7:Destroy();

        if u5 then
            u4:SetAttribute("ChromaUnusual", nil);
        end;
    end);
end;