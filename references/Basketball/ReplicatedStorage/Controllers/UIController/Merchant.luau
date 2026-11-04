 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("MarketplaceService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("UserInputService");
game:GetService("GuiService");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.RelicsXYZ);
local Trove = require(ReplicatedStorage.Packages.Trove);
local CustomScrollbar = require(ReplicatedStorage.Shared.Utility.CustomScrollbar);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local MerchantSettings = require(ReplicatedStorage.Shared.Tables.MerchantSettings);
local Content = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Merchant"):WaitForChild("Content");
local u1 = CustomScrollbar.new(Content.Frame.ScrollingFrame, Content.Frame.Scrollbar);
local u2 = nil;
local u3 = Trove.new();
local u4 = Knit.CreateController({
    Name = "MerchantController"
});

local function deep_equals(p5, p6, p7) -- Line: 42
    -- upvalues: deep_equals (copy)
    if p5 == p6 then
        return true;
    end;

    local v8 = type(p5);

    if v8 ~= type(p6) then
        return false;
    end;

    if v8 ~= "table" then
        return false;
    end;

    if not p7 then
        local v9 = getmetatable(p5);

        if v9 and v9.__eq then
            return p5 == p6;
        end;
    end;

    for i, v in pairs(p5) do
        local v10 = p6[i];

        if v10 == nil or deep_equals(v, v10, p7) == false then
            return false;
        end;
    end;

    for i, _ in pairs(p6) do
        if p5[i] == nil then
            return false;
        end;
    end;

    return true;
end;

