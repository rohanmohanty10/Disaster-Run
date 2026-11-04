  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LimitedCrateData = require(ReplicatedStorage.Shared.LimitedCrateData);
local Janitor = require(ReplicatedStorage.Packages.Janitor);
local Popup = require(ReplicatedStorage.Shared.Popup);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local VfxManager = require(ReplicatedStorage2.Shared.VfxManager);
local LimitedStockItems = require(ReplicatedStorage.Modules.LimitedStockItems);
local v1 = Knit.CreateController({
    Name = "LimitedCrateController"
});
local PlayerData = require(ReplicatedStorage.ClientModules.ClientGlobals).PlayerData;
local _ = Players.LocalPlayer;
local u2 = nil;
local Client = require(ReplicatedStorage.Packages.Replion.Client);
local QuestTextTemplate = ReplicatedStorage.Assets.UI.LimitedCrate.QuestTextTemplate;

local function loadAnimation(p3: userdata, p4: string) -- Line: 29
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p4;

    return p3:LoadAnimation(Animation);
end;

local function createPodiumDisplay() -- Line: 35
    -- upvalues: makePlayerModel (copy), ReplicatedStorage2 (copy)
    local workspace_LimitedCrate = workspace.LimitedCrate;
    local v5 = makePlayerModel();
    v5:PivotTo(workspace_LimitedCrate.Origin.CFrame * CFrame.new(0, 0, 0));
    v5.Parent = workspace_LimitedCrate;
    local v6 = ReplicatedStorage2.Assets.Misc.SixSeven["67"]:Clone();
    v6:PivotTo(v5.HumanoidRootPart.CFrame * ReplicatedStorage2.Assets.Misc.SixSeven.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
    v6.Parent = workspace.Debris;
    local v7 = ReplicatedStorage2.Assets.Misc.SixSeven.HumanoidRootPart:Clone();
    v7:PivotTo(v5.HumanoidRootPart.CFrame);
    v7.Anchored = true;
    v7.Parent = workspace.Debris;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 0, 0);
    Highlight.Parent = v5;
    local v8 = v5.Humanoid:LoadAnimation(ReplicatedStorage2.Assets.Emotes["Six Seven"]);
    v8.Priority = Enum.AnimationPriority.Action4;
    v8.Looped = true;
    v8:Play();
    local Sound = Instance.new("Sound");
    Sound.Name = "SongForTimeScale";
    Sound.SoundId = "rbxassetid://99974582876758";
    Sound.Playing = true;
    Sound.Looped = true;
    Sound.RollOffMaxDistance = 50;
    Sound.RollOffMinDistance = 10;
    Sound.Parent = v5.HumanoidRootPart;
end;

