  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local ClientAssets = PathShortcuts.ClientAssets;

local function DetermineLocation(p2) -- Line: 16
    local v3 = { "Shibuya", "Main Spawn" };
    local v4 = p2:GetAttribute("Location");

    if v4 then
        if table.find(v3, v4) then
            table.remove(v3, table.find(v3, v4));
        end;

        return v3;
    end;
end;

return {
    Title = "Subway Station",

    Start = function() -- Line: 12, Name: GetStart
        return "start";
    end,

    Nodes = {
        start = {
            Mutable = true,
            Text = "Where do you wanna go?",

            Transformer = function(p5, p6) -- Line: 35, Name: Transformer
                -- upvalues: Players (copy), DetermineLocation (copy), u1 (copy), ClientAssets (copy), TweenService (copy)
                local LocalPlayer = Players.LocalPlayer;
                local Model = p5:GetMetadata().Model;

                if LocalPlayer.Character:GetAttribute("InCombat") then
                    p6.Text = "You\'re currently fighting someone, I\'m unable to help you at this time.";
                    p6.Options = {};

                    return;
                end;

                local v7 = DetermineLocation(Model);
                local Teleports = workspace.Map.Teleports;
                p6.Options = {};
                local v8 = {
                    Shibuya = "Shibuya",
                    ["Main Spawn"] = "Main_Area"
                };

                for _, v in ipairs(v7 or {}) do
                    local u9 = u1:CheckRequirement("NPCLocation", Teleports, v8[v]):expect();

                    if u9 then
                        table.insert(p6.Options, {
                            Response = "Take me to " .. v,

                            Callback = function() -- Line: 57, Name: Callback
                                -- upvalues: LocalPlayer (copy), u9 (copy), ClientAssets (ref), TweenService (ref)
                                task.delay(0.5, function() -- Line: 58
                                    -- upvalues: LocalPlayer (ref), u9 (ref), ClientAssets (ref), TweenService (ref)
                                    if not (LocalPlayer and LocalPlayer.Character) then
                                        return;
                                    end;

                                    local Position = u9.Position;
                                    local v10 = ClientAssets.BlackScreen:Clone();
                                    local BlackScreen = v10.BlackScreen;
                                    v10.Parent = LocalPlayer.PlayerGui;
                                    task.delay(5, v10.Destroy, v10);
                                    TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                                        BackgroundTransparency = 0
                                    }):Play();
                                    task.wait(0.25);
                                    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
                                    local v11 = os.clock();

                                    while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v11 <= 3 do
                                        LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
                                        task.wait(0.25);
                                    end;

                                    TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
                                        BackgroundTransparency = 1
                                    }):Play();
                                    LocalPlayer.Character.HumanoidRootPart.Anchored = false;
                                    task.wait(0.5);
                                    v10:Destroy();
                                end);
                            end,

                            Next = {
                                Text = "To " .. v .. " we go!"
                            }
                        });
                    end;
                end;
            end,

            Options = {}
        }
    }
};