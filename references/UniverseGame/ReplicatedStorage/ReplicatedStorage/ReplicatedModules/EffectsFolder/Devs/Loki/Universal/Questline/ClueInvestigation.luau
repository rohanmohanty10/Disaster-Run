  

 

local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
require(ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = Knit.GetService("DialogueService");
local LocalPlayer = Players.LocalPlayer;
local Petal = _G.Petal;
Petal("New");
local Tween = Petal("Util").Tween;

return function(p2) -- Line: 21
    -- upvalues: AssetHandler (copy), Trove (copy), u1 (copy), LocalPlayer (copy), Tween (copy)
    local u3 = AssetHandler.GetAsset("Universal/QuestAssets/The Infinite Rotation");
    local Duration = p2.Duration;
    local u4 = Trove.new();
    local u5 = workspace.ItemSpawns.InvestigationClues:GetChildren();
    local u6 = { "Flag", "Dirty Napkin", "Blood Stains", "Corpse Part" };
    local v7 = #u6;
    local u8 = 0;

    local function CreateClue(p9) -- Line: 39
        -- upvalues: u6 (copy), u5 (copy), u3 (copy), u1 (ref), CreateClue (copy), u4 (copy)
        if #u6 == 0 or #u5 == 0 then
            print("Possible clues exhausted");

            return;
        end;

        local v10 = math.random(1, #u6);
        local v11 = math.random(1, #u5);
        local u12 = u6[v10];
        local v13 = u5[v11];
        local u14 = u3:FindFirstChild(u12):Clone();
        table.remove(u6, v10);
        table.remove(u5, v11);
        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.ActionText = "Confiscate";
        ProximityPrompt.ObjectText = u12;
        ProximityPrompt.MaxActivationDistance = 10;
        ProximityPrompt.Name = "";
        ProximityPrompt.Parent = u14;
        ProximityPrompt.Triggered:Once(function() -- Line: 64
            -- upvalues: u1 (ref), u12 (copy), u14 (copy), u6 (ref), CreateClue (ref)
            local v15 = u1:CheckRequirement("ClueConfiscated", u12):expect();
            print(v15);
            u14:Destroy();

            if #u6 > 0 then
                task.delay(5, function() -- Line: 71
                    -- upvalues: CreateClue (ref)
                    CreateClue();
                end);
            end;
        end);
        u14.Parent = workspace.Effects;
        u14.CFrame = v13.CFrame;
        u4:Add(u14);
    end;

    local function toHMS(p16) -- Line: 84
        return string.format("%02i:%02i", p16 / 60 % 60, p16 % 60);
    end;

    local u17 = Color3.fromRGB(95, 255, 92);
    local u18 = Color3.fromRGB(255, 73, 73);

    local function UpdateTimer(p19) -- Line: 89
        -- upvalues: u8 (ref), Duration (copy), u17 (copy), u18 (copy)
        local Remaining = p19.Holder.Remaining;
        local v20 = math.abs(u8 - Duration);
        local v21 = math.max(0, v20);
        Remaining.Text = `TIME REMAINING: {string.format("%02i:%02i", v21 / 60 % 60, v21 % 60)}`;
        p19.Holder.ProgressBar.Bar.Size = UDim2.fromScale(math.clamp(1 - u8 / Duration, 0, 1), 1);
        p19.Holder.ProgressBar.Bar.BackgroundColor3 = u17:Lerp(u18, (math.clamp(u8 / Duration, 0, 1)));
    end;

    local v22 = AssetHandler.CloneAsset("Universal/QuestAssets/The Infinite Rotation/Timer");
    v22.Parent = LocalPlayer.PlayerGui.Core;
    local Holder = v22.Holder;
    Holder.Position = Holder.Position - UDim2.fromScale(0, 0.15);
    v22.Visible = true;
    Tween(v22.Holder, 1.5, "Back", "Out", {
        Position = v22.Holder.Position + UDim2.fromScale(0, 0.15)
    });
    UpdateTimer(v22);
    u4:Add(v22);
    CreateClue();
    local v23 = false;

    while u8 <= Duration do
        u8 = u8 + task.wait(0.1);
        UpdateTimer(v22);
        v23 = LocalPlayer:GetAttribute("CluesConfiscated") == v7 and not v23 and true or v23;

        if not LocalPlayer:GetAttribute("InInvestigation") then
            break;
        end;
    end;

    print(v23 == true and "Success" or "Failed");
    u4:Destroy();
end;