function v1.KnitStart(p9) -- Line: 77
    -- upvalues: LimitedCrateData (copy), u2 (ref), Client (copy), Players (copy), createPodiumDisplay (copy), PlayerData (copy), Janitor (copy), Popup (copy), QuestTextTemplate (copy), Knit (copy), MarketplaceService (copy), VfxManager (copy), LimitedStockItems (copy), FormatNumber (copy)
    if not LimitedCrateData.Enabled then
        return;
    end;

    u2 = Client:WaitReplion("LimitedStockItems");
    local LocalPlayer = Players.LocalPlayer;
    local _ = LocalPlayer.PlayerGui;
    local BillboardGui = workspace.LimitedCrate.FreeCrateOrigin.BillboardGui;
    local Frame = BillboardGui.Main.Frame;
    createPodiumDisplay();
    local Animator = workspace.LimitedCrate.AnimationController.Animator;
    local u10 = {};
    local Normal = LimitedCrateData.Animations.Normal;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = Normal;
    u10.Normal = Animator:LoadAnimation(Animation);
    local Robux = LimitedCrateData.Animations.Robux;
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Robux;
    u10.Robux = Animator:LoadAnimation(Animation2);
    PlayerData:WaitForLoaded();
    local u11 = Janitor.new();

    local function checkGoalReached(p12: userdata, p13: any, p14: any, p15: any) -- Line: 99
        -- upvalues: LimitedCrateData (ref)
        if p14 <= p15 then
            p12.LayoutOrder = p12.LayoutOrder + LimitedCrateData.QuestAmount;
            p12.TextColor3 = Color3.new(0.411765, 1, 0.686275);

            return;
        end;

        p12.LayoutOrder = p12.LayoutOrder - (p12.LayoutOrder > LimitedCrateData.QuestAmount and LimitedCrateData.QuestAmount or 0);
        p12.TextColor3 = Color3.new(1, 1, 1);
    end;

    local function checkAllGoals(p16) -- Line: 112
        for _, v in p16.Quests do
            if v.Progress < v.Goal then
                return false;
            end;
        end;

        return true;
    end;

    local function notifyGoalsReached(p17) -- Line: 125
        -- upvalues: Popup (ref)
        if p17.DailyCrateClaimed then
            return;
        end;

        local v18 = true;

        for _, v in p17.Quests do
            if v.Progress < v.Goal then
                v18 = false;
                break;
            end;
        end;

        if v18 then
            Popup.Popup(nil, "You have completed all limited quests, go claim  your free crate!");
        end;
    end;

    local function createQuests() -- Line: 137
        -- upvalues: u11 (copy), PlayerData (ref), LimitedCrateData (ref), QuestTextTemplate (ref), Frame (copy), checkGoalReached (copy), Popup (ref), BillboardGui (copy)
        u11:Cleanup();
        local Quests = PlayerData.Data.LimitedCrate[LimitedCrateData.EVENT].QuestsData.Quests;

        if not Quests then
            return;
        end;

        for i, v in Quests do
            local v19 = LimitedCrateData.Quests[i];
            local v20 = QuestTextTemplate:Clone();
            local string_gsub_ret = string.gsub(v19.Display, "X", v.Goal);
            u11:Add(v20, "Destroy");
            v20.Name = i;
            v20.Text = string.gsub(string_gsub_ret, "Y", v.Progress);
            v20.Parent = Frame;
            checkGoalReached(v20, v20.Text, v.Goal, v.Progress);
        end;

        local QuestsData = PlayerData.Data.LimitedCrate[LimitedCrateData.EVENT].QuestsData;

        if not QuestsData.DailyCrateClaimed then
            local v21 = true;

            for _, v in QuestsData.Quests do
                if v.Progress < v.Goal then
                    v21 = false;
                    break;
                end;
            end;

            if v21 then
                Popup.Popup(nil, "You have completed all limited quests, go claim  your free crate!");
            end;
        end;

        if PlayerData.Data.LimitedCrate[LimitedCrateData.EVENT].QuestsData.DailyCrateClaimed then
            BillboardGui.Main.Visible = false;
            BillboardGui.Refresh.Visible = true;

            return;
        end;

        BillboardGui.Main.Visible = true;
        BillboardGui.Refresh.Visible = false;
    end;

    PlayerData:Observe({ "LimitedCrate", LimitedCrateData.EVENT, "QuestsData" }, function(p22) -- Line: 170
        -- upvalues: createQuests (copy)
        createQuests();
    end);
    local Service = Knit.GetService("LimitedCrateService");
    workspace.LimitedCrate.FreeCrateOrigin.OpenCrate.Triggered:Connect(function() -- Line: 176
        -- upvalues: PlayerData (ref), LimitedCrateData (ref), Service (copy), Popup (ref)
        local v23 = PlayerData.Data.LimitedCrate[LimitedCrateData.EVENT];

        if not v23 then
            return;
        end;

        if not v23.QuestsData.Quests then
            return;
        end;

        local v24 = true;

        for _, v in v23.QuestsData.Quests do
            if v.Progress < v.Goal then
                v24 = false;
                break;
            end;
        end;

        if v24 and not v23.QuestsData.DailyCrateClaimed then
            Service:OpenNormalCrate();

            return;
        end;

        if v23.QuestsData.DailyCrateClaimed then
            Popup.Popup(nil, "You have already claimed today\'s free crate");

            return;
        end;

        Popup.Popup(nil, "You can only open this crate after finishing all your goals");
    end);

    for _, child in workspace.LimitedCrate.PremiumCrateOrigin:GetChildren() do
        if child:IsA("ProximityPrompt") then
            local ID = LimitedCrateData.RobuxCratePurchases[child.Name].ID;
            task.spawn(function() -- Line: 198
                -- upvalues: MarketplaceService (ref), ID (copy), child (copy)
                local success, result = pcall(function() -- Line: 199
                    -- upvalues: MarketplaceService (ref), ID (ref)
                    return MarketplaceService:GetProductInfo(ID, Enum.InfoType.Product);
                end);

                if success and result then
                    child.ActionText = `{result.PriceInRobux}` or "[???]";
                end;
            end);
            child.Triggered:Connect(function() -- Line: 210
                -- upvalues: MarketplaceService (ref), LocalPlayer (copy), ID (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, ID);
            end);
        end;
    end;

    Service.SendCrateRewards:Connect(function(u25, p26) -- Line: 217
        -- upvalues: LimitedCrateData (ref), u10 (copy), VfxManager (ref), Popup (ref)
        for _, v in p26 do
            local _ = LimitedCrateData.Crates[u25][v[1]];
            local v27 = u10[u25];
            v27:Play();
            task.delay(0.5, function() -- Line: 224
                -- upvalues: VfxManager (ref), u25 (copy)
                VfxManager.Emit(workspace.LimitedCrate[`{u25}Explosion`]);
            end);
            v27.Ended:Wait();
            Popup.Popup(nil, v[2]);
        end;
    end);
    local Frame2 = workspace.LimitedCrate.Origin.LimitedOverhead.Frame;
    workspace.LimitedCrate.Origin.Transparency = 1;

    local function applyStock(p28: number?) -- Line: 240
        -- upvalues: LimitedStockItems (ref), Frame2 (copy), FormatNumber (ref)
        local v29 = p28 or 0;
        local InitialStock = LimitedStockItems["Six Seven"].InitialStock;
        local math_clamp_ret = math.clamp(v29 / InitialStock, 0, 1);
        Frame2.Stock.Text = `{FormatNumber.Commas(v29)}/{FormatNumber.Commas(InitialStock)}`;

        if math_clamp_ret == nil then
            Frame2.Stock.TextColor3 = Color3.fromRGB(70, 255, 70);

            return;
        end;

        if math_clamp_ret < 0.1 then
            Frame2.Stock.TextColor3 = Color3.fromRGB(255, 70, 70);

            return;
        end;

        if math_clamp_ret < 0.3 then
            Frame2.Stock.TextColor3 = Color3.fromRGB(255, 170, 40);

            return;
        end;

        Frame2.Stock.TextColor3 = Color3.fromRGB(70, 255, 70);
    end;

    applyStock(u2:Get({ "Stocks", "Six Seven" }) or 0);
    u2:OnChange({ "Stocks", "Six Seven" }, function(p30: number, p31: number?) -- Line: 265
        -- upvalues: applyStock (copy)
        applyStock(p30);
    end);
end;

return v1;