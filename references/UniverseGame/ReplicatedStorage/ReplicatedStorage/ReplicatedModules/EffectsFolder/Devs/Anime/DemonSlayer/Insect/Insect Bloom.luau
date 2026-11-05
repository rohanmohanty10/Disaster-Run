  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy), EffectsHandler (copy), TweenService (copy)
    local u3 = p2 or {};
    local Lifetime = u3.Lifetime;
    local Offset = u3.Offset;
    local Character = u3.Player.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v4 = AssetHandler.GetAbilityData(Character);
    local u5 = AssetHandler.CloneAsset("Particles/Bloom/Slashes", v4);
    u5.Parent = workspace.Effects;
    ParticleHandler.AttachTo(u5, {
        Part = HumanoidRootPart,
        Offset = Offset:Inverse()
    });
    task.delay(Lifetime, function() -- Line: 56
        -- upvalues: ParticleHandler (ref), u5 (copy)
        ParticleHandler.DestroyEmit(u5);
        ParticleHandler.EnableAllParticles(u5, false);
    end);
    local v6 = os.clock();
    local v7 = os.clock();
    local v8 = os.clock();

    while HumanoidRootPart and HumanoidRootPart:IsDescendantOf(game) do
        task.wait();
        local u9 = HumanoidRootPart.CFrame * Offset;

        if os.clock() - v8 >= 0.045 then
            v8 = os.clock();
            task.spawn(function() -- Line: 77
                -- upvalues: u1 (ref), u3 (ref), u9 (copy), EffectsHandler (ref), Character (copy), TweenService (ref)
                local v10 = u1:NextNumber(-1, 1);
                local v11 = u1:NextNumber(0, 0.3);
                local Unit = Vector3.new(v10, v11, u1:NextNumber(-1, 1)).Unit;
                local v12 = (u3.Radius or 15) * u1:NextNumber(0.6, 0.85);
                local Position = u9.Position;
                local v13 = u1:NextNumber(4, 8);
                local u14 = Position + Vector3.new(0, v13, 0) + Unit * v12;
                local v15 = u1:NextNumber(15, 20);
                local u16 = u14 - Vector3.new(0, v15, 0);
                local u17 = CFrame.new(u14, u14 + (u9.Position - u14).Unit * Vector3.new(1, 0, 1)) * CFrame.Angles(0, 0, 3.141592653589793);
                local u18 = EffectsHandler.CallEffect("Byee_Afterimage", {
                    IsHighlight = true,
                    OutlineTransparency = 1,
                    Origin = u17,
                    Character = Character,
                    Lifetime = u1:NextNumber(0.75, 0.95),
                    FillColor = Color3.fromRGB(145, 67, 255),
                    OutlineColor = Color3.fromRGB(99, 14, 168),
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    FillTransparency = u1:NextNumber(0.3, 0.6) * (math.random(1, 2) == 1 and 1 or -1)
                });
                task.spawn(function() -- Line: 113
                    -- upvalues: u17 (copy), u18 (copy), TweenService (ref), u14 (copy), u16 (copy)
                    local v19, v20, v21 = u17:ToOrientation();
                    local v22 = math.random(20, 30);

                    for i = 1, v22 do
                        if not (u18 and u18:IsDescendantOf(game)) then
                            break;
                        end;

                        task.wait();
                        local v23 = u14:Lerp(u16, (TweenService:GetValue(i / v22, Enum.EasingStyle.Sine, Enum.EasingDirection.In)));
                        u18:PivotTo(CFrame.new(v23) * CFrame.fromOrientation(v19, v20, v21));
                    end;
                end);
            end);
        end;

        if os.clock() - v7 >= 0.02 then
            v7 = os.clock();
            local v24 = HumanoidRootPart.CFrame * Offset;
            local v25 = AssetHandler.CloneAsset("Particles/Bloom/BeamSlash", v4);
            local v26 = v24 * CFrame.new(u1:NextNumber(-5, 5), u1:NextNumber(-0.3, 3.5), u1:NextNumber(-4, 1));
            local Angles = CFrame.Angles;
            local v27 = u1:NextNumber(-360, 360);
            local v28 = math.rad(v27);
            local v29 = u1:NextNumber(-360, 360);
            local v30 = math.rad(v29);
            local v31 = u1:NextNumber(-360, 360);
            v25.CFrame = v26 * Angles(v28, v30, (math.rad(v31)));
            v25.Parent = workspace.Effects;
            AssetHandler.ScaleAsset(v25, {
                Scale = u1:NextNumber(0.85, 1.4)
            });
            local v32 = u1:NextNumber(0.1, 0.15);
            task.delay(v32, v25.Destroy, v25);
            TweenService:Create(v25, TweenInfo.new(v32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = v25.CFrame * CFrame.Angles(0, -10, 0)
            }):Play();

            for _, descendant in v25:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(v32, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;
        end;

        if Lifetime <= os.clock() - v6 then
            break;
        end;
    end;
end;