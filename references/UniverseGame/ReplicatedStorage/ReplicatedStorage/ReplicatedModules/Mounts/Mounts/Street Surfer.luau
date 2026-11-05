  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Tween = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

return {
    Inherit = "Bike",
    ItemId = "MOUNT_57",
    Animator = "StreetSurferAnimator",
    MovementProperties = {
        MAX_SPEED = 65,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 0.75,
        MOTIONAL_DECELERATION = 0.2
    },

    OnSetup = function(p1) -- Line: 32, Name: OnSetup
        -- upvalues: Tween (copy)
        p1.Character:FindFirstChild("HumanoidRootPart");
        p1.Model.PrimaryPart.Equip:Play();

        for _, child in p1.Model:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
                task.delay(0.16, function() -- Line: 44
                    -- upvalues: Tween (ref), child (copy)
                    Tween(child, 0.1, "Linear", "InOut", {
                        Transparency = 0
                    });
                end);
            end;
        end;
    end,

    OnDestroy = function(p2) -- Line: 50, Name: OnDestroy
        p2.Character:FindFirstChild("HumanoidRootPart");
        local _ = p2.Model.PrimaryPart;
    end,

    OnMove = function(u3, p4) -- Line: 58, Name: OnMove
        -- upvalues: ParticleHandler (copy), Tween (copy)
        local _ = u3.Model;
        local PrimaryPart = u3.Model.PrimaryPart;

        if u3.MovementLoop then
            u3.MovementLoop:Disconnect();
        end;

        if p4 then
            u3.MovementLoop = u3.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 68
                -- upvalues: u3 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.PlaybackSpeed = (Vector3.new(1, 0, 1) * u3.Character.HumanoidRootPart.Velocity).Magnitude / 78;
            end);
        end;

        ParticleHandler.EnableAllParticles(u3.Model, p4);
        Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
            Volume = p4 and 1.5 or 0
        });
    end
};