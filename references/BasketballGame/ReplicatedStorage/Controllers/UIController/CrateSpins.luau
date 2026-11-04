 
 

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local SeasonPass = require(ReplicatedStorage.Shared.Tables.SeasonPass);
local CratesItems = require(ReplicatedStorage.Shared.Tables.CratesItems);
local v1 = Knit.CreateController({
    Name = "CrateSpins"
});

function v1.KnitInit(p2) -- Line: 26
end;

function v1.DataUpdate(p3) -- Line: 30
    -- upvalues: NumberUtil (copy)
    p3.UI.BG.CurrencyCounter.Amount.Text = NumberUtil.WithCommas(p3.SeasonPassData.Currency);
end;

function v1.SpinsUpdate(p4) -- Line: 34
    -- upvalues: SeasonPass (copy)
    p4.UI.BG.MainFrame.Crate.Buttons.Spin.Amount.Text = p4.CrateSpins >= 1 and "Spin" or 100;

    if p4.CrateSpins >= 1 then
        p4.UI.BG.MainFrame.Crate.Buttons.Spin.TextLabel.Text = `Click to Spin! ({p4.CrateSpins} Spins Left)`;

        return;
    end;

    p4.UI.BG.MainFrame.Crate.Buttons.Spin.TextLabel.Text = `Click to Spin using {SeasonPass.Items.Currency.DisplayName}!`;
end;

function v1.Spin(u5, u6, u7, u8) -- Line: 43
    -- upvalues: TweenService (copy), CratesItems (copy), SeasonPass (copy), Effects (copy)
    u5.Opening = true;
    u5.HighlightPosition.Value = u5.HighlightPosition.Value % 5;

    if u5.HighlightPosition.Value == 0 then
        u5.HighlightPosition.Value = 5;
    end;

    u5.Tween = TweenService:Create(u5.HighlightPosition, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 80 + (u7 and 1 or u6)
    });
    u5.Tween:Play();
    u5.UI.BG.MainFrame.Crate.Buttons.Spin.Amount.Text = "Skip";

    if u7 then
        repeat
            task.wait();
        until not (u5.Tween and (not u5.Tween.Completed and u5.Opening));

        u5.SpinDebounce = tick() + 1;
        u5.Opening = "OP";
        u5.UI.BG.MainFrame.Crate.Buttons.Spin.Amount.Text = "Skip";
        u5.Tween = TweenService:Create(u5.HighlightPosition, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 80 + u6
        });
        u5.Tween:Play();
    end;

    u5.Tween.Completed:Connect(function() -- Line: 68
        -- upvalues: u5 (copy), CratesItems (ref), u7 (copy), u6 (copy), u8 (copy), SeasonPass (ref), Effects (ref)
        u5.UI.BG.MainFrame.Crate.Buttons.Spin.Amount.Text = u5.CrateSpins >= 1 and "Spin" or 100;
        local v9 = CratesItems[u7 and "OP" or "Basic"][u6];
        local v10;

        if u8 and v9[3].LuckySpins then
            v10 = `Duplicate! Received {v9[3].LuckySpins} Lucky Style Spins!`;
        elseif u8 and v9[3].SeasonPassCurrency then
            v10 = `Duplicate! Received {v9[3].SeasonPassCurrency} {SeasonPass.Items.Currency.DisplayName}!`;
        elseif typeof(v9[3]) == "number" and v9[3] > 0 then
            v10 = `You got {v9[3]} {v9[2]}!`;
        else
            v10 = `You got {v9[2]}!`;
        end;

        Effects:Popup(v10, 2, u7 and Color3.new(0.870588, 0.137255, 1) or Color3.new(1, 0.74902, 0));
        u5.Debounce = tick() + 1;
        u5.SpinDebounce = tick() + 0.25;
        u5.Opening = false;
    end);
end;

