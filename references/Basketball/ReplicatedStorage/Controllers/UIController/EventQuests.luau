 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local EventQuests = PlayerGui:WaitForChild("EventQuests");
local Knit = require(ReplicatedStorage.Packages.Knit);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local EventQuests2 = require(ReplicatedStorage.Shared.Tables.EventQuests);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local RandomUtil = require(ReplicatedStorage.Shared.Utility.RandomUtil);
local EventQuestRewards = require(ReplicatedStorage.Shared.Tables.EventQuestRewards);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local u1 = Trove.new();
local u14 = {
    ["Style Spins"] = function(p2: userdata, p3: any) -- Line: 22
        p2.Image = "rbxassetid://111333169806568";
    end,

    ["Lucky Style Spins"] = function(p4: userdata, p5: any) -- Line: 25
        p4.Image = "rbxassetid://111333169806568";
        script.Rainbow:Clone().Parent = p4;
    end,

    ["Zone Spins"] = function(p6: userdata, p7: any) -- Line: 30
        p6.Image = "rbxassetid://71537410313776";
    end,

    ["Lucky Zone Spins"] = function(p8: userdata, p9: any) -- Line: 33
        p8.Image = "rbxassetid://71537410313776";
        script.Rainbow:Clone().Parent = p8;
    end,

    ["Ball Trail Spins"] = function(p10: userdata, p11: any) -- Line: 38
        p10.Image = "rbxassetid://118616255715301";
    end,

    Emote = function(u12: userdata, u13: any) -- Line: 41
        -- upvalues: Knit (copy)
        task.spawn(function() -- Line: 42
            -- upvalues: u12 (copy), Knit (ref), u13 (copy)
            u12.ImageTransparency = 1;
            local ViewportFrame = Instance.new("ViewportFrame");
            ViewportFrame.Size = UDim2.fromScale(1, 1);
            ViewportFrame.Ambient = Color3.fromRGB(255, 255, 255);
            ViewportFrame.BackgroundTransparency = 1;
            ViewportFrame.ZIndex = u12.ZIndex;
            ViewportFrame.Parent = u12;
            local Controller = Knit.GetController("EmotesController");

            while not Controller.CharacterRig do
                task.wait();
            end;

            Controller:CreatePreview(u13, ViewportFrame, Controller.CharacterRig);
        end);
    end
};
local u15 = {
    LuckySpins = "rbxassetid://111333169806568",
    Spins = "rbxassetid://111333169806568",
    ZoneLuckySpins = "rbxassetid://71537410313776",
    ZoneSpins = "rbxassetid://71537410313776",
    TrailColorSpins = "rbxassetid://118616255715301",
    ZoneColorSpins = "rbxassetid://118616255715301",
    Money = "rbxassetid://82949801556287"
};
local u16 = {
    LuckySpins = "Lucky Style Spins",
    ZoneLuckySpins = "Lucky Zone Spins",
    ZoneColorSpins = "Zone Color Spins",
    TrailColorSpins = "Ball Trail Color Spins",
    Money = "Money",
    Spins = "Style Spins",
    ZoneSpins = "Zone Spins"
};

local function deep_equals(p17, p18, p19) -- Line: 82
    -- upvalues: deep_equals (copy)
    if p17 == p18 then
        return true;
    end;

    local v20 = type(p17);

    if v20 ~= type(p18) then
        return false;
    end;

    if v20 ~= "table" then
        return false;
    end;

    if not p19 then
        local v21 = getmetatable(p17);

        if v21 and v21.__eq then
            return p17 == p18;
        end;
    end;

    for i, v in pairs(p17) do
        local v22 = p18[i];

        if v22 == nil or deep_equals(v, v22, p19) == false then
            return false;
        end;
    end;

    for i, _ in pairs(p18) do
        if p17[i] == nil then
            return false;
        end;
    end;

    return true;
end;

local function FormatValue(p23) -- Line: 117
    -- upvalues: NumberUtil (copy)
    if typeof(p23.Value) ~= "number" then
        return p23.Value;
    end;

    if p23.Reward == "Money" then
        return `${NumberUtil.WithCommas(p23.Value)}`;
    end;

    return NumberUtil.WithCommas(p23.Value);
end;

local u24 = Knit.CreateController({
    Name = "EventQuests"
});

