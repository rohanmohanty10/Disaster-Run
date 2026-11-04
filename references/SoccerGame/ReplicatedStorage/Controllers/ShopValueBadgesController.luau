  

local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    [2660228654] = 4000,
    [2660228791] = 15000,
    [2660228867] = 32000,
    [2660228990] = 50000,
    [2660229193] = 99000
};
local u2 = {};

local function fetchPrice(p3: number) -- Line: 32
    -- upvalues: u2 (copy), MarketplaceService (copy)
    local v4 = u2[p3];

    if v4 then
        return v4;
    end;

    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, p3, Enum.InfoType.Product);

    if not (success and (typeof(result) == "table" and typeof(result.PriceInRobux) == "number")) then
        return nil;
    end;

    u2[p3] = result.PriceInRobux;

    return result.PriceInRobux;
end;

local function savingPercent(p5: number, p6: number, p7: number, p8: number) -- Line: 45
    local v9 = p7 / p8;

    return v9 <= 0 and 0 or math.floor((1 - p5 / p6 / v9) * 100 + 1e-6);
end;

local function findTitle(p10: userdata) -- Line: 53
    local v11 = nil;

    for _, child in p10:GetChildren() do
        if child:IsA("TextLabel") and (child.Name == "Text" and (child.Visible and (not v11 or child.Position.Y.Scale < v11.Position.Y.Scale))) then
            v11 = child;
        end;
    end;

    return v11;
end;

local function hasOwnTag(p12: userdata) -- Line: 65
    for _, child in p12:GetChildren() do
        if child:IsA("TextLabel") and (child.Name ~= "ValueTag" and (child.Visible and string.upper(child.Text) == "BEST VALUE")) then
            return true;
        end;
    end;

    return false;
end;

local function setTag(p13: userdata, p14: string?, p15: boolean) -- Line: 74
    -- upvalues: ReplicatedStorage (copy), findTitle (copy)
    local ValueTag = p13:FindFirstChild("ValueTag");

    if not p14 then
        if ValueTag then
            ValueTag:Destroy();
        end;

        return;
    end;

    local v16 = ValueTag or ReplicatedStorage.Assets.UI.ValueTag:Clone();
    local v17;

    if p15 then
        v17 = findTitle(p13);
    else
        v17 = nil;
    end;

    if v17 then
        local Scale = v17.Size.Y.Scale;
        local v18 = v17.Position.Y.Scale + Scale * (1 - v17.AnchorPoint.Y);
        v16.AnchorPoint = Vector2.new(0.5, 0);
        v16.Position = UDim2.fromScale(v17.Position.X.Scale + v17.Size.X.Scale * (0.5 - v17.AnchorPoint.X), v18 + Scale * 0.15);
        v16.Size = UDim2.fromScale(v17.Size.X.Scale, Scale * 0.8);
    end;

    v16.Text = p14;
    v16.Parent = p13;
end;

local function applyGroup(p19: table, p20: boolean) -- Line: 97
    -- upvalues: hasOwnTag (copy), setTag (copy)
    local v21 = nil;

    for _, v in p19 do
        if not v21 or v.units < v21.units then
            v21 = v;
        end;
    end;

    for _, v in p19 do
        local v22;

        if v21 and (v21.price and (v.price and v ~= v21)) then
            local v23 = v21.price / v21.units;
            v22 = v23 <= 0 and 0 or math.floor((1 - v.price / v.units / v23) * 100 + 1e-6);
        else
            v22 = 0;
        end;

        local v24;

        if v22 >= 10 then
            v24 = not hasOwnTag(v.card);
        else
            v24 = false;
        end;

        local card = v.card;
        local v25;

        if v24 then
            v25 = "SAVE " .. tostring(v22) .. "%";
        else
            v25 = nil;
        end;

        setTag(card, v25, p20);
    end;
end;

local function parseShownPrice(p26: string) -- Line: 115
    if not string.find(p26, "", 1, true) then
        return nil;
    end;

    local string_gsub_ret = string.gsub(p26, "%D", "");

    return tonumber(string_gsub_ret);
end;

local v27 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "ShopValueBadgesController"
});