function u4.UpdateMerchantShop() -- Line: 77
    -- upvalues: u3 (copy), Knit (copy), u2 (ref), Customization (copy), Styles (copy), Zones (copy), Content (copy), ReplicatedStorage (copy), Rarities (copy), Essentials (copy), MarketplaceService (copy), LocalPlayer (copy), Effects (copy), u4 (copy), RunService (copy), GetUnixTime (copy), MerchantSettings (copy), NumberUtil (copy), deep_equals (copy)
    u3:Clean();
    local Controller = Knit.GetController("Shop");
    local Controller2 = Knit.GetController("Network");
    local Service = Knit.GetService("MerchantService");

    if not u2 then
        u2 = Service:GetStock();
    end;

    for i, v in ipairs(u2.Shop) do
        local v11 = nil;

        if Customization[v.Type] then
            v11 = Customization[v.Type][v.Name];
        elseif v.Type == "Styles" then
            v11 = Styles.Styles[v.Name];
        elseif v.Type == "Zones" then
            v11 = Zones.Zones[v.Name];
        end;

        if v11 then
            local u12 = u3:Add(script.Template:Clone());
            u12.Parent = Content.Frame.ScrollingFrame;
            u12.Name = i;
            u12.LayoutOrder = i;

            if v.Type == "ChatTags" then
                u12.Item.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Name, true).UIGradient.Color.Keypoints[1].Value) });
                u12.Frame.UIGradient.Color = ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Name, true).UIGradient.Color;
                u12.Frame.Equip.UIGradient.Color = ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Name, true).UIGradient.Color;
            elseif v11.Rarity then
                u12.Item.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Rarities.Colors[v11.Rarity]) });
                u12.Frame.UIGradient.Color = ColorSequence.new(Rarities.Colors[v11.Rarity]);
                u12.Frame.Equip.UIGradient.Color = ColorSequence.new(Rarities.Colors[v11.Rarity]);
            end;

            if v.Stock and v.Stock >= 1 then
                u12.Frame.Stock.Amount.Text = v.Stock > 1 and (`{v.Stock} IN STOCK` or "IN STOCK") or "IN STOCK";
                u12.Frame.Stock.Amount.TextColor3 = Color3.fromRGB(84, 255, 37);
                u12.Purchase.Visible = true;
                u12.Price.Visible = true;
                u12.LayoutOrder = i;
                local v13 = u2.Shop[tonumber(u12.Name)];

                if v13 and (Controller2.Player.Customization.Inventory[v13.Type] and table.find(Controller2.Player.Customization.Inventory[v13.Type], v13.Name) or (v13.Type == "Styles" and table.find(Controller2.Player.LimitedStyles, v13.Name) or v13.Type == "Zones" and table.find(Controller2.Player.LimitedZones, v13.Name))) then
                    u12.Purchase.Label.Text = "OWNED";
                end;
            else
                u12.Frame.Stock.Amount.Text = "OUT OF STOCK";
                u12.Frame.Stock.Amount.TextColor3 = Color3.fromRGB(255, 37, 37);
                u12.Purchase.Visible = false;
                u12.Price.Visible = false;
                u12.LayoutOrder = i + 1000;
            end;

            local string_gsub_ret = string.gsub(v.Type:sub(1, #v.Type - 1), "(.)(%u)", "%1 %2");
            u12.Item.Text = `{v.Name} ({string_gsub_ret})`;

            if v.Desc then
                u12.Desc.Text = v.Desc;
            elseif u2.Desc[v.Type] then
                u12.Desc.Text = u2.Desc[v.Type];
            elseif v.Type == "Styles" then
                u12.Desc.Text = Styles.Styles[v.Name].Desc;
            elseif v.Type == "Zones" then
                u12.Desc.Text = Zones.Zones[v.Name].Desc;
            else
                u12.Desc.Text = "";
            end;

            if v.Type == "Emotes" then
                task.spawn(function() -- Line: 162
                    -- upvalues: u12 (copy), Knit (ref), v (copy)
                    u12.Frame.Icon.ImageTransparency = 1;
                    local ViewportFrame = Instance.new("ViewportFrame", u12.Frame.Icon);
                    ViewportFrame.Size = UDim2.fromScale(1, 1);
                    ViewportFrame.Ambient = Color3.fromRGB(255, 255, 255);
                    ViewportFrame.BackgroundTransparency = 1;
                    ViewportFrame.ZIndex = u12.Frame.Icon.ZIndex;
                    local Controller3 = Knit.GetController("EmotesController");

                    while not Controller3.CharacterRig do
                        task.wait();
                    end;

                    Controller3:CreatePreview(v.Emote or v.Name, ViewportFrame, Controller3.CharacterRig);
                end);
            elseif v.Type == "GoalEffects" then
                u12.Frame.Icon.Image = Controller.GoalIcons[v.Name] or "";
            elseif v.Type == "ShotEffects" then
                u12.Frame.Icon.Image = Controller.ShotIcons[v.Name] or "";
            elseif v.Type == "Cards" then
                u12.Frame.Icon.Image = Controller.Cards[v.Name] or "";
            elseif v11.IconId then
                u12.Frame.Icon.Image = `rbxassetid://{v11.IconId}`;
            elseif v.Type == "ChatTags" then
                local v14 = script.StyleOrZoneName:Clone();
                v14.Parent = u12.Frame;
                v14.Text = ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Name, true).Value;
                v14.ZIndex = u12.Frame.Icon.ZIndex;
                u12.Frame.Icon:Destroy();
                ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Name, true).UIGradient:Clone().Parent = v14;
            elseif v.Type == "Styles" then
                local v15 = script.StyleOrZoneName:Clone();
                v15.Parent = u12.Frame;
                v15.Text = v11.UIName or v.Name;
                v15.ZIndex = u12.Frame.Icon.ZIndex;
                u12.Frame.Icon:Destroy();
                ReplicatedStorage.Controllers.UIController.Style.Gradients[v11.Rarity]:Clone().Parent = v15;
            elseif v.Type == "Zones" then
                local v16 = script.StyleOrZoneName:Clone();
                v16.Parent = u12.Frame;
                v16.Text = v.Name;
                v16.ZIndex = u12.Frame.Icon.ZIndex;
                u12.Frame.Icon:Destroy();
                ReplicatedStorage.Controllers.UIController.Zone.Gradients[v11.Rarity]:Clone().Parent = v16;
            end;

            u12.Price.Text = `${Essentials:formatNumberWithCommas(v.Price)}`;
            u12.Purchase.MouseButton1Click:Connect(function() -- Line: 217
                -- upvalues: Controller2 (copy), v (copy), MarketplaceService (ref), LocalPlayer (ref), Effects (ref), Service (copy), i (copy), u2 (ref), u4 (ref)
                local v17 = Controller2.Player.Money - v.Price;

                if v17 < 0 then
                    if Controller2.Policy then
                        return;
                    end;

                    if math.abs(v17) > 25000 then
                        MarketplaceService:PromptProductPurchase(LocalPlayer, 2838789495);
                    elseif math.abs(v17) > 10000 then
                        MarketplaceService:PromptProductPurchase(LocalPlayer, 2838789218);
                    elseif math.abs(v17) > 5000 then
                        MarketplaceService:PromptProductPurchase(LocalPlayer, 2838789087);
                    else
                        MarketplaceService:PromptProductPurchase(LocalPlayer, 2838788938);
                    end;

                    MarketplaceService:PromptProductPurchase(LocalPlayer, 2838788938);
                    Effects:Popup("Not enough money!");

                    return;
                end;

                local v18, v19 = Service:Buy(i);

                if not v18 then
                    if v19 then
                        Effects:Popup(v19);
                    end;

                    return;
                end;

                for i2, v2 in ipairs(u2.Shop) do
                    u2.Shop[i2].Stock = (v2.Stock or 0) - (v19[tostring(i2)] or 0);
                end;

                u4.UpdateMerchantShop();
            end);
        end;
    end;

    local u20 = nil;
    local u21 = u2;
    u3:Connect(RunService.Heartbeat, function(p22: number) -- Line: 253
        -- upvalues: GetUnixTime (ref), u20 (ref), MerchantSettings (ref), Content (ref), NumberUtil (ref), deep_equals (ref), u21 (copy), u2 (ref), u4 (ref)
        local v23 = GetUnixTime();

        if u20 == v23 then
            return;
        end;

        u20 = v23;
        local v24 = (math.floor(v23 / MerchantSettings.Restock.Interval) + 1 - v23 / MerchantSettings.Restock.Interval) * MerchantSettings.Restock.Interval;
        Content.Timer.Text = `AVAILABLE FOR {string.upper(NumberUtil.AdaptiveClockString(v24))}`;

        if not deep_equals(u21, u2) then
            u4.UpdateMerchantShop();
        end;
    end);
