  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 21
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), LocalPlayer (copy), CurrentCamera (copy), u1 (copy), TweenService (copy), RunService (copy)
    local v3 = p2 or {};
    local Player = v3.Player;
    local Character = v3.Character;
    local Origin = v3.Origin;
    local v4 = v3.Speed or 75;
    local Positions = v3.Positions;
    table.insert(Positions, Origin.Position);
    EffectsHandler.CallEffect("SK_VANISH", {
        AffectStands = true,
        Transparency = 1,
        Character = Character,
        TweenInfo = { 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }
    });
    local v5 = AssetHandler.GetAbilityData(Character);
    local v6 = AssetHandler.CloneAsset("Particles/DeadCalm/WaterTrail", v5);
    ParticleHandler.Unusualify(v6, {
        Player = Player,
        Character = Character
    });
    v6.Position = Origin.Position;
    v6.Parent = workspace.Effects;
    local v7;

    if LocalPlayer == Player then
        v7 = Instance.new("Part");
        v7.Anchored = true;
        v7.Transparency = 1;
        v7.CFrame = Origin;
        v7.Parent = workspace.Effects;
        task.delay(10, v7.Destroy, v7);
        CurrentCamera.CameraSubject = v7;
        v7.AncestryChanged:Connect(function(p8, p9) -- Line: 60
            -- upvalues: CurrentCamera (ref), Character (copy)
            if not p9 then
                CurrentCamera.CameraSubject = Character.Humanoid;
            end;
        end);
    else
        v7 = nil;
    end;

    local Position = Origin.Position;
    local v10 = u1:NextNumber() * 3.141592653589793 * 2;
    local v11 = 0;

    for _, v in ipairs(Positions) do
        local v12 = v - Position;
        local Magnitude = v12.Magnitude;

        if Magnitude >= 0.1 and Magnitude >= 0.1 then
            local Unit = v12.Unit;
            local v13 = Unit:Cross(Vector3.new(0, 1, 0));

            if v13.Magnitude < 0.01 then
                v13 = Unit:Cross(Vector3.new(1, 0, 0));
            end;

            local Unit2 = v13.Unit;
            local Unit3 = Unit2:Cross(Unit).Unit;
            local v14 = math.clamp(Magnitude / 30, 0.15, 1);
            local v15 = {
                {
                    Freq = u1:NextNumber(1.5, 2),
                    Amp = u1:NextNumber(4, 6) * v14,
                    Phase = u1:NextNumber() * 3.141592653589793 * 2
                },
                {
                    Freq = u1:NextNumber(2, 3),
                    Amp = u1:NextNumber(2, 4) * v14,
                    Phase = u1:NextNumber() * 3.141592653589793 * 2
                },
                {
                    Freq = u1:NextNumber(0.7, 1.5),
                    Amp = u1:NextNumber(3, 5) * v14,
                    Phase = u1:NextNumber() * 3.141592653589793 * 2
                }
            };
            local v16 = math.clamp(Magnitude / v4, 0.04, 0.4);
            local v17 = os.clock();

            if v7 then
                v7.CFrame = CFrame.new(Position, v);
                TweenService:Create(v7, TweenInfo.new(v16, Enum.EasingStyle.Linear), {
                    CFrame = v7.CFrame * CFrame.new(0, 0, -Magnitude)
                }):Play();
            end;

            while true do
                local v18 = (os.clock() - v17) / v16;
                local v19 = math.clamp(v18, 0, 1);
                local v20 = math.pow(v19, 2) * (3 - v19 * 2);
                local v21 = Position:Lerp(v, v20);
                local v22 = math.sin(v20 * 3.141592653589793);
                local v23 = 0;
                local v24 = 0;

                for _, v2 in v15 do
                    local v25 = v10 + v2.Phase + v20 * v2.Freq * 3.141592653589793 * 2;
                    v23 = v23 + math.sin(v25) * v2.Amp;
                    v24 = v24 + math.cos(v25) * v2.Amp * 0.5;
                end;

                local v26 = v21 + Unit2 * (v23 * v22) + Unit3 * (v24 * v22);
                v6.Position = v26;

                if os.clock() - v11 > 0.08 then
                    v11 = os.clock();
                    local u27 = v26 + Unit2 * u1:NextNumber(-2, 2) + Unit3 * u1:NextNumber(-1, 1);
                    local v28 = math.clamp(Magnitude / 25, 0.2, 1);
                    local u29 = u27 + Unit * (u1:NextNumber(9, 18) * v28) + Unit2 * u1:NextNumber(-4, 4) * v28 + Unit3 * u1:NextNumber(-2, 2) * v28;
                    local u30 = (u27 + u29) / 2 + Unit2 * u1:NextNumber(-15, 15) * v28 + Unit3 * u1:NextNumber(1.5, 7) * v28;
                    local u31 = u1:NextNumber(0.1, 0.26);
                    local u32 = AssetHandler.CloneAsset("Particles/DeadCalm/SplashTrail", v5);
                    u32.Position = u27;
                    u32.Parent = workspace.Effects;
                    task.spawn(function() -- Line: 146
                        -- upvalues: u31 (copy), u32 (copy), u27 (copy), u30 (copy), u29 (copy), RunService (ref), ParticleHandler (ref)
                        local v33 = os.clock();

                        while true do
                            local v34 = (os.clock() - v33) / u31;
                            local v35 = math.clamp(v34, 0, 1);
                            local v36 = math.pow(v35, 2) * (3 - v35 * 2);
                            u32.Position = (1 - v36) ^ 2 * u27 + 2 * (1 - v36) * v36 * u30 + v36 ^ 2 * u29;

                            if v36 >= 1 then
                                break;
                            end;

                            RunService.Heartbeat:Wait();
                        end;

                        ParticleHandler.EnableAllParticles(u32, false);
                        ParticleHandler.DestroyEmit(u32);
                    end);
                end;

                if v20 >= 1 then
                    break;
                end;

                RunService.Heartbeat:Wait();
            end;

            v10 = v10 + u1:NextNumber(1, 3);
            Position = v;
        end;
    end;

    EffectsHandler.CallEffect("SK_VANISH", {
        AffectStands = true,
        Transparency = 0,
        Character = Character,
        TweenInfo = { 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }
    });

    if v7 then
        v7:Destroy();
    end;

    ParticleHandler.EnableAllParticles(v6, false);
    ParticleHandler.DestroyEmit(v6);
end;