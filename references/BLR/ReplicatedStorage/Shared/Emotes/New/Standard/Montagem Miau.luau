  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://106569666081702",
    looped = true,
    meta = {
        rarity = "Mythic"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local Montagem = ReplicatedStorage.Assets.Misc.Montagem;
        local v6 = Montagem.Enable_Aura:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame * Montagem.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = workspace.Debris;
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v6.Parent = workspace.Debris;
        v5:Add(v6);
        local v7 = Montagem.HumanoidRootPart:Clone();
        v7:PivotTo(p2.HumanoidRootPart.CFrame);
        v7.Parent = workspace.Debris;
        v7.Anchored = false;
        v7.CanCollide = false;
        v7.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, v7, v7);
        v7.Parent = workspace.Debris;
        v5:Add(v7);
        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://73110745626575";
        Sound.Looped = true;
        Sound.Parent = p2.HumanoidRootPart;
        Sound:Play();
        v5:Add(Sound);

        return v5;
    end
});