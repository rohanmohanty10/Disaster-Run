  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };

return function(p4, p5) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u3 (copy), u2 (copy), TweenService (copy), u1 (copy)
    local HumanoidRootPart = p4.HumanoidRootPart;
    local SkinName = p5.SkinName;
    local v6 = AssetHandler.GetAsset("Particles/Fever/Smoke", p5):Clone();
    v6.Parent = p4;
    ParticleHandler.AttachTo(v6, {
        Part = HumanoidRootPart,
        Offset = CFrame.new(0, 2.25, 5)
    });
    local v7;

    if SkinName == "Sanji" then
        v7 = AssetHandler.CloneAsset("Models/Fever/Rotation", p5);
        v7.Parent = p4;
        ParticleHandler.AttachTo(v7, {
            Part = p4.Torso,
            Offset = CFrame.new(0, 2.25, 0)
        });
        local v8 = AssetHandler.CloneAsset("Particles/Fever/TorsoWhirl", p5);
        v8.Parent = v7;
        ParticleHandler.AttachTo(v8, {
            Part = p4.Torso,
            Offset = CFrame.identity
        });
    else
        v7 = nil;
    end;

    local v9 = { Color3.new(1, 0.513725, 0.113725), Color3.new(1, 0.113725, 0.113725) };
    local v10 = 0;
    local v11 = 0;

    while true do
        v10 = v10 + task.wait();

        if v10 / 0.016666666666666666 >= 1 then
            v10 = v10 - 0.016666666666666666;
            local v12 = workspace:Raycast(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5, Vector3.new(0, -4, 0), u3);

            if v12 then
                local v13, v14, v15 = v12.Instance.Color:ToHSV();
                ParticleHandler.HSVShiftParticles(v6, {
                    Hue = v13,
                    Saturation = v14,
                    Value = v15
                });
            end;

            ParticleHandler.EnableParticles(v6, v12 ~= nil);

            if SkinName == "Sanji" then
                for _ = 1, 2 do
                    v11 = v11 + 1;
                    local v16 = math.random(1, 2) == 1 and -1 or 1;
                    local v17 = HumanoidRootPart.CFrame * CFrame.new(u2:NextNumber(-0.25, 3) * v16, u2:NextNumber(-2, 2) - 1, -12);
                    local v18 = HumanoidRootPart.CFrame * CFrame.new(u2:NextNumber(0.3, 0.75) * v16, u2:NextNumber(-1, 1) - 1, -5.5);
                    local v19 = AssetHandler.CloneAsset("Particles/Fever/SpectreLeg", p5);
                    v19.CFrame = CFrame.new(v18.Position, v17.Position) * CFrame.Angles(0, 3.141592653589793, 0);
                    v19.Size = v19.Size * u2:NextNumber(1, 1.2);
                    v19.Parent = workspace.Effects;
                    task.delay(ParticleHandler.GetMaxLifetime(v19), v19.Destroy, v19);
                    TweenService:Create(v19, TweenInfo.new(0.18, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Transparency = 1,
                        CFrame = v19.CFrame * CFrame.new(0, 0, u2:NextNumber(3.7, 5.25))
                    }):Play();

                    if v11 % 6 == 0 then
                        ParticleHandler.Emit(v19, ParticleHandler.GenerateEmitInfo(v19));
                    end;
                end;

                local v20 = u2:NextNumber(0, 6.283185307179586);
                local _ = CFrame.new(math.cos(v20), u2:NextNumber(0.25, 0.65), (math.sin(v20))).LookVector;
                local v21 = u1.Gura.Line:Clone();
                local CFrame2 = HumanoidRootPart.CFrame;
                local Angles = CFrame.Angles;
                local v22 = math.random(-360, 360);
                local v23 = math.rad(v22);
                local v24 = math.random(-360, 360);
                local v25 = math.rad(v24);
                local v26 = math.random(-360, 360);
                v21.CFrame = CFrame2 * Angles(v23, v25, (math.rad(v26)));
                v21.Color = v9[math.random(1, #v9)];
                local v27 = v21.Size.X * u2:NextNumber(1, 1.25);
                local v28 = v21.Size.Y * u2:NextNumber(0.9, 1.15);
                local v29 = v21.Size.Z * u2:NextNumber(1, 1.25);
                v21.Size = Vector3.new(v27, v28, v29) * 0.2;
                v21.Parent = workspace.Effects;
                task.delay(0.1, v21.Destroy, v21);
                TweenService:Create(v21, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0),
                    CFrame = v21.CFrame * CFrame.new(0, u2:NextNumber(49, 69) * 0.12, 0)
                }):Play();
            end;
        end;

        if not (p4:IsDescendantOf(game) and p4:GetAttribute("PerfumeFever")) then
            task.delay(ParticleHandler.EnableParticles(v6, false), v6.Destroy, v6);

            if v7 then
                task.delay(ParticleHandler.EnableParticles(v7, false), v7.Destroy, v7);
                TweenService:Create(v7, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                TweenService:Create(v7.Other, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;

            return;
        end;
    end;
end;