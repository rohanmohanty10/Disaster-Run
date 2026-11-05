  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u3 = Knit.GetService("EffectService");

return {
    Type = "Bike",
    ItemId = "MOUNT_1",
    Animator = "BikeAnimator",
    Handler = "MainHandler",
    MovementProperties = {
        MAX_SPEED = 60,
        BACKWARD_MAX_SPEED = 0,
        ROTATIONAL_ACCELERATION = 0.05,
        MOTIONAL_ACCELERATION = 0.5,
        MOTIONAL_DECELERATION = 0.25
    },

    OnSetup = function(p4) -- Line: 54, Name: OnSetup
        local Model = p4.Model;

        if Model then
            Model.Body.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));
        end;
    end,

    OnDestroy = function(p5) -- Line: 61, Name: OnDestroy
    end,

    OnMove = function(u6, p7) -- Line: 64, Name: OnMove
        local Model = u6.Model;
        local Character = u6.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local Humanoid = Character.Humanoid;

        if u6.MovementLoop then
            u6.MovementLoop:Disconnect();
        end;

        local PrimaryPart = u6.Model.PrimaryPart;
        local u8 = { "MovementLoop", "MovementSFX" };

        if p7 then
            if not u6.LastBell then
                u6.LastBell = os.clock();
            end;

            u6.MovementLoop = u6.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 86
                -- upvalues: Model (copy), u6 (copy), PrimaryPart (copy), HumanoidRootPart (copy), Humanoid (copy), u8 (copy)
                if Model and (os.clock() - u6.LastBell > 16 and Model.Name == "Bike") then
                    u6.LastBell = os.clock();
                    PrimaryPart.Bell:Play();
                end;

                local Magnitude = (Vector3.new(1, 0, 1) * HumanoidRootPart.Velocity).Magnitude;

                if Model.Name == "Bike" then
                    PrimaryPart.Riding.Volume = Humanoid.FloorMaterial == Enum.Material.Air and 0 or Magnitude / 20;
                    PrimaryPart.Pedalling.Volume = Magnitude / 45;
                end;

                for _, v in u8 do
                    if PrimaryPart:FindFirstChild(v) then
                        PrimaryPart[v].Volume = Magnitude / 30;
                    end;
                end;
            end);
        end;

        if Model.PrimaryPart:FindFirstChild("MovementStart") then
            Model.PrimaryPart.MovementStart[p7 and "Play" or "Stop"](Model.PrimaryPart.MovementStart);
        end;

        if Model.Name == "Bike" then
            PrimaryPart.Riding.Playing = p7;
            PrimaryPart.Pedalling.Playing = p7;
        end;

        for _, v in u8 do
            if PrimaryPart:FindFirstChild(v) then
                PrimaryPart[v].Playing = p7;
            end;
        end;
    end,

    Skills = {
        Jump = function(p9, p10, p11) -- Line: 125, Name: Jump
            -- upvalues: u2 (copy), u1 (copy), u3 (copy)
            local Model = p9.Model;
            local Character = p9.Character;
            local HumanoidRootPart = Character.HumanoidRootPart;
            local _ = Character.Humanoid;

            if p10 then
                if Model.PrimaryPart:FindFirstChild("StartJump") then
                    Model.PrimaryPart.StartJump:Play();
                end;
            else
                if Model.PrimaryPart:FindFirstChild("JumpRelease") then
                    Model.PrimaryPart.JumpRelease:Play();
                end;

                local v12 = u2.RaycastMap(HumanoidRootPart.Position, (Vector3.new(0, -(p9.MountInfo.RaycastDown or 5), 0)));
                local v13 = u1.Misc.JumpFX:FindFirstChild(p9.Mount);

                if v12 and v13 then
                    u3.FireAllClients("Emit Particle V3", {
                        IgnoreUnusuals = true,
                        PlaySounds = true,
                        Origin = CFrame.new(v12.Position, v12.Position + v12.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0),
                        Particle = v13.Jump
                    });
                end;

                if v13 then
                    u3.FireAllClients("OnCharacterLand", Character, v13.Land, CFrame.Angles(-1.5707963267948966, 0, 0), 20, "Mount", true, p9.MountInfo.RaycastDown or 5);
                end;
            end;
        end
    },

    Callback = function(p14) -- Line: 12, Name: DefaultSetup
        -- upvalues: u1 (copy)
        local _ = p14.Player;
        local Character = p14.Character;
        local _ = p14.Cache;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v15 = p14.Trove:Clone(p14.MountInfo.Model or u1.Mounts[p14.Mount or "Bike"]);
        v15.Name = p14.Mount;
        v15.Parent = Character;
        v15:PivotTo(HumanoidRootPart.CFrame);
        v15.PrimaryPart.Motor6D.Part0 = HumanoidRootPart;

        for _, descendant in v15:GetDescendants() do
            if descendant:IsA("BasePart") then
                local CustomPhysicalProperties = descendant.CustomPhysicalProperties;

                if CustomPhysicalProperties then
                    descendant.CustomPhysicalProperties = PhysicalProperties.new(CustomPhysicalProperties.Density, CustomPhysicalProperties.Friction, 0, CustomPhysicalProperties.FrictionWeight, 100);
                end;
            end;
        end;

        return v15;
    end
};