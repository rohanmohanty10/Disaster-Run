 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Quests = require(ReplicatedStorage.Shared.Tables.Quests);
local QuestMilestones = require(ReplicatedStorage.Shared.Tables.QuestMilestones);
require(ReplicatedStorage.Shared.Tables.Rarities);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Quests2 = LocalPlayer.PlayerGui:WaitForChild("Quests");
local u1 = Trove.new();
local u14 = {
    ["Style Spins"] = function(p2: userdata, p3: any) -- Line: 20
        p2.Image = "rbxassetid://111333169806568";
    end,

    ["Lucky Style Spins"] = function(p4: userdata, p5: any) -- Line: 23
        p4.Image = "rbxassetid://111333169806568";
        script.Rainbow:Clone().Parent = p4;
    end,

    ["Zone Spins"] = function(p6: userdata, p7: any) -- Line: 28
        p6.Image = "rbxassetid://71537410313776";
    end,

    ["Lucky Zone Spins"] = function(p8: userdata, p9: any) -- Line: 31
        p8.Image = "rbxassetid://71537410313776";
        script.Rainbow:Clone().Parent = p8;
    end,

    ["Ball Trail Spins"] = function(p10: userdata, p11: any) -- Line: 36
        p10.Image = "rbxassetid://118616255715301";
    end,

    Emote = function(p12: userdata, p13: any) -- Line: 39
        -- upvalues: Knit (copy)
        p12.ImageTransparency = 1;
        local ViewportFrame = Instance.new("ViewportFrame");
        ViewportFrame.Size = UDim2.fromScale(1, 1);
        ViewportFrame.Ambient = Color3.fromRGB(255, 255, 255);
        ViewportFrame.BackgroundTransparency = 1;
        ViewportFrame.ZIndex = p12.ZIndex;
        ViewportFrame.Parent = p12;
        local Controller = Knit.GetController("EmotesController");

        while not Controller.CharacterRig do
            task.wait();
        end;

        Controller:CreatePreview(p13, ViewportFrame, Controller.CharacterRig);
    end
};

local function deep_equals(p15, p16, p17) -- Line: 60
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
    Name = "QuestsController",
    CurrentlyVisible = "DailyQuests"
});

function u21.FormatProgress(p22: string, p23: number, p24: number) -- Line: 100
    -- upvalues: NumberUtil (copy)
    local WithCommas = NumberUtil.WithCommas;

    if p22 == "Playtime" then
        p23 = math.floor(p23 / 60) or p23;
    end;

    local v25 = WithCommas(p23);
    local WithCommas2 = NumberUtil.WithCommas;

    if p22 == "Playtime" then
        p24 = math.floor(p24 / 60) or p24;
    end;

    return `{v25}/{WithCommas2(p24)}`;
end;

function u21.FormatValue(p26) -- Line: 104
    -- upvalues: NumberUtil (copy)
    if typeof(p26.Value) ~= "number" then
        return p26.Value;
    end;

    if p26.Reward == "Money" then
        return `${NumberUtil.WithCommas(p26.Value)}`;
    end;

    return NumberUtil.WithCommas(p26.Value);
end;

function u21.MakeVisible(p27: userdata) -- Line: 116
    -- upvalues: Quests2 (copy), u21 (copy)
    for _, v in { Quests2.Content.Holder.Contents.DailyQuests, Quests2.Content.Holder.Contents.SeasonPassQuests } do
        v.Visible = false;
    end;

    p27.Visible = true;

    for _, child in Quests2.Content.Holder.Header:GetChildren() do
        if child:IsA("ImageButton") and child.Name ~= "Close" then
            child.ImageColor3 = `{child.Name}Quests` == p27.Name and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(145, 145, 145);
        end;
    end;

    Quests2.Content.Holder.Title.Text = p27.Name == "DailyQuests" and "DAILY QUESTS" or (p27.Name == "SeasonPassQuests" and "SEASON PASS QUESTS" or "QUESTS");
    Quests2.Content.Holder.Contents.Rewards.Visible = p27.Name == "DailyQuests";
    u21.CurrentlyVisible = p27.Name;
end;

