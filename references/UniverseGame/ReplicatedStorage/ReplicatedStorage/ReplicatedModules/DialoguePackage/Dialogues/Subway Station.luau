  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u3 = Dialogue.new();
local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ClientAssets = PathShortcuts.ClientAssets;

local function IsPlayerInCombat(p4) -- Line: 19
    if p4 and p4.Character then
        return p4.Character:GetAttribute("InCombat") == true;
    end;

    return false;
end;

local function DetermineLocation(p5) -- Line: 27
    local v6 = { "Subway Area", "Subway Entrance" };
    local v7 = p5:GetAttribute("Location");

    if v7 then
        if table.find(v6, v7) then
            table.remove(v6, table.find(v6, v7));
        end;

        return v6;
    end;
end;

u3:SetTitle("Train Station");
u3:SetStarterText("Where do you wanna go?");

function u3.Setup(p8) -- Line: 46
    -- upvalues: u3 (copy), DetermineLocation (copy), u2 (copy), LocalPlayer (copy), ClientAssets (copy), TweenService (copy)
    u3:AddCallback("OnDestroy", function(p9) -- Line: 47
        table.clear(p9._Responses);
    end);
    local v10 = p8:GetNPCModel();

    if not v10 then
        return;
    end;

    local u11 = DetermineLocation(v10);
    local Teleports = workspace.Map.Teleports;
    local v12 = {
        ["Subway Area"] = "SubwayArea_Teleport",
        ["Subway Entrance"] = "SubwayEnter_Teleport"
    };

    for i = 1, #u11 do
        if not u11[i] then
            return;
        end;

        local u13 = u2:CheckRequirement("NPCLocation", Teleports, v12[u11[i]]):expect();

        if not u13 then
            return;
        end;

        u3:AddResponse("Take me to " .. u11[i], function() -- Line: 70
            -- upvalues: LocalPlayer (ref), u3 (ref), u11 (copy), i (copy), u13 (copy), ClientAssets (ref), TweenService (ref)
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

            u3:SetText("To " .. u11[i] .. " we go!");
            task.delay(0.5, function() -- Line: 79
                -- upvalues: LocalPlayer (ref), u13 (ref), ClientAssets (ref), TweenService (ref)
                if not (LocalPlayer and LocalPlayer.Character) then
                    return;
                end;

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

                TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
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