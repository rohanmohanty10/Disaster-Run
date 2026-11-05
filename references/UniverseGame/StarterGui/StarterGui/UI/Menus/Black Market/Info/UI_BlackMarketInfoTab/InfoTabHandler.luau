  

 

local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.StandsModule);
require(PathShortcuts.KnitPath.Trove);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").StatsHandler);
Knit.GetService("ShopService");
local u1 = game.Players.LocalPlayer or {};
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4, p5) -- Line: 13
    -- upvalues: u2 (copy)
    local v6 = {
        MetaData = p5,
        CurrencyString = p5.CurrencyString,
        Button = script.Button,
        TextBox = script.TextBox,
        Buttons = p3.Buttons,
        Description = p3.Description,
        Name = p3.Label,
        Rarity = p3.Rarity,
        Trove = p4.new()
    };
    setmetatable(v6, u2);

    return v6;
end;

function u2.CreateBlackMarketInfoTab(u7, p8, p9, p10, u11, p12, p13) -- Line: 28
    -- upvalues: ItemData (copy), u1 (copy)
    local _ = u7.Trove;
    local _ = u7.Buttons;
    local Rarity = u7.Rarity;
    local Description = u7.Description;
    u7.Name.Text = tostring(p8.DisplayName or p8.Name);
    local v14 = ItemData.Rarities[p8.Rarity];
    Rarity.Text = v14.Name;
    Rarity.TextColor3 = v14.Color;

    if #p8.Description > 0 then
        local Label = Description.Label;
        Label.Text = Label.Text .. p8.Description .. "\n";
    end;

    local BlackMarketBasePrice = p8.BlackMarketBasePrice;
    local BlackMarketMaxPrice = p8.BlackMarketMaxPrice;
    local v15 = BlackMarketMaxPrice - BlackMarketBasePrice;
    local v16 = BlackMarketBasePrice + v15 * (p12 / 100);
    u7:DisplayPrice(BlackMarketBasePrice, v15 * (p12 / 100));

    if BlackMarketMaxPrice >= v16 then
        BlackMarketMaxPrice = v16;
    end;

    local u17 = math.ceil(BlackMarketMaxPrice);

    local function Transfer() -- Line: 60
        -- upvalues: u1 (ref), u11 (copy), u17 (ref), u7 (copy)
        local Frame = u1.PlayerGui.UI.Menus["Black Market"].Frame;
        local Items = Frame.Backpack.BlackMarketItemExchangePanel.Escrow.Items;
        local Items2 = Frame.Backpack.Items;
        local Button = Frame.Backpack.BlackMarketItemExchangePanel.Sell.Button;
        local v18 = Button:GetAttribute("ItemCount") or 0;
        local v19 = Button:GetAttribute("ItemsCumulativePrice") or 0;
        local v20, v21;

        if u11.Parent == Items then
            u11:SetAttribute("InEscrow", nil);
            u11.Parent = Items2;
            v20 = v18 - 1;
            v21 = v19 - u17;
        else
            u11:SetAttribute("InEscrow", true);
            u11.Parent = Items;
            v20 = v18 + 1;
            v21 = v19 + u17;
        end;

        local v22 = u7.MetaData:AbbreviateNumber(v21);
        local v23 = math.clamp(v20, 0, 999);
        Button.Text = `SELL {v23} ITEMS ({v22} {u7.CurrencyString or "<s>u</s>S"})`;
        Button:SetAttribute("ItemCount", v23);
        Button:SetAttribute("ItemsCumulativePrice", v21);
    end;

    u7.Trove:Connect(p13.TransferAllSignal, function() -- Line: 90
        -- upvalues: Transfer (copy)
        print("reading signal");
        Transfer();
    end);
    u7:DisplayButton("Transfer", function() -- Line: 94
        -- upvalues: Transfer (copy)
        Transfer();
    end);
end;

function u2.DisplayButton(p24, p25, p26) -- Line: 132
    local v27 = p24.Trove:Clone(p24.Button);
    v27.TextLabel.Text = p25;
    v27.MouseButton1Click:Connect(p26);
    v27.Visible = true;
    v27.Parent = p24.Buttons;
end;

function u2.DisplayNumberBox(p28, p29, p30) -- Line: 141
    local u31 = p28.Trove:Clone(p28.TextBox);
    u31.TextBox.PlaceholderText = p29;
    u31:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 146
        -- upvalues: u31 (copy)
        local Text = u31.Text;

        if Text == "" then
            u31.Text = 1;
            Text = 1;
        end;

        if not tonumber(Text) then
            u31.Text = 1;
            Text = 1;
        end;

        local v32 = tonumber(Text);
        u31.Text = math.clamp(v32, 1, 999);
    end);
    u31.Visible = true;
    u31.Parent = p28.Buttons;
end;

function u2.DisplayPrice(p33, p34, p35) -- Line: 164
    local Description = p33.Description;
    local v36 = "";

    if p34 then
        v36 = v36 .. "<font size=\"28\">Item Value: <font color=\"rgb(75,170,255)\">" .. tostring(p34) .. " " .. p33.CurrencyString .. "</font></font>";
    end;

    if #v36 <= 0 then
        return;
    end;

    local Label = Description.Label;
    Label.Text = Label.Text .. v36 .. "\n";
    local v37 = math.ceil(p35);
    local v38 = "<font size=\"28\">Purity Bonus Value: <font color=\"rgb(90,255,90)\">+" .. tostring(v37) .. " " .. p33.CurrencyString .. "</font></font>";

    if #v38 <= 0 then
        return;
    end;

    local Label2 = Description.Label;
    Label2.Text = Label2.Text .. v38 .. "\n";
end;

function u2.Clean(p39) -- Line: 179
    p39.Name.Text = "";
    p39.Rarity.Text = "";
    p39.Description.Label.Text = "";
    p39.Trove:Clean();
end;

return u2;