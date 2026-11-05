  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v12 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17461741279
        },
        Movement = {
            ["Bike Fall"] = 17477069400,
            ["Bike Forward"] = 17461751169,
            ["Bike Idle"] = 17461693191,
            ["Bike Left"] = 17461728956,
            ["Bike Legs"] = 17461711918,
            ["Bike Right"] = 17461724621,
            ["Bike Wheels"] = 17477073229
        }
    },

    Init = function(p1, p2) -- Line: 27, Name: Init
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

                        if Name == "Bike Wheels" then
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

    Step = function(p4, p5, p6, p7, p8) -- Line: 70, Name: Step
        local v9 = math.abs(p5) > 0;
        local v10 = p4.OnGround();

        if v10 then
            p4.Tracks["Bike Idle"]:AdjustWeight(v9 and 0.0001 or 1);

            if p4.Tracks["Bike Legs"] then
                p4.Tracks["Bike Legs"]:AdjustWeight(v9 and 1 or 0.0001);
                p4.Tracks["Bike Legs"]:AdjustSpeed((p6 == 0 or not v9) and 0 or ((p6 < 0 and -1 or 1) * math.abs(p5) / (p8 / 3) or 0));
            end;

            local v11 = `Bike {p7 == -1 and "Left" or (p7 == 1 and "Right" or "Forward")}`;

            for _, v in { "Bike Forward", "Bike Left", "Bike Right" } do
                p4.Tracks[v]:AdjustWeight(v9 and v == v11 and 1 or 0.0001);
            end;
        else
            p4:WeightAllTracks(0.0001, { "Bike Idle", "Bike Legs", "Bike Left", "Bike Right", "Bike Forward" });
        end;

        p4.Tracks["Bike Fall"]:AdjustWeight(v10 and 0.0001 or 1);
        p4.Tracks["Bike Wheels"]:AdjustSpeed(p5 / (p8 / 3));
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v12:CreateAnimatorFolder(script);

return v12;