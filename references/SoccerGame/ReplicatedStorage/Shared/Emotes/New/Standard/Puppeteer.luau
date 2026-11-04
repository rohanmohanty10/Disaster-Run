  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://115425258938026",
    looped = true,
    maxWalkDistance = 2,
    meta = {
        rarity = "Limited",
        continuousDisplay = true
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 14, Name: effect
        -- upvalues: Trove (copy), SoundService (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local v6 = script.Puppeteer:Clone();

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.Massless = true;
            end;
        end;

        local RootPart = v6.Main.RootPart;
        RootPart.MainWeld.Part1 = HumanoidRootPart;
        v6.Parent = workspace.Debris;
        v5:Add(v6);
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://77706591326495";
        local v7 = v6.Main.AnimationController.Animator:LoadAnimation(Animation);
        v7.Looped = true;
        v7:Play();
        v7.TimePosition = p3.TimePosition;
        v7:AdjustSpeed(p3.Speed);
        v5:Add(v7, "Stop");
        local Sound = RootPart.Sound;
        local DisplayEmotes = SoundService:FindFirstChild("DisplayEmotes");

        if p4 == "Game" or not DisplayEmotes then
            DisplayEmotes = SoundService.Emotes;
        end;

        Sound.SoundGroup = DisplayEmotes;
        Sound:Play();

        return v5;
    end
});