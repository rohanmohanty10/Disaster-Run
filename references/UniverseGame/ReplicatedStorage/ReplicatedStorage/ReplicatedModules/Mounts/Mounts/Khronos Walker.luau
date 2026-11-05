  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u2 = Knit.GetService("EffectService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function ConstrainTo360(p3) -- Line: 13
    return (p3 % 360 + 360) % 360;
end;

local _ = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

return {
    Type = "Bike",
    Animator = "MechAnimator",
    Inherit = "Bike",
    ItemId = "MOUNT_56",
    MovementProperties = {
        MAX_SPEED = 83,
        FOV_SHIFT = 5,
        BACKWARD_MAX_SPEED = -25,
        ROTATIONAL_ACCELERATION = 0.05,
        MOTIONAL_ACCELERATION = 1,
        MOTIONAL_DECELERATION = 2.5,
        CHARACTER_TILT_MULTIPLIER = 0.35
    },

    Callback = function(p4) -- Line: 33, Name: Callback
        -- upvalues: u1 (copy)
        local _ = p4.Player;
        local Character = p4.Character;
        local _ = p4.Cache;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v5 = p4.Trove:Clone(u1.Mounts[p4.Mount]);
        v5.Name = p4.Mount;

        for _, descendant in v5:GetDescendants() do
            if descendant:IsA("BasePart") and not descendant.Name:lower():find("root") then
                descendant.CanCollide = false;
                descendant.Massless = true;
            end;

            if descendant:IsA("BasePart") then
                local CustomPhysicalProperties = descendant.CustomPhysicalProperties;

                if CustomPhysicalProperties then
                    descendant.CustomPhysicalProperties = PhysicalProperties.new(CustomPhysicalProperties.Density, CustomPhysicalProperties.Friction, 0, CustomPhysicalProperties.FrictionWeight, 100);
                end;
            end;
        end;

        v5:PivotTo(HumanoidRootPart.CFrame);
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Name = "MechRoot";
        Motor6D.C0 = CFrame.new(0, 5.895, -0.215);
        Motor6D.Part0 = HumanoidRootPart;
        Motor6D.Part1 = v5:FindFirstChild("Lower Torso", true);
        Motor6D.Parent = HumanoidRootPart;
        v5.Parent = Character;

        return v5;
    end,

    OnSetup = function(p6) -- Line: 73, Name: OnSetup
        -- upvalues: ParticleHandler (copy), u2 (copy)
        local _ = p6.Character;
        local Mech = p6.Model:FindFirstChild("Mech");
        ParticleHandler.EnableAllParticles(Mech:FindFirstChild("Limbs"), true);
        local PassiveAttachs = Mech:FindFirstChild("PassiveAttachs", true);

        if PassiveAttachs then
            ParticleHandler.EnableAllParticles(PassiveAttachs, true);
        end;

        local v7 = Mech:FindFirstChild("Light Neon", true);

        if v7 then
            ParticleHandler.EnableAllParticles(v7, true);
        end;

        local Collider = Mech:FindFirstChild("Collider", true);

        if Collider then
            task.defer(function() -- Line: 92
                -- upvalues: Collider (copy)
                Collider.CanCollide = true;
            end);
        end;

        u2.FireAllClients("MechInstructor", p6.Character, -1);
        u2.FireAllClients("MechSpawn", p6.Character);
        p6.Model.PrimaryPart.Equip:Play();
        p6.Model.PrimaryPart.IdleLoop:Play();
    end,

    OnDestroy = function(p8) -- Line: 104, Name: OnDestroy
        p8.Character:FindFirstChild("HumanoidRootPart");
    end,

    OnMove = function(p9, p10) -- Line: 115, Name: OnMove
        local _ = p9.Model;
        local _ = p9.Model.PrimaryPart;
    end,

    Skills = {
        Jump = function(p11, p12, p13) -- Line: 122, Name: Jump
            -- upvalues: ParticleHandler (copy), u2 (copy)
            local Model = p11.Model;
            local _ = p11.Model.PrimaryPart;
            local Character = p11.Character;
            local v14 = game:GetService("Players"):GetPlayerFromCharacter(Character);
            local Mech = Model:FindFirstChild("Mech");

            if p13 == 2 then
                if p12 then
                    local BoostAttachs = Mech:FindFirstChild("BoostAttachs", true);

                    if BoostAttachs then
                        ParticleHandler.Emit(BoostAttachs, ParticleHandler.GenerateEmitInfo(BoostAttachs));
                    end;

                    p11.Model.PrimaryPart.Boost:Play();
                    ParticleHandler.EnableAllParticles(Mech:FindFirstChild("TrailsAttachs", true), true);
                    task.delay(1.2, function() -- Line: 137
                        -- upvalues: Model (copy), ParticleHandler (ref), Mech (copy)
                        if not (Model and Model.Parent) then
                            return;
                        end;

                        ParticleHandler.EnableAllParticles(Mech:FindFirstChild("TrailsAttachs", true), false);
                    end);
                end;
            else
                u2.FireAllClientsExcept({ v14 }, "MechJump", p11.Character);
                u2.FireAllClientsExcept({ v14 }, "MechLand", Character, CFrame.Angles(-1.5707963267948966, 0, 0), 12.5, "Mount", true, 10, 0.75);
            end;
        end
    }
};