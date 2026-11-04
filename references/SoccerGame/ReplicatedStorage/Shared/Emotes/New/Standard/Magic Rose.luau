  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://133447043164657",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = script.roserigged:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        Essentials:Weld(p2.HumanoidRootPart, v6.PrimaryPart, v6);
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://118264633637887";
        v6.Parent = p2.HumanoidRootPart;
        local v7 = v6.AnimationController.Animator:LoadAnimation(Animation);
        v7:Play();
        v7.TimePosition = p3.TimePosition;
        v7:AdjustSpeed(p3.Speed);
        v5:Add(v6);

        return v5;
    end
});