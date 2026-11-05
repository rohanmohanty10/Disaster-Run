  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v11 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17603859627
        },
        Movement = {
            ["Egg Fall"] = 17603853852,
            ["Egg Forward"] = 17603856046,
            ["Egg Idle"] = 17603858222,
            ["Egg Left"] = 17603860906,
            ["Egg Right"] = 17603862057,
            ["Egg Roll"] = 17603899857
        }
    },

    Init = function(p1, p2) -- Line: 26, Name: Init
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

                        if Name == "Egg Roll" then
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

    Step = function(p3, p4, p5, p6, p7) -- Line: 63, Name: Step
        local v8 = math.abs(p4) > 0;
        local v9 = p3.OnGround();

        if v9 then
            p3.Tracks["Egg Idle"]:AdjustWeight(v8 and 0.0001 or 1);
            p3.Tracks["Egg Roll"]:AdjustSpeed(p4 / (p7 / 3));
            p3.Tracks["Egg Roll"]:AdjustWeight(p3:IsPlaying("Jump") and 0.0001 or 1);
            local v10 = `Egg {p6 == -1 and "Left" or (p6 == 1 and "Right" or "Forward")}`;
            p3.Tracks[v10]:AdjustSpeed(p4 / (p7 / 3));

            for _, v in { "Egg Forward", "Egg Left", "Egg Right" } do
                p3.Tracks[v]:AdjustWeight(v8 and v == v10 and 1 or 0.0001);
            end;
        else
            p3:WeightAllTracks(0.0001, { "Egg Idle", "Egg Left", "Egg Right", "Egg Forward" });
        end;

        p3.Tracks["Egg Fall"]:AdjustWeight(v9 and 0.0001 or 1);
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v11:CreateAnimatorFolder(script);

return v11;