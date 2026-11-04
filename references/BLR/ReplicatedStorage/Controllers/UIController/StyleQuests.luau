  

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Trove = require(ReplicatedStorage.RelicsXYZ.Shared.Trove);
require(ReplicatedStorage.ClientModules.ClientGlobals);
local NELQuests = require(ReplicatedStorage.Shared.Configs.NELQuests);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local ProductIds = require(ReplicatedStorage.Shared.Configs.ProductIds);
require(ReplicatedStorage.Shared.PlrStyles);
local Popup = require(ReplicatedStorage.Shared.Popup);
local u1 = nil;
local Teams = game:GetService("Teams");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local StyleQuestLine = ClientGlobals.PlayerGui.StyleQuestLine;
local NewNeoEgoists = ClientGlobals.PlayerGui.NewNeoEgoists;
local u2 = NewNeoEgoists.Frame.BG:FindFirstChild("ScrollingFrame") or NewNeoEgoists.Frame.BG.Options;
local Quests = ClientGlobals.PlayerGui.Quests;
local List = StyleQuestLine.BG.List;
local Template = List.ScrollingFrame.Template;
Template.Parent = nil;
local u3 = {
    [0] = -1,
    [1] = -0.4,
    [2] = 0,
    [3] = 0.3,
    [4] = 0.5
};
local u4 = Trove.new();
local v5 = {
    Name = "StyleQuests"
};

