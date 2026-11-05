  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Type = "Hoverboard",
    Animator = "HoverboardAnimator",
    Inherit = "Bike",
    ItemId = "MOUNT_3",
    MovementProperties = {
        CHARACTER_TILT_MULTIPLIER = 2,
        MAX_SPEED = 70,
        BACKWARD_MAX_SPEED = -45,
        MOTIONAL_ACCELERATION = 1,
        ROTATIONAL_ACCELERATION = 0.075,
        MOTIONAL_DECELERATION = 1
    },

    OnSetup = function(p2) -- Line: 21, Name: OnSetup
        -- upvalues: ParticleHandler (copy), u1 (copy)
        local Model = p2.Model;

        if Model and Model.Name == "Hoverboard" then
            local v3 = Random.new();
            local v4 = v3:NextNumber(0, 1);
            local v5 = v3:NextNumber(0, 1);
            local v6 = v3:NextNumber(0.5, 1);
            local v7 = Color3.fromHSV(v4, v5, v6);
            Model.Neon.Color = v7;
            ParticleHandler.HSVShiftParticles(Model, {
                Hue = v4,
                Saturation = v5,
                Value = v6
            });
        end;

        task.delay(1, u1.FireAllClients, "Hoverboard Active", p2.Character);

        for _, v in { "Equip", "Loop", "Music" } do
            if Model.PrimaryPart:FindFirstChild(v) then
                Model.PrimaryPart[v]:Play();
            end;
        end;
    end,

    OnMove = function(p8, p9) -- Line: 45, Name: OnMove
        if not p8.Model.PrimaryPart then
            return;
        end;

        local Character = p8.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local _ = Character.Humanoid;

        if p8.MovementLoop then
            p8.MovementLoop:Disconnect();
        end;

        local PrimaryPart = p8.Model.PrimaryPart;

        if p9 then
            p8.MovementLoop = p8.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 63
                -- upvalues: HumanoidRootPart (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * HumanoidRootPart.Velocity).Magnitude;

                if PrimaryPart:FindFirstChild("Movement") then
                    PrimaryPart.Movement.Volume = Magnitude / 40;
                end;

                if PrimaryPart:FindFirstChild("WindLoop") then
                    PrimaryPart.WindLoop.Volume = Magnitude / 40;
                end;
            end);
        end;

        if PrimaryPart:FindFirstChild("Movement") then
            PrimaryPart.Movement.Playing = p9;
        end;

        if PrimaryPart:FindFirstChild("WindLoop") then
            PrimaryPart.WindLoop.Playing = p9;
        end;

        if PrimaryPart:FindFirstChild("Music") then
            PrimaryPart.Music.Playing = p9;
        end;
    end
};