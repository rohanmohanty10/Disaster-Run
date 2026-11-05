  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v12 = {
    Tracks = {},
    Animations = {
        Action2 = {
            Thruster = 105398274261506
        },
        Action = {
            Jump = 133425306568093
        },
        Movement = {
            Fall = 114667950892929,
            Run = 92940901279847,
            Forward = 87857640824434,
            Idle = 111932861531019,
            Backward = 87857640824434
        }
    },

    Init = function(p1, p2, p3) -- Line: 31, Name: Init
        -- upvalues: LocalPlayer (copy), EffectsHandler (copy)
        local v4 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
        local Humanoid = v4:WaitForChild("Humanoid", 3);
        p1.Tracks = {};
        p1.State = "Idle";

        for _, v in Humanoid:GetPlayingAnimationTracks() do
            local v5 = p2.Animations:FindFirstChild(v.Name, true);

            if v5 and string.match(v5.AnimationId, "%d+$") == string.match(v.Animation.AnimationId, "%d+$") then
                p1.Tracks[v.Name] = v;
            end;
        end;

        for _, descendant in p2:GetDescendants() do
            if descendant:IsA("Animation") then
                local Name = descendant.Name;

                if not p1.Tracks[Name] then
                    p1.Tracks[Name] = Humanoid:LoadAnimation(descendant);

                    if descendant:IsDescendantOf(p2.Animations.Movement) then
                        local v6 = p1.Tracks[Name];
                        v6.Priority = Enum.AnimationPriority.Movement;
                        v6:Play(0.1);
                        v6:AdjustWeight(0.0001);
                    end;
                end;
            end;
        end;

        local v7 = { "Forward", "Backward", "Run" };
        local HumanoidRootPart = v4:FindFirstChild("HumanoidRootPart");

        for i = 1, #v7 do
            local u8 = v7[i];
            local u9 = p1.Tracks[u8];

            if u9 then
                p3:Connect(u9:GetMarkerReachedSignal("Step"), function(p10) -- Line: 79
                    -- upvalues: u9 (copy), u8 (copy), HumanoidRootPart (copy), EffectsHandler (ref)
                    if u9.WeightCurrent <= 0.5 then
                        return;
                    end;

                    if not HumanoidRootPart then
                        return;
                    end;

                    local v11 = HumanoidRootPart.CFrame * CFrame.new((u8 == "Backward" and (p10 == "Left" and "Right" or "Left") or p10) == "Left" and -3 or 3, -1, u8 == "Backward" and 2.5 or (u8 == "Forward" and -2.5 or (u8 == "Run" and -7.5 or 1)));
                    EffectsHandler.CallEffect("CRYSTAL_RaycastEmit", {
                        Direction = Vector3.new(-0, -10, -0),
                        YOffset = 0.25,
                        Origin = v11
                    }, {
                        RawPath = true,
                        Path = "Universal/Mounts/Khronos Walker/Footstep",
                        Scale = 1.2,
                        PlaySounds = true
                    });
                end);
            end;
        end;

        return p1.Tracks;
    end
};

local function Lerp(p13, p14, p15) -- Line: 102
    return p13 + (p14 - p13) * p15;
end;

function v12.Step(p16, p17, p18, p19, p20) -- Line: 106
    local v21 = p17 >= 7;
    local v22 = p17 <= -7;
    local v23 = p17 >= 55;
    local v24 = p16.OnGround();
    p16.State = v24 and (v21 and "Forward" or (v22 and "Backward" or "Idle")) or "Falling";
    p16.Tracks.Idle:AdjustWeight((v21 or (not v24 or v22)) and 0.0001 or 1, 0.2);
    p16.Tracks.Run:AdjustWeight(v21 and (v24 and v23) and 1 or 0.0001, 0.2);
    p16.Tracks.Forward:AdjustWeight(v21 and (v24 and not v23) and 1 or 0.0001, 0.2);
    p16.Tracks.Forward:AdjustSpeed(2.5);
    p16.Tracks.Backward:AdjustWeight(v22 and v24 and 1 or 0.0001, 0.2);
    p16.Tracks.Backward:AdjustSpeed(-2);
    p16.Tracks.Fall:AdjustWeight(v24 and 0.0001 or 1, 0.2);
    p16.Tracks.Fall:AdjustSpeed(0.7);
end;

local v25 = TableUtil.Reconcile(v12, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v25:CreateAnimatorFolder(script);

return v25;