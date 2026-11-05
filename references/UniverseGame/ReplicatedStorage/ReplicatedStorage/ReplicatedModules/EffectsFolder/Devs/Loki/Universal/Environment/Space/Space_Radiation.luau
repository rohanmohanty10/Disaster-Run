  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("Lighting");
local _ = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local ClientUIOutput = PathShortcuts.RemotesPath:WaitForChild("ClientUIOutput");
local u1 = nil;

local function _(p2, p3) -- Line: 23
    return Random.new():NextNumber(p2, p3);
end;

local u4 = false;

return function(u5, p6) -- Line: 35
    -- upvalues: u1 (ref), u4 (ref), Trove (copy), ClientUIOutput (copy), EffectsHandler (copy)
    if not u5 or p6 == false then
        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        return;
    end;

    if u4 then
        return;
    end;

    local v7 = Trove.new();
    local u8 = true;
    v7:AttachToInstance(u5);
    v7:Add(function() -- Line: 52
        -- upvalues: u8 (ref)
        u8 = false;
    end);
    ClientUIOutput:Fire(
        "ShowSelfNotification",
        "<font color=\"rgb(255, 97, 49)\"><b>[WARNING]</b></font><br /><b>Lethal radiation exposure imminent.</b>",
        4
    );
    script.RadiationWarning:Play();
    u1 = v7;
    task.spawn(function() -- Line: 63
        -- upvalues: u4 (ref), u8 (ref), u5 (copy), EffectsHandler (ref), u1 (ref)
        local v9 = 0;
        u4 = true;

        while u8 do
            v9 = v9 + task.wait(0.5);

            if not u8 then
                break;
            end;

            local v10 = u5:GetAttribute("SpaceRadiation");

            if not v10 or v10 <= 95 then
                return;
            end;

            task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
                LifeTime = 0.2,
                Transparency = 0.5,
                TweenIn = { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut },
                TweenOut = { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut },
                Size = UDim2.fromScale(1.15, 1.15),
                Color = Color3.fromRGB(255, 113, 66),
                Color2 = Color3.fromRGB(255, 84, 84)
            });
        end;

        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        u4 = false;
    end);
end;