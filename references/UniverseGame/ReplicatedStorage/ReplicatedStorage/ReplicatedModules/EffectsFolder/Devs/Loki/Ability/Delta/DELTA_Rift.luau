  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.Types);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = v2.Rng;

return function(u3, u4, p5) -- Line: 33
    -- upvalues: Trove (copy), AssetHandler (copy), Sequence_V3 (copy), ParticleHandler (copy), Fusion (copy), EffectsHandler (copy)
    local u6 = Trove.new();
    u6:AttachToInstance(u3);
    u6:AttachToInstance(u4);
    local u7 = AssetHandler.GetAbilityData(u4);
    local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart");
    local v26 = Sequence_V3.new({
        Validate = function() -- Line: 43, Name: Validate
            -- upvalues: u3 (copy)
            local v8 = u3 and u3:IsDescendantOf(workspace);

            return v8;
        end,

        Speed = p5.Speed,
        Frames = {
            { 0, function(p9, p10) -- Line: 48
                    -- upvalues: AssetHandler (ref), u4 (copy), ParticleHandler (ref), u6 (copy)
                    local v11 = p9:GetCache();
                    local u12 = AssetHandler.CloneAsset("Particles/Rift/Rift", AssetHandler.GetAbilityData(u4));
                    u12.Size = Vector3.new(0, 1.6, 0.1);
                    ParticleHandler.Unusualify(u12, {
                        IncludeParts = true,
                        Character = u4
                    });
                    u12.Parent = workspace.Effects;
                    u6:Add(function() -- Line: 58
                        -- upvalues: u12 (copy)
                        task.delay(2, function() -- Line: 59
                            -- upvalues: u12 (ref)
                            u12:Destroy();
                        end);
                    end);
                    v11.Rift = u12;
                end },
            { 40, function(p13, p14) -- Line: 67
                    -- upvalues: Fusion (ref), u4 (copy), HumanoidRootPart (copy), EffectsHandler (ref)
                    local v15 = p13:GetCache();
                    local Rift = v15.Rift;
                    local v16 = Fusion.Value(Rift.Size);
                    Fusion.Hydrate(Rift)({
                        Transparency = 0,
                        CFrame = u4.HumanoidRootPart.CFrame * CFrame.new(
                            0.490661621,
                            4.86297607,
                            -11.4001398,
                            0.906307757,
                            0.42261833,
                            0,
                            0.42261833,
                            -0.906307757,
                            0,
                            0,
                            0,
                            -1
                        ),
                        Size = Fusion.Spring(v16, 30 * p13:GetSpeed(), 0.5)
                    });
                    v16:set(v16:get() + Vector3.new(18, 0, 0));

                    if HumanoidRootPart then
                        EffectsHandler.CallEffects({
                            {
                                Name = "Emit Particle V3",
                                Data = {
                                    {
                                        Path = "Particles/Common/Cut",
                                        AttachTo = {
                                            Part = HumanoidRootPart,
                                            Offset = CFrame.new(
                                                -1.30566406,
                                                -10.9998779,
                                                3.5880127,
                                                -0.906307876,
                                                -0.422618359,
                                                -0,
                                                0,
                                                0,
                                                -1,
                                                0.422618359,
                                                -0.906307876,
                                                0
                                            )
                                        },
                                        Character = u4
                                    }
                                }
                            }
                        });
                    end;

                    v15.SizeState = v16;
                end },
            { 97, function(p17, p18) -- Line: 113
                end },
            { 131, function(p19, p20) -- Line: 117
                end },
            { 154, function(p21) -- Line: 121
                    -- upvalues: ParticleHandler (ref)
                    local Rift = p21:GetCache().Rift;
                    ParticleHandler.EnableAllParticles(Rift, false);
                end },
            { 155, function(p22, p23) -- Line: 128
                    -- upvalues: EffectsHandler (ref), AssetHandler (ref), u7 (copy), ParticleHandler (ref), u4 (copy), u6 (copy)
                    local v24 = p22:GetCache();
                    local Rift = v24.Rift;
                    local SizeState = v24.SizeState;
                    SizeState:set(SizeState:get() + Vector3.new(0, 7, 0));
                    Rift.Transparency = 1;
                    local u25 = os.clock() + math.random(1, 1000);
                    EffectsHandler.CallEffect("Enable Particles", {
                        Enabled = true,
                        Scale = 1.3,
                        EmitOnCreate = true,
                        Parent = Rift,
                        ReferencePart = AssetHandler.GetAsset("Particles/Rift/RiftPortal", u7),
                        Offset = CFrame.Angles(0, 3.141592653589793, 0),
                        Id = u25,
                        HSVShift = ParticleHandler.GetUnusualHSVData({
                            Character = u4
                        })
                    });
                    u6:Add(function() -- Line: 151
                        -- upvalues: EffectsHandler (ref), u25 (copy)
                        EffectsHandler.CallEffect("Enable Particles", {
                            Enabled = false,
                            Id = u25
                        });
                    end);
                end }
        }
    });
    u6:Add(v26);
    v26:Play();

    if p5.StartFrame then
        v26:MoveTo(p5.StartFrame, true);
    end;

    while v26:IsPlaying() do
        task.wait(0.1);
    end;

    v26:Destroy();
end;