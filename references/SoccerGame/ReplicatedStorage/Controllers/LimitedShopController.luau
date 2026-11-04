  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Client = require(ReplicatedStorage.Packages.Replion.Client);
local OnSaleLimiteds = require(ReplicatedStorage.Shared.Configs.OnSaleLimiteds);
local OnSaleTrueLimiteds = require(ReplicatedStorage.Shared.Configs.OnSaleTrueLimiteds);
local OnSaleMythics = require(ReplicatedStorage.Shared.Configs.OnSaleMythics);
local playerOwnsItem = require(ReplicatedStorage.Shared.utils.playerOwnsItem);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local Popup = require(ReplicatedStorage.Shared.Popup);
local Gift = require(ReplicatedStorage.Controllers.UIController.Gift);
local LimitedStockItems = require(ReplicatedStorage.Modules.LimitedStockItems);
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local Podiums = workspace.GameObjects.OnSaleLimiteds.Podiums;
local Podiums2 = workspace.GameObjects.OnSaleTrueLimiteds.Podiums;
local u1 = {
    PlayerCard = "Player Card",
    GoalEffect = "Goal Effect",
    MVPCutscene = "MVP Cutscene"
};
local v2 = KnitClient.CreateController({
    Name = "LimitedShopController"
});
local u3 = nil;

local function getTrueLimitedStockKey(p4) -- Line: 36
    return p4.Name;
end;

local function setupTrueLimitedStockLabel(u5: userdata, p6: any) -- Line: 40
    -- upvalues: u3 (ref), LimitedStockItems (copy), FormatNumber (copy)
    if not u3 then
        u5.ItemType.Text = "?";

        return;
    end;

    local Name = p6.Name;

    local function applyStock(p7: number?) -- Line: 48
        -- upvalues: LimitedStockItems (ref), Name (copy), u5 (copy), FormatNumber (ref)
        local v8 = p7 or 0;
        local InitialStock = LimitedStockItems[Name].InitialStock;
        local math_clamp_ret = math.clamp(v8 / InitialStock, 0, 1);
        u5.ItemType.Text = `{FormatNumber.Commas(v8)}/{FormatNumber.Commas(InitialStock)}`;

        if math_clamp_ret == nil then
            u5.ItemType.TextColor3 = Color3.fromRGB(70, 255, 70);

            return;
        end;

        if math_clamp_ret < 0.1 then
            u5.ItemType.TextColor3 = Color3.fromRGB(255, 70, 70);

            return;
        end;

        if math_clamp_ret < 0.3 then
            u5.ItemType.TextColor3 = Color3.fromRGB(255, 170, 40);

            return;
        end;

        u5.ItemType.TextColor3 = Color3.fromRGB(70, 255, 70);
    end;

    applyStock(u3:Get({ "Stocks", Name }) or 0);
    u3:OnChange({ "Stocks", Name }, function(p9: number, p10: number?) -- Line: 73
        -- upvalues: applyStock (copy)
        applyStock(p9);
    end);
end;

