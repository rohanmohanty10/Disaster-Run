  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
game:GetService("CollectionService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Batbike",
    Animator = "MotorcycleAnimator",
    ItemId = "MOUNT_18",
    MovementProperties = {
        MAX_SPEED = 70,
        FOV_SHIFT = 15,
        MOTIONAL_ACCELERATION = 1.25
    },

    OnSetup = function(p1) -- Line: 29, Name: OnSetup
        p1.Model.PrimaryPart.Idle:Play();
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(u2, p3) -- Line: 34, Name: OnMove
        for _, descendant in u2.Model.PrimaryPart.BikeControlBone.Exhaust:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if descendant.Parent.Name == "ImpactBurst" and p3 then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                end;

                descendant.Enabled = p3;
            end;
        end;

        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        local PrimaryPart = u2.Model.PrimaryPart;

        if p3 then
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 58
                -- upvalues: u2 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude / 25;
            end);
        end;

        PrimaryPart.MovementLoop.Playing = p3;
        u2.Model.PrimaryPart.MoveStart[p3 and "Play" or "Stop"](u2.Model.PrimaryPart.MoveStart);
    end
};