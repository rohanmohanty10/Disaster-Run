  

 

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

local function DetermineLocation(p4) -- Line: 18
    local v5 = { "Ice Fortress", "Main Area" };
    local v6 = p4:GetAttribute("Location");

    if v6 then
        if table.find(v5, v6) then
            table.remove(v5, table.find(v5, v6));
        end;

        return v5;
    end;
end;

u3:SetTitle("Bawxstar");
u3:SetStarterText("Where would you like to go?");

function u3.Setup(p7) -- Line: 36
    -- upvalues: u3 (copy), LocalPlayer (copy), DetermineLocation (copy), u2 (copy), ClientAssets (copy), TweenService (copy)
    u3:AddCallback("OnDestroy", function(p8) -- Line: 37
        table.clear(p8._Responses);
    end);
    local v9 = p7:GetNPCModel();

    if not v9 then
        return;
    end;

    if LocalPlayer.Character:GetAttribute("InCombat") then
        u3:SetText("Sorry, you have too much heat on you! Come back when you\'ve lost it.");

        return;
    end;

    local v10 = DetermineLocation(v9);
    local Teleports = workspace.Map.Teleports;
    local v11 = {
        ["Ice Fortress"] = "IceFortressTeleport",
        ["Main Area"] = "MainAreaTeleport"
    };

    for i = 1, #v10 do
        if not v10[i] then
            return;
        end;

        local u12 = u2:CheckRequirement("NPCLocation", Teleports, v11[v10[i]]):expect();

        if not u12 then
            return;
        end;

        u3:AddResponse("Take me to the " .. v10[i], function() -- Line: 64
            -- upvalues: u3 (ref), u12 (copy), ClientAssets (ref), LocalPlayer (ref), TweenService (ref)
            u3:SetText("Alright, it\'ll just be a second.");
            task.spawn(function() -- Line: 67
                -- upvalues: u12 (ref), ClientAssets (ref), LocalPlayer (ref), TweenService (ref)
                local Position = u12.Position;
                local v13 = ClientAssets.BlackScreen:Clone();
                local BlackScreen = v13.BlackScreen;
                v13.Parent = LocalPlayer.PlayerGui;
                task.delay(5, v13.Destroy, v13);
                TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0
                }):Play();
                task.wait(0.25);
                LocalPlayer.Character.HumanoidRootPart.Anchored = true;
                local v14 = os.clock();

                while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v14 <= 3 do
                    LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
                    task.wait(0.25);
                end;

                TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play();
                LocalPlayer.Character.HumanoidRootPart.Anchored = false;
                task.wait(0.5);
                v13:Destroy();
            end);

            return "ClearResponses";
        end);
    end;
end;

return u3;