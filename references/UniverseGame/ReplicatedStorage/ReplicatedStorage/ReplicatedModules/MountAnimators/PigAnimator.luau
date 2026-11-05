  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v9 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {},
        Movement = {
            ["Mount Idle"] = 18332096569,
            Forward = 18332098310
        }
    },

    Init = function(p1, p2) -- Line: 22, Name: Init
        -- upvalues: LocalPlayer (copy)
        local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid", 3);
        p1.Tracks = {};

        for _, v in Humanoid:GetPlayingAnimationTracks() do
            if p2.Animations:FindFirstChild(v.Name, true) then
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

                        if Name == "Forward" then
                            p1.Tracks[Name]:AdjustSpeed(0);
                            p1.Tracks[Name]:AdjustWeight(0.0001);
                        end;
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end,

    Step = function(p3, p4, p5, p6, p7) -- Line: 57, Name: Step
        local v8 = math.abs(p4) > 0;
        p3.Tracks.Forward:AdjustSpeed(p4 / (p7 / 3));
        p3.Tracks.Forward:AdjustWeight(v8 and 1 or 0.0001);
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v9:CreateAnimatorFolder(script);

return v9;