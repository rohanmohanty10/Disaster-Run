  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LightingManager = require(ReplicatedStorage.ReplicatedModules.Independent.LightingManager);
local _ = Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 13
    -- upvalues: LightingManager (copy), TweenService (copy)
    local v2 = p1 or {};
    local v3 = v2.Source and require(script[v2.Source]) or LightingManager.OriginalLighting;
    local v4 = v2.Target and require(script[v2.Target]) or LightingManager.OriginalLighting;
    local v5 = v2.EasingTime or 1;
    local v6 = v2.EasingStyle or "Linear";
    local v7 = v2.EasingDirection or "Out";
    local v8 = 0;
    local v9 = true;
    local v10 = {
        SourceHSVShift = v2.SourceHSVShift,
        TargetHSVShift = v2.TargetHSVShift
    };

    if v5 > 0 then
        LightingManager:Set(v3, nil, v10);

        while v9 do
            v8 = v8 + task.wait();
            local v11 = TweenService:GetValue(math.clamp(v8 / v5, 0, 1), v6, v7);

            if v11 >= 1 then
                LightingManager:Set(v4, nil, v10);
                v9 = false;
            else
                LightingManager:Transition(v3, v4, v11, v10);
            end;
        end;
    else
        LightingManager:Set(v4);
    end;
end;