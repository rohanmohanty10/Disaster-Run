  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://72714133363378",
    looped = true,
    meta = {
        rarity = "Mythic"
    },
    sound = script.Sound,

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 12, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local script_Dance = script.Dance;
        local CFrame = script_Dance.CFrame;
        local v6 = script_Dance:Clone();
        v6.Name = "VekiVekiDanceVFX";
        local Descendants = v6:GetDescendants();
        table.insert(Descendants, v6);

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

        v6.Parent = workspace.Debris;
        v5:Add(v6);

        return v5;
    end
});