  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://111955433756506",
    maxWalkDistance = 2,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), VfxManager (copy)
        local v3 = Trove.new();
        local Head = p2:FindFirstChild("Head");

        if not Head then
            return v3;
        end;

        local u4 = ReplicatedStorage.Assets.Misc.grills1:Clone();
        u4.Weld.Part0 = Head;
        u4.Weld.Part1 = u4;
        u4.Parent = p2;
        VfxManager.Enable(u4, true);
        v3:Add(function() -- Line: 24
            -- upvalues: VfxManager (ref), u4 (copy)
            VfxManager.Enable(u4, false);
            task.delay(0.2, function() -- Line: 26
                -- upvalues: u4 (ref)
                u4:Destroy();
            end);
        end);

        return v3;
    end
});