function v1.KnitStart(u11) -- Line: 94
    -- upvalues: Knit (copy), LocalPlayer (copy), SfxManager (copy), Customization (copy), Styles (copy), Zones (copy), ReplicatedStorage (copy), CratesItems (copy), MarketplaceService (copy), Effects (copy)
    local Controller = Knit.GetController("Shop");
    local Controller2 = Knit.GetController("Network");
    local Controller3 = Knit.GetController("EmotesController");
    local Controller4 = Knit.GetController("PromptController");
    local Controller5 = Knit.GetController("GiftingController");
    local Service = Knit.GetService("CratesService");
    u11.UI = LocalPlayer.PlayerGui:WaitForChild("CrateSpins");
    u11.HighlightPosition = Instance.new("NumberValue");
    u11.HighlightPosition.Value = 1;
    local u12 = 0;
    u11.HighlightPosition.Changed:Connect(function() -- Line: 109
        -- upvalues: u11 (copy), u12 (ref), SfxManager (ref)
        local math_ceil_ret = math.ceil(u11.HighlightPosition.Value);
        local v13;

        if math_ceil_ret > 5 then
            local v14 = math_ceil_ret % 5;
            v13 = v14 == 0 and 5 or v14;
        else
            v13 = math_ceil_ret <= 0 and 1 or math_ceil_ret;
        end;

        if v13 == u12 then
            return;
        end;

        u12 = v13;

        if u11.Opening then
            SfxManager:playSound({
                Sound = "Spin",
                Parent = workspace
            });
        end;

        if u11.Opening == "OP" then
            for _, child in u11.UI.BG.MainFrame.Crate.OP:GetChildren() do
                if child:IsA("ImageLabel") then
                    if tonumber(child.Name) == u12 then
                        child.Starburst.UIGradient.Enabled = false;
                    else
                        child.Starburst.UIGradient.Enabled = true;
                    end;
                end;
            end;

            for _, child in u11.UI.BG.MainFrame.Crate.Basic:GetChildren() do
                if child:IsA("ImageLabel") then
                    child.Starburst.UIGradient.Enabled = true;
                end;
            end;

            return;
        end;

        for _, child in u11.UI.BG.MainFrame.Crate.Basic:GetChildren() do
            if child:IsA("ImageLabel") then
                if tonumber(child.Name) == u12 then
                    child.Starburst.UIGradient.Enabled = false;
                else
                    child.Starburst.UIGradient.Enabled = true;
                end;
            end;
        end;

        for _, child in u11.UI.BG.MainFrame.Crate.OP:GetChildren() do
            if child:IsA("ImageLabel") then
                child.Starburst.UIGradient.Enabled = true;
            end;
        end;
    end);

    local function setupItem(p15, p16, p17) -- Line: 161
        -- upvalues: Controller3 (copy), Controller (copy), Customization (ref), Styles (ref), Zones (ref), ReplicatedStorage (ref), CratesItems (ref)
        local v18 = p16[1];
        local v19 = p16[2]:upper();
        local u20 = p16[3];
        local v21 = p16[4];
        local u22 = p17:FindFirstChild(p15);

        if not u22 then
            return;
        end;

        if typeof(u20) == "number" and u20 > 0 then
            u22.NameX.Text = `{u20} {v19}`;
        else
            u22.NameX.Text = v19;
        end;

        if typeof(u20) == "table" then
            if u20.Type == "Emotes" then
                task.spawn(function() -- Line: 178
                    -- upvalues: u22 (copy), Controller3 (ref), u20 (copy)
                    u22.Icon.ImageTransparency = 1;
                    u22.Icon.Size = UDim2.new(0.944, 0, 0.7, 0);
                    local ViewportFrame = Instance.new("ViewportFrame", u22.Icon);
                    ViewportFrame.Size = UDim2.fromScale(1, 1);
                    ViewportFrame.Ambient = Color3.fromRGB(255, 255, 255);
                    ViewportFrame.BackgroundTransparency = 1;
                    ViewportFrame.ZIndex = u22.Icon.ZIndex;

                    while not Controller3.CharacterRig do
                        task.wait();
                    end;

                    Controller3:CreatePreview(u20.Name, ViewportFrame, Controller3.CharacterRig);
                end);
            elseif v18 == "LimitedItem" then
                if u20.Type == "GoalEffects" then
                    u22.Icon.Image = Controller.GoalIcons[u20.Name] or "";
                elseif u20.Type == "ShotEffects" then
                    u22.Icon.Image = Controller.ShotIcons[u20.Name] or "";
                elseif u20.Type == "Cards" then
                    u22.Icon.Image = Controller.Cards[u20.Name] or "";
                else
                    local v23 = Customization[u20.Type][u20.Name];

                    if v23.IconId then
                        u22.Icon.Image = `rbxassetid://{v23.IconId}`;
                    end;
                end;
            elseif v18 == "Styles" or v18 == "Zones" then
                local v24 = v18 == "Styles" and Styles.Styles[u20.Name];

                if not v24 then
                    if v18 == "Zones" then
                        v24 = Zones.Zones[u20.Name];
                    else
                        v24 = false;
                    end;
                end;

                local v25 = script.StyleOrZoneName:Clone();
                v25.Parent = u22;
                v25.Text = v24.UIName or u20.Name;
                v25.ZIndex = u22.Icon.ZIndex;
                u22.Icon:Destroy();
                ReplicatedStorage.Controllers.UIController.Style.Gradients[v24.Rarity]:Clone().Parent = v25;
            end;
        else
            local v26 = CratesItems.Icons[v18];

            if v26 then
                u22.Icon.Image = v26;

                if v18:match("^Lucky") then
                    script.Rainbow:Clone().Parent = u22.Icon;
                end;
            else
                u22.Icon.Visible = false;
            end;
        end;

        u22.Chance.Text = `{v21}%`;
    end;

    for i, v in CratesItems.Basic do
        setupItem(i, v, u11.UI.BG.MainFrame.Crate.Basic);
    end;

    for i, v in CratesItems.OP do
        setupItem(i, v, u11.UI.BG.MainFrame.Crate.OP);
    end;

    u11.UI.BG.MainFrame.Crate.Buttons.Spin.Activated:Connect(function() -- Line: 246
        -- upvalues: u11 (copy), Controller2 (copy), MarketplaceService (ref), LocalPlayer (ref), Service (copy)
        if not u11.SpinDebounce or u11.SpinDebounce - tick() <= 0 then
            if u11.Opening then
                if not Controller2.Player.CanSkipCrates then
                    MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1549557629);

                    return;
                end;

                if u11.Tween then
                    u11.Tween:Cancel();
                end;

                u11.Opening = false;

                return;
            end;

            u11.Opening = true;
            local v27, v28, v29 = Service:SpinCrate();

            if v27 then
                u11:Spin(v27, v28, v29);

                return;
            end;

            u11.Opening = false;
        end;
    end);
    u11.UI.BG.MainFrame.Crate.Buttons.Buy1CrateSpin.Activated:Connect(function() -- Line: 274
        -- upvalues: Controller2 (copy), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        if Controller2.Policy then
            Effects:Popup("This purchase is not available for your region.");

            return;
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, 3565187923);
    end);
    u11.UI.BG.MainFrame.Crate.Buttons.Buy10CrateSpins.Activated:Connect(function() -- Line: 279
        -- upvalues: Controller2 (copy), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        if Controller2.Policy then
            Effects:Popup("This purchase is not available for your region.");

            return;
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, 3565188370);
    end);
    u11.UI.BG.MainFrame.Crate.Buttons.Gift.Activated:Connect(function() -- Line: 284
        -- upvalues: Controller5 (copy)
        Controller5.PromptGiftPlayer(3565188151);
    end);
    task.spawn(function() -- Line: 288
        -- upvalues: Controller4 (copy), u11 (copy)
        local v30 = Controller4.RepeatGetProductInfo(3565187923, Enum.InfoType.Product);
        u11.UI.BG.MainFrame.Crate.Buttons.Buy1CrateSpin.Price.Text = v30.PriceInRobux .. " R$";
        local v31 = Controller4.RepeatGetProductInfo(3565188370, Enum.InfoType.Product);
        u11.UI.BG.MainFrame.Crate.Buttons.Buy10CrateSpins.Price.Text = v31.PriceInRobux .. " R$";
    end);
    u11.SeasonPassData = Controller2.Player.SeasonPass;
    u11.CrateSpins = Controller2.Player.CrateSpins;
    u11:DataUpdate();
    u11:SpinsUpdate();
    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 302
        -- upvalues: u11 (copy), Controller2 (copy)
        if u11.SeasonPassData ~= Controller2.SeasonPass then
            u11.SeasonPassData = Controller2.Player.SeasonPass;
            u11:DataUpdate();
        end;

        if u11.CrateSpins ~= Controller2.Player.CrateSpins then
            u11.CrateSpins = Controller2.Player.CrateSpins;
            u11:SpinsUpdate();
        end;
    end);
    u11.UI.BG.TabButtonsFrame.QuestsButton.Activated:Connect(function() -- Line: 313
        -- upvalues: u11 (copy), LocalPlayer (ref)
        u11.UI.Enabled = false;
        LocalPlayer.PlayerGui.Quests.Enabled = true;
    end);
    u11.UI.BG.TabButtonsFrame.SeasonPassButton.Activated:Connect(function() -- Line: 318
        -- upvalues: u11 (copy), LocalPlayer (ref)
        u11.UI.Enabled = false;
        LocalPlayer.PlayerGui.SeasonPass.Enabled = true;
    end);
    u11.UI.BG.TabButtonsFrame.CratesButton.Activated:Connect(function() -- Line: 323
        -- upvalues: u11 (copy), LocalPlayer (ref)
        u11.UI.Enabled = false;
        LocalPlayer.PlayerGui.Crates.Enabled = true;
    end);
    u11.UI.BG.CurrencyCounter.PlusButton.Activated:Connect(function() -- Line: 328
        -- upvalues: u11 (copy), LocalPlayer (ref)
        u11.UI.Enabled = false;
        LocalPlayer.PlayerGui.SeasonPassCurrency.Enabled = true;
    end);
    u11.UI.BG.CloseButton.Activated:Connect(function() -- Line: 333
        -- upvalues: u11 (copy), LocalPlayer (ref)
        u11.UI.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = true;
    end);

    while true do
        if not (u11.Debounce and u11.Debounce - tick() > 0 or (u11.Opening or not u11.UI.Enabled)) then
            local HighlightPosition = u11.HighlightPosition;
            HighlightPosition.Value = HighlightPosition.Value + 1;
        end;

        task.wait(0.5);
    end;
end;

return v1;