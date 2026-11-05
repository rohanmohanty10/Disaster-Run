  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The Mercenaries"
    },
    Animations = {
        Action = {
            Idle = 94673611984713,
            Walk = 94673611984713,
            Run = 94673611984713,
            Jump = 94673611984713,
            Fall = 94673611984713
        }
    },
    Stats = {
        Pose = {
            MusicAmount = 2
        }
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = "rbxassetid://106894303051133",
            Volume = 4,
            PlaybackSpeed = 0.825,
            Looped = true,
            TimePosition = 0
        },
        ["PoseMusic-2"] = {
            SoundId = "rbxassetid://117857953266194",
            Volume = 4,
            PlaybackSpeed = 1.175,
            Looped = true,
            TimePosition = 0
        }
    },
    Metadata = {
        PostRig = function(p1) -- Line: 44, Name: PostRig
            local Player = p1.Player;
            local Character = p1.Character;
            local _ = p1.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            if not Player.Settings.CosmeticalChanges.Value then
                return;
            end;

            task.delay(0.016666666666666666, function() -- Line: 55
                -- upvalues: Character (copy)
                if not Character then
                    return;
                end;

                for _, child in Character:GetChildren() do
                    if child:IsA("BasePart") then
                        local v2 = child:FindFirstChildOfClass("SpecialMesh");

                        if v2 then
                            v2:Destroy();
                        end;

                        local SpecialMesh = Instance.new("SpecialMesh");
                        SpecialMesh.Scale = Vector3.new(0, 0, 0);
                        SpecialMesh.Parent = child;
                        child.Transparency = 1;
                    elseif child:IsA("Accessory") then
                        child:Destroy();
                    end;
                end;
            end);
            local v3 = game.ServerStorage.StandModels["34"]["SCOUT MODEL"]:Clone();
            v3.Parent = Character;
            v3.Root.CFrame = Character.HumanoidRootPart.CFrame;
            v3.Root.Anchored = false;
            v3.Root.Weld.Part1 = Character.HumanoidRootPart;
        end
    }
};