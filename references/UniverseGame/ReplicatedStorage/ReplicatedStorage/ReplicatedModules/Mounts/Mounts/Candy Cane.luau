  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Hoverboard",
    Animator = "HoverboardAnimator",
    ItemId = "MOUNT_50",
    MovementProperties = {
        MAX_SPEED = 80
    },

    OnSetup = function(p1) -- Line: 16, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(u2, p3) -- Line: 21, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableParticleTrails(u2.Model, p3);

        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        if p3 then
            u2.Model.PrimaryPart.Movement:Play();
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 31
                -- upvalues: u2 (copy)
                u2.Model.PrimaryPart.Loop.Volume = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude / 40;
            end);
        end;

        u2.Model.PrimaryPart.Loop.Playing = p3;
    end
};