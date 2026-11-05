  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ClientAssets = PathShortcuts.ClientAssets;

local function DetermineLocation(p2) -- Line: 11
    local v3 = { "Cathedral", "Main Area" };
    local v4 = p2:GetAttribute("Location");

    if not v4 then
        return v3;
    end;

    if table.find(v3, v4) then
        table.remove(v3, table.find(v3, v4));
    end;

    return v3;
end;

return {
    Title = "Bawxstar",

    Start = function() -- Line: 23, Name: GetStart
        return "teleport";
    end,

    Nodes = {
        teleport = {
            Mutable = true,
            Text = "Where would you like to go?",

            Transformer = function(p5, p6) -- Line: 34, Name: Transformer
                -- upvalues: LocalPlayer (copy), DetermineLocation (copy), u1 (copy), ClientAssets (copy), TweenService (copy), Dialogue (copy)
                local Model = p5.Metadata.Model;

                if not Model then
                    return;
                end;

                if LocalPlayer.Character:GetAttribute("InCombat") then
                    p6.Text = "Sorry, you have too much heat on you! Come back when you\'ve lost it.";
                    p6.Options = nil;

                    return;
                end;

                local v7 = DetermineLocation(Model);
                local Teleports = workspace.Map.Teleports;
                p6.Options = {};
                local v8 = {
                    Cathedral = "CathedralTeleport",
                    ["Main Area"] = "MainAreaTeleport"
                };

                for i = 1, #v7 do
                    local v9 = v7[i];

                    if v9 then
                        local u10 = u1:CheckRequirement("NPCLocation", Teleports, v8[v9]):expect();

                        if not u10 then
                            return;
                        end;

                        if u10 then
                            table.insert(p6.Options, {
                                Response = "Take me to the " .. v9,

                                Callback = function(p11, p12, p13) -- Line: 64, Name: Callback
                                    -- upvalues: u10 (copy), ClientAssets (ref), LocalPlayer (ref), TweenService (ref)
                                    task.spawn(function() -- Line: 65
                                        -- upvalues: u10 (ref), ClientAssets (ref), LocalPlayer (ref), TweenService (ref)
                                        local Position = u10.Position;
                                        local v14 = ClientAssets.BlackScreen:Clone();
                                        local BlackScreen = v14.BlackScreen;
                                        v14.Parent = LocalPlayer.PlayerGui;
                                        task.delay(5, v14.Destroy, v14);
                                        TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                                            BackgroundTransparency = 0
                                        }):Play();
                                        task.wait(0.25);
                                        LocalPlayer.Character.HumanoidRootPart.Anchored = true;
                                        local v15 = os.clock();

                                        while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v15 <= 3 do
                                            LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
                                            task.wait(0.25);
                                        end;

                                        TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                                            BackgroundTransparency = 1
                                        }):Play();
                                        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
                                        task.wait(0.5);
                                        v14:Destroy();
                                    end);
                                    p12.Next = {
                                        Text = "Alright, it\'ll just be a second.",
                                        Options = nil
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            });
                        end;
                    end;
                end;
            end
        }
    }
};