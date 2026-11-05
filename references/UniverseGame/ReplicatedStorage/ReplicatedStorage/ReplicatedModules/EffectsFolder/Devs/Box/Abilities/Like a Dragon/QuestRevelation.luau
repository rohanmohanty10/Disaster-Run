  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AnimationHandler = require(ReplicatedModules.AnimationHandler);
require(ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.KnitPath.Trove);
local Sequences = script.Sequences;
local LocalPlayer = game.Players.LocalPlayer;
local u1 = game.ReplicatedStorage["Client Assets"].Assets.Universal.QuestAssets["Awakening The Dragon"];

return function(p2) -- Line: 16
    -- upvalues: LocalPlayer (copy), Sequences (copy), EffectsHandler (copy), u1 (copy), AnimationHandler (copy)
    local RevelationSequence = p2.RevelationSequence;

    if not RevelationSequence then
        return;
    end;

    local RemoteEvent = p2.RemoteEvent;

    if not RemoteEvent then
        return;
    end;

    p2.Prompt.Enabled = false;
    local Character = LocalPlayer.Character;
    p2.RevelationPoint.Transparency = 1;
    local v3 = Sequences:FindFirstChild(RevelationSequence);

    if v3 and not require(v3)(p2) then
        return;
    end;

    p2.Prompt:SetAttribute("Done", true);
    task.spawn(function() -- Line: 39
        -- upvalues: EffectsHandler (ref), Character (copy), u1 (ref)
        EffectsHandler.CallEffect("Camera Animation", {
            AbilityName = "Standless",
            AnimationName = "Revelation Camera",
            Speed = 1,
            CameraPart = "Camera",
            Character = Character,
            Target = Character,
            Offset = CFrame.new(0, -3, 0),
            FOVData = {
                TimeIn = 0,
                FOV = 70
            },
            CameraRig = u1.Camera
        });
    end);
    local v4 = AnimationHandler.Get(Character.Humanoid.Animator):PlayAnimation("Revelation");
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://132470886325041";
    Sound.Volume = 1;
    Sound.Parent = workspace.Effects;
    Sound:Play();
    v4.Stopped:Wait();
    Sound:Destroy();
    RemoteEvent:FireServer();
end;