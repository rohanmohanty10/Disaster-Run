  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://74769507122673",
    looped = true,
    meta = {
        rarity = "Mythic"
    },
    sound = script.Sound,

    effect = function(p2) -- Line: 12, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v3 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local v4 = script["Cosmic Tentacles"];
        local WorldCFrame = v4.RootAttachment.WorldCFrame;
        local v5 = v4:Clone();
        v5.Name = "ComeWithMeVFX";
        local Descendants = v5:GetDescendants();
        table.insert(Descendants, v5);

        for _, v in Descendants do
            if v:IsA("BasePart") then
                v.CFrame = HumanoidRootPart.CFrame * WorldCFrame:ToObjectSpace(v.CFrame);
                v.Anchored = false;
                v.CanCollide = false;
                v.CanTouch = false;
                v.CanQuery = false;
                v.Massless = true;
                Essentials:Weld(HumanoidRootPart, v, v);
            end;
        end;

        v5.Parent = p2;
        v3:Add(v5);

        return v3;
    end
});