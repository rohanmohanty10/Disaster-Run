  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;
local u2 = game.ReplicatedStorage["Client Assets"];
local u3 = Dialogue.new();

local function ResetDialogue() -- Line: 19
    -- upvalues: u3 (copy)
    u3:Destroy();
end;

u3:SetTitle("Mysterious Boat");
u3:SetStarterText("You find a mysterious boat, would you like to see where it takes you?");
u3:AddResponse("YES", function() -- Line: 26
    -- upvalues: u3 (copy), u2 (copy), LocalPlayer (copy), TweenService (copy)
    u3:SetText("Alright then, lets get rowing.");
    task.spawn(function() -- Line: 28
        -- upvalues: u2 (ref), LocalPlayer (ref), TweenService (ref)
        local v4 = workspace.NPCS["Motherland Boat"]:GetAttribute("Position");
        local v5 = u2.BlackScreen:Clone();
        v5.Parent = LocalPlayer.PlayerGui;
        local BlackScreen = v5.BlackScreen;
        TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.5);
        LocalPlayer:RequestStreamAroundAsync(v4, 5);
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v4 + Vector3.new(0, 5, 0));
        TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play();
        task.wait(0.5);
        v5:Destroy();
    end);

    return "ClearResponses";
end);
u3:AddResponse("No", function() -- Line: 46
    -- upvalues: u3 (copy)
    u3:SetText("Very well, come back whenever you please.");

    return "ClearResponses";
end);

return u3;