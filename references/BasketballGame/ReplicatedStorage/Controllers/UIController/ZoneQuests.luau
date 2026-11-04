 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.Utility.Essentials);
local ZoneQuests = require(ReplicatedStorage.Shared.Tables.ZoneQuests);
local ZoneQuestMilestones = require(ReplicatedStorage.Shared.Tables.ZoneQuestMilestones);
local SeasonPass = require(ReplicatedStorage.Shared.Tables.SeasonPass);
require(ReplicatedStorage.Shared.Tables.Customization);
require(ReplicatedStorage.Shared.Tables.Zones);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Tables.Rarities);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local ZoneQuests2 = LocalPlayer.PlayerGui:WaitForChild("ZoneQuests");
local ZoneQuests3 = LocalPlayer.PlayerGui:WaitForChild("InGame").BG.ZoneQuests;
local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
local ZoneQuests4 = HUD.Right:WaitForChild("ZoneQuests");
local u1 = Trove.new();
local u14 = {
    ["Style Spins"] = function(p2: userdata, p3: any) -- Line: 36
        p2.Image = "rbxassetid://111333169806568";
    end,

    ["Lucky Style Spins"] = function(p4: userdata, p5: any) -- Line: 40
        p4.Image = "rbxassetid://111333169806568";
        script.Rainbow:Clone().Parent = p4;
    end,

    ["Zone Spins"] = function(p6: userdata, p7: any) -- Line: 46
        p6.Image = "rbxassetid://71537410313776";
    end,

    ["Lucky Zone Spins"] = function(p8: userdata, p9: any) -- Line: 50
        p8.Image = "rbxassetid://71537410313776";
        script.Rainbow:Clone().Parent = p8;
    end,

    Money = function(p10: userdata, p11: any) -- Line: 56
        p10.Image = "rbxassetid://120199213702338";
    end,

    [SeasonPass.Items.Currency.DisplayName] = function(p12: userdata, p13: any) -- Line: 60
        -- upvalues: SeasonPass (copy)
        p12.Image = SeasonPass.Items.Currency.Icon;
    end
};

local function deep_equals(p15, p16, p17) -- Line: 66
    -- upvalues: deep_equals (copy)
    if p15 == p16 then
        return true;
    end;

    local v18 = type(p15);

    if v18 ~= type(p16) then
        return false;
    end;

    if v18 ~= "table" then
        return false;
    end;

    if not p17 then
        local v19 = getmetatable(p15);

        if v19 and v19.__eq then
            return p15 == p16;
        end;
    end;

    for i, v in pairs(p15) do
        local v20 = p16[i];

        if v20 == nil or deep_equals(v, v20, p17) == false then
            return false;
        end;
    end;

    for i, _ in pairs(p16) do
        if p15[i] == nil then
            return false;
        end;
    end;

    return true;
end;

local u21 = Knit.CreateController({
    Name = "ZoneQuestsController"
});

