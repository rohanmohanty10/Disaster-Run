  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://133618609432835",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, u3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local v5 = Trove.new();
        local ShootingStar = ReplicatedStorage.Assets.Misc.ShootingStar;
        local v6 = ShootingStar.Aura:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame * ShootingStar.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v6.Parent = workspace.Debris;
        v5:Add(v6);
        local u7 = ShootingStar.ShootingStars:Clone();
        u7:PivotTo(p2.HumanoidRootPart.CFrame * ShootingStar.HumanoidRootPart.CFrame:ToObjectSpace(u7:GetPivot()));
        Essentials:Weld(p2.HumanoidRootPart, u7, u7);
        u7.Parent = workspace.Debris;
        task.delay(4.5, function() -- Line: 30
            -- upvalues: u7 (copy), VfxManager (ref), u3 (copy)
            if not u7.Parent then
                return;
            end;

            VfxManager.Enable(u7, true);
            u3.TimePosition = 4.5;
            u3:AdjustSpeed(0);
        end);
        v5:Add(u7);

        return v5;
    end
});