end;

function u4.KnitInit(p25) -- Line: 272
end;

function u4.KnitStart(p26) -- Line: 278
    -- upvalues: Knit (copy), LocalPlayer (copy), Effects (copy), u2 (ref), Content (copy), u4 (copy), u1 (copy), u3 (copy), MarketplaceService (copy)
    Knit.GetController("Network");
    local Controller = Knit.GetController("UIController");
    Knit.GetService("MerchantService").Restock:Connect(function(p27) -- Line: 284
        -- upvalues: LocalPlayer (ref), Effects (ref), u2 (ref)
        if LocalPlayer.Team == game.Teams.Visitor then
            Effects:Popup("BLACK MARKET HAS BEEN RESTOCKED!", 3);
        end;

        u2 = p27;
    end);
    Content.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 292
        -- upvalues: Content (ref), u4 (ref), u1 (ref), u3 (ref), Controller (copy)
        if Content.Parent.Enabled then
            u4.UpdateMerchantShop();
            u1:Start();

            return;
        end;

        u3:Clean();
        Controller:Focus(false, Content);
        u1:Stop();
    end);
    Content.Close.MouseButton1Click:Connect(function() -- Line: 305
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.HUD.Enabled = true;
    end);
    Content.Restock.MouseButton1Click:Connect(function() -- Line: 309
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, 3520561724);
    end);
end;

return u4;