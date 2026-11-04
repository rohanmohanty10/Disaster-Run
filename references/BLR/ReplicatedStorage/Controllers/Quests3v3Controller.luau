  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local Quests3v3 = require(ReplicatedStorage.Shared.Configs.Quests3v3);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local environment = require(ReplicatedStorage.Shared.environment);
local Popup = require(ReplicatedStorage.Shared.Popup);
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local v1 = Knit.CreateController({
    Name = "Quests3v3Controller"
});
local Color3_fromRGB_ret = Color3.fromRGB(130, 130, 130);

function v1.KnitStart(p2) -- Line: 23
    -- upvalues: environment (copy), Knit (copy), PlayerData (copy), PlayerGui (copy), Quests3v3 (copy), FormatNumber (copy), Color3_fromRGB_ret (copy), MarketplaceService (copy), LocalPlayer (copy), RunService (copy), Popup (copy)
    if environment.mode ~= "Normal3v3" then
        return;
    end;

    local Service = Knit.GetService("Quests3v3Service");
    PlayerData:WaitForLoaded();
    local u3 = PlayerGui:WaitForChild("3X3");
    local Frame = u3.Frame;
    local Options = Frame.Options;
    local Template = Options.Template;
    local Refresh = Options.Refresh;
    Template.Visible = false;
    Refresh.Visible = false;
    local u4 = {};
    local u5 = "";
    local ImageColor3 = Template.Claim.ImageColor3;

    local function clearQuests() -- Line: 42
        -- upvalues: u4 (copy)
        for _, v in u4 do
            if v.instance then
                v.instance:Destroy();
            end;

            if v.timerConnection then
                v.timerConnection:Disconnect();
            end;
        end;

        table.clear(u4);
    end;

    local function getDisplayText(p6, p7) -- Line: 54
        -- upvalues: Quests3v3 (ref), FormatNumber (ref)
        local v8 = Quests3v3.Quests[p6];

        if p6 == "Playtime" then
            return string.gsub(v8.Display, "X", FormatNumber.AdaptiveClockString(p7));
        end;

        return string.gsub(v8.Display, "X", (tostring(p7)));
    end;

    local function getProgressText(p9, p10, p11) -- Line: 63
        -- upvalues: FormatNumber (ref)
        if p9 == "Playtime" then
            return `{FormatNumber.AdaptiveClockString(p10)}/{FormatNumber.AdaptiveClockString(p11)}`;
        end;

        return `{p10}/{p11}`;
    end;

    local function getStructureKey(p12) -- Line: 71
        if not p12 then
            return "";
        end;

        local v13 = {};

        for i, v in p12 do
            local v14 = i .. ":" .. tostring(v.Claimed);
            table.insert(v13, v14);
        end;

        table.sort(v13);

        return table.concat(v13, ",");
    end;

    local function updateQuestProgress() -- Line: 81
        -- upvalues: PlayerData (ref), u4 (copy), FormatNumber (ref), ImageColor3 (copy)
        local v15 = PlayerData:TryIndex({ "Quests3V3", "Quests" });

        if not v15 then
            return;
        end;

        for i, v in v15 do
            local v16 = u4[i];

            if v16 and (v16.instance and not v.Claimed) then
                local instance = v16.instance;
                local math_min_ret = math.min(v.Progress, v.Goal);
                local TextLabel = instance.ExpBar.TextLabel;
                local Goal = v.Goal;
                local v17;

                if i == "Playtime" then
                    v17 = `{FormatNumber.AdaptiveClockString(math_min_ret)}/{FormatNumber.AdaptiveClockString(Goal)}`;
                else
                    v17 = `{math_min_ret}/{Goal}`;
                end;

                TextLabel.Text = v17;
                instance.ExpBar.Frame.Size = UDim2.new(math.clamp(math_min_ret / v.Goal, 0, 1), 0, 1, 0);

                if v.Goal <= math_min_ret then
                    instance.Claim.Label.Text = "CLAIM";
                    instance.Claim.ImageColor3 = ImageColor3;
                end;
            end;
        end;
    end;

    local function createActiveQuest(u18, u19) -- Line: 103
        -- upvalues: Template (copy), Quests3v3 (ref), FormatNumber (ref), Color3_fromRGB_ret (ref), Service (copy), Options (copy)
        local v20 = Template:Clone();
        v20.Name = u18;
        v20.Visible = true;
        local v21 = Quests3v3.Quests[u18];
        local QuestName = v20.QuestName;
        local Goal = u19.Goal;
        local v22 = Quests3v3.Quests[u18];
        local v23;

        if u18 == "Playtime" then
            v23 = string.gsub(v22.Display, "X", FormatNumber.AdaptiveClockString(Goal));
        else
            v23 = string.gsub(v22.Display, "X", (tostring(Goal)));
        end;

        QuestName.Text = v23;
        v20["100XP"].Text = `{v21.XP} XP`;
        local math_min_ret = math.min(u19.Progress, u19.Goal);
        local TextLabel = v20.ExpBar.TextLabel;
        local Goal2 = u19.Goal;
        local v24;

        if u18 == "Playtime" then
            v24 = `{FormatNumber.AdaptiveClockString(math_min_ret)}/{FormatNumber.AdaptiveClockString(Goal2)}`;
        else
            v24 = `{math_min_ret}/{Goal2}`;
        end;

        TextLabel.Text = v24;
        v20.ExpBar.Frame.Size = UDim2.new(math.clamp(math_min_ret / u19.Goal, 0, 1), 0, 1, 0);
        local v25;

        if u19.Goal <= math_min_ret then
            v25 = not u19.Claimed;
        else
            v25 = false;
        end;

        if v25 then
            v20.Claim.Label.Text = "CLAIM";
        else
            v20.Claim.Label.Text = "IN PROGRESS";
            v20.Claim.ImageColor3 = Color3_fromRGB_ret;
        end;

        v20.Claim.Activated:Connect(function() -- Line: 124
            -- upvalues: u19 (copy), Service (ref), u18 (copy)
            if u19.Progress < u19.Goal then
                return;
            end;

            if u19.Claimed then
                return;
            end;

            Service:ClaimQuest(u18);
        end);
        v20.Parent = Options;

        return v20;
    end;

    local function createRefreshQuest(u26, u27) -- Line: 134
        -- upvalues: Refresh (copy), Service (copy), MarketplaceService (ref), LocalPlayer (ref), Options (copy), RunService (ref), Quests3v3 (ref), FormatNumber (ref)
        local u28 = Refresh:Clone();
        u28.Name = u26;
        u28.Visible = true;

        for _, child in u28:GetChildren() do
            if child:IsA("TextLabel") and child.Name == "QuestName" then
                if child.Position.Y.Scale < 0.3 then
                    child.Text = "REFRESHES IN...";
                else
                    child.Text = "...";
                end;
            end;
        end;

        u28.RefreshNow.Activated:Connect(function() -- Line: 150
            -- upvalues: Service (ref), u26 (copy), MarketplaceService (ref), LocalPlayer (ref)
            Service:SetPendingRefresh(u26);
            MarketplaceService:PromptProductPurchase(LocalPlayer, 3546804646);
        end);
        u28.Parent = Options;

        return u28, RunService.Heartbeat:Connect(function() -- Line: 156
            -- upvalues: u27 (copy), Quests3v3 (ref), u28 (copy), FormatNumber (ref)
            if not u27.RefreshTimer then
                return;
            end;

            local v29 = u27.RefreshTimer + Quests3v3.QuestResetTime - DateTime.now().UnixTimestamp;
            local math_max_ret = math.max(0, v29);

            for _, child in u28:GetChildren() do
                if child:IsA("TextLabel") and (child.Name == "QuestName" and child.Position.Y.Scale > 0.3) then
                    child.Text = FormatNumber.AdaptiveClockString(math_max_ret);
                end;
            end;
        end);
    end;

    local function buildQuests() -- Line: 169
        -- upvalues: clearQuests (copy), PlayerData (ref), createRefreshQuest (copy), u4 (copy), createActiveQuest (copy), u5 (ref), getStructureKey (copy)
        clearQuests();
        local v30 = PlayerData:TryIndex({ "Quests3V3", "Quests" });

        if not v30 then
            return;
        end;

        for i, v in v30 do
            if v.Claimed then
                local v31, v32 = createRefreshQuest(i, v);
                u4[i] = {
                    instance = v31,
                    timerConnection = v32
                };
            else
                u4[i] = {
                    instance = createActiveQuest(i, v)
                };
            end;
        end;

        u5 = getStructureKey(v30);
    end;

    buildQuests();
    PlayerData:Observe({ "Quests3V3", "Quests" }, function(p33) -- Line: 189
        -- upvalues: getStructureKey (copy), u5 (ref), updateQuestProgress (copy), buildQuests (copy)
        if getStructureKey(p33) == u5 then
            updateQuestProgress();

            return;
        end;

        buildQuests();
    end);
    local Prizes = Frame.Prizes;
    local v34 = PlayerData:TryIndex({ "Quests3V3", "Xp" }) or 0;
    local u35 = {};

    for i, v in Quests3v3.Rewards do
        if v.XPRequired <= v34 then
            u35[i] = true;
        end;
    end;

    local function updatePrizes() -- Line: 211
        -- upvalues: PlayerData (ref), Prizes (copy), Quests3v3 (ref), FormatNumber (ref), u35 (copy), Popup (ref)
        local v36 = PlayerData:TryIndex({ "Quests3V3", "Xp" }) or 0;
        local v37 = PlayerData:TryIndex({ "Quests3V3", "ClaimedRewards" }) or {};

        for _, child in Prizes:GetChildren() do
            if child:IsA("ImageButton") then
                local v38 = Quests3v3.Rewards[child.LayoutOrder];

                if v38 then
                    local icon = child:FindFirstChild("icon");

                    if icon and (v38.Image and v38.Image ~= "") then
                        icon.Image = v38.Image;
                    end;

                    local v39 = child;
                    local v40 = nil;
                    local v41 = nil;

                    for _, child2 in child:GetChildren() do
                        if child2:IsA("TextLabel") then
                            if child2.Position.Y.Scale > 0.9 then
                                v40 = child2;
                            else
                                v41 = child2;
                            end;
                        end;
                    end;

                    v40.Text = `{FormatNumber.Commas(v38.XPRequired)} XP`;

                    if v38.Amount and typeof(v38.Amount) == "number" then
                        v41.Text = `x{FormatNumber.Commas(v38.Amount)} {v38.Type}`;
                    else
                        v41.Text = v38.Display or (v38.Reward or "");
                    end;

                    local v42 = table.find(v37, v39.LayoutOrder) ~= nil;
                    local v43 = v38.XPRequired <= v36;
                    v39.Locked.Visible = not v43 and not v42;
                    v39.Claimed.Visible = v42;

                    if v43 and not u35[v39.LayoutOrder] then
                        u35[v39.LayoutOrder] = true;
                        Popup.Popup(nil, (`Unlocked 3v3 Reward: {v41.Text}!`));
                    end;
                end;
            end;
        end;
    end;

    for _, child in Prizes:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 261
                -- upvalues: PlayerData (ref), Quests3v3 (ref), child (copy), Service (copy)
                local v44 = PlayerData:TryIndex({ "Quests3V3", "Xp" }) or 0;
                local v45 = PlayerData:TryIndex({ "Quests3V3", "ClaimedRewards" }) or {};
                local v46 = Quests3v3.Rewards[child.LayoutOrder];

                if not v46 then
                    return;
                end;

                if table.find(v45, child.LayoutOrder) then
                    return;
                end;

                if v44 < v46.XPRequired then
                    return;
                end;

                Service:ClaimReward(child.LayoutOrder);
            end);
        end;
    end;

    local u47 = {
        Frame[`PrizeBar{1}`].Frame,
        Frame[`PrizeBar{2}`].Frame,
        Frame[`PrizeBar{3}`].Frame,
        Frame[`PrizeBar{4}`].Frame
    };

    local function updatePrizeBar() -- Line: 277
        -- upvalues: PlayerData (ref), Quests3v3 (ref), u47 (copy)
        local v48 = PlayerData:TryIndex({ "Quests3V3", "Xp" }) or 0;

        for i = 1, 4 do
            local XPRequired = Quests3v3.Rewards[i].XPRequired;
            local XPRequired2 = Quests3v3.Rewards[i + 1].XPRequired;
            local v49;

            if XPRequired2 <= v48 then
                u47[i].Size = UDim2.new(1, 0, 1, 0);
                v49 = i;
            elseif XPRequired < v48 then
                local math_clamp_ret = math.clamp((v48 - XPRequired) / (XPRequired2 - XPRequired), 0, 1);
                u47[i].Size = UDim2.new(math_clamp_ret, 0, 1, 0);
                v49 = i;
            else
                u47[i].Size = UDim2.new(0, 0, 1, 0);
                v49 = i;
            end;
        end;
    end;

    updatePrizes();
    updatePrizeBar();
    PlayerData:Listen({ { "Quests3V3", "Xp" }, { "Quests3V3", "ClaimedRewards" } }, function() -- Line: 297
        -- upvalues: updatePrizes (copy), updatePrizeBar (copy)
        updatePrizes();
        updatePrizeBar();
    end);
    Frame.Close.Activated:Connect(function() -- Line: 302
        -- upvalues: u3 (copy)
        u3.Enabled = false;
    end);
    local Rig = workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):FindFirstChild("Quests3v3"):WaitForChild("Rig");

    if Rig then
        Rig:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt").Triggered:Connect(function(p50) -- Line: 309
            -- upvalues: LocalPlayer (ref), u3 (copy)
            if p50 ~= LocalPlayer then
                return;
            end;

            u3.Enabled = true;
        end);
    end;
end;

return v1;