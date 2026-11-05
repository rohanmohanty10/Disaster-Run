  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);
local u2 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u3 = {
    LowGain = 0,
    MidGain = 0,
    HighGain = 0
};
local u4 = {
    LowGain = 0,
    MidGain = -40,
    HighGain = -55
};

return {
    Inherit = "Hoverboard",
    Animator = "ZenithAnimator",
    ItemId = "MOUNT_16",

    OnSetup = function(p5) -- Line: 26, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        local Model = p5.Model;
        local PrimaryPart = Model.PrimaryPart;
        local v6 = Random.new();
        local v7 = v6:NextNumber(0, 1);
        local v8 = v6:NextNumber(0, 1);
        local v9 = v6:NextNumber(0.5, 1);
        local v10 = Color3.fromHSV(v7, v8, v9);

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Color = v10;
            end;
        end;

        ParticleHandler.HSVShiftParticles(Model, {
            Hue = v7,
            Saturation = v8,
            Value = v9
        });
        local Music = PrimaryPart:WaitForChild("Music", 3);

        if Music then
            Music:Play();
        end;
    end,

    OnMove = function(p11, p12) -- Line: 47, Name: OnMove
        -- upvalues: TweenService (copy), u2 (copy), u3 (copy), u4 (copy)
        if not p11.Model.PrimaryPart then
            return;
        end;

        local Character = p11.Character;
        local _ = Character.HumanoidRootPart;
        local _ = Character.Humanoid;
        local PrimaryPart = p11.Model.PrimaryPart;

        if p11.Tween then
            p11.Tween:Pause();
        end;

        local v13;

        if p12 then
            v13 = u3;
        else
            v13 = u4;
        end;

        p11.Tween = TweenService:Create(PrimaryPart.Music.EqualizerSoundEffect, u2, v13);
        p11.Tween:Play();
    end,

    Callback = function(p14) -- Line: 68, Name: Callback
        -- upvalues: u1 (copy)
        local _ = p14.Player;
        local Character = p14.Character;
        local _ = p14.Cache;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v15 = p14.Trove:Clone(p14.MountInfo.Model or u1.Mounts[p14.Mount or "Bike"]);
        v15.Name = p14.Mount;
        v15.Parent = Character;
        v15.PrimaryPart.Stand2Human.Part0 = HumanoidRootPart;

        return v15;
    end
};