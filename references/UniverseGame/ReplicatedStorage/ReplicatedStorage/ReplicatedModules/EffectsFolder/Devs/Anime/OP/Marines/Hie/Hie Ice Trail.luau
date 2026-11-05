  

 

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
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

local function Bezier(p3, p4, p5, p6) -- Line: 21
    return (1 - p6) ^ 2 * p3 + 2 * (1 - p6) * p6 * p4 + p6 ^ 2 * p5;
end;

return function(p7, p8) -- Line: 25
    -- upvalues: AssetHandler (copy), u2 (copy), u1 (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy), RunService (copy)
    local v9 = p8 or {};
    local v10 = v9.Scalar or 1;
    local Attribute = v9.Attribute;
    local u11 = v9.TweenTime or 0.35;
    local v12 = v9.MinDistance or 4.5;
    local v13 = v9.MinTime or 2;
    local u14 = v9.DissolveIce or false;
    local v15 = AssetHandler.GetAbilityData(v9.Character);
    local v16 = os.clock();
    local Position = p7.Position;

    local function Side() -- Line: 41
        return math.random(1, 2) == 1 and -1 or 1;
    end;

    local v17 = 1;

    while p7:IsDescendantOf(game) and (not p7.Parent:GetAttribute("Inactive") and (Attribute == nil or p7:GetAttribute(Attribute))) do
        if v12 < (p7.Position * Vector3.new(1, 0, 1) - Position).Magnitude then
            local v18 = workspace:Raycast(p7.Position, Vector3.new(0, -6.5, 0), u2);

            if v18 then
                local u19 = AssetHandler.CloneAsset("Models/GroundIce", v15);
                local Mesh = u19.Mesh;
                local v20 = 1.5 + u1:NextNumber(-0.4, 0.4);
                local v21 = 0.6 + u1:NextNumber(-0.05, 0.15);
                local v22 = 1.5 + u1:NextNumber(-0.4, 0.4);
                Mesh.Scale = Vector3.new(v20, v21, v22) * v10;
                u19.Size = u19.Size * (2 * v10);
                local v23 = CFrame.new(v18.Position, v18.Position + v18.Normal) * CFrame.new(0, 0, -u1:NextNumber(0.12, 0.18));
                local Angles = CFrame.Angles;
                local v24 = math.random(-360, 360);
                u19.CFrame = v23 * Angles(-1.5707963267948966, math.rad(v24), 0);
                u19.Decal.ZIndex = v17;
                u19.Parent = workspace.Effects;
                task.delay(v13 + 1, u19.Destroy, u19);
                local Scale = u19.Mesh.Scale;
                u19.Mesh.Scale = Vector3.new(0, 0, 0);
                TweenService:Create(u19.Mesh, TweenInfo.new(u11 / 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Scale = Scale
                }):Play();
                local v25 = CFrame.new(u1:NextNumber(7, 8) * (math.random(1, 2) == 1 and -1 or 1), u1:NextNumber(-3, 0.5), u1:NextNumber(1.25, 2.5) * (math.random(1, 2) == 1 and -1 or 1));
                local u26;

                if math.random(1, 4) == 1 then
                    u26 = AssetHandler.CloneAsset("Models/Spike", v15);
                    u26.Size = u26.Size * u1:NextNumber(0.7, 1.25);
                    u26.CFrame = CFrame.new(v18.Position, v18.Position + v18.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * v25;
                    local v27 = CFrame.new(u26.Position, u19.Position);
                    local Angles2 = CFrame.Angles;
                    local v28 = u1:NextNumber(-10, 10);
                    local v29 = math.rad(v28);
                    local v30 = u1:NextNumber(-10, 10);
                    local v31 = math.rad(v30);
                    local v32 = u1:NextNumber(-5, 5);
                    u26.CFrame = v27 * Angles2(v29, v31, (math.rad(v32)));
                    u26.Parent = workspace.Effects;
                    task.delay(v13 + 1, u26.Destroy, u26);
                    u26.CFrame = u26.CFrame * CFrame.new(0, -10, 0);
                    TweenService:Create(u26, TweenInfo.new(u1:NextNumber(0.3, 0.4), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        CFrame = u26.CFrame * CFrame.new(0, 10, 0)
                    }):Play();
                else
                    u26 = nil;
                end;

                task.delay(v13 - u11, function() -- Line: 92
                    -- upvalues: u14 (copy), EffectsHandler (ref), u19 (copy), TweenService (ref), u11 (copy), ParticleHandler (ref), u26 (ref)
                    if u14 then
                        task.spawn(EffectsHandler.CallEffect, "Hie Ice Dissolve", {
                            Time = 0.05,
                            Flipbook = "Ground",
                            Mesh = u19
                        });
                    else
                        TweenService:Create(u19.Mesh, TweenInfo.new(u11, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            Scale = Vector3.new(0, 0, 0)
                        }):Play();
                        TweenService:Create(u19, TweenInfo.new(u11, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            CFrame = u19.CFrame * CFrame.new(0, -0.55, 0)
                        }):Play();
                        ParticleHandler.EnableAllParticles(u19, false);
                    end;

                    if u26 then
                        if u14 then
                            task.spawn(EffectsHandler.CallEffect, "Hie Ice Dissolve", {
                                Time = 0.05,
                                Flipbook = "Spike",
                                Mesh = u26
                            });

                            return;
                        end;

                        TweenService:Create(u26, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            Size = Vector3.new(0, 0, 0),
                            CFrame = u26.CFrame * CFrame.new(0, -10, 0)
                        }):Play();
                    end;
                end);
                Position = u19.Position * Vector3.new(1, 0, 1);
                local v33 = v17 + 1;
                v17 = v33 > 3 and 1 or v33;
            end;
        end;

        if os.clock() - v16 > 0.15 then
            v16 = os.clock();
            local Position2 = p7.Position;
            local v34 = u1:NextNumber(-2, 2);
            local v35 = u1:NextNumber(-2.5, 1.5);
            local u36 = Position2 + Vector3.new(v34, v35, u1:NextNumber(-2, 2)) + p7.CFrame.LookVector * u1:NextNumber(7, 10);
            local u37 = AssetHandler.CloneAsset(`Particles/Skate/Trails/{math.random(1, 2)}`, v15);
            u37.Parent = workspace.Effects;
            local v38 = u1:NextNumber(-15, 15);
            local v39 = u1:NextNumber(-4, 10);
            local u40 = u36 + Vector3.new(v38, v39, u1:NextNumber(-15, 15));
            local v41 = u1:NextNumber(-15, 15);
            local v42 = u1:NextNumber(-4, 6);
            local u43 = u36 + Vector3.new(v41, v42, u1:NextNumber(-15, 15));
            local u44 = u1:NextNumber(0.4, 0.6);
            local u45 = 0;
            local u46 = nil;
            u46 = RunService.RenderStepped:Connect(function(p47) -- Line: 166
                -- upvalues: u45 (ref), u44 (copy), u37 (copy), u36 (copy), u40 (copy), u43 (copy), u46 (ref), ParticleHandler (ref)
                u45 = u45 + p47;
                local v48 = math.clamp(u45 / u44, 0, 1);
                u37.Position = (1 - v48) ^ 2 * u36 + 2 * (1 - v48) * v48 * u40 + v48 ^ 2 * u43;

                if v48 >= 1 then
                    u46:Disconnect();
                    u46 = nil;
                    ParticleHandler.EnableAllParticles(u37, false);
                    ParticleHandler.DestroyEmit(u37);
                end;
            end);
        end;

        task.wait();
    end;
end;