  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref), RunService (copy), u3 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");

    if RunService:IsServer() then
        u3 = require(game.ServerScriptService.ServerLibrary.ProjectileData.Shared.AnyProjectile);
    end;
end);
local u4 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Oppressor = PathShortcuts.ClientAssets.Mounts.Effects.Oppressor;
local u5 = RunService:IsServer() and require(script:WaitForChild("Bezier"));

local function GetRandomMissile(p6) -- Line: 28
    return p6.Root.Missiles:FindFirstChild("Missile" .. math.random(1, 4));
end;

return {
    Type = "Hoverboard",
    Animator = "OppressorMKIIAnimator",
    Inherit = "Hoverboard",
    ItemId = "MOUNT_40",
    MovementProperties = {
        MAX_SPEED = 85,
        BACKWARD_MAX_SPEED = -40,
        MOTIONAL_ACCELERATION = 1.85,
        ROTATIONAL_ACCELERATION = 0.1,
        MOTIONAL_DECELERATION = 1
    },

    OnSetup = function(p7) -- Line: 44, Name: OnSetup
        -- upvalues: u1 (ref)
        local Model = p7.Model;

        if Model and Model.Name == "Oppressor MKII" then
            local v8 = math.random(1, 8);

            for _, child in Model.Root.Livery:GetChildren() do
                if child:IsA("BasePart") then
                    if v8 == 1 then
                        child.Color = Color3.fromRGB(0, 0, 0);
                    elseif v8 == 2 then
                        child.Color = Color3.fromRGB(163, 162, 165);
                        child.Material = Enum.Material.SmoothPlastic;
                    else
                        local v9 = Random.new();
                        local v10 = v9:NextNumber(0, 1);
                        local v11 = v9:NextNumber(0, 1);
                        local v12 = v9:NextNumber(0.5, 1);
                        child.Color = Color3.fromHSV(v10, v11, v12);
                    end;
                end;
            end;
        end;

        task.delay(1, u1.FireAllClients, "Oppressor_Setup", p7.Character);

        for _, v in { "Equip", "Loop", "Music" } do
            if Model.PrimaryPart:FindFirstChild(v) then
                Model.PrimaryPart[v]:Play();
            end;
        end;
    end,

    OnMove = function(p13, p14) -- Line: 78, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        if not p13.Model.PrimaryPart then
            return;
        end;

        local Character = p13.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local _ = Character.Humanoid;

        if p13.MovementLoop then
            p13.MovementLoop:Disconnect();
        end;

        local PrimaryPart = p13.Model.PrimaryPart;

        if p14 then
            p13.MovementLoop = p13.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 96
                -- upvalues: HumanoidRootPart (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * HumanoidRootPart.Velocity).Magnitude;

                if PrimaryPart:FindFirstChild("Movement") then
                    PrimaryPart.Movement.Volume = Magnitude / 40;
                end;
            end);
            ParticleHandler.Emit(PrimaryPart.Flame.Burst1, ParticleHandler.GenerateEmitInfo(PrimaryPart.Flame.Burst1));
            ParticleHandler.Emit(PrimaryPart.Flame.Burst2, ParticleHandler.GenerateEmitInfo(PrimaryPart.Flame.Burst2));
        end;

        if PrimaryPart:FindFirstChild("Movement") then
            PrimaryPart.Movement.Playing = p14;
        end;

        if PrimaryPart:FindFirstChild("Move") then
            PrimaryPart.WindLoop.Playing = p14;
        end;

        ParticleHandler.EnableAllParticles(PrimaryPart.Flame.Exhaust, p14);
    end,

    Skills = {
        Jump = function(u15, p16, p17) -- Line: 120, Name: Jump
            -- upvalues: ParticleHandler (copy), u2 (ref), u3 (ref), u4 (copy), u5 (copy), Oppressor (copy), u1 (ref)
            local Character = u15.Character;
            local HumanoidRootPart = Character.HumanoidRootPart;
            local _ = Character.Humanoid;
            local u18 = game:GetService("Players"):GetPlayerFromCharacter(Character);
            ParticleHandler.EnableAllParticles(u15.Model.Root.Wind, p16);
            task.delay(1, function() -- Line: 128
                -- upvalues: ParticleHandler (ref), u15 (copy)
                ParticleHandler.EnableAllParticles(u15.Model.Root.Wind, false);
            end);
            local v19 = { 22675525, 21141528 };

            if not u18 or Character:GetAttribute("Ran") then
                return;
            end;

            Character:SetAttribute("Ran", true);
            task.delay(1, function() -- Line: 141
                -- upvalues: Character (copy)
                Character:SetAttribute("Ran", false);
            end);

            if table.find(v19, u18.UserId) then
                local v20 = 1000000;
                local v21 = nil;
                local u22 = {
                    Distance = 20,
                    Damage = 35,
                    Ragdoll = {
                        Time = 2,
                        Intangible = false
                    },
                    Knockback = {
                        RelativePart = "TargetRootPart",
                        Time = 0.2,
                        Speed = 20,
                        Velocity = Vector3.new(0, 20, 0)
                    }
                };

                for _, v in u2.Hitbox({
                    Caster = Character,
                    Stats = {
                        Hitbox = {
                            Size = 50
                        }
                    }
                }) do
                    local Character2 = v.Character;
                    local v23;

                    if Character2 then
                        v23 = (Character2.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;
                    else
                        v23 = Character2;
                    end;

                    if Character2 and (v23 and v23 < v20) then
                        v21 = Character2;
                        v20 = v23;
                    end;
                end;

                if not v21 then
                    return;
                end;

                local HumanoidRootPart2 = v21:FindFirstChild("HumanoidRootPart");
                local u24 = u3.CreateUserData({
                    Character = Character,
                    Player = u18,
                    Stats = u22
                });
                u4:NextNumber(-15, 15);
                u4:NextNumber(-15, 15);
                local v25 = u15.Model.Root.Missiles:FindFirstChild("Missile" .. math.random(1, 4));
                local v26 = v25 and v25.CFrame * CFrame.new(0, 0, 1) or HumanoidRootPart.CFrame;
                local Magnitude = (HumanoidRootPart2.CFrame.Position - v26.Position).Magnitude;
                local u27 = nil;
                u5.CreateProjectile({
                    Waypoints = { v25.CFrame * CFrame.new(0, 0, 1), v25.CFrame * CFrame.new(u4:NextNumber(-30, 30), u4:NextNumber(0, 15), -Magnitude / 2), HumanoidRootPart2.CFrame },
                    EasingStyle = Enum.EasingStyle.Cubic,
                    EasingDirection = Enum.EasingDirection.Out,
                    Time = Magnitude / 75,
                    DisplayProjectile = Oppressor.Missile,

                    Callback = function(p28) -- Line: 218, Name: Callback
                        -- upvalues: HumanoidRootPart2 (copy), u24 (copy), u3 (ref), u27 (ref), u2 (ref), Character (copy), u1 (ref), Oppressor (ref), u18 (copy), u22 (copy)
                        p28.Tween:UpdateEndpoint(HumanoidRootPart2.CFrame.Position);
                        local Position = p28.Position;
                        u24.Position = Position;

                        if #u3.FindTargets(u24) <= 0 or u27 then
                            return;
                        end;

                        u27 = true;
                        local v29 = CFrame.new(Position);
                        local v30 = u2.Hitbox({
                            Caster = Character,
                            Stats = {
                                Size = 10,
                                Origin = v29
                            }
                        });
                        u1.FireAllClients("Emit Particle V3", {
                            Origin = v29,
                            Particle = Oppressor.Explosion,
                            Player = u18
                        });

                        for _, v in v30 do
                            u2.Attack({
                                Attacker = Character,
                                Target = v.Character,
                                Stats = u22
                            });
                        end;
                    end
                });
            end;
        end
    }
};