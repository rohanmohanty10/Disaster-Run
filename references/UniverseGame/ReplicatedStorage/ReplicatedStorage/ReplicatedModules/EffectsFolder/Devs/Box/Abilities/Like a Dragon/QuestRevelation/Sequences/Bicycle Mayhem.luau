  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
game:GetService("TweenService");
local _ = game.Players.LocalPlayer;
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AnimationHandler = require(ReplicatedModules.AnimationHandler);
local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.TableUtil);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.EffectsFolder.Devs.Boojie.Combat.Step);
local u1 = game.ReplicatedStorage["Client Assets"].Assets.Universal.QuestAssets["Awakening The Dragon"];
local LocalPlayer = game.Players.LocalPlayer;
local Dragon = game.ReplicatedStorage["Client Assets"].Assets.Abilities.Dragon;

return function(p2) -- Line: 20
    -- upvalues: LocalPlayer (copy), Trove (copy), u1 (copy), Dragon (copy), EffectsHandler (copy), AnimationHandler (copy), Sequence_V2 (copy)
    local RevelationSequence = p2.RevelationSequence;

    if not RevelationSequence then
        return;
    end;

    if not p2.RemoteEvent then
        return;
    end;

    local RevelationPoint = p2.RevelationPoint;
    local Character = LocalPlayer.Character;
    local u3 = Trove.new();
    local u4 = {};
    local v14 = Sequence_V2.CreateFromOldSequence({
        Frames = {
            { 0, function(p5, p6) -- Line: 34
                    -- upvalues: u1 (ref), RevelationPoint (copy), u3 (copy), u4 (copy), Dragon (ref), Character (copy), EffectsHandler (ref), AnimationHandler (ref), RevelationSequence (copy)
                    local v7 = u1.Decoy:Clone();
                    v7.HumanoidRootPart.CFrame = RevelationPoint.Positioning.CFrame;
                    v7.Parent = workspace.Effects;
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = "rbxassetid://129227358470444";
                    Sound.Volume = 1;
                    Sound.RollOffMinDistance = 70;
                    Sound.RollOffMaxDistance = 100;
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
                    Sound.Parent = v7.HumanoidRootPart;
                    Sound:Play();
                    u3:Add(Sound);
                    u3:Add(v7);
                    u4.Decoy = v7;
                    local v8 = Dragon.Models.Bike:Clone();
                    v8.BikeRoot.ArmWeld.Part0 = v7["Right Arm"];
                    v8.Parent = Character;
                    u4.Bicycle = v8;
                    u3:Add(v8);
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        AutoSerialize = true,
                        IgnoreData = true,
                        Origin = v7.HumanoidRootPart.CFrame,
                        Particle = Dragon.Particles.BicycleMayhem.SummonFX,
                        Player = v7,
                        AttachTo = {
                            Part = v8.BikeRoot
                        }
                    });
                    local Animator = v7.Humanoid.Animator;

                    if not Animator:IsDescendantOf(workspace) then
                        return;
                    end;

                    local v9 = AnimationHandler.CreateAnimations("Dragon");
                    local v10 = AnimationHandler.new(Animator);
                    v10:AddAnimations(v9);
                    local v11 = v10:PlayAnimation(RevelationSequence);
                    u4.Animation = v11;
                    v11.Stopped:Wait();
                end },
            { 173, function(p12, p13) -- Line: 90
                    -- upvalues: u4 (copy), EffectsHandler (ref)
                    local Bicycle = u4.Bicycle;
                    Bicycle.BikeRoot.ArmWeld:Destroy();
                    Bicycle.BikeRoot:ClearAllChildren();
                    Bicycle.Body.Break:Play();

                    for _, child in Bicycle:GetChildren() do
                        if child:IsA("BasePart") then
                            child.CanCollide = true;
                        end;
                    end;

                    Bicycle.Parent = workspace.Effects;
                    task.spawn(function() -- Line: 105
                        -- upvalues: EffectsHandler (ref), u4 (ref)
                        EffectsHandler.CallEffect("Slam Effect", {
                            Radius = 8,
                            DebrisSize = Vector3.new(1.5, 1.5, 1.5),
                            Character = u4.Decoy,
                            Origin = u4.Decoy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                        });
                    end);
                    task.delay(1.5, Bicycle.Destroy, Bicycle);
                end },
            { 210, "End" }
        }
    });
    v14:Play();
    u3:Add(function() -- Line: 125
        -- upvalues: u4 (copy)
        table.clear(u4);
    end);

    while v14:IsPlaying() and Character.Parent ~= nil do
        task.wait(0.1);
    end;

    u3:Destroy();

    if Character.Parent then
        return true;
    end;
end;