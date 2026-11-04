  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/mountEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local u2 = {
    walk = "rbxassetid://75370103311503",
    idle = "rbxassetid://74878062155302"
};

local function switchSerpent(p3: table, p4: string) -- Line: 14
    for i, v in p3 do
        if i == p4 then
            if not v.IsPlaying then
                v:Play();
            end;
        else
            v:Stop();
        end;
    end;
end;

return v1({
    meta = {
        rarity = "Limited"
    },
    anims = {
        walk = "rbxassetid://111733420529551",
        idle = "rbxassetid://71780565746351"
    },

    init = function(p5, p6, p7) -- Line: 32, Name: init
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), u2 (copy), switchSerpent (copy)
        local v8 = Trove.new();
        local HumanoidRootPart = p5.HumanoidRootPart;
        local SerpentRider = ReplicatedStorage.Assets.Misc.SerpentRider;
        local v9 = SerpentRider.GreenSerpent:Clone();
        v9:PivotTo(HumanoidRootPart.CFrame * SerpentRider.HumanoidRootPart.CFrame:ToObjectSpace(v9.RootPart.CFrame));
        Essentials:Weld(HumanoidRootPart, v9.RootPart, v9);
        v9.Parent = p5;
        v8:Add(v9);
        local v10 = v9.AnimationController:FindFirstChildOfClass("Animator");
        local v11 = {};

        for i, v in u2 do
            local Animation = Instance.new("Animation");
            Animation.AnimationId = v;
            v8:Add(Animation);
            local v12 = v10:LoadAnimation(Animation);
            v12.Priority = Enum.AnimationPriority.Action4;
            v12.Looped = true;
            v8:Add(v12, "Stop");
            v11[i] = v12;
        end;

        local v13 = p7 == "Game" and "idle" or "walk";

        for i, v in p6 do
            if i ~= v13 then
                v:Stop();
            end;
        end;

        switchSerpent(v11, v13);

        return v8, v11;
    end,

    walk = function(p14, p15, p16) -- Line: 65, Name: walk
        -- upvalues: switchSerpent (copy)
        switchSerpent(p16, "walk");
    end,

    idle = function(p17, p18, p19) -- Line: 68, Name: idle
        -- upvalues: switchSerpent (copy)
        switchSerpent(p19, "idle");
    end
});