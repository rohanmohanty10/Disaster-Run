  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v9 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {},
        Movement = {
            Idle = 95671356934914
        }
    },

    Init = function(p1, p2) -- Line: 22, Name: Init
        -- upvalues: LocalPlayer (copy)
        local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid", 3);
        p1.Tracks = {};

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
                        p1.Tracks[Name]:Play();
                        p1.Tracks[Name]:AdjustWeight(1);
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end,

    Step = function(p4, p5, p6, p7, p8) -- Line: 61, Name: Step
        p4.Tracks.Idle:AdjustSpeed(p6 > 0 and 3 or 1);
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v9:CreateAnimatorFolder(script);

return v9;