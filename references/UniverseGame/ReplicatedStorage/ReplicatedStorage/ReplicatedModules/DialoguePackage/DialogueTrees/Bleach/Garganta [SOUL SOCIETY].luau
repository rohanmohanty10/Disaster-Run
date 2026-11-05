  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("DialogueService");
Knit.GetService("HakiService");
local u1 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function Teleport(p2) -- Line: 15
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
    if not (LocalPlayer and LocalPlayer.Character) then
        return;
    end;

    local Position = workspace.NPCS["Garganta [" .. (p2 or "Karakura Town"):upper() .. "]"].HumanoidRootPart.Position;
    local v3 = ReplicatedStorage["Client Assets"].BlackScreen:Clone();
    local BlackScreen = v3.BlackScreen;
    v3.Parent = LocalPlayer.PlayerGui;
    task.delay(5, v3.Destroy, v3);
    game.TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
        BackgroundTransparency = 0
    }):Play();
    task.wait(0.25);
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    local v4 = os.clock();

    while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v4 <= 3 do
        LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
        task.wait(0.25);
    end;

    game.TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play();
    LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    task.wait(0.5);
    v3:Destroy();
end;

return {
    Title = "Garganta",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: u1 (copy)
        return `step_{u1:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Which location would you like to go to?",
            Options = {
                {
                    Response = "Take me to Karakura Town.",

                    Callback = function(p5, p6, p7) -- Line: 68, Name: Callback
                        -- upvalues: Teleport (copy)
                        task.spawn(Teleport, "KARAKURA TOWN");
                        p6.Next = {
                            Text = "|| You have been teleported to Karakura Town ||"
                        };
                    end,

                    Next = {
                        Text = "alr"
                    }
                },
                {
                    Response = "Take me to Hueco Mundo.",

                    Callback = function(p8, p9, p10) -- Line: 82, Name: Callback
                        -- upvalues: Teleport (copy)
                        task.spawn(Teleport, "HUECO MUNDO");
                        p9.Next = {
                            Text = "|| You have been teleported to Hueco Mundo ||"
                        };
                    end,

                    Next = {
                        Text = "alr"
                    }
                }
            }
        }
    }
};