function u24.UpdateGui() -- Line: 133
    -- upvalues: u1 (copy), Knit (copy), RunService (copy), GetUnixTime (copy), EventQuests (copy), NumberUtil (copy), EventQuests2 (copy), Rarities (copy), u14 (copy), u15 (copy), Effects (copy), MarketplaceService (copy), LocalPlayer (copy), ReplicatedStorage (copy), deep_equals (copy), u24 (copy)
    u1:Clean();
    local Controller = Knit.GetController("Network");
    u1:Add(RunService.Heartbeat:Connect(function() -- Line: 138
        -- upvalues: Controller (copy), GetUnixTime (ref), EventQuests (ref), NumberUtil (ref)
        if not Controller.Player.LastDailyQuestRefresh then
            EventQuests.Content.TimeLeft.Text = "Refreshing...";

            return;
        end;

        local v25 = 86400 - (GetUnixTime() - Controller.Player.LastDailyQuestRefresh);
        local math_max_ret = math.max(v25, 0);
        EventQuests.Content.TimeLeft.Text = `{NumberUtil.AdaptiveClockString(math_max_ret)} UNTIL NEXT QUESTS`;
    end));

    for i, v in Controller.Player.EventQuests do
        local Reward = v.Metadata.Reward;
        local v26 = EventQuests2[v.QuestName];
        local v27 = u1:Add(script.Quest:Clone());
        v27.LayoutOrder = i;
        v27.ItemDisplayBorder.UIGradient.Color = ColorSequence.new(Rarities.Colors[Reward.Rarity]);
        local DisplayName = v27.ItemDisplay.DisplayName;
        local v28;

        if typeof(Reward.Value) == "number" then
            if Reward.Reward == "Money" then
                v28 = `${NumberUtil.WithCommas(Reward.Value)}`;
            else
                v28 = NumberUtil.WithCommas(Reward.Value);
            end;
        else
            v28 = Reward.Value;
        end;

        DisplayName.Text = `{v28} {Reward.Reward}`;
        v27.Bar.ZoneBar.Size = UDim2.fromScale(math.min(v.Metadata[v.Metadata.Index] / v.Metadata.Target * 0.98, 0.98), 0.334);
        v27.Description.Text = typeof(v26.Description) == "function" and v26.Description(v) or v26.Description;
        local Description = v27.Description;
        Description.Text = Description.Text .. " (IN 3V3 or 2V2 MODE ONLY)";
        v27.Parent = EventQuests.Content.DailyQuests.Content;

        if u14[Reward.Reward] then
            u14[Reward.Reward](v27.ItemDisplay.DisplayImage, Reward.Value);
        else
            v27.ItemDisplay.DisplayImage.Image = u15[Reward.DataIndex] or "rbxassetid://82949801556287";
        end;

        v27.Claim.MouseButton1Click:Connect(function() -- Line: 168
            -- upvalues: Effects (ref), Knit (ref), v (copy)
            if workspace:GetAttribute("IsPrivateServer") then
                Effects:Popup("Cannot Claim Quests in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

                return;
            end;

            Knit.GetService("QuestsService"):CompleteQuest(v.UniqueId, true);
        end);
        v27.Skip.MouseButton1Click:Connect(function() -- Line: 178
            -- upvalues: Effects (ref), v (copy), Knit (ref)
            if workspace:GetAttribute("IsPrivateServer") then
                Effects:Popup("Cannot Skip Quests in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

                return;
            end;

            if v.Metadata[v.Metadata.Index] >= v.Metadata.Target then
                Effects:Popup("Cannot Skip a Completed Quest!", 5, Color3.fromRGB(255, 53, 53));

                return;
            end;

            Knit.GetService("QuestsService"):SkipQuest(v.UniqueId, true);
        end);
    end;

    u1:Add(EventQuests.Content.SkipAll.MouseButton1Click:Connect(function() -- Line: 196
        -- upvalues: Effects (ref), Controller (copy), MarketplaceService (ref), LocalPlayer (ref)
        if workspace:GetAttribute("IsPrivateServer") then
            Effects:Popup("Cannot purchase in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

            return;
        end;

        local v29 = false;

        for _, v in Controller.Player.Quests do
            if v.Metadata[v.Metadata.Index] < v.Metadata.Target then
                v29 = true;
                break;
            end;
        end;

        if v29 then
            MarketplaceService:PromptProductPurchase(LocalPlayer, 3263965235);

            return;
        end;

        Effects:Popup("No Quests Available to Skip!", 5, Color3.fromRGB(255, 53, 53));
    end));
    u1:Add(EventQuests.Content.Refresh.MouseButton1Click:Connect(function() -- Line: 221
        -- upvalues: Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        if workspace:GetAttribute("IsPrivateServer") then
            Effects:Popup("Cannot purchase in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

            return;
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, 3263965882);
    end));
    local EventQuests3 = Controller.Player.EventQuests;
    u1:Add(ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 233
        -- upvalues: deep_equals (ref), EventQuests3 (copy), Controller (copy), u24 (ref)
        if not deep_equals(EventQuests3, Controller.Player.EventQuests) then
            u24.UpdateGui();
        end;
    end));
end;

function u24.KnitInit(p30) -- Line: 240
    -- upvalues: EventQuests (copy)
    EventQuests.Content.Close.MouseButton1Click:Connect(function() -- Line: 241
        -- upvalues: EventQuests (ref)
        EventQuests.Enabled = false;
    end);
end;

function u24.KnitStart(p31) -- Line: 246
    -- upvalues: Knit (copy), EventQuests (copy), u24 (copy), u1 (copy), RandomUtil (copy), EventQuestRewards (copy), u15 (copy), NumberUtil (copy), u16 (copy), PlayerGui (copy)
    local Controller = Knit.GetController("UIController");
    EventQuests:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 249
        -- upvalues: EventQuests (ref), u24 (ref), Controller (copy), u1 (ref)
        if not EventQuests.Enabled then
            u1:Clean();

            return;
        end;

        u24.UpdateGui();
        Controller:Focus(true, EventQuests.Content);
    end);
    local TotalWeight = RandomUtil.GetTotalWeight(EventQuestRewards);

    for i, v in EventQuestRewards do
        local Value = v.Value;
        local string_find_ret = string.find(string.lower(Value.DataIndex), "lucky");
        local v32 = script:FindFirstChild((`{string_find_ret and "Mythic" or "Legendary"}Display`)):Clone();
        v32.Name = `{i}`;
        v32.LayoutOrder = math.round(-v.Weight * 100);
        v32.Icon.Image = u15[Value.DataIndex];
        v32.Reward.Text = string.upper((`{NumberUtil.TruncateNumber(Value.Range.Min, 1)} - {NumberUtil.TruncateNumber(Value.Range.Max, 1)} {u16[Value.DataIndex]}`));
        v32.Chance.Text = string.upper((`{string.format("%.1f", v.Weight / TotalWeight * 100)}%`));
        v32.Parent = PlayerGui.EventQuests.Content.Rewards.Content;

        if string_find_ret then
            v32.Icon.Rainbow.Enabled = true;
        end;
    end;
end;

return u24;