  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.Types);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v4 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = v4.Rng;
local u5 = TweenInfo.new(0.1, Enum.EasingStyle.Sine);

local function Animate(p6, p7) -- Line: 40
    -- upvalues: TweenService (copy), u5 (copy)
    TweenService:Create(p6, u5, p7):Play();
end;

return function(u8, p9, p10) -- Line: 44
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u5 (copy), Sequence_V3 (copy)
    local HumanoidRootPart = p9:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v11 = Trove.new();
    v11:AttachToInstance(u8);
    local v12 = AssetHandler.GetAbilityData(p9);
    local u13 = {
        Begin = AssetHandler.CloneAsset("Particles/Corrupt Ray/BeginRay", v12),
        Middle = AssetHandler.CloneAsset("Particles/Corrupt Ray/MiddleRay", v12),
        End = AssetHandler.CloneAsset("Particles/Corrupt Ray/EndRay", v12)
    };

    for _, v in u13 do
        ParticleHandler.Unusualify(v, {
            Character = p9
        });
        v.Parent = workspace.Effects;
    end;

    v11:Add(function() -- Line: 65
        -- upvalues: u13 (copy)
        for _, v in u13 do
            task.delay(1.5, function() -- Line: 67
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;
    end);

    local function UpdateRayModelTransform(p14, p15, p16) -- Line: 73
        -- upvalues: TweenService (ref), u5 (ref)
        local Start = p14:FindFirstChild("Start");
        local Middle = p14:FindFirstChild("Middle");
        local End = p14:FindFirstChild("End");

        if Start then
            TweenService:Create(Start, u5, {
                CFrame = p15
            }):Play();
        end;

        if End then
            TweenService:Create(End, u5, {
                CFrame = p16
            }):Play();
        end;

        if Middle then
            TweenService:Create(Middle, u5, {
                CFrame = p15:Lerp(p16, 0.5),
                Size = vector.create(Middle.Size.X, Middle.Size.Y, (p15.Position - p16.Position).Magnitude)
            }):Play();
        end;
    end;

    local u17 = p10.Range or 45;
    local v42 = Sequence_V3.new({
        Validate = function() -- Line: 101, Name: Validate
            -- upvalues: u8 (copy)
            local v18 = u8 and u8:IsDescendantOf(workspace);

            return v18;
        end,

        Speed = p10.Speed,
        Frames = {
            { 0, function(p19, p20) -- Line: 106
                end },
            { 30, function(p21) -- Line: 110
                    -- upvalues: HumanoidRootPart (copy), u17 (copy), u13 (copy), UpdateRayModelTransform (copy)
                    local v22 = HumanoidRootPart.CFrame * CFrame.new(-0.2, -0.75, -4);
                    local v23 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -u17);
                    local v24 = RaycastMap(v22.Position, HumanoidRootPart.CFrame.LookVector * u17);

                    if v24 then
                        v23 = CFrame.lookAt(v24.Position + v24.Normal, v22.Position) * CFrame.Angles(0, 3.141592653589793, 0);
                    end;

                    for _, v in u13 do
                        UpdateRayModelTransform(v, v22, v23);
                    end;
                end },
            { 70, function(p25, p26) -- Line: 124
                    -- upvalues: ParticleHandler (ref), u13 (copy)
                    ParticleHandler.EnableAllParticles(u13.Begin, true);
                end },
            { 85, function(p27, p28) -- Line: 130
                    -- upvalues: ParticleHandler (ref), u13 (copy)
                    ParticleHandler.EnableParticleBeams(u13.End.End, true);
                    ParticleHandler.EnableAllParticles(u13.End.Middle, true);
                    ParticleHandler.EnableAllParticles(u13.End.Start, true);
                end },
            { 100, function(p29, p30) -- Line: 136
                end },
            { 109, function(p31, p32) -- Line: 140
                    -- upvalues: ParticleHandler (ref), u13 (copy)
                    ParticleHandler.EnableAllParticles(u13.Middle, true);
                end },
            { 70, 117, function(p33, p34) -- Line: 146
                    -- upvalues: HumanoidRootPart (copy), u17 (copy), u13 (copy), UpdateRayModelTransform (copy)
                    local v35 = HumanoidRootPart.CFrame * CFrame.new(-0.2, -0.75, -4);
                    local v36 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -u17);
                    local v37 = RaycastMap(v35.Position, HumanoidRootPart.CFrame.LookVector * u17);

                    if v37 then
                        v36 = CFrame.lookAt(v37.Position + v37.Normal, v35.Position) * CFrame.Angles(0, 3.141592653589793, 0);
                    end;

                    for _, v in u13 do
                        UpdateRayModelTransform(v, v35, v36);
                    end;
                end },
            { 120, function(p38, p39) -- Line: 160
                    -- upvalues: ParticleHandler (ref), u13 (copy)
                    ParticleHandler.EmitFromAttribute(u13.End.End);
                    ParticleHandler.EnableAllParticles(u13.Begin, false);
                    ParticleHandler.EnableAllParticles(u13.Middle, false);
                    ParticleHandler.EnableAllParticles(u13.End, false);
                end },
            { 125, function(p40, p41) -- Line: 172
                end }
        }
    });
    v11:Add(v42);
    v42:Play();

    if p10.StartFrame then
        v42:MoveTo(p10.StartFrame, true);
    end;

    while v42:IsPlaying() do
        task.wait(0.1);
    end;

    v42:Destroy();
end;