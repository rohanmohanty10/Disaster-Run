  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
local RunService = game:GetService("RunService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);
local u1 = {
    MAX_SPEED = 72.5,
    FOV_SHIFT = 27.5,
    MOTIONAL_ACCELERATION = 2.25
};

return {
    Inherit = "Bike",
    Animator = "KartAnimator",
    ItemId = "MOUNT_41",
    MovementProperties = u1,

    OnSetup = function(u2) -- Line: 31, Name: OnSetup
        -- upvalues: RunService (copy), u1 (copy), ParticleHandler (copy)
        local PrimaryPart = u2.Model.PrimaryPart;
        local v3 = Random.new();
        local v4 = v3:NextInteger(1, 360);
        local v5 = v3:NextInteger(1, 10) == 1;
        PrimaryPart.Layer1.Volume = 0.5;
        PrimaryPart.Layer2.Volume = 0;
        PrimaryPart.Layer3.Volume = 0;
        PrimaryPart.Layer4.Volume = 0;
        PrimaryPart.Layer1:Play();
        PrimaryPart.Idle:Play();
        PrimaryPart.Layer2:Play();
        PrimaryPart.Layer3:Play();
        PrimaryPart.Layer4:Play();

        if not u2.MovementLoop then
            u2.MovementLoop = u2.Trove:Connect(RunService.Heartbeat, function() -- Line: 49
                -- upvalues: u2 (copy), PrimaryPart (copy), u1 (ref)
                local Magnitude = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude;
                PrimaryPart.MovementSFX.Volume = math.clamp(Magnitude / u1.MAX_SPEED * 2, 0, 0.5);
                PrimaryPart.MovementSFX2.Volume = math.clamp(Magnitude / u1.MAX_SPEED * 3, 0, 0.25);
                PrimaryPart.Layer1.Volume = math.clamp(Magnitude / (u1.MAX_SPEED / 4), 0.5, 1);
                PrimaryPart.Layer2.Volume = math.clamp(Magnitude / (u1.MAX_SPEED / 4), 0, 1);
                PrimaryPart.Layer3.Volume = math.clamp(Magnitude / (u1.MAX_SPEED / 2), 0, 1);
                PrimaryPart.Layer4.Volume = math.clamp(Magnitude / u1.MAX_SPEED, 0, 1);
            end);
        end;

        if not v5 then
            for _, descendant in u2.Model:GetDescendants() do
                local v6;

                if descendant then
                    v6 = descendant:GetAttribute("ColorApply");
                else
                    v6 = descendant;
                end;

                local v7;

                if descendant then
                    v7 = descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail"));
                else
                    v7 = descendant;
                end;

                if v6 or v7 then
                    descendant.Color = ParticleHandler.HSVShift(descendant.Color, {
                        V2Shift = false,
                        HueShift = v4
                    });
                end;
            end;
        end;
    end,

    OnMove = function(p8, p9) -- Line: 75, Name: OnMove
        local PrimaryPart = p8.Model.PrimaryPart;
        local v10 = PrimaryPart.Layer1.TimePosition - 0.016666666666666666;
        PrimaryPart.Layer2.TimePosition = v10;
        PrimaryPart.Layer3.TimePosition = v10;
        PrimaryPart.Layer4.TimePosition = v10;

        if p9 and PrimaryPart.MovementSFX.TimePosition > PrimaryPart.MovementSFX.LoopRegion.Min then
            PrimaryPart.MovementSFX.TimePosition = 0;
            PrimaryPart.MovementSFX2.TimePosition = 0;
        end;

        PrimaryPart.MovementSFX.Playing = p9;
        PrimaryPart.MovementSFX2.Playing = p9;
        PrimaryPart.Idle.Playing = not p9;

        for _, descendant in p8.Model.Boosters.BoosterParts:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                if descendant.Parent.Name == "ImpactBurst" and p9 then
                    descendant:Emit(1);
                else
                    descendant.Enabled = p9;
                end;
            end;
        end;

        for _, descendant in p8.Model.Seat:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                local v11;

                if string.find(descendant.Parent.Name, "Drift") then
                    v11 = false;
                else
                    v11 = p9;
                end;

                descendant.Enabled = v11;
            end;
        end;
    end
};