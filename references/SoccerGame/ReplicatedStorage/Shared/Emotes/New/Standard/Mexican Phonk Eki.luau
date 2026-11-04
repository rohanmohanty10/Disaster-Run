  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://77240157104153",
    looped = true,
    meta = {
        rarity = "Mythic"
    },
    sound = script.Sound,

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 12, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local v6 = script["Phoenix Breeze"];
        local CFrame = v6.CFrame;
        local v7 = v6:Clone();
        v7.Name = "MexicanPhonkEkiVFX";
        local Descendants = v7:GetDescendants();
        table.insert(Descendants, v7);

        for _, v in Descendants do
            if v:IsA("BasePart") then
                v.CFrame = HumanoidRootPart.CFrame * CFrame:ToObjectSpace(v.CFrame);
                v.Anchored = false;
                v.CanCollide = false;
                v.CanTouch = false;
                v.CanQuery = false;
                v.Massless = true;
                Essentials:Weld(HumanoidRootPart, v, v);
            end;
        end;

        v7.Parent = workspace.Debris;
        v5:Add(v7);

        return v5;
    end
});