local function loadQuestLine(u6: string) -- Line: 50
    -- upvalues: u4 (copy), NELQuests (copy), countStyleMastery (copy), PlayerData (copy), StyleQuestLine (copy), TweenService (copy), u3 (copy), u1 (ref), Template (copy), List (copy), ProductIds (copy), MarketplaceService (copy), LocalPlayer (copy)
    u4:Destroy();
    local u7 = NELQuests[u6];
    local XP = u7.RewardLine[#u7.RewardLine].XP;
    local u8 = nil;
    local u9 = nil;

    local function updateMasteryProgress() -- Line: 56
        -- upvalues: u8 (ref), u9 (ref), countStyleMastery (ref), PlayerData (ref), u6 (copy), StyleQuestLine (ref), XP (copy), TweenService (ref), u3 (ref), u7 (copy)
        local v10, v11 = countStyleMastery(PlayerData.Data, u6);
        u8 = v10;
        u9 = v11;
        StyleQuestLine.BG.XP.Text = `{math.min(u9, XP)}/{XP}`;
        TweenService:Create(StyleQuestLine.BG.Line.UIGradient, TweenInfo.new(0.3), {
            Offset = Vector2.new(0, u3[u8])
        }):Play();
        local v12 = PlayerData.Data.DisabledMasteryLevels[u6] or {};

        for i = 1, 4 do
            local v13 = StyleQuestLine.BG.Line:FindFirstChild((`Dot{i}`));

            if i <= u8 then
                v13.ImageLabel.Image = v12[i] == true and "rbxassetid://18209598048" or "rbxassetid://132488438458755";
                v13.ImageTransparency = 0;
                v13.Center.BackgroundColor3 = Color3.fromRGB(243, 228, 24);
                v13.TextLabel.TextColor3 = Color3.fromRGB(243, 228, 24);
            else
                v13.ImageLabel.Image = "";
                v13.ImageTransparency = 1;
                v13.Center.BackgroundColor3 = Color3.fromRGB(90, 90, 90);
                v13.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;

            v13.TextLabel.Text = `{u7.RewardLine[i].Display} [{u7.RewardLine[i].XP} XP]`;
            local _ = i;
        end;
    end;

    updateMasteryProgress();
    u4:Add(StyleQuestLine.BG.Line.Dot1.Activated:Connect(function() -- Line: 85
        -- upvalues: u1 (ref), u6 (copy)
        u1:ToggleMasteryLevel(u6, 1);
    end));
    u4:Add(StyleQuestLine.BG.Line.Dot2.Activated:Connect(function() -- Line: 88
        -- upvalues: u1 (ref), u6 (copy)
        u1:ToggleMasteryLevel(u6, 2);
    end));
    u4:Add(StyleQuestLine.BG.Line.Dot3.Activated:Connect(function() -- Line: 91
        -- upvalues: u1 (ref), u6 (copy)
        u1:ToggleMasteryLevel(u6, 3);
    end));
    u4:Add(StyleQuestLine.BG.Line.Dot4.Activated:Connect(function() -- Line: 94
        -- upvalues: u1 (ref), u6 (copy)
        u1:ToggleMasteryLevel(u6, 4);
    end));
    u4:Add(PlayerData:Listen({ "DisabledMasteryLevels" }, updateMasteryProgress));
    StyleQuestLine.BG.Header.PlrStyle.Text = u6;
    StyleQuestLine.BG.Header.TargetStyle.Text = u7.NELName;
    StyleQuestLine.BG.TargetStyle.Text = `{string.upper(u7.NELName)}!`;
    StyleQuestLine.BG.Rarity.Text = u7.NELRarity;
    StyleQuestLine.BG.StyleAvatar.Image = u7.ChibiImage;
    StyleQuestLine.BG.List.Title.Text = `[100 XP Needed To Unlock Full {u7.NELName}]`;

    for i, v in u7.Quests do
        local u14 = Template:Clone();
        u14.Label.Text = v.Display;
        u14.Parent = List.ScrollingFrame;
        u14.Reward.Label.Text = `{v.XP} XP`;
        u14.Activated:Connect(function() -- Line: 111
            -- upvalues: u1 (ref), i (copy)
            u1:CompleteNELQuest(i);
        end);
        u4:Add(u14);

        local function setBar(p15: string) -- Line: 116
            -- upvalues: u14 (copy)
            u14.Progress.YellowBar.Visible = p15 == "Yellow";
            u14.Progress.GreenBar.Visible = p15 == "Green";
        end;

        local goal = v.internal.goal;
        u4:Add(PlayerData:Observe({ "StyleQuestData", i }, function(p16) -- Line: 122
            -- upvalues: u14 (copy), updateMasteryProgress (copy), goal (copy), v (copy)
            if p16.completed then
                u14.Progress.YellowBar.Visible = false;
                u14.Progress.GreenBar.Visible = true;
                u14.Progress.Label.Text = "COMPLETED";
                updateMasteryProgress();

                return;
            end;

            u14.Progress.YellowBar.Visible = true;
            u14.Progress.GreenBar.Visible = false;
            local math_clamp_ret = math.clamp(p16.progress, 0, goal);
            u14.Progress.YellowBar.Size = UDim2.fromScale(math_clamp_ret / goal, 1);

            if goal <= math_clamp_ret then
                u14.Progress.Label.Text = "CLAIM NOW!";

                return;
            end;

            local v18 = v.format or function(p17) -- Line: 134
                return tostring(p17);
            end;
            u14.Progress.Label.Text = `{v18(math_clamp_ret)}/{v18(goal)}`;
        end));
    end;

    local u19 = (u8 or 0) + 1;
    local u20 = ProductIds.NELQuests.Skips[u19];

    local function reloadPrice() -- Line: 144
        -- upvalues: u19 (ref), u8 (ref), u20 (ref), ProductIds (ref), StyleQuestLine (ref), MarketplaceService (ref)
        u19 = (u8 or 0) + 1;
        u20 = ProductIds.NELQuests.Skips[u19];

        if not u20 then
            StyleQuestLine.BG.SkipStageButton.Visible = false;

            return;
        end;

        StyleQuestLine.BG.SkipStageButton.Visible = true;
        task.spawn(function() -- Line: 150
            -- upvalues: MarketplaceService (ref), u20 (ref), StyleQuestLine (ref), u19 (ref)
            local success, result = pcall(function() -- Line: 151
                -- upvalues: MarketplaceService (ref), u20 (ref)
                return MarketplaceService:GetProductInfo(u20, Enum.InfoType.Product);
            end);

            if success and result then
                StyleQuestLine.BG.SkipStageButton.TextLabel.Text = `Skip Stage {u19}: {result.PriceInRobux}` or "[???]";
            end;
        end);
    end;

    u4:Add(StyleQuestLine.BG.SkipStageButton.Activated:Connect(function() -- Line: 164
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u20 (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, u20);
    end));
    u4:Add(PlayerData:Observe({ "BonusMasteryXP", u6 }, function(p21) -- Line: 169
        -- upvalues: updateMasteryProgress (copy), reloadPrice (copy)
        updateMasteryProgress();
        reloadPrice();
    end));
end;

function v5.KnitStart(p22) -- Line: 177
    -- upvalues: u1 (ref), KnitClient (copy), LocalPlayer (copy), Teams (copy), StyleQuestLine (copy), NewNeoEgoists (copy), PlayerData (copy), u2 (copy), NELQuests (copy), Quests (copy), Popup (copy), loadQuestLine (copy)
    u1 = KnitClient.GetService("QuestsService");
    local Controller = KnitClient.GetController("UIController");
    local u23;

    if LocalPlayer.Team == nil then
        u23 = false;
    else
        u23 = LocalPlayer.Team ~= Teams:FindFirstChild("Visitor");
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 183
        -- upvalues: u23 (ref), LocalPlayer (ref), Teams (ref), StyleQuestLine (ref), NewNeoEgoists (ref)
        local v24;

        if LocalPlayer.Team == nil then
            v24 = false;
        else
            v24 = LocalPlayer.Team ~= Teams:FindFirstChild("Visitor");
        end;

        u23 = v24;

        if u23 then
            StyleQuestLine.Enabled = false;
            NewNeoEgoists.Enabled = false;
        end;
    end);
    local BillboardGui = workspace.Quests.HumanoidRootPart.BillboardGui;
    PlayerData:Observe({ "Style" }, function(p25) -- Line: 192
        -- upvalues: u2 (ref), NELQuests (ref), BillboardGui (copy)
        for _, child in u2:GetChildren() do
            if child:IsA("ImageButton") then
                if p25 == child.Name and NELQuests[p25] then
                    child.Sizer.bg.Locked.Visible = false;
                else
                    child.Sizer.bg.Locked.Visible = true;
                end;
            end;
        end;

        if not NELQuests[p25] then
            BillboardGui.StyleQuest.Visible = false;

            return;
        end;

        BillboardGui.StyleQuest.Visible = true;
        BillboardGui.StyleQuest.Text = `{NELQuests[p25].NELName} quest available!`;
    end);
    NewNeoEgoists.Frame.Option.Daily.Activated:Connect(function() -- Line: 217
        -- upvalues: NewNeoEgoists (ref), Quests (ref)
        NewNeoEgoists.Enabled = false;
        Quests.Enabled = true;
    end);
    StyleQuestLine.BG.Option.NEL.Activated:Connect(function() -- Line: 223
        -- upvalues: StyleQuestLine (ref), NewNeoEgoists (ref)
        StyleQuestLine.Enabled = false;
        NewNeoEgoists.Enabled = true;
    end);
    StyleQuestLine.BG.Option.Daily.Activated:Connect(function() -- Line: 229
        -- upvalues: StyleQuestLine (ref), Quests (ref)
        StyleQuestLine.Enabled = false;
        Quests.Enabled = true;
    end);

    for _, child in u2:GetChildren() do
        if NELQuests[child.Name] then
            child.Activated:Connect(function() -- Line: 237
                -- upvalues: PlayerData (ref), u23 (ref), Popup (ref), child (copy), NELQuests (ref), NewNeoEgoists (ref), loadQuestLine (ref), StyleQuestLine (ref), Controller (copy)
                local Style = PlayerData.Data.Style;

                if u23 then
                    Popup.Popup(nil, "You can\'t open this while in a match!");

                    return;
                end;

                if Style ~= child.Name or not NELQuests[Style] then
                    Popup.Popup(nil, (`You need {child.Name} to check the quests`));

                    return;
                end;

                NewNeoEgoists.Enabled = false;
                loadQuestLine(PlayerData.Data.Style);

                if StyleQuestLine.Enabled then
                    return;
                end;

                Controller:Open(StyleQuestLine.Name);
            end);
        end;
    end;
end;

return KnitClient.CreateController(v5);