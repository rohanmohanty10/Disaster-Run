  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v11 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17604294710
        },
        Movement = {
            ["Kart Fall"] = 17604295953,
            ["Kart Forward"] = 17604298799,
            ["Kart Idle"] = 17604285034,
            ["Kart Left"] = 17604297260,
            ["Kart Right"] = 17604299880,
            ["Kart Wheels"] = 17604301344
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
                        p1.Tracks[Name]:Play(Name == "Kart Idle" and 0 or nil);

                        if Name == "Kart Wheels" then
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

    Step = function(p3, p4, p5, p6, p7) -- Line: 62, Name: Step
        local v8 = math.abs(p4) > 0;
        local v9 = p3.OnGround();

        if v9 then
            p3.Tracks["Kart Idle"]:AdjustWeight(v8 and 0.0001 or 1);
            local v10 = `Kart {p6 == -1 and "Left" or (p6 == 1 and "Right" or "Forward")}`;

            for _, v in { "Kart Forward", "Kart Left", "Kart Right" } do
                p3.Tracks[v]:AdjustWeight(v8 and v == v10 and 1 or 0.0001);
            end;
        else
            p3:WeightAllTracks(0.0001, { "Kart Idle", "Kart Legs", "Kart Left", "Kart Right", "Kart Forward" });
        end;

        p3.Tracks["Kart Fall"]:AdjustWeight(v9 and 0.0001 or 1);
        p3.Tracks["Kart Wheels"]:AdjustSpeed(p4 / (p7 / 3));
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
v11:CreateAnimatorFolder(script);

return v11;