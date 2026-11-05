  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v10 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 118045724726783,
            Fall = 118045724726783
        },
        Movement = {
            ["Train Forward"] = 119321878291880,
            ["Train Idle"] = 118045724726783,
            ["Train Wheels"] = 131246653343671
        }
    },

    Init = function(p1, p2) -- Line: 24, Name: Init
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

                        if Name == "Train Wheels" then
                            p1.Tracks[Name]:AdjustSpeed(0);
                        else
                            p1.Tracks[Name]:AdjustWeight(0.0001);
                        end;
                    end;
                end;
            end;
        end;

        return p1.Tracks;
    end,

    Step = function(p4, p5, p6, p7, p8) -- Line: 67, Name: Step
        local v9 = math.abs(p5) > 0;

        if p4.OnGround() then
            p4.Tracks["Train Idle"]:AdjustWeight(v9 and 0.0001 or 1);
            p4.Tracks["Train Forward"]:AdjustWeight(v9 and 1 or 0.0001);
        else
            p4:WeightAllTracks(0.0001, { "Train Idle", "Train Forward" });
        end;

        p4.Tracks["Train Wheels"]:AdjustSpeed(p5 / (p8 / 3));
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v10:CreateAnimatorFolder(script);

return v10;