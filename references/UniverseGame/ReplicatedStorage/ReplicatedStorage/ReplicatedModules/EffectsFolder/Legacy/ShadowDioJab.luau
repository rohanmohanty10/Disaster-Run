  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), TweenService (copy)
    local lookVector = p1.CFrame.lookVector;
    local v4 = ReplicatedStorage["Client Assets"].ShadowDio.Jab:Clone();
    local v5;

    if p2 == "Crouching" then
        v4.CFrame = p1.CFrame:ToWorldSpace(CFrame.new(-0.8, -0.4, 0));
        v5 = CFrame.new(v4.Position + lookVector * 7, p1.Position + lookVector * 9 - Vector3.new(0, 0.8, 0));
    else
        v4.CFrame = p1.CFrame:ToWorldSpace(CFrame.new(-1, 0.2, 0));
        v5 = CFrame.new(v4.Position + lookVector * 6, p1.Position + lookVector * 8);
    end;

    local v6 = ParticleHandler.GetUnusualHSVData({
        Player = p3.Player,
        Character = p3.Character
    });

    if v6 ~= nil then
        v4.Color = ParticleHandler.HSVShift(v4.Color, v6);
    end;

    v4.Parent = workspace.Effects;
    TweenService:Create(v4, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = v4.Size * Vector3.new(0.8, 0.8, 0.01),
        CFrame = v5
    }):Play();
    TweenService:Create(v4, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play();
    game.Debris:AddItem(v4, 0.35);
end;