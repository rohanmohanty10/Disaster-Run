  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.Types);
require(ReplicatedRoot.Services.CombatService);
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
local Rng = v4.Rng;
local u5 = TweenInfo.new(0.1, Enum.EasingStyle.Sine);

local function Animate(p6, p7) -- Line: 41
    -- upvalues: TweenService (copy), u5 (copy)
    TweenService:Create(p6, u5, p7):Play();
end;

return function(p8, p9, p10) -- Line: 45
    -- upvalues: AssetHandler (copy), Rng (copy), ParticleHandler (copy), TweenService (copy), u5 (copy)
    local v11 = AssetHandler.GetAbilityData(p8);
    local u12 = {};

    local function GetPosition(p13) -- Line: 50
        local v14 = p13:FindFirstChild("HumanoidRootPart") or p13.PrimaryPart;
        local v15 = RaycastMap(v14.Position, Vector3.new(-0, -8, -0) * p13:GetScale());
        local Position = v14.Position;
        local v16 = 2.9 * p13:GetScale();
        local v17 = Position - vector.create(0, v16, 0);

        if v15 then
            v17 = v15.Position + v15.Normal * 0.1;
        end;

        return v17;
    end;

    for i = 1, #p9 do
        local v18 = AssetHandler.CloneAsset("Particles/FloorSigil", v11);
        local v19 = GetPosition(p9[i]);
        local v20 = CFrame.new(v19);
        local Angles = CFrame.Angles;
        local v21 = Rng(-360, 360);
        v18.CFrame = v20 * Angles(0, math.rad(v21), 0);
        ParticleHandler.Unusualify(v18, {
            Character = p8
        });
        v18.Parent = workspace.Effects;
        ParticleHandler.EmitFromAttribute(v18);
        ParticleHandler.EnableAllParticles(v18, true);
        u12[p9[i]] = v18;
    end;

    local Reference = p10.Reference;
    task.spawn(function() -- Line: 81
        -- upvalues: Reference (copy), u12 (copy), GetPosition (copy), TweenService (ref), u5 (ref), ParticleHandler (ref)
        while Reference and Reference:IsDescendantOf(workspace) do
            for i, v in u12 do
                TweenService:Create(v, u5, {
                    Position = GetPosition(i)
                }):Play();
            end;

            task.wait(0.05);
        end;

        for i, v in u12 do
            ParticleHandler.EnableAllParticles(v, false);
            ParticleHandler.DestroyByMaxLifetime(v);
            u12[i] = nil;
        end;

        table.freeze(u12);
    end);
end;