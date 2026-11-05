  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v10 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 18300450103
        },
        Movement = {
            ["Striker Fall"] = 18300265695,
            ["Striker Forward"] = 18300452013,
            ["Striker Idle"] = 18300448069
        }
    },

    Init = function(p1, p2) -- Line: 23, Name: Init
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
                        p1.Tracks[Name]:AdjustWeight(0.0001);
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end,

    Step = function(p3, p4, p5, p6, p7) -- Line: 55, Name: Step
        local v8 = math.abs(p4) > 0;
        local v9 = p3.OnGround();

        if v9 then
            p3.Tracks["Striker Idle"]:AdjustWeight(v8 and 0.0001 or 1);
            p3.Tracks["Striker Forward"]:AdjustWeight(v8 and 1 or 0.0001);
        else
            p3:WeightAllTracks(0.0001, { "Striker Idle", "Striker Forward" });
        end;

        p3.Tracks["Striker Fall"]:AdjustWeight(v9 and 0.0001 or 1);
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v10:CreateAnimatorFolder(script);

return v10;