function v27.KnitStart(p28) -- Line: 126
    -- upvalues: LocalPlayer (copy), u1 (copy), u2 (copy), MarketplaceService (copy), applyGroup (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    task.spawn(function() -- Line: 129
        -- upvalues: PlayerGui (copy), u1 (ref), u2 (ref), MarketplaceService (ref), applyGroup (ref)
        local Shop = PlayerGui:WaitForChild("Shop");
        local u29 = {};
        local u30 = {};

        for _, child in Shop:WaitForChild("BG"):WaitForChild("ShopUI"):WaitForChild("Inside"):WaitForChild("Cash"):GetChildren() do
            if child:IsA("GuiObject") then
                local RobuxButton = child:FindFirstChild("RobuxButton");
                local v31;

                if RobuxButton then
                    v31 = RobuxButton:GetAttribute("ID");
                else
                    v31 = RobuxButton;
                end;

                local v32;

                if typeof(v31) == "number" then
                    v32 = u1[v31];
                else
                    v32 = false;
                end;

                if v32 then
                    table.insert(u30, {
                        price = nil,
                        card = child,
                        units = v32,
                        productId = v31
                    });
                    local Txt = RobuxButton:FindFirstChild("Txt");

                    if child:FindFirstChild("DiscountedPrice") and (Txt and Txt:IsA("TextLabel")) then
                        u29[child] = Txt;
                    end;
                end;
            end;
        end;

        local u33 = false;

        local function refresh() -- Line: 153
            -- upvalues: u30 (copy), u2 (ref), MarketplaceService (ref), u29 (copy), applyGroup (ref)
            local v34 = false;

            for _, v in u30 do
                if not v.price and v.productId then
                    local productId = v.productId;
                    local v35 = u2[productId];

                    if not v35 then
                        local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, productId, Enum.InfoType.Product);

                        if success and (typeof(result) == "table" and typeof(result.PriceInRobux) == "number") then
                            u2[productId] = result.PriceInRobux;
                            v35 = result.PriceInRobux;
                        else
                            v35 = nil;
                        end;
                    end;

                    v.price = v35;
                end;

                v34 = not v.price and true or v34;
                local v36 = u29[v.card];

                if v36 and v.price then
                    v36.Text = tostring(v.price);
                end;
            end;

            applyGroup(u30, true);

            return v34;
        end;

        local u37 = refresh();
        Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 172
            -- upvalues: Shop (copy), u37 (ref), u33 (ref), refresh (copy)
            if Shop.Enabled and (u37 and not u33) then
                u33 = true;
                u37 = refresh();
            end;
        end);
    end);

    local function watchLuckyMenu(u38: string) -- Line: 180
        -- upvalues: PlayerGui (copy), applyGroup (ref)
        task.spawn(function() -- Line: 181
            -- upvalues: PlayerGui (ref), u38 (copy), applyGroup (ref)
            local u39 = {};

            local function update() -- Line: 186
                -- upvalues: u39 (copy), applyGroup (ref)
                for _, v in u39 do
                    local Button = v.card:FindFirstChild("Button");

                    if Button then
                        Button = Button:FindFirstChild("Text");
                    end;

                    local v40;

                    if Button and Button:IsA("TextLabel") then
                        local Text = Button.Text;

                        if string.find(Text, "", 1, true) then
                            local string_gsub_ret = string.gsub(Text, "%D", "");
                            v40 = tonumber(string_gsub_ret);
                        else
                            v40 = nil;
                        end;
                    else
                        v40 = nil;
                    end;

                    v.price = v40;
                end;

                applyGroup(u39, false);
            end;

            for _, child in PlayerGui:WaitForChild(u38):WaitForChild("BuyLucky"):WaitForChild("Frame"):GetChildren() do
                local v41 = tonumber(child.Name);

                if child:IsA("GuiObject") and v41 then
                    table.insert(u39, {
                        price = nil,
                        productId = nil,
                        card = child,
                        units = v41
                    });
                    local Button = child:WaitForChild("Button", 10);

                    if Button then
                        Button = Button:WaitForChild("Text", 10);
                    end;

                    if Button and Button:IsA("TextLabel") then
                        Button:GetPropertyChangedSignal("Text"):Connect(update);
                    end;
                end;
            end;

            update();
        end);
    end;

    local u42 = "Style";
    task.spawn(function() -- Line: 181
        -- upvalues: PlayerGui (copy), u42 (copy), applyGroup (ref)
        local u43 = {};

        local function v45() -- Line: 186
            -- upvalues: u43 (copy), applyGroup (ref)
            for _, v in u43 do
                local Button = v.card:FindFirstChild("Button");

                if Button then
                    Button = Button:FindFirstChild("Text");
                end;

                local v44;

                if Button and Button:IsA("TextLabel") then
                    local Text = Button.Text;

                    if string.find(Text, "", 1, true) then
                        local string_gsub_ret = string.gsub(Text, "%D", "");
                        v44 = tonumber(string_gsub_ret);
                    else
                        v44 = nil;
                    end;
                else
                    v44 = nil;
                end;

                v.price = v44;
            end;

            applyGroup(u43, false);
        end;

        for _, child in PlayerGui:WaitForChild(u42):WaitForChild("BuyLucky"):WaitForChild("Frame"):GetChildren() do
            local v46 = tonumber(child.Name);

            if child:IsA("GuiObject") and v46 then
                table.insert(u43, {
                    price = nil,
                    productId = nil,
                    card = child,
                    units = v46
                });
                local Button = child:WaitForChild("Button", 10);

                if Button then
                    Button = Button:WaitForChild("Text", 10);
                end;

                if Button and Button:IsA("TextLabel") then
                    Button:GetPropertyChangedSignal("Text"):Connect(v45);
                end;
            end;
        end;

        v45();
    end);
    local u47 = "Flow";
    task.spawn(function() -- Line: 181
        -- upvalues: PlayerGui (copy), u47 (copy), applyGroup (ref)
        local u48 = {};

        local function v50() -- Line: 186
            -- upvalues: u48 (copy), applyGroup (ref)
            for _, v in u48 do
                local Button = v.card:FindFirstChild("Button");

                if Button then
                    Button = Button:FindFirstChild("Text");
                end;

                local v49;

                if Button and Button:IsA("TextLabel") then
                    local Text = Button.Text;

                    if string.find(Text, "", 1, true) then
                        local string_gsub_ret = string.gsub(Text, "%D", "");
                        v49 = tonumber(string_gsub_ret);
                    else
                        v49 = nil;
                    end;
                else
                    v49 = nil;
                end;

                v.price = v49;
            end;

            applyGroup(u48, false);
        end;

        for _, child in PlayerGui:WaitForChild(u47):WaitForChild("BuyLucky"):WaitForChild("Frame"):GetChildren() do
            local v51 = tonumber(child.Name);

            if child:IsA("GuiObject") and v51 then
                table.insert(u48, {
                    price = nil,
                    productId = nil,
                    card = child,
                    units = v51
                });
                local Button = child:WaitForChild("Button", 10);

                if Button then
                    Button = Button:WaitForChild("Text", 10);
                end;

                if Button and Button:IsA("TextLabel") then
                    Button:GetPropertyChangedSignal("Text"):Connect(v50);
                end;
            end;
        end;

        v50();
    end);
end;

return v27;