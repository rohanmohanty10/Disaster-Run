  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://127179425265206",
    looped = true,
    meta = {
        rarity = "Mythic"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local HitTheJackpot = ReplicatedStorage.Assets.Misc.HitTheJackpot;
        local v6 = HitTheJackpot.DanceVFX:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame * HitTheJackpot.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = workspace.Debris;

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.Massless = true;
                Essentials:Weld(p2.HumanoidRootPart, descendant, descendant);
            end;
        end;

        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://115869696246143";
        Sound.Looped = true;
        Sound.Parent = p2.HumanoidRootPart;
        Sound:Play();
        v5:Add(Sound);
        v5:Add(v6);
        local v7 = HitTheJackpot.Highlight:Clone();
        v7.Parent = p2;
        v5:Add(v7);

        return v5;
    end
});