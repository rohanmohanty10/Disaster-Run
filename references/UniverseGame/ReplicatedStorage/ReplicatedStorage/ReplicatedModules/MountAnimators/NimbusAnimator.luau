  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v3 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17614985541
        },
        Movement = {
            ["Mount Idle"] = 17614985541
        }
    },

    Init = function(p1, p2) -- Line: 21, Name: Init
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
                        p1.Tracks[Name]:Play(0);
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v3:CreateAnimatorFolder(script);

return v3;