  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

function RandSign()
    return math.random(0, 2) == 1 and -1 or 1;
end;

return function(p2) -- Line: 18
    -- upvalues: Players (copy), AssetHandler (copy), TweenService (copy), ParticleHandler (copy), u1 (copy), EffectsHandler (copy)
    local v3 = Players:GetPlayerFromCharacter(p2);
    local HumanoidRootPart = p2.HumanoidRootPart;
    local u4 = AssetHandler.GetAbilityData(v3 or p2);
    local u5 = 0;

    if v3 and v3.Data.Skin:GetAttribute("UnusualHueId") then
        u5 = u5 + v3.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local u6 = AssetHandler.CloneAsset("Particles/Infatuation/Heart", u4);
    u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 17.5, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
    u6.Parent = workspace.Effects;
    u6.Transparency = 1;
    TweenService:Create(u6, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play();

    if u5 > 0 then
        ParticleHandler.HSVShiftParticles(u6, {
            HueShift = u5
        });
        u6.Color = ParticleHandler.HSVShift(u6.Color, {
            HueShift = u5
        });
    end;

    ParticleHandler.Emit(u6.Container.Summon, ParticleHandler.GenerateEmitInfo(u6.Container.Summon));
    local v7 = os.clock();
    local v8 = os.clock();
    local v9 = os.clock();
    local CFrame2 = u6.CFrame;
    local v10 = {};
    local v11 = 0;

    for i = 1, 2 do
        local v12 = AssetHandler.CloneAsset("Particles/Infatuation/ArmFX", u4);
        v12.Parent = p2;

        if u5 > 0 then
            ParticleHandler.HSVShiftParticles(v12, {
                HueShift = u5
            });
        end;

        ParticleHandler.AttachTo(v12, {
            Part = p2[(i == 1 and "Left" or "Right") .. " Arm"],
            Offset = CFrame.identity
        });
        table.insert(v10, v12);
    end;

    local v13 = AssetHandler.CloneAsset("Particles/Infatuation/BurningArea", u4);
    v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    v13.Parent = workspace.Effects;

    if u5 > 0 then
        ParticleHandler.HSVShiftParticles(v13, {
            HueShift = u5
        });
    end;

    ParticleHandler.Emit(v13["SUMMON/DESUMMON"], ParticleHandler.GenerateEmitInfo(v13["SUMMON/DESUMMON"]));

    while true do
        local v14 = task.wait();
        CFrame2 = CFrame2 * CFrame.Angles(0, math.rad(100 * v14), 0);
        v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);

        if os.clock() - v7 > 0.3 then
            v11 = v11 + 4.71238898038469 * v14;

            if v11 >= 6.283185307179586 then
                v11 = v11 - 6.283185307179586;
            end;

            TweenService:Create(u6, TweenInfo.new(v14, Enum.EasingStyle.Linear), {
                CFrame = CFrame2 * CFrame.new(0, math.sin(v11) * 1.5, 0),
                Size = u6.Size + Vector3.new(0.17, 0.17, 0.17) * math.sin(v11)
            }):Play();
        end;

        if os.clock() - v8 > 0.3 then
            v8 = os.clock();
            task.spawn(function() -- Line: 114
                -- upvalues: AssetHandler (ref), u4 (copy), u5 (ref), ParticleHandler (ref), u1 (ref), u6 (copy), TweenService (ref)
                local v15 = AssetHandler.CloneAsset("Particles/Infatuation/Trail", u4);

                if u5 > 0 then
                    ParticleHandler.HSVShiftParticles(v15, {
                        HueShift = u5
                    });
                end;

                local v16 = u1:NextNumber(18, 25);
                local v17 = u1:NextNumber(-360, 360);
                local v18 = u1:NextNumber(-8, 8);
                local v19 = os.clock();
                local v20 = u1:NextNumber(1, 1.35);

                while v18 > -3 and v18 < 3 do
                    v18 = u1:NextNumber(-8, 8);
                end;

                local v21 = u1:NextNumber(-360, 360);
                local v22 = math.rad(v21);
                local CFrame3 = u6.CFrame;
                local Angles = CFrame.Angles;
                local v23 = u1:NextNumber(-360, 360);
                local v24 = math.rad(v23);
                local v25 = u1:NextNumber(-360, 360);
                local v26 = math.rad(v25);
                local v27 = u1:NextNumber(-360, 360);
                local v28 = CFrame3 * Angles(v24, v26, (math.rad(v27)));
                local new = CFrame.new;
                local v29 = math.rad(v17);
                local v30 = math.cos(v29) * v16;
                local v31 = math.rad(v17);
                v15.CFrame = v28 * new(v30, 0, math.sin(v31) * v16);
                v15.Parent = workspace.Effects;
                task.delay(v20 + 1, v15.Destroy, v15);
                local v32 = 0;

                while v15:IsDescendantOf(game) and (os.clock() - v19 <= v20 and u6:IsDescendantOf(game)) do
                    local v33 = task.wait();
                    v32 = v32 + v33;

                    if v32 >= 0.016666666666666666 then
                        v32 = v32 - 0.016666666666666666;
                        local v34 = TweenInfo.new(v33, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
                        local v35 = {};
                        local new2 = CFrame.new;
                        local v36 = math.rad(v17);
                        local v37 = math.cos(v36) * v16;
                        local v38 = math.rad(v17);
                        v35.CFrame = v28 * new2(v37, 0, math.sin(v38) * v16) * CFrame.Angles(0, v22, 0);
                        TweenService:Create(v15, v34, v35):Play();
                        v17 = v17 + v18;
                    end;
                end;

                for _, descendant in v15:GetDescendants() do
                    if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;

        if os.clock() - v9 > 0.8 then
            v9 = os.clock();
            ParticleHandler.Emit(u6.Container.Pulse, ParticleHandler.GenerateEmitInfo(u6.Container.Pulse));

            for _, v in v10 do
                ParticleHandler.Emit(v, ParticleHandler.GenerateEmitInfo(v));
            end;
        end;

        if not (p2:IsDescendantOf(game) and p2:GetAttribute("Infatuation")) then
            TweenService:Create(u6, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            ParticleHandler.Emit(u6.Container.Summon, ParticleHandler.GenerateEmitInfo(u6.Container.Summon));
            ParticleHandler.Emit(u6.Container.Explosion, ParticleHandler.GenerateEmitInfo(u6.Container.Explosion));
            task.delay(ParticleHandler.EnableParticles(u6, false), u6.Destroy, u6);
            task.delay(ParticleHandler.EnableParticles(v13, false), v13.Destroy, v13);
            TweenService:Create(u6.SpotLight, TweenInfo.new(2), {
                Brightness = 0
            }):Play();
            EffectsHandler.CallEffect("TweenBeams", v13, {
                Time = 0.35,
                EasingStyle = "ExitExpressive",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = NumberSequence.new(1)
                }
            });

            for _, v in v10 do
                task.delay(ParticleHandler.EnableParticles(v, false), v.Destroy, v);
            end;

            return;
        end;
    end;
end;