function v2.LoadPodium(p11: table, p12: number, u13: any, p14: userdata, p15: boolean?) -- Line: 80
    -- upvalues: ReplicatedStorage (copy), setupTrueLimitedStockLabel (copy), u1 (copy), u3 (ref), Popup (copy), LocalPlayer (copy), playerOwnsItem (copy), PlayerData (copy), MarketplaceService (copy), Gift (copy), FormatNumber (copy)
    local u16 = p15 == true;
    local u17 = p14:FindFirstChild((tostring(p12)));

    if not u17 then
        warn("Podium model not found for ID:", p12);

        return;
    end;

    u17.Origin.Transparency = 1;
    local LimitedTemplates = ReplicatedStorage.Assets.LimitedTemplates;
    local u18 = (u16 and LimitedTemplates.LimitedHeaderTemplate or LimitedTemplates.HeaderTemplate):Clone();
    u18.Adornee = u17.PrimaryPart;
    u18.ItemName.Text = (u13.DisplayName or u13.Name):upper();
    u18.StudsOffsetWorldSpace = Vector3.new(0, u13.HeaderOffset, 0);
    u18.Parent = u17;
    u13.Gradient:Clone().Parent = u18.ItemName;

    if u16 then
        setupTrueLimitedStockLabel(u18, u13);
    else
        u18.ItemType.Text = (u1[u13.Type] or u13.Type):upper();
    end;

    local u19 = script.Prox:Clone();
    u19.ObjectText = `LIMITED {(u1[u13.Type] or u13.Type):upper()}`;
    u19.ActionText = "PURCHASE";
    u19.Parent = u17.Origin.Prompts;
    u19.MaxActivationDistance = u16 and 20 or 10;
    u19.Triggered:Connect(function() -- Line: 122
        -- upvalues: u16 (ref), u3 (ref), u13 (copy), Popup (ref), LocalPlayer (ref), playerOwnsItem (ref), PlayerData (ref), MarketplaceService (ref)
        if u16 and (u3 and (u3:Get({ "Stocks", u13.Name }) or 0) <= 0) then
            Popup.Popup(LocalPlayer, "This item is out of stock!");

            return;
        end;

        if playerOwnsItem(PlayerData.Data, u13.Type, u13.Name) then
            Popup.Popup(LocalPlayer, "You already own this!");

            return;
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, u13.ProductId);
    end);
    local u20 = script.Gift:Clone();
    u20.ActionText = `GIFT LIMITED {(u1[u13.Type] or u13.Type):upper()}`;
    u20.Parent = u17.Origin.Prompts;
    u20.MaxActivationDistance = u16 and 20 or 10;
    u20.Triggered:Connect(function() -- Line: 145
        -- upvalues: u16 (ref), u3 (ref), u13 (copy), Popup (ref), LocalPlayer (ref), Gift (ref)
        if u16 and (u3 and (u3:Get({ "Stocks", u13.Name }) or 0) <= 0) then
            Popup.Popup(LocalPlayer, "This item is out of stock!");

            return;
        end;

        if Gift.ButtonDb > tick() then
            return;
        end;

        LocalPlayer.PlayerGui.Gift.Enabled = true;
        Gift.LastID = u13.GiftProductId;
        Gift.LastReceiptID = nil;
    end);
    task.spawn(function() -- Line: 165
        -- upvalues: MarketplaceService (ref), u13 (copy), FormatNumber (ref), u19 (copy), u20 (copy), u16 (ref), u18 (ref)
        local success, result = pcall(function() -- Line: 166
            -- upvalues: MarketplaceService (ref), u13 (ref)
            return MarketplaceService:GetProductInfo(u13.ProductId, Enum.InfoType.Product);
        end);

        if not success then
            warn("Failed to GetProductInfo for limited:", result);

            return;
        end;

        local v21 = tonumber(result.PriceInRobux);

        if not v21 then
            return;
        end;

        local v22 = FormatNumber.Commas(v21);
        u19.ActionText = `{v22}`;
        u20.ObjectText = `{v22}`;

        if u16 then
            local Price = u18:FindFirstChild("Price");

            if Price and Price:IsA("TextLabel") then
                Price.Text = `{v22}`;
            end;
        end;
    end);
    local success, result = pcall(function() -- Line: 194
        -- upvalues: u13 (copy), u17 (copy)
        u13:LoadVisual(u17);
    end);

    if not success then
        warn((`failed to load limited. error:\n{result}\n\nthe model has been hidden`));
        u17:PivotTo(CFrame.new(0, 10000, 0));
    end;
end;

