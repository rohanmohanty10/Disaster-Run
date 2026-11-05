  

 

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
    local v6 = { "Shibuya", "Main Spawn" };
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
    -- upvalues: u3 (copy), LocalPlayer (copy), DetermineLocation (copy), u2 (copy), ClientAssets (copy), TweenService (copy)
    u3:AddCallback("OnDestroy", function(p9) -- Line: 47
        table.clear(p9._Responses);
    end);
    local v10 = p8:GetNPCModel();

    if not v10 then
        return;
    end;

    local v11 = LocalPlayer;
    local v12;

    if v11 and v11.Character then
        v12 = v11.Character:GetAttribute("InCombat") == true;
    else
        v12 = false;
    end;

    if v12 then
        u3:SetText("You\'re currently fighting someone, I\'m unable to help you at this time.");

        return;
    end;

    local u13 = DetermineLocation(v10);
    local Teleports = workspace.Map.Teleports;
    local v14 = {
        Shibuya = "Shibuya",
        ["Main Spawn"] = "Main_Area"
    };

    for i = 1, #u13 do
        if not u13[i] then
            return;
        end;

        local u15 = u2:CheckRequirement("NPCLocation", Teleports, v14[u13[i]]):expect();

        if not u15 then
            return;
        end;

        u3:AddResponse("Take me to " .. u13[i], function() -- Line: 75
            -- upvalues: LocalPlayer (ref), u13 (copy), i (copy), u3 (ref), u15 (copy), ClientAssets (ref), TweenService (ref)
            if LocalPlayer.Data.Ability:GetAttribute("AbilityLevel") < 150 and u13[i] == "Shibuya" then
                u3:SetText("You need level 150 to go through.");

                return "ClearResponses";
            end;

            local v16 = LocalPlayer;
            local v17;

            if v16 and v16.Character then
                v17 = v16.Character:GetAttribute("InCombat") == true;
            else
                v17 = false;
            end;

            if v17 then
                u3:SetText("You\'re currently fighting someone, I\'m unable to help you at this time.");

                return "ClearResponses";
            end;

            u3:SetText("To " .. u13[i] .. " we go!");
            task.delay(0.5, function() -- Line: 90
                -- upvalues: LocalPlayer (ref), u15 (ref), ClientAssets (ref), TweenService (ref)
                if not (LocalPlayer and LocalPlayer.Character) then
                    return;
                end;

                local Position = u15.Position;
                local v18 = ClientAssets.BlackScreen:Clone();
                local BlackScreen = v18.BlackScreen;
                v18.Parent = LocalPlayer.PlayerGui;
                task.delay(5, v18.Destroy, v18);
                TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0
                }):Play();
                task.wait(0.25);
                LocalPlayer.Character.HumanoidRootPart.Anchored = true;
                local v19 = os.clock();

                while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v19 <= 3 do
                    LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
                    task.wait(0.25);
                end;

                TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
                    BackgroundTransparency = 1
                }):Play();
                LocalPlayer.Character.HumanoidRootPart.Anchored = false;
                task.wait(0.5);
                v18:Destroy();
            end);

            return "ClearResponses";
        end);
    end;
end;

return u3;