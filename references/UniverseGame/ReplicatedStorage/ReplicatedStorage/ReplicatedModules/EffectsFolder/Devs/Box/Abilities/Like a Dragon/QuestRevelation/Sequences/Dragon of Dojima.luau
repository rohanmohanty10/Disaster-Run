  

 

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
    local v20 = Sequence_V2.CreateFromOldSequence({
        Frames = {
            { 0, function(p5, p6) -- Line: 34
                    -- upvalues: u1 (ref), RevelationPoint (copy), u3 (copy), u4 (copy), AnimationHandler (ref), RevelationSequence (copy)
                    local v7 = u1.Decoy:Clone();
                    v7.HumanoidRootPart.CFrame = RevelationPoint.Positioning.CFrame;
                    v7.Parent = workspace.Effects;
                    local v8 = u1.Decoy:Clone();
                    v8.HumanoidRootPart.CFrame = RevelationPoint.Positioning.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
                    v8.Parent = workspace.Effects;
                    u3:Add(v7);
                    u3:Add(v8);
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = "rbxassetid://129683087394154";
                    Sound.Volume = 1;
                    Sound.RollOffMinDistance = 70;
                    Sound.RollOffMaxDistance = 100;
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
                    Sound.Parent = v7.HumanoidRootPart;
                    Sound:Play();
                    u3:Add(Sound);
                    u4.Decoy = v7;
                    u4.VictimDecoy = v7;
                    local Animator = v7.Humanoid.Animator;
                    local Animator2 = v8.Humanoid.Animator;

                    if not (Animator:IsDescendantOf(workspace) and Animator2:IsDescendantOf(workspace)) then
                        return;
                    end;

                    local v9 = AnimationHandler.CreateAnimations("Dragon");
                    local v10 = AnimationHandler.new(Animator);
                    v10:AddAnimations(v9);
                    local v11 = AnimationHandler.new(Animator2);
                    v11:AddAnimations(v9);
                    u4.AnimationPlayer = v10;
                    u4.VictimAnimationPlayer = v11;
                    u4.Anim = v10:PlayAnimation(RevelationSequence);
                end },
            { 22, function(p12, p13) -- Line: 81
                    -- upvalues: u4 (copy), RevelationSequence (copy), u3 (copy)
                    u4.Anim:Stop();
                    u4.AnimationPlayer:PlayAnimation(RevelationSequence .. " Attacker");
                    u4.VictimAnimationPlayer:PlayAnimation(RevelationSequence .. " Victim");
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = "rbxassetid://96659083754429";
                    Sound.Volume = 1;
                    Sound.RollOffMinDistance = 70;
                    Sound.RollOffMaxDistance = 100;
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
                    Sound.Parent = u4.Decoy.HumanoidRootPart;
                    Sound:Play();
                    u3:Add(Sound);
                end },
            { 65, function(p14, p15) -- Line: 100
                end },
            { 125, function(p16, p17) -- Line: 104
                end },
            { 182, function(p18, p19) -- Line: 108
                end }
        }
    });
    v20:Play();
    u3:Add(function() -- Line: 118
        -- upvalues: u4 (copy)
        table.clear(u4);
    end);

    while v20:IsPlaying() and Character.Parent ~= nil do
        task.wait(0.1);
    end;

    u3:Destroy();

    if Character.Parent then
        return true;
    end;
end;