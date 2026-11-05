  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
game:GetService("TweenService");
local _ = game.Players.LocalPlayer;
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AnimationHandler = require(ReplicatedModules.AnimationHandler);
local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.TableUtil);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.EffectsFolder.Devs.Boojie.Combat.Step);
local u1 = game.ReplicatedStorage["Client Assets"].Assets.Universal.QuestAssets["Awakening The Dragon"];
local LocalPlayer = game.Players.LocalPlayer;
local _ = game.ReplicatedStorage["Client Assets"].Assets.Abilities.Dragon;

return function(p2) -- Line: 20
    -- upvalues: LocalPlayer (copy), Trove (copy), u1 (copy), AnimationHandler (copy), Sequence_V2 (copy)
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
    local v10 = Sequence_V2.CreateFromOldSequence({
        Frames = {
            { 0, function(p5, p6) -- Line: 34
                    -- upvalues: u1 (ref), RevelationPoint (copy), u3 (copy), u4 (copy), AnimationHandler (ref), RevelationSequence (copy)
                    local v7 = u1.Decoy:Clone();
                    v7.HumanoidRootPart.CFrame = RevelationPoint.Positioning.CFrame;
                    v7.Parent = workspace.Effects;
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = "rbxassetid://76546517653461";
                    Sound.Volume = 1;
                    Sound.RollOffMinDistance = 70;
                    Sound.RollOffMaxDistance = 100;
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
                    Sound.Parent = v7.HumanoidRootPart;
                    Sound:Play();
                    u3:Add(Sound);
                    u3:Add(v7);
                    u4.Decoy = v7;
                    local Animator = v7.Humanoid.Animator;

                    if not Animator:IsDescendantOf(workspace) then
                        return;
                    end;

                    local v8 = AnimationHandler.CreateAnimations("Dragon");
                    local v9 = AnimationHandler.new(Animator);
                    v9:AddAnimations(v8);
                    v9:PlayAnimation(RevelationSequence).Stopped:Wait();
                    v7:Destroy();
                end },
            { 240, "End" }
        }
    });
    v10:Play();
    u3:Add(function() -- Line: 77
        -- upvalues: u4 (copy)
        table.clear(u4);
    end);

    while v10:IsPlaying() and Character.Parent ~= nil do
        task.wait(0.1);
    end;

    u3:Destroy();

    if Character.Parent then
        return true;
    end;
end;