 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Promise = require(ReplicatedStorage.Packages.Promise);
local CustomScrollbar = require(ReplicatedStorage.Shared.Utility.CustomScrollbar);
local ShopSettings = require(ReplicatedStorage.Shared.Tables.ShopSettings);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Content = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BuySpins"):WaitForChild("Content");
local u1 = Knit.CreateController({
    Name = "BuySpinsController",
    CurrentlyOpenId = nil,
    IsGuiLoading = false,
    ScrollBar = CustomScrollbar.new(Content.Content, Content.Content.Scrollbar.Scrollbar),
    ProductInfoCache = {}
});
local u2 = nil;

function u1.ClearGuiContent() -- Line: 32
    -- upvalues: u1 (copy), Content (copy)
    while u1.IsGuiLoading do
        task.wait();
    end;

    for _, child in Content.Content:GetChildren() do
        if child:IsA("ImageLabel") then
            child:Destroy();
        end;
    end;

    u1.CurrentlyOpenId = nil;
end;

function u1.ShowGui(p3: string, p4: table, u5: boolean?) -- Line: 48
    -- upvalues: u1 (copy), Content (copy), Promise (copy), MarketplaceService (copy), ShopSettings (copy), Knit (copy), Effects (copy), u2 (ref), LocalPlayer (copy)
    if u1.CurrentlyOpenId == p3 then
        u1.CloseGui();

        return;
    end;

    u1.ClearGuiContent();
    u1.ScrollBar:Start();
    u1.IsGuiLoading = true;
    u1.CurrentlyOpenId = p3;
    Content.Parent.Enabled = true;
    local v6 = {};

    for i, v in p4 do
        table.insert(v6, Promise.new(function(p7) -- Line: 65
            -- upvalues: u1 (ref), v (copy), MarketplaceService (ref), i (copy), Content (ref), ShopSettings (ref), Knit (ref), Effects (ref), u2 (ref), LocalPlayer (ref), u5 (copy)
            local u8 = u1.ProductInfoCache[v.ProductId];

            if u8 == nil then
                u8 = MarketplaceService:GetProductInfo(v.ProductId, Enum.InfoType.Product);
                u1.ProductInfoCache[v.ProductId] = u8;
            end;

            local v9 = script.SpinProduct:Clone();
            v9.LayoutOrder = i;
            v9.Buttons.BuyRobux.TextLabel.Text = `{utf8.char(57346)}{u8.PriceInRobux}`;
            v9.Title.Text = u8.Name;
            v9.BackgroundIcon.Image = v.ImageId or "";
            v9.BackgroundIcon.Rainbow.Enabled = v.IsRainbow == true;
            v9.Parent = Content.Content;
            v9.Buttons.BuyCash.Visible = false;

            if ShopSettings.Spins[v.ProductId] == nil then
                v9.Buttons.BuyCash.Visible = false;
            else
                v9.Buttons.BuyCash.TextLabel.Text = `${ShopSettings.Spins[v.ProductId] or " n/a"}`;
                v9.Buttons.BuyCash.MouseButton1Click:Connect(function() -- Line: 85
                    -- upvalues: Knit (ref), v (ref), Effects (ref), u8 (ref)
                    if Knit.GetService("SpinsService"):BuyProductWithCash(v.ProductId) == true then
                        Effects:Popup(`Purchased {u8.Name}!`, 2, Color3.fromRGB(0, 255, 0));

                        return;
                    end;

                    Effects:Popup(`Could not purchase {u8.Name}`, 2, Color3.fromRGB(255, 0, 0));
                end);
            end;

            v9.Buttons.BuyRobux.MouseButton1Click:Connect(function() -- Line: 99
                -- upvalues: u2 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref), v (ref), u5 (ref), u1 (ref)
                if u2.Policy then
                    Effects:Popup("This purchase is not available for your region.");

                    return;
                end;

                MarketplaceService:PromptProductPurchase(LocalPlayer, v.ProductId);

                if u5 then
                    u1.CloseGui();
                end;
            end);
            v9.Buttons.Gift.MouseButton1Click:Connect(function() -- Line: 107
                -- upvalues: Knit (ref), v (ref), u5 (ref), u1 (ref)
                Knit.GetController("GiftingController").PromptGiftPlayer(v.ProductId);

                if u5 then
                    u1.CloseGui();
                end;
            end);
            p7();
        end));
    end;

    Promise.allSettled(v6):await();
    u1.IsGuiLoading = false;
end;

function u1.CloseGui() -- Line: 125
    -- upvalues: Content (copy), u1 (copy)
    Content.Parent.Enabled = false;
    u1.ScrollBar:Stop();
    u1.CurrentlyOpenId = nil;
end;

function u1.KnitInit(p10) -- Line: 132
    -- upvalues: Content (copy), u1 (copy)
    Content.Close.MouseButton1Click:Connect(function() -- Line: 133
        -- upvalues: u1 (ref)
        u1.CloseGui();
    end);
end;

function u1.KnitStart(p11) -- Line: 138
    -- upvalues: u2 (ref), Knit (copy)
    u2 = Knit.GetController("Network");
end;

return u1;