function u21.UpdateQuestsGui() -- Line: 105
    -- upvalues: u1 (copy), Knit (copy), ZoneQuests4 (copy), ZoneQuests3 (copy), GetUnixTime (copy), ZoneQuests (copy), ZoneQuests2 (copy), NumberUtil (copy), u14 (copy), ZoneQuestMilestones (copy), Zones (copy), ReplicatedStorage (copy), RunService (copy), u21 (copy), TweenService (copy), deep_equals (copy)
    u1:Clean();
    Knit.GetController("Shop");
    local Controller = Knit.GetController("Network");
    local Service = Knit.GetService("ZoneQuestsService");

    if not ZoneQuests4.Visible then
        ZoneQuests4.Visible = true;
    end;

    if ZoneQuests3.Visible then
        if Controller.Player.SelectedZoneQuestSkill == "" or Controller.Player.ClaimedZoneQuest == script:GetAttribute("Zone") then
            ZoneQuests3.Visible = false;
        end;
    elseif Controller.Player.SelectedZoneQuestSkill ~= "" and Controller.Player.ClaimedZoneQuest ~= script:GetAttribute("Zone") then
        ZoneQuests3.Visible = true;
    end;

    if GetUnixTime() >= workspace:GetAttribute("ZoneQuestsTime") then
        ZoneQuests4.Visible = false;
        ZoneQuests3.Visible = false;

        return;
    end;

    local v22 = {};
    local v23 = {};
    local v24 = {};
    local v25 = 0;
    local v26 = 0;

    for i, v in ZoneQuests do
        v22[i] = #v;
        table.insert(v23, i);
        table.insert(v24, i);
    end;

    for i, v in Controller.Player.ZoneQuests do
        if table.find(v23, v.Skill) and not v.Completed then
            table.remove(v23, table.find(v23, v.Skill));
        end;

        if table.find(v24, v.Skill) and not v.Claimed then
            table.remove(v24, table.find(v24, v.Skill));
        end;

        v25 = v25 + math.ceil((v.Completed and 1 or v.Metadata[v.Metadata.Index] / v.Metadata.Target) / v22[v.Skill] * 100) / 100;

        if v.Skill == Controller.Player.SelectedZoneQuestSkill then
            local v27 = ZoneQuests[v.Skill][v.Index];

            if v27 then
                local InitialMetadata = v27.InitialMetadata;

                if typeof(InitialMetadata) == "function" then
                    InitialMetadata();
                end;

                local v28 = u1:Add(script.Quest:Clone());
                v28.Parent = ZoneQuests2.Quests.MainFrame.Quests.ScrollingFrame;
                v28.LayoutOrder = v.Index;
                v28.Description.Text = v27.Description;

                if v.Completed then
                    v28.Skip.Visible = false;

                    if v.Claimed then
                        v28.Claim.Visible = false;
                    end;
                end;

                u1:Connect(v28.Claim.MouseButton1Down, function() -- Line: 179
                    -- upvalues: Service (copy), v (copy)
                    Service:ClaimQuest(v.UniqueId);
                end);
                u1:Connect(v28.Skip.MouseButton1Down, function() -- Line: 183
                    -- upvalues: Service (copy), v (copy)
                    Service:SkipQuest(v.UniqueId);
                end);

                if v.Metadata.OneMatch then
                    if v.Completed then
                        v28.Progress.Text = "Progress: 1/1";
                        v28.BarBG.BarFill.UIGradient.Offset = Vector2.new(0, 0);
                    else
                        v28.Progress.Text = "Progress: 0/1";
                        v28.BarBG.BarFill.UIGradient.Offset = Vector2.new(-1, 0);
                    end;
                elseif v.Metadata[v.Metadata.Index] then
                    v28.Progress.Text = `Progress: {v.Completed and v.Metadata.Target or v.Metadata[v.Metadata.Index]}/{v.Metadata.Target}`;
                    v28.BarBG.BarFill.UIGradient.Offset = Vector2.new(math.clamp((v.Completed and 1 or v.Metadata[v.Metadata.Index] / v.Metadata.Target) - 1, -1, 0), 0);
                end;

                local v29 = u1:Add(script.InGameQuest:Clone());
                v29.Parent = ZoneQuests3;
                v29.LayoutOrder = i;
                v29.Description.Text = v27.Description;

                if v.Metadata.OneMatch then
                    if v.Completed then
                        v29.Progress.Text = "1/1";
                        v29.BarBG.BarFill.UIGradient.Offset = Vector2.new(0, 0);
                    else
                        v29.Progress.Text = "0/1";
                        v29.BarBG.BarFill.UIGradient.Offset = Vector2.new(-1, 0);
                    end;
                elseif v.Metadata[v.Metadata.Index] then
                    v29.Progress.Text = `{v.Completed and v.Metadata.Target or v.Metadata[v.Metadata.Index]}/{v.Metadata.Target}`;
                    v29.BarBG.BarFill.UIGradient.Offset = Vector2.new(math.clamp((v.Completed and 1 or v.Metadata[v.Metadata.Index] / v.Metadata.Target) - 1, -1, 0), 0);
                end;

                for _, v2 in v27.Rewards do
                    local v30 = v28.Rewards:FindFirstChild(v2.DataIndex) or string.find(v2.DataIndex, "Spins") and v28.Rewards.Spins;

                    if v30 then
                        v30.Text.Text = NumberUtil.TruncateNumber(v2.Value, 1) .. " " .. string.upper(v2.Name or v2.DataIndex);

                        if u14[v2.Name or v2.DataIndex] then
                            u14[v2.Name or v2.DataIndex](v30.Icon);
                        end;

                        v30.Visible = true;
                    end;
                end;

                if v.Completed then
                    v26 = v26 + 1;
                    v28.MainFrame.Image = "rbxassetid://127529996564405";
                    v28.BarBG.Image = "rbxassetid://106330374688289";
                    v28.BarBG.BarFill.Image = "rbxassetid://116364633278467";
                else
                    v28.MainFrame.Image = "rbxassetid://94715276510120";
                    v28.BarBG.Image = "rbxassetid://96026762536140";
                    v28.BarBG.BarFill.Image = "rbxassetid://112632919424186";
                end;
            end;
        end;
    end;

    for _, child in ZoneQuests2.Skills.Frame:GetChildren() do
        if child:IsA("ImageLabel") then
            local v31 = ZoneQuests2.Skills.TopFrame:FindFirstChild(child.Name);

            if v31 then
                v31.Visible = table.find(v23, child.Name);
            end;

            if table.find(v23, child.Name) or child.Name == Controller.Player.SelectedZoneQuestSkill then
                child.StartButton.Image = "rbxassetid://131884339326098";
                child.StartButton.Text.Text = table.find(v23, child.Name) and "CLAIM" or "IN PROGRESS";
            else
                child.StartButton.Image = "rbxassetid://89820913545544";
                child.StartButton.Text.Text = "START";
            end;

            if table.find(v24, child.Name) then
                child.StartButton.Visible = false;
                child.FinishedText.Visible = true;
                child.CheckIcon.Visible = true;
                child.Darkened.Visible = true;
            else
                child.StartButton.Visible = true;
                child.FinishedText.Visible = false;
                child.CheckIcon.Visible = false;
                child.Darkened.Visible = false;
            end;
        end;
    end;

    ZoneQuests2.Quests.MainFrame.Top.BarBg.BarFill.UIGradient.Offset = Vector2.new((v25 / 5 + 0.1) * 0.05 + math.floor(v25 - 1) * 0.2 - 1, 0);
    ZoneQuests3.CurrentQuests.Text = `Current Quests [{v26}/{v22[Controller.Player.SelectedZoneQuestSkill] or 0}]`;
    local v32 = ZoneQuestMilestones[1];
    local v33 = Zones.Zones[v32.Name];
    ZoneQuests2.Skills.TopFrame.ZoneBox.ZoneText.Text = v32.Name;
    u1:Add(ReplicatedStorage.Controllers.UIController.Zone.Gradients[v33.Rarity]:Clone()).Parent = ZoneQuests2.Skills.TopFrame.ZoneBox.ZoneText;
    local ZoneQuests5 = Controller.Player.ZoneQuests;
    local SelectedZoneQuestSkill = Controller.Player.SelectedZoneQuestSkill;
    local u34 = nil;
    u1:Add(RunService.Heartbeat:Connect(function() -- Line: 290
        -- upvalues: GetUnixTime (ref), u34 (ref), u21 (ref), ZoneQuests4 (ref), NumberUtil (ref), TweenService (ref)
        local v35 = GetUnixTime();

        if u34 == v35 then
            return;
        end;

        u34 = v35;
        local v36 = workspace:GetAttribute("ZoneQuestsTime") - v35;

        if v36 <= 0 then
            u21.UpdateQuestsGui();

            return;
        end;

        ZoneQuests4.Timer.Text = NumberUtil.AdaptiveClockString(v36);
        ZoneQuests4.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
        ZoneQuests4.Timer.Size = UDim2.fromScale(1, 0.45);
        TweenService:Create(ZoneQuests4.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.fromScale(1, 0.293)
        }):Play();
    end));
    u1:Add(ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 316
        -- upvalues: ZoneQuests2 (ref), deep_equals (ref), ZoneQuests5 (copy), Controller (copy), SelectedZoneQuestSkill (copy), u21 (ref)
        if not ZoneQuests2.Enabled then
            return;
        end;

        if not deep_equals(ZoneQuests5, Controller.Player.ZoneQuests) or SelectedZoneQuestSkill ~= Controller.Player.SelectedZoneQuestSkill then
            u21.UpdateQuestsGui();
        end;
    end));
