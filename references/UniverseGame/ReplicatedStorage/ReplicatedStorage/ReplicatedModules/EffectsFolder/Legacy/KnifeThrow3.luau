  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3) -- Line: 10
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    if p1 == nil then
        return;
    end;

    for _ = 1, 4 do
        local v4 = nil;
        local v5 = nil;

        if p2 == "Left" then
            local Angles = CFrame.Angles;
            local v6 = math.random(20, 45);
            local v7 = math.rad(v6);
            local v8 = math.random(-105, -75);
            v4 = Angles(3.141592653589793, v7, (math.rad(v8)));
            v5 = CFrame.Angles(-0.8726646259971648, 0, 0);
        elseif p2 == "Right" then
            local Angles = CFrame.Angles;
            local v9 = math.random(-45, -20);
            local v10 = math.rad(v9);
            local v11 = math.random(-105, -75);
            v4 = Angles(3.141592653589793, v10, (math.rad(v11)));
            v5 = CFrame.Angles(0.8726646259971648, 0, 0);
        end;

        local v12 = AssetHandler.CloneAsset("Slash", {
            AbilityName = "ShadowDio",
            SkinName = p3.SkinName
        });
        v12.CFrame = p1.CFrame:ToWorldSpace(v4);
        local v13 = ParticleHandler.GetUnusualHSVData({
            Player = p3.Player,
            Character = p3.Character
        });

        if v13 ~= nil then
            v12.Color = ParticleHandler.HSVShift(v12.Color, v13);
        end;

        v12.Parent = workspace.Effects;
        TweenService:Create(v12, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
            Size = v12.Size * Vector3.new(0.01, 1.2, 1.2),
            CFrame = v12.CFrame:ToWorldSpace(v5)
        }):Play();
        TweenService:Create(v12, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        game.Debris:AddItem(v12, 0.4);
    end;
end;