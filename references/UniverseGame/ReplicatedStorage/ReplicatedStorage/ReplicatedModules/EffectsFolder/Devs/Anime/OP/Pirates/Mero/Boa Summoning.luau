  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local u1 = Random.new();

function Bezier(p2, p3, p4, p5)
    return (1 - p2) ^ 2 * p3 + 2 * (1 - p2) * p2 * p4 + p2 ^ 2 * p5;
end;

return function(p6, p7) -- Line: 18
    -- upvalues: TweenService (copy), AssetHandler (copy), ParticleHandler (copy), AnimationHandler (copy), EffectsHandler (copy), u1 (copy)
    if not p6 then
        return;
    end;

    local _ = p6.HumanoidRootPart;
    local HeartRig = p6:FindFirstChild("HeartRig");

    if HeartRig then
        local Heart = HeartRig.Part1.Heart;
        TweenService:Create(Heart, TweenInfo.new(p7), {
            Color = Color3.fromRGB(255, 102, 204),
            Size = Heart.Size * 1.8
        }):Play();
        local v8 = AssetHandler.CloneAsset("Particles/BossSummoning/Aura", {
            AbilityName = "Mero"
        });
        v8.Position = workspace.ItemSpawns.PveEvents.Zone6.SpawnLocation.Position - Vector3.new(0, 5.35, 0);
        v8.Parent = workspace.Effects;
        ParticleHandler.EnableAllParticles(v8, false);
        local v9 = os.clock();
        local v10 = AssetHandler.CloneAsset("Models/BossSummoning/Outline", {
            AbilityName = "Mero"
        });
        v10.HumanoidRootPart.CFrame = CFrame.new(workspace.ItemSpawns.PveEvents.Zone6.SpawnLocation.Position - Vector3.new(0, 2.75, 0));
        v10.Parent = workspace.Effects;
        local v11 = AnimationHandler.CreateAnimationByName("Mero", nil, "Idle");
        v11.Parent = v10;
        v10.AnimationController.Animator:LoadAnimation(v11):Play();
        EffectsHandler.CallEffect("Active Lightning", {
            Interval = 0.2,
            Part = {
                [Heart] = true,
                [v8] = 1
            },
            Lifetime = p7,
            Ranges = {
                X = NumberRange.new(-10, 10),
                Y = NumberRange.new(-10, 10),
                Z = NumberRange.new(-10, 10)
            },
            Lightning = {
                Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
            }
        });
        local v12 = false;

        repeat
            if os.clock() - v9 > 1 then
                if not v12 then
                    ParticleHandler.EnableAllParticles(v8, true);
                    v12 = true;

                    for _, descendant in v8:GetDescendants() do
                        if descendant:IsA("Beam") then
                            local Transparency = descendant.Transparency;
                            descendant.Transparency = NumberSequence.new(1);
                            EffectsHandler.CallEffect("Boat Tween", descendant, {
                                Time = 0.2,
                                EasingStyle = "EntranceExpressive",
                                EasingDirection = "In",
                                StepType = "RenderStepped",
                                Goal = {
                                    Transparency = Transparency
                                }
                            });
                        end;

                        v8.Sound:Play();
                    end;
                end;

                v9 = os.clock();
                ParticleHandler.Emit(Heart.Charge.Pulse, ParticleHandler.GenerateEmitInfo(Heart.Charge.Pulse));
                EffectsHandler.CallEffect("HighlightObject", p6, {
                    OutlineTransparency = 0,
                    Lifetime = 0.5,
                    Tween = true,
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    FillColor = Color3.fromRGB(255, 117, 253),
                    OutlineColor = Color3.fromRGB(255, 117, 253)
                });
                local Part = Instance.new("Part");
                Part.Material = Enum.Material.ForceField;
                Part.Shape = "Ball";
                Part.Size = Vector3.new(20, 20, 20);
                Part.Transparency = 0.25;
                Part.Position = v8.Indicator.WorldPosition;
                Part.Color = Color3.fromRGB(255, 117, 253);
                Part.CanCollide = false;
                Part.CastShadow = false;
                Part.Anchored = true;
                Part.Parent = workspace.Effects;
                task.delay(1, Part.Destroy, Part);
                TweenService:Create(Part, TweenInfo.new(0.75), {
                    Size = Vector3.new(0, 0, 0),
                    Transparency = 1
                }):Play();

                for _, child in v10:GetChildren() do
                    for _, child2 in child:GetChildren() do
                        if child2:IsA("BasePart") then
                            child2.Transparency = 0;
                            TweenService:Create(child2, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;
            end;

            local u13 = AssetHandler.CloneAsset("Particles/BossSummoning/Trail", {
                AbilityName = "Mero"
            });
            u13.CFrame = Heart.CFrame;
            u13.Parent = workspace.Effects;
            local Position = Heart.Position;
            local WorldPosition = v8.Indicator.WorldPosition;
            local Magnitude = (Position - WorldPosition).Magnitude;
            local v14 = u1:NextNumber(-Magnitude / 5, Magnitude / 5);
            local u15 = (Position + WorldPosition) / 2 + Vector3.new(v14, Magnitude * 1.5, u1:NextNumber(-Magnitude / 5, Magnitude / 5));
            task.spawn(function() -- Line: 148
                -- upvalues: u13 (copy), TweenService (ref), Position (copy), u15 (copy), WorldPosition (copy), ParticleHandler (ref)
                for i = 1, 10 do
                    if not u13:IsDescendantOf(game) then
                        break;
                    end;

                    local v16 = task.wait(0.1);
                    TweenService:Create(u13, TweenInfo.new(v16, Enum.EasingStyle.Linear), {
                        Position = Bezier(i / 10, Position, u15, WorldPosition)
                    }):Play();
                end;

                task.wait(0.2);
                task.delay(ParticleHandler.EnableAllParticles(u13, false), u13.Destroy, u13);
            end);
            task.wait(u1:NextNumber(0.15, 0.25));
        until not (Heart:IsDescendantOf(game) and (p6:IsDescendantOf(game) and p6:GetAttribute("SummoningBoa")));

        v10:Destroy();
        task.delay(ParticleHandler.EnableAllParticles(v8, false), v8.Destroy, v8);

        if Heart:IsDescendantOf(game) then
            TweenService:Create(Heart, TweenInfo.new(0.25), {
                Transparency = 1,
                Size = Heart.Size * 5
            }):Play();
            ParticleHandler.Emit(Heart.Charge.Explode, ParticleHandler.GenerateEmitInfo(Heart.Charge.Explode));
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/BossSummoning/Summoned",
                AbilityName = "Mero",
                PlaySounds = true,
                Origin = CFrame.new(workspace.ItemSpawns.PveEvents.Zone6.SpawnLocation.Position - Vector3.new(0, 2, 0))
            });
        end;
    end;
end;