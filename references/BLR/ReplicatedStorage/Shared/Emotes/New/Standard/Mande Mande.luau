  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://95310026990169",
    looped = true,
    meta = {
        rarity = "Mythic"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local MandeMande = ReplicatedStorage.Assets.Misc.MandeMande;
        local v6 = MandeMande.VFXPart:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame * MandeMande.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = workspace.Debris;
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v6.Parent = workspace.Debris;
        v5:Add(v6);
        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://121484500517987";
        Sound.Looped = true;
        Sound.Parent = p2.HumanoidRootPart;
        Sound:Play();
        v5:Add(Sound);
        local v7 = MandeMande.Highlight:Clone();
        v7.Parent = p2;
        v5:Add(v7);

        return v5;
    end
});