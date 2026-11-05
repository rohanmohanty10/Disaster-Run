  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 11
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), AssetHandler (copy)
    if not (p1 and p1:IsDescendantOf(game)) then
        return;
    end;

    local v3 = p2 or {};
    local v4 = {
        AbilityName = "Dragon Knight",
        SkinName = v3.SkinName
    };
    local v5 = 0;

    if v3.Player and (v3.Player:IsA("Player") and v3.Player.Data.Skin:GetAttribute("UnusualHueId")) then
        v5 = v5 + v3.Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local v6 = v3.Speed or 1;
    local v7 = v3.Origin or HumanoidRootPart.CFrame;

    if not v3.ParticleOffset then
        local _ = HumanoidRootPart.CFrame * CFrame.new(0, 0, -4);
    end;

    if not v3.Orientation then
        CFrame.Angles(0, 0, 0);
    end;

    if not p1:IsDescendantOf(game) then
        return;
    end;

    local v8 = {
        Igris = Color3.fromRGB(23, 25, 125),
        ["Frost Knight"] = Color3.fromRGB(110, 183, 217),
        ["Black Knight"] = Color3.fromRGB(25, 25, 25),
        Reinhardt = Color3.fromRGB(255, 117, 38)
    };
    local v9 = Random.new():NextNumber(0.11, 0.13);
    local _ = v9 * 60 * 1.3;
    local v10 = v8[v3.SkinName] or (v3.Color or Color3.fromRGB(255, 44, 16));

    if v5 > 0 then
        v10 = ParticleHandler.HSVShift(v10, {
            HueShift = v5
        });
    end;

    task.spawn(EffectsHandler.CallEffect, "FlipbookSlash", {
        SurfaceDirection = "Bottom",
        SlashMesh = AssetHandler.GetAsset("Particles/Slash/SlashMesh", v4),
        Flipbook = AssetHandler.GetAsset("Particles/Slash/SlashBook", v4),
        Origin = v7,
        Time = 0.15 / v6,
        Size = Vector3.new(v9, 0.15, v9) * 1.3,
        EndCFrame = v3.EndCFrame or CFrame.Angles(0, -1.5707963267948966, 0),
        Color = v10,
        DoWeld = v3.DoWeld
    });
end;