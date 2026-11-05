  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();
local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ClientAssets = PathShortcuts.ClientAssets;

local function IsPlayerInCombat(p4) -- Line: 18
    if p4 and p4.Character then
        return p4.Character:GetAttribute("InCombat") == true;
    end;

    return false;
end;

local function DetermineLocation(p5) -- Line: 26
    local v6 = { "Joestar Mansion", "Port", "Colosseum" };
    local v7 = p5:GetAttribute("Location");

    if v7 then
        if table.find(v6, v7) then
            table.remove(v6, table.find(v6, v7));
        end;

        return v6;
    end;
end;

u3:SetTitle("Ferry Boat Captain");
u3:SetStarterText("Where would you like to go?");

function u3.Setup(p8) -- Line: 45
    -- upvalues: u3 (copy), DetermineLocation (copy), u2 (copy), LocalPlayer (copy), ClientAssets (copy), TweenService (copy)
    u3:AddCallback("OnDestroy", function(p9) -- Line: 46
        table.clear(p9._Responses);
    end);
    local v10 = p8:GetNPCModel();

    if not v10 then
        return;
    end;

    local v11 = DetermineLocation(v10);
    local Teleports = workspace.Map.Teleports;
    local v12 = {
        ["Joestar Mansion"] = "__MansionTeleport",
        Port = "PortTeleport",
        Colosseum = "ColosseumTeleport"
    };

    for i = 1, #v11 do
        if not v11[i] then
            return;
        end;

        local u13 = u2:CheckRequirement("NPCLocation", Teleports, v12[v11[i]]):expect();

        if not u13 then
            return;
        end;

        u3:AddResponse("Take me to the " .. v11[i], function() -- Line: 68
            -- upvalues: LocalPlayer (ref), u3 (ref), u13 (copy), ClientAssets (ref), TweenService (ref)
            local v14 = LocalPlayer;
            local v15;

            if v14 and v14.Character then
                v15 = v14.Character:GetAttribute("InCombat") == true;
            else
                v15 = false;
            end;

            if v15 then
                u3:SetText("You\'re currently fighting someone, I\'m unable to help you at this time.");

                return "ClearResponses";
            end;

            u3:SetText("Very well, let\'s get moving then.");
            task.spawn(function() -- Line: 75
                -- upvalues: u13 (ref), ClientAssets (ref), LocalPlayer (ref), TweenService (ref)
                local Position = u13.Position;
                local v16 = ClientAssets.BlackScreen:Clone();
                local BlackScreen = v16.BlackScreen;
                v16.Parent = LocalPlayer.PlayerGui;
                task.delay(5, v16.Destroy, v16);
                TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0
                }):Play();
                task.wait(0.25);
                LocalPlayer.Character.HumanoidRootPart.Anchored = true;
                local v17 = os.clock();

                while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v17 <= 3 do
                    LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
                    task.wait(0.25);
                end;

                TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play();
                LocalPlayer.Character.HumanoidRootPart.Anchored = false;
                task.wait(0.5);
                v16:Destroy();
            end);

            return "ClearResponses";
        end);
    end;
end;

return u3;