function v2.LoadMythicPodium(p23, u24) -- Line: 204
    -- upvalues: ReplicatedStorage (copy), u1 (copy), MarketplaceService (copy), FormatNumber (copy), playerOwnsItem (copy), PlayerData (copy), Popup (copy), LocalPlayer (copy)
    local u25 = workspace:FindFirstChild(u24.PodiumName or "Mythic" .. u24.Type);
    assert(u25);
    local Origin = u25:FindFirstChild("Origin");

    if Origin then
        Origin.Transparency = 1;
    end;

    local v26 = ReplicatedStorage.Assets.MythicTemplates.Header:Clone();
    v26.Adornee = u25.PrimaryPart;
    v26.ItemName.Text = (u24.DisplayName or u24.Name):upper();
    v26.StudsOffset = Vector3.new(0, u24.HeaderOffset, 0);
    v26.Parent = u25;
    u24.Gradient:Clone().Parent = v26.ItemName;
    local v27 = v26:FindFirstChild("ItemType") or v26:FindFirstChild("ButtonName");

    if v27 and v27:IsA("TextLabel") then
        v27.Text = (u1[u24.Type] or u24.Type):upper();
    end;

    local u28 = script.Prox:Clone();
    u28.ObjectText = `MYTHIC {(u1[u24.Type] or u24.Type):upper()}`;
    u28.ActionText = "PURCHASE";
    u28.RequiresLineOfSight = false;
    u28.MaxActivationDistance = 18;
    task.spawn(function() -- Line: 230
        -- upvalues: u24 (copy), MarketplaceService (ref), FormatNumber (ref), u28 (copy)
        local u29 = nil;
        local u30 = nil;

        if u24.CatalogAssetID then
            u29 = u24.CatalogAssetID;
            u30 = Enum.InfoType.Asset;
        elseif u24.GamepassId then
            u29 = u24.GamepassId;
            u30 = Enum.InfoType.GamePass;
        elseif u24.ProductId then
            u29 = u24.ProductId;
            u30 = Enum.InfoType.Product;
        end;

        if not u29 then
            return;
        end;

        local success, result = pcall(function() -- Line: 242
            -- upvalues: MarketplaceService (ref), u29 (ref), u30 (ref)
            return MarketplaceService:GetProductInfo(u29, u30);
        end);

        if not success then
            warn("Failed to GetProductInfo for mythic:", result);

            return;
        end;

        local v31 = tonumber(result.PriceInRobux);

        if not v31 then
            return;
        end;

        u28.ActionText = `{FormatNumber.Commas(v31)}`;
    end);
    u28.Parent = Origin or u25.Main;
    u28.Triggered:Connect(function() -- Line: 262
        -- upvalues: playerOwnsItem (ref), PlayerData (ref), u24 (copy), Popup (ref), LocalPlayer (ref), MarketplaceService (ref)
        if playerOwnsItem(PlayerData.Data, u24.Type, u24.Name) then
            Popup.Popup(LocalPlayer, "You already own this!");

            return;
        end;

        if u24.CatalogAssetID then
            MarketplaceService:PromptPurchase(LocalPlayer, u24.CatalogAssetID);

            return;
        end;

        if u24.GamepassId then
            MarketplaceService:PromptGamePassPurchase(LocalPlayer, u24.GamepassId);

            return;
        end;

        if u24.ProductId then
            MarketplaceService:PromptProductPurchase(LocalPlayer, u24.ProductId);
        end;
    end);
    local success, result = pcall(function() -- Line: 277
        -- upvalues: u24 (copy), u25 (copy)
        u24:LoadVisual(u25);
    end);

    if not success then
        warn((`failed to load mythic. error:\n{result}\n\nthe model has been hidden`));
        u25:PivotTo(CFrame.new(0, 10000, 0));
    end;
end;

function v2.KnitStart(p32) -- Line: 287
    -- upvalues: u3 (ref), Client (copy), OnSaleLimiteds (copy), Podiums (copy), OnSaleTrueLimiteds (copy), Podiums2 (copy), OnSaleMythics (copy)
    u3 = Client:WaitReplion("LimitedStockItems");

    for i, v in OnSaleLimiteds do
        p32:LoadPodium(i, v, Podiums, false);
    end;

    for i, v in OnSaleTrueLimiteds do
        p32:LoadPodium(i, v, Podiums2, true);
    end;

    for _, v in OnSaleMythics do
        p32:LoadMythicPodium(v);
    end;
end;

return v2;