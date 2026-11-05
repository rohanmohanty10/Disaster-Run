  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenService (copy), ParticleHandler (copy), RunService (copy), u1 (copy)
    local v3 = p2 or {};
    local Player = v3.Player;
    local _ = v3.Speed;
    local Character = v3.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u4 = AssetHandler.GetAbilityData(Character);
    local Particle = EffectsHandler.CallEffect("Emit Particle V3", {
        Destroy = false,
        Path = "Particles/Whirlpool/Up",
        Player = Player,
        Origin = HumanoidRootPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
    }).Particle;
    local v5 = {};
    local u6 = { 17866633882, 17866635268, 17866635031, 17866634793, 17866634478, 17866636423, 17866636047, 7866635798, 17866635537, 17866637416, 17866637203, 17866637018, 17866636709, 17866638078, 17866637834, 17866637585 };

    for _, descendant in Particle:GetDescendants() do
        if descendant:IsA("Attachment") and descendant.Name ~= "Emit" then
            v5[descendant] = descendant.Position;
            descendant.Position = Vector3.new(0, 0, 0);
            TweenService:Create(descendant, TweenInfo.new(0.45), {
                Position = v5[descendant]
            }):Play();
        end;
    end;

    for _, descendant in Particle:GetDescendants() do
        if descendant:IsA("Beam") then
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 1,
                EasingStyle = "Quad",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Goal = {
                    TextureSpeed = 0,
                    Width1 = 0,
                    Width0 = 0,
                    Transparency = NumberSequence.new(1)
                }
            });
        end;
    end;

    task.delay(0.5, function() -- Line: 71
        -- upvalues: ParticleHandler (ref), Particle (copy)
        ParticleHandler.EnableAllParticles(Particle, false);
        ParticleHandler.DestroyEmit(Particle);
    end);
    local u7 = AssetHandler.CloneAsset("Particles/Whirlpool/SpinPart", u4);
    u7.CFrame = HumanoidRootPart.CFrame;
    u7.Parent = workspace.Effects;
    task.delay(5, u7.Destroy, u7);
    local u8 = nil;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 82
        -- upvalues: u7 (copy), u8 (ref)
        if not (u7 and u7:IsDescendantOf(game)) then
            u8:Disconnect();
            u8 = nil;

            return;
        end;

        local v10 = p9 * 60;
        local v11 = u7;
        v11.CFrame = v11.CFrame * CFrame.Angles(0, 0.2617993877991494 * v10, 0);
        local v12 = u7;
        v12.CFrame = v12.CFrame * CFrame.new(0, 0.8 * v10, 0);
    end);
    task.delay(0.5, u8.Disconnect, u8);
    local u13 = AssetHandler.CloneAsset("Particles/Whirlpool/WindReverseInside", u4);
    u13.CFrame = HumanoidRootPart.CFrame;
    u13.Parent = workspace.Effects;
    task.delay(5, u13.Destroy, u13);
    TweenService:Create(u13.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Scale = Vector3.new(0.359, 0.875, 0.359)
    }):Play();
    task.spawn(function() -- Line: 108
        -- upvalues: u6 (copy), u13 (copy), EffectsHandler (ref)
        for i = 1, #u6 do
            u13.Decal.Texture = "rbxassetid://" .. u6[i];
            EffectsHandler.Wait(0.4 / #u6);
        end;
    end);
    TweenService:Create(u13, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0), {
        CFrame = u13.CFrame * CFrame.Angles(0, 4, 0)
    }):Play();
    TweenService:Create(u13.Decal, TweenInfo.new(0.75), {
        Transparency = 1
    }):Play();
    task.spawn(function() -- Line: 124
        -- upvalues: AssetHandler (ref), u4 (copy), HumanoidRootPart (copy), u1 (ref), RunService (ref), ParticleHandler (ref), EffectsHandler (ref)
        local u14 = AssetHandler.GetAsset("Particles/Whirlpool/Trail", u4);

        if u14 then
            for _ = 1, 4 do
                task.spawn(function() -- Line: 129
                    -- upvalues: HumanoidRootPart (ref), u1 (ref), u14 (copy), RunService (ref), ParticleHandler (ref)
                    local v15 = HumanoidRootPart.CFrame * CFrame.new(u1:NextNumber(-5, 5), -15, u1:NextNumber(-5, 5));
                    local Angles = CFrame.Angles;
                    local v16 = u1:NextNumber(-360, 360);
                    local v17 = v15 * Angles(0, math.rad(v16), 0);
                    local v18 = 0;
                    local v19 = 90;

                    if math.random(0, 1) == 1 then
                        v19 = v19 * -1;
                    end;

                    local v20 = u14:Clone();
                    v20.CFrame = v17;
                    v20.Parent = workspace.Effects;

                    while v18 < 0.65 do
                        v18 = v18 + RunService.Heartbeat:Wait();
                        local v21 = v18 / 0.13;
                        local v22 = 10 - v21 * 6;
                        local v23 = v19 * v21;
                        local new = CFrame.new;
                        local v24 = math.rad(v23);
                        local v25 = v22 * math.sin(v24);
                        local v26 = math.rad(v23);
                        v20.CFrame = v17 * new(v25, v21 * 8 + 1, v22 * math.cos(v26)) * CFrame.new(0, 2, 0);
                    end;

                    ParticleHandler.EnableAllParticles(v20, false);
                    ParticleHandler.DestroyEmit(v20);
                end);
                EffectsHandler.Wait(0.06);
            end;
        end;
    end);

    for i = 1, 14 do
        local v27 = i / 14;
        local v28 = u1:NextNumber(0.75, 1.1) + v27 * 0.3;
        local v29 = u1:NextNumber(0.9, 4) + v27 * 0.4;
        local u30 = AssetHandler.CloneAsset("Particles/Whirlpool/Slash", u4);
        local v31 = u30.Mesh.Scale * Vector3.new(v28, v29, v28);
        local v32 = HumanoidRootPart.CFrame * CFrame.new(u1:NextNumber(-2, 2), u1:NextNumber(-2, 0.7), u1:NextNumber(-2, 2));
        local v33 = {};
        local v34 = u30.Decal.Color3.R * 255 * u1:NextNumber(0.95, 1.22);
        v33.R = math.round(v34);
        local v35 = u30.Decal.Color3.G * 255 * u1:NextNumber(0.95, 1.22);
        v33.G = math.round(v35);
        local v36 = u30.Decal.Color3.B * 255 * u1:NextNumber(1, 1.45);
        v33.B = math.round(v36);
        u30.Decal.Color3 = Color3.fromRGB(v33.R, v33.G, v33.B);
        u30.Decal.Transparency = u1:NextNumber(0.35, 0.7);
        local Angles = CFrame.Angles;
        local v37 = u1:NextNumber(-11, 11);
        local v38 = math.rad(v37);
        local v39 = u1:NextNumber(0, 360);
        local v40 = math.rad(v39);
        local v41 = u1:NextNumber(-11, 11);
        u30.CFrame = v32 * Angles(v38, v40, (math.rad(v41)));
        u30.Mesh.Scale = Vector3.new(0.01, 0.01, 0.01);
        u30.Parent = workspace.Effects;
        TweenService:Create(u30.Mesh, TweenInfo.new(u1:NextNumber(0.2, 0.45), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Scale = v31
        }):Play();
        local v42 = u1:NextNumber(0.65, 1);
        local v43 = v42 * u1:NextNumber(0.88, 1);
        TweenService:Create(u30.Decal, TweenInfo.new(v42 * 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, v42 * 0.5), {
            Transparency = 1
        }):Play();
        local v44 = TweenInfo.new(v43, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v42 - v43);
        local v45 = {
            Position = v32.Position + HumanoidRootPart.CFrame.UpVector * (22 + u1:NextNumber(0, 6)) * v27
        };
        local Orientation = u30.Orientation;
        local v46 = u1:NextNumber(-10, 10);
        local v47 = u1:NextNumber(550, 950) * v42;
        v45.Orientation = Orientation + Vector3.new(v46, v47, u1:NextNumber(-10, 10));
        local v48 = TweenService:Create(u30, v44, v45);
        v48:Play();
        v48.Completed:Connect(function() -- Line: 212
            -- upvalues: u30 (copy)
            u30:Destroy();
        end);
    end;

    local u49 = AssetHandler.CloneAsset("Particles/Whirlpool/Slamwave", u4);
    u49.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0);
    u49.Parent = workspace.Effects;
    local v50 = TweenService:Create(u49, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Size = Vector3.new(50, 5, 50),
        Transparency = 1
    });
    v50:Play();
    v50.Completed:Connect(function() -- Line: 226
        -- upvalues: u49 (copy)
        u49:Destroy();
    end);
    EffectsHandler.CallEffect("Anubis_Laceration", {
        Size = Vector3.new(12, 15, 12),
        Amount = 8,
        RockSizeMultiplier = 0.7,
        Origin = HumanoidRootPart.CFrame
    });
end;