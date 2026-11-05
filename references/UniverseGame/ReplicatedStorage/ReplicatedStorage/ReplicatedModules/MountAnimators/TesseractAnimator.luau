  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v5 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Movement = {
            Forward = 18431776183,
            Idle = 18431770411,
            Backward = 18431774290
        }
    },

    Init = function(p1, p2) -- Line: 19, Name: Init
        -- upvalues: LocalPlayer (copy)
        local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid", 3);
        p1.Tracks = {};
        p1.State = "Idle";

        for _, v in Humanoid:GetPlayingAnimationTracks() do
            local v3 = p2.Animations:FindFirstChild(v.Name, true);

            if v3 and string.match(v3.AnimationId, "%d+$") == string.match(v.Animation.AnimationId, "%d+$") then
                p1.Tracks[v.Name] = v;
            end;
        end;

        for _, descendant in p2:GetDescendants() do
            if descendant:IsA("Animation") then
                local Name = descendant.Name;

                if not p1.Tracks[Name] then
                    p1.Tracks[Name] = Humanoid:LoadAnimation(descendant);

                    if descendant:IsDescendantOf(p2.Animations.Movement) then
                        local v4 = p1.Tracks[Name];
                        v4.Priority = Enum.AnimationPriority.Action2;
                        v4:Play(0.5);
                        v4:AdjustWeight(0.0001);
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.HoverboardAnimator));

local function Lerp(p6, p7, p8) -- Line: 64
    return p6 + (p7 - p6) * p8;
end;

function v5.Step(p9, p10, p11, p12, p13) -- Line: 68
    local v14 = p10 >= 10;
    local v15 = p10 <= -10;
    p9.State = v14 and "Forward" or (v15 and "Backward" or "Idle");
    p9.Tracks.Idle:AdjustWeight((v14 or v15) and 0.0001 or 1, 0.2);
    p9.Tracks.Forward:AdjustWeight(v14 and 1 or 0.0001, 0.2);
    p9.Tracks.Backward:AdjustWeight(v15 and 0.8 or 0.0001, 0.2);
end;

v5:CreateAnimatorFolder(script);

return v5;