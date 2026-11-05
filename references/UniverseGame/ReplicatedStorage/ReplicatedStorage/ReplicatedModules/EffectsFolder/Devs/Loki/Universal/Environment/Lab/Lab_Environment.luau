  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local _ = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = nil;

local function _(p2, p3) -- Line: 23
    return Random.new():NextNumber(p2, p3);
end;

local LocalPlayer = Players.LocalPlayer;

return function(p4, p5) -- Line: 35
    -- upvalues: u1 (ref), Trove (copy), EffectsHandler (copy), LocalPlayer (copy), SoundService (copy)
    if not p4 then
        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        return;
    end;

    local u6 = Trove.new();
    local u7 = true;
    u6:Add(function() -- Line: 47
        -- upvalues: u7 (ref)
        u7 = false;
    end);
    u1 = u6;
    task.spawn(function() -- Line: 53
        -- upvalues: EffectsHandler (ref), LocalPlayer (ref), u6 (copy), SoundService (ref)
        local u8 = EffectsHandler.CallEffect("Ambience Music", {
            Sound = "rbxassetid://72048883139846",
            Volume = 0.12,
            TweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        });

        if LocalPlayer:GetAttribute("NoAmbienceMusic") then
            u8.Volume:set(0);
        end;

        u6:Connect(LocalPlayer:GetAttributeChangedSignal("NoAmbienceMusic"), function() -- Line: 64
            -- upvalues: LocalPlayer (ref), u8 (copy)
            local v9 = LocalPlayer:GetAttribute("NoAmbienceMusic") ~= nil;
            u8.Volume:set(v9 and 0 or 0.12);
        end);
        u6:Connect(LocalPlayer:GetAttributeChangedSignal("WormholeChamber"), function() -- Line: 69
            -- upvalues: LocalPlayer (ref), SoundService (ref)
            if LocalPlayer:GetAttribute("WormholeChamber") ~= nil then
                SoundService.AmbientReverb = Enum.ReverbType.Arena;

                return;
            end;

            SoundService.AmbientReverb = Enum.ReverbType.NoReverb;
        end);
        u6:Add(function() -- Line: 78
            -- upvalues: SoundService (ref)
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb;
        end);
        u6:Add(u8);
    end);
end;