function u21.UpdateQuestsGui() -- Line: 136
    -- upvalues: u1 (copy), Knit (copy), QuestMilestones (copy), Quests2 (copy), u21 (copy), u14 (copy), TweenService (copy), Effects (copy), RunService (copy), GetUnixTime (copy), NumberUtil (copy), Quests (copy), MarketplaceService (copy), LocalPlayer (copy), ReplicatedStorage (copy), deep_equals (copy)
    u1:Clean();
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("SeasonPass");

    for i, v in QuestMilestones do
        if v == false then
            local v28 = u1:Add(script.BlankItemDisplay:Clone());
            v28.LayoutOrder = i;
            v28.Parent = Quests2.Content.Holder.Contents.Rewards.ItemDisplays;
        else
            local v29 = u1:Add(script.ItemDisplay:Clone());
            v29.LayoutOrder = i;
            v29.AmountLabel.Text = `{u21.FormatValue(v)} {v.Reward}`;
            v29.Parent = Quests2.Content.Holder.Contents.Rewards.ItemDisplays;

            if u14[v.Reward] then
                u14[v.Reward](v29.RewardIcon, v.Value);
            else
                v29.RewardIcon.Image = "rbxassetid://82949801556287";
            end;
        end;
    end;

    local UIGradient = Quests2.Content.Holder.Contents.Rewards.ProgressBar.Fill.UIGradient;
    local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local v30 = {};
    local v31;

    if Controller.Player.TotalQuestsCompleted == 0 then
        v31 = Quests2.Content.Holder.Contents.Rewards.ProgressBar.Fill.UIGradient.Offset.X > -0.335 and 0 or -1;
    else
        v31 = Controller.Player.TotalQuestsCompleted == 1 and -0.908 or (Controller.Player.TotalQuestsCompleted == 2 and -0.765 or (Controller.Player.TotalQuestsCompleted == 3 and -0.621 or (Controller.Player.TotalQuestsCompleted == 4 and -0.477 or (Controller.Player.TotalQuestsCompleted == 5 and -0.335 or (Controller.Player.TotalQuestsCompleted == 6 and -0.191 or 0)))));
    end;

    v30.Offset = Vector2.new(v31);
    TweenService:Create(UIGradient, TweenInfo_new_ret, v30):Play();

    if Controller.Player.TotalQuestsCompleted == 0 then
        task.delay(0.6, function() -- Line: 179
            -- upvalues: Controller (copy), TweenService (ref), Quests2 (ref)
            if Controller.Player.TotalQuestsCompleted == 0 then
                TweenService:Create(Quests2.Content.Holder.Contents.Rewards.ProgressBar.Fill.UIGradient, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Offset = Vector2.new(-1, 0)
                }):Play();
            end;
        end);
    end;

    u21.MakeVisible(Controller2.Active and Quests2.Content.Holder.Contents.SeasonPassQuests or Quests2.Content.Holder.Contents.DailyQuests);

    for _, child in Quests2.Content.Holder.Header:GetChildren() do
        if child:IsA("ImageButton") and child.Name ~= "Close" then
            u1:Add(child.MouseButton1Click:Connect(function() -- Line: 198
                -- upvalues: child (copy), Controller2 (copy), Effects (ref), u21 (ref), Quests2 (ref)
                if child.Name == "SeasonPass" and not Controller2.Active then
                    Effects:Popup("There is no season pass active right now!");

                    return;
                end;

                u21.MakeVisible(Quests2.Content.Holder.Contents[`{child.Name}Quests`]);
            end));
        end;
    end;

    u1:Add(RunService.Heartbeat:Connect(function() -- Line: 209
        -- upvalues: Controller (copy), GetUnixTime (ref), Quests2 (ref), NumberUtil (ref)
        if not Controller.Player.LastDailyQuestRefresh then
            Quests2.Content.Holder.TimeRemaining.TextLabel.Text = "REFRESHING...";

            return;
        end;

        local v32 = 86400 - (GetUnixTime() - Controller.Player.LastDailyQuestRefresh);
        local math_max_ret = math.max(v32, 0);
        Quests2.Content.Holder.TimeRemaining.TextLabel.Text = `QUEST REFRESH IN {NumberUtil.AdaptiveClockString(math_max_ret)}`;
    end));

    for i, v in Controller.Player.Quests do
        local Reward = v.Metadata.Reward;
        local v33 = Quests[v.QuestName];
        local v34 = u1:Add(script.Quest:Clone());
        v34.LayoutOrder = i;
        v34.ItemDisplay["1"].AmountLabel.Text = `{u21.FormatValue(Reward)} {Reward.Reward}`;
        v34.ProgressBar.Fill.Size = UDim2.fromScale(math.min(v.Metadata[v.Metadata.Index] / v.Metadata.Target, 1), 1);
        v34.Progress.Text = u21.FormatProgress(v.Metadata.Index, v.Metadata[v.Metadata.Index], v.Metadata.Target);
        v34.QuestTitle.Text = string.upper(v33.DisplayName);
        v34.TextLabel.Text = string.upper(typeof(v33.Description) == "function" and v33.Description(v) or v33.Description);
        v34.Parent = Quests2.Content.Holder.Contents[`{v.Category}Quests`];

        if u14[Reward.Reward] then
            u14[Reward.Reward](v34.ItemDisplay["1"].RewardIcon, Reward.Value);
        else
            v34.ItemDisplay["1"].RewardIcon.Image = "rbxassetid://82949801556287";
        end;

        v34.Buttons.Claim.MouseButton1Click:Connect(function() -- Line: 239
            -- upvalues: Effects (ref), Knit (ref), v (copy)
            if workspace:GetAttribute("IsPrivateServer") then
                Effects:Popup("Cannot Claim Quests in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

                return;
            end;

            Knit.GetService("QuestsService"):CompleteQuest(v.UniqueId);
        end);
        v34.Buttons.Skip.MouseButton1Click:Connect(function() -- Line: 249
            -- upvalues: Effects (ref), v (copy), Knit (ref)
            if workspace:GetAttribute("IsPrivateServer") then
                Effects:Popup("Cannot Skip Quests in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

                return;
            end;

            if v.Metadata[v.Metadata.Index] >= v.Metadata.Target then
                Effects:Popup("Cannot Skip a Completed Quest!", 5, Color3.fromRGB(255, 53, 53));

                return;
            end;

            Knit.GetService("QuestsService"):SkipQuest(v.UniqueId);
        end);
    end;

    u1:Add(Quests2.Content.Refresh.MouseButton1Click:Connect(function() -- Line: 301
        -- upvalues: Effects (ref), u21 (ref), MarketplaceService (ref), LocalPlayer (ref)
        if workspace:GetAttribute("IsPrivateServer") then
            Effects:Popup("Cannot purchase in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

            return;
        end;

        if u21.CurrentlyVisible == "DailyQuests" then
            MarketplaceService:PromptProductPurchase(LocalPlayer, 3238866681);

            return;
        end;

        if u21.CurrentlyVisible == "SeasonPassQuests" then
            MarketplaceService:PromptProductPurchase(LocalPlayer, 3312498736);
        end;
    end));
    local Quests3 = Controller.Player.Quests;
    u1:Add(ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 317
        -- upvalues: deep_equals (ref), Quests3 (copy), Controller (copy), u21 (ref)
        if not deep_equals(Quests3, Controller.Player.Quests) then
            u21.UpdateQuestsGui();
        end;
    end));
end;

function u21.KnitInit(p35) -- Line: 324
end;

function u21.KnitStart(p36) -- Line: 328
    -- upvalues: Knit (copy), Quests2 (copy), u21 (copy), u1 (copy), Effects (copy)
    local Controller = Knit.GetController("UIController");
    Quests2:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 331
        -- upvalues: Quests2 (ref), u21 (ref), Controller (copy), u1 (ref)
        if not Quests2.Enabled then
            u1:Clean();

            return;
        end;

        u21.UpdateQuestsGui();
        Controller:Focus(true, Quests2.Content);
    end);
    Knit.GetService("QuestsService").Notify:Connect(function(p37, p38, p39, p40) -- Line: 342
        -- upvalues: u21 (ref), Effects (ref)
        Effects:Popup(string.format(p38, (`{u21.FormatValue(p37)} {p37.Reward}`)), p39, p40);
    end);
end;

return u21;