end;

function u21.KnitInit(p37) -- Line: 324
end;

function u21.KnitStart(p38) -- Line: 328
    -- upvalues: Knit (copy), ZoneQuests2 (copy), u21 (copy), ZoneQuests4 (copy), HUD (copy), ZoneQuests3 (copy), Effects (copy)
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local Service = Knit.GetService("ZoneQuestsService");
    ZoneQuests2:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 334
        -- upvalues: ZoneQuests2 (ref), u21 (ref)
        if ZoneQuests2.Enabled then
            u21.UpdateQuestsGui();
        end;
    end);
    u21.UpdateQuestsGui();
    ZoneQuests4.Button.MouseButton1Down:Connect(function() -- Line: 341
        -- upvalues: ZoneQuests2 (ref), HUD (ref), Controller2 (copy)
        ZoneQuests2.Enabled = not ZoneQuests2.Enabled;
        HUD.Enabled = not ZoneQuests2.Enabled;
        Controller2:Focus(ZoneQuests2.Enabled, ZoneQuests2.Quests);
    end);
    local u39 = true;
    local Position = ZoneQuests3.Position;
    ZoneQuests3.Buttons.Arrow.MouseButton1Down:Connect(function() -- Line: 350
        -- upvalues: u39 (ref), ZoneQuests3 (ref), Position (copy)
        if u39 then
            u39 = false;
            ZoneQuests3.Buttons.Arrow.Rotation = 0;
            ZoneQuests3.Position = UDim2.new(Position.X.Scale - ZoneQuests3.Size.X.Scale * 1.05, 0, Position.Y.Scale, 0);

            return;
        end;

        u39 = true;
        ZoneQuests3.Buttons.Arrow.Rotation = 180;
        ZoneQuests3.Position = Position;
    end);
    ZoneQuests2.Skills.QuestionMark.MouseButton1Down:Connect(function() -- Line: 362
        -- upvalues: Effects (ref)
        Effects:Popup((`Complete all quests within each skill to unlock {script:GetAttribute("Zone")} Zone!`));
    end);
    ZoneQuests2.Quests.Back.MouseButton1Down:Connect(function() -- Line: 366
        -- upvalues: ZoneQuests2 (ref)
        ZoneQuests2.Skills.Visible = true;
        ZoneQuests2.Quests.Visible = false;
    end);

    for _, child in ZoneQuests2.Skills.Frame:GetChildren() do
        if child:IsA("ImageLabel") then
            child.StartButton.MouseButton1Down:Connect(function() -- Line: 373
                -- upvalues: child (copy), Controller (copy), Service (copy), u21 (ref), ZoneQuests2 (ref)
                if child.Name ~= Controller.Player.SelectedZoneQuestSkill then
                    Service:SelectSkill(child.Name);
                    Controller.Player.SelectedZoneQuestSkill = child.Name;
                    u21.UpdateQuestsGui();
                end;

                ZoneQuests2.Skills.Visible = false;
                ZoneQuests2.Quests.Visible = true;
            end);
        end;
    end;
end;

return u21;