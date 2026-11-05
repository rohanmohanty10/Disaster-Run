  

 

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
local u5 = TweenInfo.new(0.05, Enum.EasingStyle.Sine);

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
    local v13 = AssetHandler.CloneAsset("Particles/Tri-Phase Beam/Beam", v12);
    local u14 = {
        Begin = v13:FindFirstChild("Begin"),
        Middle = v13:FindFirstChild("Dissipate"),
        End = v13:FindFirstChild("End")
    };

    for _, v in u14 do
        ParticleHandler.ScaleParticle(v, 1.85);

        if v == u14.End then
            ParticleHandler.ScaleParticle(v, 1.2);

            for _, child in v:FindFirstChild("end").beams:GetChildren() do
                child.Width0 = child.Width0 * 1.6;
                child.Width1 = child.Width1 * 1.6;
            end;
        end;

        ParticleHandler.Unusualify(v, {
            Character = p9
        });
        v.Parent = workspace.Effects;
    end;

    v11:Add(function() -- Line: 76
        -- upvalues: ParticleHandler (ref), u14 (copy)
        ParticleHandler.EnableAllParticles(u14.Begin, false);
        ParticleHandler.EnableAllParticles(u14.Middle, false);
        ParticleHandler.EnableAllParticles(u14.End, false);
        ParticleHandler.Emit(u14.Middle, ParticleHandler.GenerateEmitInfo(u14.Middle));

        for _, v in u14 do
            task.delay(2.5, function() -- Line: 84
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;
    end);

    local function UpdateRayModelTransform(p15, p16, p17) -- Line: 90
        -- upvalues: TweenService (ref), u5 (ref), u8 (copy)
        local Begin = p15.Begin;
        local Middle = p15.Middle;
        local End = p15.End;

        if Begin then
            if p17 then
                Begin.CFrame = p16;
            else
                TweenService:Create(Begin, u5, {
                    CFrame = p16
                }):Play();
            end;
        end;

        if End then
            if p17 then
                End.CFrame = u8.WorldCFrame * CFrame.Angles(0, 3.141592653589793, 0);
            else
                TweenService:Create(End, u5, {
                    CFrame = u8.WorldCFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play();
            end;
        end;

        if Middle then
            local Magnitude = (p16.Position - u8.WorldCFrame.Position).Magnitude;

            if p17 then
                Middle.CFrame = CFrame.lookAt(p16.Position, u8.WorldPosition) * CFrame.new(0, 0, -Magnitude / 2);
                Middle.Size = vector.create(Middle.Size.X, Middle.Size.Y, Magnitude);

                return;
            end;

            TweenService:Create(Middle, u5, {
                CFrame = CFrame.lookAt(p16.Position, u8.WorldPosition) * CFrame.new(0, 0, -Magnitude / 2),
                Size = vector.create(Middle.Size.X, Middle.Size.Y, Magnitude)
            }):Play();
        end;
    end;

    local u18 = CFrame.new(-0.568695068, 3.96204948, -9.78787231);
    local v19 = HumanoidRootPart.CFrame * u18 * CFrame.Angles(0, 1.5707963267948966, 0);
    local Begin = u14.Begin;
    local Middle = u14.Middle;
    local End = u14.End;

    if Begin then
        Begin.CFrame = v19;
    end;

    if End then
        End.CFrame = u8.WorldCFrame * CFrame.Angles(0, 3.141592653589793, 0);
    end;

    if Middle then
        local Magnitude = (v19.Position - u8.WorldCFrame.Position).Magnitude;
        Middle.CFrame = CFrame.lookAt(v19.Position, u8.WorldPosition) * CFrame.new(0, 0, -Magnitude / 2);
        Middle.Size = vector.create(Middle.Size.X, Middle.Size.Y, Magnitude);
    end;

    local v31 = Sequence_V3.new({
        Validate = function() -- Line: 134, Name: Validate
            -- upvalues: u8 (copy)
            local v20 = u8 and u8:IsDescendantOf(workspace);

            return v20;
        end,

        Speed = p10.Speed,
        Frames = {
            { 0, function(p21, p22) -- Line: 139
                end },
            { 2, function(p23, p24) -- Line: 142
                    -- upvalues: ParticleHandler (ref), u14 (copy)
                    ParticleHandler.EnableAllParticles(u14.Begin, true);
                    ParticleHandler.EnableAllParticles(u14.End, true);
                end },
            { 1, 180, function(p25, p26) -- Line: 147
                    -- upvalues: HumanoidRootPart (copy), u18 (copy), UpdateRayModelTransform (copy), u14 (copy)
                    UpdateRayModelTransform(u14, HumanoidRootPart.CFrame * u18 * CFrame.Angles(0, 1.5707963267948966, 0));
                end },
            { 181, function(p27, p28) -- Line: 153
                    -- upvalues: ParticleHandler (ref), u14 (copy)
                    ParticleHandler.EnableAllParticles(u14.Begin, false);
                    ParticleHandler.EnableAllParticles(u14.Middle, false);
                    ParticleHandler.EnableAllParticles(u14.End, false);
                end },
            { 185, function(p29, p30) -- Line: 164
                end }
        }
    });
    v11:Add(v31);
    v31:Play();

    if p10.StartFrame then
        v31:MoveTo(p10.StartFrame, true);
    end;

    while v31:IsPlaying() do
        task.wait(0.1);
    end;

    v31:Destroy();
end;