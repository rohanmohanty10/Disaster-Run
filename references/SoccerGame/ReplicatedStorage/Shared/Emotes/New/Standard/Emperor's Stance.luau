  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://129520381505076",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local v5 = Trove.new();
        local u6 = ReplicatedStorage.Assets.Misc.EmperorsStance:Clone();
        u6:PivotTo(p2:GetPivot());
        Essentials:Weld(u6.PrimaryPart, p2.HumanoidRootPart);
        VfxManager.Enable(u6, false);
        u6.Parent = p2;
        task.delay(0.4166666666666667, function() -- Line: 20
            -- upvalues: u6 (copy), VfxManager (ref)
            if u6 and u6.Parent then
                VfxManager.Enable(u6, true);
            end;
        end);
        v5:Add(function() -- Line: 27
            -- upvalues: u6 (copy), VfxManager (ref)
            if u6 and u6.Parent then
                VfxManager.Enable(u6, false);
                local u7 = u6;
                task.delay(0.75, function() -- Line: 31
                    -- upvalues: u7 (copy)
                    if u7 then
                        u7:Destroy();
                    end;
                end);
            end;
        end);

        return v5;
    end
});