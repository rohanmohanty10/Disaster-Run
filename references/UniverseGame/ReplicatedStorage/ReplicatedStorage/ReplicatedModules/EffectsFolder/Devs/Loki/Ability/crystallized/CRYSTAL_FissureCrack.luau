  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = RaycastParams.new();
u1.IgnoreWater = true;
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
u1.CollisionGroup = "Map";

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

local u4 = Random.new();
local Part = Instance.new("Part");
Part.TopSurface = Enum.SurfaceType.SmoothNoOutlines;
Part.LeftSurface = Enum.SurfaceType.SmoothNoOutlines;
Part.RightSurface = Enum.SurfaceType.SmoothNoOutlines;
Part.BackSurface = Enum.SurfaceType.SmoothNoOutlines;
Part.FrontSurface = Enum.SurfaceType.SmoothNoOutlines;

local function CreateCrack(p5, p6, p7, p8, u9, p10) -- Line: 44
    -- upvalues: Part (copy), Fusion (copy)
    local Folder = Instance.new("Folder");
    local v11 = #p6;
    local v12 = p7 / v11;
    local u13 = {};

    for i, v in p6 do
        local u14 = v[1];
        local u15 = v[2];
        local u16 = Instance.fromExisting(Part);
        u16.Anchored = true;
        u16.Color = Color3.new();
        u16.Material = "Neon";
        u16.CFrame = u14 * CFrame.Angles(0, 0, 0);
        local v17 = math.lerp(1.25, 0.5, i / v11) * (p10 or 1);
        u16.Size = Vector3.new(v17, 3, 0);
        u16.Transparency = 1;
        local v18 = RaycastMap(u14.Position + Vector3.new(0, 1, 0), Vector3.new(-0, -15, -0));

        if v18 then
            u16.Material = v18.Instance.Material;
            local v19, v20, v21 = v18.Instance.Color:ToHSV();
            u16.Color = Color3.fromHSV(v19, v20, (math.clamp(v21, 0.1, 0.2)));
        end;

        u16.Parent = Folder;
        local v22 = TweenInfo.new(v12 * 1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        local u23 = Fusion.Value(u16.Size);
        local v24 = Fusion.Tween(u23, v22);
        Fusion.Hydrate(u16)({
            Size = v24,
            CFrame = Fusion.Tween(Fusion.Computed(function() -- Line: 79
                -- upvalues: u23 (copy), u16 (copy)
                local v25 = u23:get();

                return u16.CFrame * CFrame.new(0, 0, -v25.Z / 2);
            end), v22)
        });
        table.insert(u13, u16);
        task.delay(v12 * i, function() -- Line: 87
            -- upvalues: u16 (copy), u9 (copy), u14 (copy), i (copy), u23 (copy), u15 (copy)
            u16.Transparency = 0;

            if u9 and u9[1] then
                u9[1](u14, u16, i);
            end;

            u23:set(u16.Size + Vector3.new(0, 0, 1) * u15 + Vector3.new(-0, -2.5, -0));
        end);
    end;

    Folder.Parent = workspace.Effects;
    task.delay(p7 + p8, function() -- Line: 100
        -- upvalues: u13 (copy), u9 (copy)
        for i, v in u13 do
            if u9 and u9[2] then
                u9[2](v.CFrame, v, i);
            end;
        end;
    end);

    return Folder, u13;
end;

return function(u26, u27, p28, u29) -- Line: 111
    -- upvalues: Trove (copy), BoatTween (copy), AssetHandler (copy), ParticleHandler (copy), CreateCrack (copy), EffectsHandler (copy), u4 (copy)
    if not (u26 and u27) then
        return;
    end;

    local u30 = #p28;

    if not p28[u30] then
        return;
    end;

    local u31 = Trove.new();

    local function Tween(p32, p33) -- Line: 119
        -- upvalues: u31 (copy), BoatTween (ref)
        u31:Add(BoatTween:Create(p32, p33)):Play();
    end;

    local u34 = p28[u30][1] * CFrame.new(0, 0, p28[u30][2]);
    local u35 = AssetHandler.CloneAsset("Particles/Fissure Rupture/Fissure", AssetHandler.GetAbilityData(u26));
    u31:Add(u35);
    ParticleHandler.Unusualify(u35, {
        Character = u26
    });
    ParticleHandler.ScaleParticle(u35, 0.8);
    u31:Add((CreateCrack(u27, p28, u29.Duration, u29.Lifetime, { function(p36, p37, p38) -- Line: 132
            -- upvalues: EffectsHandler (ref), u4 (ref), u26 (copy), u35 (copy), u29 (copy), u31 (copy), BoatTween (ref), u27 (copy), u34 (copy), CreateCrack (ref), u30 (copy)
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/Fissure Rupture/GroundSlam",
                AutoSerialize = true,
                BypassRenderCap = true,
                Origin = p36 * CFrame.new(0, 0.15, 0),
                Scale = 1.2 + u4:NextNumber(-0.05, 0.05),
                Character = u26
            });

            for _ = 1, math.random(1, 2) do
                local CallEffect = EffectsHandler.CallEffect;
                local v39 = {
                    Collision = true,
                    Inconsistent = true,
                    UseRawForce = true,
                    Origin = p36 * CFrame.new(0, 0, u4:NextNumber(-p37.Size.Z / 2, p37.Size.Z / 2)),
                    Lifetime = u4:NextNumber(0.7, 1.3),
                    Size = u4:NextNumber(0.5, 1),
                    Amount = math.random(1, 2)
                };
                local v40 = u4:NextNumber(-2, 2);
                v39.Force = Vector3.new(v40, 1.4, u4:NextNumber(-2, 2)) * u4:NextNumber(14, 18);
                v39.Tween = {
                    Transparency = 1,
                    Size = Vector3.new(0, 0, 0)
                };
                v39.TweenDelay = u4:NextNumber(0.5, 0.75);
                CallEffect("Flying Debris", v39);
            end;

            if u35 then
                for _, child in u35:GetChildren() do
                    local u41 = child:Clone();
                    u41.Rate = u41.Rate / 2.5;
                    u41.Enabled = true;
                    u41.Parent = p37;
                    u31:Add(BoatTween:Create(u41, {
                        EasingStyle = "Smoother",
                        EasingDirection = "In",
                        StepType = "Heartbeat",
                        Time = u29.Lifetime,
                        Goal = {
                            Rate = u41.Rate * 3
                        }
                    })):Play();
                    task.delay(u29.Lifetime, function() -- Line: 174
                        -- upvalues: u41 (copy)
                        u41.Enabled = false;
                    end);
                end;
            end;

            if math.random(1, 2) == 1 then
                local v42 = math.random(1, 2) == 1 and 1 or -1;
                local v43 = CFrame.lookAt(u27.Position, u34.Position);
                local Angles = CFrame.Angles;
                local v44 = u4:NextNumber(-40, 40);
                local v45 = (v43 * Angles(0, math.rad(v44), 0)).RightVector * v42;
                local v46 = CFrame.lookAt(p36.Position, p36.Position + v45);
                local v47 = math.random(3, 5);
                local v48 = u4:NextNumber(6, 14);
                local v49 = {};
                local v50 = {};

                for i = 1, v47 do
                    local v51 = CFrame.new(0, 0, -v48 / v47 * i);
                    local v52 = CFrame.new((i == 1 or i == v47) and 0 or (u4:NextNumber(-3, 3) or 0), 0, 0);
                    local v53 = v46 * v51 * v52;
                    local v54;

                    if v49[i - 1] then
                        v54 = v49[i - 1][1] or nil;
                    else
                        v54 = nil;
                    end;

                    local v55 = CFrame.new(v53.X, (v54 or v46).Y, v53.Z);
                    local v56 = RaycastMap(v55.Position + Vector3.new(0, 3, 0), Vector3.new(-0, -20, -0));

                    if not v56 then
                        break;
                    end;

                    local v57 = CFrame.new(v53.X, v56.Position.Y + 0.1, v53.Z);
                    local Magnitude = ((v54 or v46).Position - v57.Position).Magnitude;
                    v49[i] = { CFrame.new(v57.Position, (v54 or u27).Position), Magnitude };
                    v50[i] = { CFrame.new((v54 or v46).Position, v57.Position), Magnitude };
                end;

                local v61 = CreateCrack(v46, v50, u29.Lifetime / 4, u29.Lifetime / 1.5, { function(p58, u59, p60) -- Line: 212
                        -- upvalues: u29 (ref), u31 (ref), BoatTween (ref)
                        task.delay(u29.Lifetime / 2, function() -- Line: 213
                            -- upvalues: u59 (copy), u29 (ref), u31 (ref), BoatTween (ref)
                            u31:Add(BoatTween:Create(u59, {
                                EasingStyle = "Smoother",
                                EasingDirection = "InOut",
                                StepType = "Heartbeat",
                                Time = u29.Lifetime / 3,
                                Goal = {
                                    Transparency = 1,
                                    Size = Vector3.new(0, u59.Size.Y / 2, u59.Size.Z)
                                }
                            })):Play();
                        end);
                    end }, 1 - p38 / (u30 + 2));
                table.clear(v50);
                table.clear(v49);
                u31:Add(v61);
            end;
        end, function(u62, u63, u64) -- Line: 233
            -- upvalues: u29 (copy), u30 (copy), u31 (copy), BoatTween (ref), EffectsHandler (ref), u4 (ref), u26 (copy)
            task.delay(u29.Duration / u30 * u64, function() -- Line: 235
                -- upvalues: u63 (copy), u64 (copy), u31 (ref), BoatTween (ref), EffectsHandler (ref), u62 (copy), u4 (ref), u26 (ref), u29 (ref)
                u31:Add(BoatTween:Create(u63, {
                    EasingStyle = "Smoother",
                    EasingDirection = "InOut",
                    StepType = "Heartbeat",
                    Time = 0.5 - u64 / 30,
                    Goal = {
                        Transparency = 1,
                        Size = Vector3.new(0, u63.Size.Y / 2, u63.Size.Z)
                    }
                })):Play();
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Fissure Rupture/FissureRuptureV2",
                    AutoSerialize = true,
                    BypassRenderCap = true,
                    Origin = u62 * CFrame.new(0, 3.1, 0),
                    Scale = 1.15 + u4:NextNumber(-0.05, 0.05),
                    Character = u26
                });

                if u29.ExplodeSound and u64 == 1 or u64 % 4 == 0 then
                    EffectsHandler.CallEffect("Play Sound At", {
                        Object = u29.ExplodeSound,
                        Origin = u62
                    });
                end;

                for _ = 1, math.random(1, 2) do
                    local CallEffect = EffectsHandler.CallEffect;
                    local v65 = {
                        Collision = true,
                        Inconsistent = true,
                        UseRawForce = true,
                        Origin = u62 * CFrame.new(0, 0, u4:NextNumber(-u63.Size.Z / 2, u63.Size.Z / 2)),
                        Lifetime = u4:NextNumber(0.7, 1.3) * 1.25,
                        Size = u4:NextNumber(0.5, 1) * 1.9,
                        Amount = math.random(1, 2)
                    };
                    local v66 = u4:NextNumber(-2, 2);
                    v65.Force = Vector3.new(v66, 1.4, u4:NextNumber(-2, 2)) * u4:NextNumber(10, 17);
                    v65.Tween = {
                        Transparency = 1,
                        Size = Vector3.new(0, 0, 0)
                    };
                    v65.TweenDelay = u4:NextNumber(0.5, 0.75) * 1.1;
                    CallEffect("Flying Debris", v65);
                end;
            end);
        end })));
    task.delay(u29.Duration + u29.Lifetime + 1.5, function() -- Line: 284
        -- upvalues: u31 (copy)
        u31:Destroy();
    end);
end;