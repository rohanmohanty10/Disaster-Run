  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local EasterQuests = require(ReplicatedStorage.Shared.Configs.EasterQuests);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local environment = require(ReplicatedStorage.Shared.environment);
local Popup = require(ReplicatedStorage.Shared.Popup);
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local v1 = Knit.CreateController({
    Name = "EasterQuestsController"
});
local Color3_fromRGB_ret = Color3.fromRGB(130, 130, 130);

function v1.KnitStart(p2) -- Line: 23
    -- upvalues: environment (copy), Knit (copy), PlayerData (copy), PlayerGui (copy), EasterQuests (copy), FormatNumber (copy), Color3_fromRGB_ret (copy), MarketplaceService (copy), LocalPlayer (copy), RunService (copy), Popup (copy)
    if environment.mode == "Ranked" then
        return;
    end;

    local Service = Knit.GetService("EasterQuestsService");
    PlayerData:WaitForLoaded();
    local EasterHunt = PlayerGui:WaitForChild("EasterHunt");
    local Frame = EasterHunt.Frame;
    local Options = Frame.Options;
    local u3 = nil;
    local v4 = {};
    local u5 = nil;

    for _, child in Options:GetChildren() do
        if child:IsA("ImageButton") then
            if child.Name == "Refresh" then
                u5 = child;
            elseif u3 then
                table.insert(v4, child);
            else
                u3 = child;
            end;
        end;
    end;

    if not (u3 and u5) then
        return;
    end;

    u3.Visible = false;
    u5.Visible = false;

    for _, v in v4 do
        v:Destroy();
    end;

    local u6 = {};
    local u7 = "";
    local ImageColor3 = u3.Claim.ImageColor3;

    local function clearQuests() -- Line: 60
        -- upvalues: u6 (copy)
        for _, v in u6 do
            if v.instance then
                v.instance:Destroy();
            end;

            if v.timerConnection then
                v.timerConnection:Disconnect();
            end;
        end;

        table.clear(u6);
    end;

    local function getDisplayText(p8, p9) -- Line: 72
        -- upvalues: EasterQuests (ref), FormatNumber (ref)
        local v10 = EasterQuests.Quests[p8];

        if not v10 then
            return p8;
        end;

        if p8 == "Playtime" then
            return string.gsub(v10.Display, "X", FormatNumber.AdaptiveClockString(p9));
        end;

        return string.gsub(v10.Display, "X", (tostring(p9)));
    end;

    local function getProgressText(p11, p12, p13) -- Line: 82
        -- upvalues: FormatNumber (ref)
        if p11 == "Playtime" then
            return `{FormatNumber.AdaptiveClockString(p12)}/{FormatNumber.AdaptiveClockString(p13)}`;
        end;

        return `{p12}/{p13}`;
    end;

    local function getStructureKey(p14) -- Line: 90
        if not p14 then
            return "";
        end;

        local v15 = {};

        for i, v in p14 do
            local v16 = i .. ":" .. tostring(v.Claimed);
            table.insert(v15, v16);
        end;

        table.sort(v15);

        return table.concat(v15, ",");
    end;

    local function updateQuestProgress() -- Line: 100
        -- upvalues: PlayerData (ref), u6 (copy), FormatNumber (ref), ImageColor3 (copy)
        local v17 = PlayerData:TryIndex({ "EasterQuests", "Quests" });

        if not v17 then
            return;
        end;

        for i, v in v17 do
            local v18 = u6[i];

            if v18 and (v18.instance and not v.Claimed) then
                local instance = v18.instance;
                local math_min_ret = math.min(v.Progress, v.Goal);
                local TextLabel = instance.ExpBar.TextLabel;
                local Goal = v.Goal;
                local v19;

                if i == "Playtime" then
                    v19 = `{FormatNumber.AdaptiveClockString(math_min_ret)}/{FormatNumber.AdaptiveClockString(Goal)}`;
                else
                    v19 = `{math_min_ret}/{Goal}`;
                end;

                TextLabel.Text = v19;
                instance.ExpBar.Frame.Size = UDim2.new(math.clamp(math_min_ret / v.Goal, 0, 1), 0, 1, 0);

                if v.Goal <= math_min_ret then
                    instance.Claim.Label.Text = "CLAIM";
                    instance.Claim.ImageColor3 = ImageColor3;
                end;
            end;
        end;
    end;

    local function createActiveQuest(u20, u21) -- Line: 122
        -- upvalues: u3 (ref), EasterQuests (ref), getDisplayText (copy), FormatNumber (ref), Color3_fromRGB_ret (ref), Service (copy), Options (copy)
        local v22 = u3:Clone();
        v22.Name = u20;
        v22.Visible = true;
        local v23 = EasterQuests.Quests[u20];
        v22.QuestName.Text = getDisplayText(u20, u21.Goal);
        local v24 = v22:FindFirstChild("100XP");

        if v24 then
            v24.Text = `{v23.XP} XP`;
        end;

        local math_min_ret = math.min(u21.Progress, u21.Goal);
        local TextLabel = v22.ExpBar.TextLabel;
        local Goal = u21.Goal;
        local v25;

        if u20 == "Playtime" then
            v25 = `{FormatNumber.AdaptiveClockString(math_min_ret)}/{FormatNumber.AdaptiveClockString(Goal)}`;
        else
            v25 = `{math_min_ret}/{Goal}`;
        end;

        TextLabel.Text = v25;
        v22.ExpBar.Frame.Size = UDim2.new(math.clamp(math_min_ret / u21.Goal, 0, 1), 0, 1, 0);
        local v26;

        if u21.Goal <= math_min_ret then
            v26 = not u21.Claimed;
        else
            v26 = false;
        end;

        if v26 then
            v22.Claim.Label.Text = "CLAIM";
        else
            v22.Claim.Label.Text = "IN PROGRESS";
            v22.Claim.ImageColor3 = Color3_fromRGB_ret;
        end;

        v22.Claim.Activated:Connect(function() -- Line: 147
            -- upvalues: u21 (copy), Service (ref), u20 (copy)
            if u21.Progress < u21.Goal then
                return;
            end;

            if u21.Claimed then
                return;
            end;

            Service:ClaimQuest(u20);
        end);
        v22.Parent = Options;

        return v22;
    end;

    local function createRefreshQuest(u27, u28) -- Line: 157
        -- upvalues: u5 (ref), Service (copy), MarketplaceService (ref), LocalPlayer (ref), Options (copy), RunService (ref), EasterQuests (ref), FormatNumber (ref)
        local u29 = u5:Clone();
        u29.Name = u27;
        u29.Visible = true;

        for _, child in u29:GetChildren() do
            if child:IsA("TextLabel") and child.Name == "QuestName" then
                if child.Position.Y.Scale < 0.3 then
                    child.Text = "REFRESHES IN...";
                else
                    child.Text = "...";
                end;
            end;
        end;

        u29.RefreshNow.Activated:Connect(function() -- Line: 173
            -- upvalues: Service (ref), u27 (copy), MarketplaceService (ref), LocalPlayer (ref)
            Service:SetPendingRefresh(u27);
            MarketplaceService:PromptProductPurchase(LocalPlayer, 3569939511);
        end);
        u29.Parent = Options;

        return u29, RunService.Heartbeat:Connect(function() -- Line: 179
            -- upvalues: u28 (copy), EasterQuests (ref), u29 (copy), FormatNumber (ref)
            if not u28.RefreshTimer then
                return;
            end;

            local v30 = u28.RefreshTimer + EasterQuests.QuestResetTime - DateTime.now().UnixTimestamp;
            local math_max_ret = math.max(0, v30);

            for _, child in u29:GetChildren() do
                if child:IsA("TextLabel") and (child.Name == "QuestName" and child.Position.Y.Scale > 0.3) then
                    child.Text = FormatNumber.AdaptiveClockString(math_max_ret);
                end;
            end;
        end);
    end;

    local function buildQuests() -- Line: 192
        -- upvalues: clearQuests (copy), PlayerData (ref), createRefreshQuest (copy), u6 (copy), createActiveQuest (copy), u7 (ref), getStructureKey (copy)
        clearQuests();
        local v31 = PlayerData:TryIndex({ "EasterQuests", "Quests" });

        if not v31 then
            return;
        end;

        for i, v in v31 do
            if v.Claimed then
                local v32, v33 = createRefreshQuest(i, v);
                u6[i] = {
                    instance = v32,
                    timerConnection = v33
                };
            else
                u6[i] = {
                    instance = createActiveQuest(i, v)
                };
            end;
        end;

        u7 = getStructureKey(v31);
    end;

    buildQuests();
    PlayerData:Observe({ "EasterQuests", "Quests" }, function(p34) -- Line: 212
        -- upvalues: getStructureKey (copy), u7 (ref), updateQuestProgress (copy), buildQuests (copy)
        if getStructureKey(p34) == u7 then
            updateQuestProgress();

            return;
        end;

        buildQuests();
    end);
    local Prizes = Frame.Prizes;
    local v35 = PlayerData:TryIndex({ "EasterQuests", "Xp" }) or 0;
    local u36 = {};

    for i, v in EasterQuests.Rewards do
        if v.XPRequired <= v35 then
            u36[i] = true;
        end;
    end;

    local function updatePrizes() -- Line: 231
        -- upvalues: PlayerData (ref), Prizes (copy), EasterQuests (ref), u36 (copy), Popup (ref)
        local v37 = PlayerData:TryIndex({ "EasterQuests", "Xp" }) or 0;
        local v38 = PlayerData:TryIndex({ "EasterQuests", "ClaimedRewards" }) or {};

        for _, child in Prizes:GetChildren() do
            if child:IsA("ImageButton") then
                local v39 = EasterQuests.Rewards[child.LayoutOrder];

                if v39 then
                    local v40 = child;
                    local v41 = nil;
                    local v42 = nil;

                    for _, child2 in child:GetChildren() do
                        if child2:IsA("TextLabel") then
                            if child2.Position.Y.Scale > 0.9 then
                                v41 = child2;
                            else
                                v42 = child2;
                            end;
                        end;
                    end;

                    if v41 then
                        v41.Text = `{v39.XPRequired} XP`;
                    end;

                    if v42 then
                        v42.Text = v39.Display or "";
                    end;

                    local v43 = table.find(v38, v40.LayoutOrder) ~= nil;
                    local v44 = v39.XPRequired <= v37;
                    local Locked = v40:FindFirstChild("Locked");
                    local Claimed = v40:FindFirstChild("Claimed");

                    if Locked then
                        Locked.Visible = not v44 and not v43;
                    end;

                    if Claimed then
                        Claimed.Visible = v43;
                    end;

                    if v44 and not u36[v40.LayoutOrder] then
                        u36[v40.LayoutOrder] = true;
                        Popup.Popup(nil, (`Unlocked Easter Reward: {v39.Display}!`));
                    end;
                end;
            end;
        end;
    end;

    for _, child in Prizes:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 277
                -- upvalues: PlayerData (ref), EasterQuests (ref), child (copy), Service (copy)
                local v45 = PlayerData:TryIndex({ "EasterQuests", "Xp" }) or 0;
                local v46 = PlayerData:TryIndex({ "EasterQuests", "ClaimedRewards" }) or {};
                local v47 = EasterQuests.Rewards[child.LayoutOrder];

                if not v47 then
                    return;
                end;

                if table.find(v46, child.LayoutOrder) then
                    return;
                end;

                if v45 < v47.XPRequired then
                    return;
                end;

                Service:ClaimReward(child.LayoutOrder);
            end);
        end;
    end;

    local PrizeBar = Frame:FindFirstChild("PrizeBar");

    if PrizeBar then
        local Frame2 = PrizeBar:FindFirstChild("Frame");
        local u48 = {};

        local function cachePrizePositions() -- Line: 294
            -- upvalues: u48 (ref), PrizeBar (copy), Prizes (copy)
            u48 = {};
            local X = PrizeBar.AbsolutePosition.X;
            local X2 = PrizeBar.AbsoluteSize.X;

            if X2 == 0 then
                return;
            end;

            local v49 = {};

            for _, child in Prizes:GetChildren() do
                if child:IsA("ImageButton") then
                    table.insert(v49, child);
                end;
            end;

            table.sort(v49, function(p50, p51) -- Line: 306
                return p50.LayoutOrder < p51.LayoutOrder;
            end);

            for i, v in v49 do
                u48[i] = math.clamp((v.AbsolutePosition.X + v.AbsoluteSize.X * 0.5 - X) / X2, 0, 1);
            end;
        end;

        task.defer(cachePrizePositions);
        EasterHunt:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 315
            -- upvalues: EasterHunt (copy), cachePrizePositions (copy)
            if EasterHunt.Enabled then
                task.defer(cachePrizePositions);
            end;
        end);

        local function updatePrizeBar() -- Line: 321
            -- upvalues: Frame2 (copy), u48 (ref), cachePrizePositions (copy), PlayerData (ref), EasterQuests (ref)
            if not Frame2 then
                return;
            end;

            if #u48 == 0 then
                cachePrizePositions();
            end;

            local v52 = PlayerData:TryIndex({ "EasterQuests", "Xp" }) or 0;
            local Rewards = EasterQuests.Rewards;
            local v53 = #Rewards;
            local v54 = 0;

            if Rewards[v53].XPRequired <= v52 then
                v54 = u48[v53] or 1;
            else
                for i = 1, v53 do
                    local XPRequired = Rewards[i].XPRequired;
                    local v55 = i == 1 and 0 or Rewards[i - 1].XPRequired;
                    local v56 = i == 1 and 0 or (u48[i - 1] or 0);
                    local v57 = u48[i] or i / v53;

                    if v52 < XPRequired then
                        v54 = v56 + (v52 - v55) / (XPRequired - v55) * (v57 - v56);
                        break;
                    end;

                    local _ = i;
                end;
            end;

            Frame2.Size = UDim2.new(math.clamp(v54, 0, 1), 0, 1, 0);
        end;

        updatePrizeBar();
        PlayerData:Listen({ { "EasterQuests", "Xp" }, { "EasterQuests", "ClaimedRewards" } }, function() -- Line: 352
            -- upvalues: updatePrizes (copy), updatePrizeBar (copy)
            updatePrizes();
            updatePrizeBar();
        end);
    else
        PlayerData:Listen({ { "EasterQuests", "Xp" }, { "EasterQuests", "ClaimedRewards" } }, function() -- Line: 357
            -- upvalues: updatePrizes (copy)
            updatePrizes();
        end);
    end;

    updatePrizes();
    Frame.Close.Activated:Connect(function() -- Line: 364
        -- upvalues: EasterHunt (copy)
        EasterHunt.Enabled = false;
    end);
    local EasterBunny = workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):FindFirstChild("EasterBunny");

    if EasterBunny then
        local v58 = EasterBunny:FindFirstChild("Torso") or (EasterBunny:FindFirstChild("HumanoidRootPart") or EasterBunny:FindFirstChildWhichIsA("BasePart"));
        local v59 = v58 and v58:FindFirstChild("ProximityPrompt");

        if v59 then
            v59.Triggered:Connect(function(p60) -- Line: 374
                -- upvalues: LocalPlayer (ref), EasterHunt (copy)
                if p60 ~= LocalPlayer then
                    return;
                end;

                EasterHunt.Enabled = not EasterHunt.Enabled;
            end);
        end;
    end;
end;

return v1;