  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://96198169756628",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), EmitModule (copy)
        local v5 = Trove.new();
        local BlackholeDomain = ReplicatedStorage.Assets.Misc.BlackholeDomain;
        local u6 = BlackholeDomain.Part:Clone();
        u6:PivotTo(p2.HumanoidRootPart.CFrame * BlackholeDomain.HumanoidRootPart.CFrame:ToObjectSpace(u6:GetPivot()));
        u6.CanCollide = false;
        u6.Massless = true;
        u6.Anchored = false;
        u6.Transparency = 1;
        Essentials:Weld(p2.HumanoidRootPart, u6, u6);
        u6.Parent = workspace.Debris;
        task.delay(0.3333333333333333, function() -- Line: 31
            -- upvalues: EmitModule (ref), u6 (copy)
            EmitModule.emit(u6);
        end);
        v5:Add(u6);

        return v5;
    end
});