  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v10 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 72104956496293,
            Fall = 72104956496293
        },
        Movement = {
            ["Tralalero Forward"] = 133458773035934,
            ["Tralalero Idle"] = 72104956496293
        }
    },

    Init = function(p1, p2) -- Line: 23, Name: Init
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
                        p1.Tracks[Name]:AdjustWeight(0.0001);
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end,

    Step = function(p4, p5, p6, p7, p8) -- Line: 62, Name: Step
        local v9 = math.abs(p5) > 0;

        if not p4.OnGround() then
            p4:WeightAllTracks(0.0001, { "Tralalero Idle", "Tralalero Forward" });

            return;
        end;

        p4.Tracks["Tralalero Idle"]:AdjustWeight(v9 and 0.0001 or 1);
        p4.Tracks["Tralalero Forward"]:AdjustWeight(v9 and 1 or 0.0001);
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v10:CreateAnimatorFolder(script);

return v10;