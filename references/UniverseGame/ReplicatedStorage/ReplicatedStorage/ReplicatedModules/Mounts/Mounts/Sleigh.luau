  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Tween = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

local function EnableAllParticles(p1, p2, p3) -- Line: 17
    for _, descendant in p1:GetDescendants() do
        if (descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam"))) and (descendant.Name ~= p3 and descendant.Parent.Name ~= p3) then
            descendant.Enabled = p2;
        end;
    end;
end;

return {
    Inherit = "Bike",
    ItemId = "MOUNT_51",
    Animator = "SleighAnimator",
    MovementProperties = {
        MAX_SPEED = 70,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 0.75,
        MOTIONAL_DECELERATION = 0.2
    },

    OnSetup = function(p4) -- Line: 40, Name: OnSetup
        p4.Character:FindFirstChild("HumanoidRootPart");
        local _ = p4.Model.PrimaryPart;
        p4.Model.PrimaryPart.Equip:Play();
        p4.Model.PrimaryPart.IdleLoop.Playing = true;
        p4.Model.PrimaryPart.MovementLoop.Playing = true;
        p4.Model.PrimaryPart.MovementMusic.Playing = true;
        p4.Model.PrimaryPart.IdleMusicLoop.Playing = true;
    end,

    OnDestroy = function(p5) -- Line: 52, Name: OnDestroy
        p5.Character:FindFirstChild("HumanoidRootPart");
        local _ = p5.Model.PrimaryPart;
    end,

    OnMove = function(u6, p7) -- Line: 60, Name: OnMove
        -- upvalues: EnableAllParticles (copy), Tween (copy)
        local Model = u6.Model;
        local PrimaryPart = u6.Model.PrimaryPart;

        if u6.MovementLoop then
            u6.MovementLoop:Disconnect();
        end;

        if p7 then
            u6.MovementLoop = u6.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 70
                -- upvalues: u6 (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * u6.Character.HumanoidRootPart.Velocity).Magnitude;
                PrimaryPart.MovementLoop.Volume = Magnitude / 40;
                PrimaryPart.MovementMusic.Volume = Magnitude / 40;
            end);
        end;

        if p7 then
            PrimaryPart.Move:Play();
        end;

        EnableAllParticles(Model, p7, "Star");
        Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
            Volume = p7 and 0 or 2
        });
        Tween(PrimaryPart.IdleMusicLoop, 1, "Linear", "InOut", {
            Volume = p7 and 0 or 2
        });
        Tween(PrimaryPart.MovementMusic, 1, "Linear", "InOut", {
            Volume = p7 and 2 or 0
        });
        Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
            Volume = p7 and 2 or 0
        });
    end
};