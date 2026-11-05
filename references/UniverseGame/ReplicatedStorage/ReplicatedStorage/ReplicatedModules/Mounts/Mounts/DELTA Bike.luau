  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Xeno Genesis 1-X",
    Animator = "DeltaBikeAnimator",
    ItemId = "MOUNT_55",
    MovementProperties = {
        MAX_SPEED = 97.5,
        FOV_SHIFT = 40,
        MOTIONAL_ACCELERATION = 1.85,
        CHARACTER_TILT_MULTIPLIER = -1.2,
        ROTATIONAL_ACCELERATION = 0.0725
    },

    OnSetup = function(p1) -- Line: 32, Name: OnSetup
        -- upvalues: Trove (copy)
        local Model = p1.Model;
        local Character = p1.Character;
        local u2 = Character:FindFirstChildOfClass("Humanoid");
        local PrimaryPart = Model.PrimaryPart;

        if u2 then
            local v3 = Trove.new();
            v3:AttachToInstance(Character);
            v3:AttachToInstance(p1.Model);
            u2:SetAttribute("OriginalHeight", u2.HipHeight);
            u2.HipHeight = 0.75;
            v3:Add(function() -- Line: 47
                -- upvalues: u2 (copy)
                u2.HipHeight = u2:GetAttribute("OriginalHeight");
                u2:SetAttribute("OriginalHeight", nil);
            end);
        end;

        PrimaryPart.Equip:Play();
        PrimaryPart.IdleLoop:Play();
    end,

    OnMove = function(u4, p5) -- Line: 57, Name: OnMove
        -- upvalues: ParticleHandler (copy), RunService (copy)
        local Model = u4.Model;
        local PrimaryPart = Model.PrimaryPart;
        ParticleHandler.EnableAllParticles(Model:FindFirstChild("BackLight") or PrimaryPart, p5);
        ParticleHandler.EnableAllParticles(Model:FindFirstChild("Exhaust") or PrimaryPart, p5);
        ParticleHandler.EnableAllParticles(PrimaryPart, p5);
        local PrimaryPart2 = u4.Model.PrimaryPart;

        if u4.MovementLoop then
            u4.MovementLoop:Disconnect();
        end;

        if p5 then
            u4.MovementLoop = u4.Trove:Connect(RunService.Heartbeat, function() -- Line: 72
                -- upvalues: u4 (copy), PrimaryPart2 (copy)
                PrimaryPart2.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u4.Character.HumanoidRootPart.Velocity).Magnitude / 45;
            end);
        end;

        PrimaryPart2.MovementLoop.Playing = p5;
        PrimaryPart2.Movement[p5 and "Play" or "Stop"](u4.Model.PrimaryPart.Movement);
    end
};