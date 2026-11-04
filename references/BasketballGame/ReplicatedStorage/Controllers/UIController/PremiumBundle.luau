 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local v1 = Knit.CreateController({
    Name = "PremiumBundle"
});

function v1.KnitInit(p2) -- Line: 15
end;

function v1.KnitStart(p3) -- Line: 19
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), GetUnixTime (copy), RunService (copy), NumberUtil (copy), TweenService (copy), ReplicatedStorage (copy)
    local Service = Knit.GetService("MarketService");
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local Controller3 = Knit.GetController("PromptController");
    local u4 = Trove.new();
    local PremiumBundle = LocalPlayer.PlayerGui:WaitForChild("PremiumBundle");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local BuySpins = LocalPlayer.PlayerGui:WaitForChild("BuySpins");

    local function IsElegible() -- Line: 31
        -- upvalues: Controller (copy), GetUnixTime (ref)
        local v5 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3310332425 then
                v5 = v5 + 1;
            end;
        end;

        if v5 >= 2 then
            return false;
        end;

        return GetUnixTime() < workspace:GetAttribute("PremiumBundleTime");
    end;

    local u6 = nil;

    local function OnDataChanged() -- Line: 49
        -- upvalues: u4 (copy), Controller (copy), GetUnixTime (ref), PremiumBundle (copy), Controller2 (copy), HUD (copy), BuySpins (copy), RunService (ref), u6 (ref), OnDataChanged (copy), NumberUtil (ref), TweenService (ref)
        u4:Clean();
        local v7 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3310332425 then
                v7 = v7 + 1;
            end;
        end;

        local v8;

        if v7 >= 2 then
            v8 = false;
        else
            v8 = GetUnixTime() < workspace:GetAttribute("PremiumBundleTime");
        end;

        if not v8 then
            if PremiumBundle.Enabled == true then
                Controller2:Focus(false, PremiumBundle);
            end;

            PremiumBundle.Enabled = false;
            HUD.Right.PremiumBundle.Visible = false;
            BuySpins.Content.Bundles.PremiumBundle.Visible = false;

            return;
        end;

        u4:Add(RunService.Heartbeat:Connect(function() -- Line: 64
            -- upvalues: GetUnixTime (ref), u6 (ref), Controller (ref), OnDataChanged (ref), HUD (ref), NumberUtil (ref), TweenService (ref), BuySpins (ref)
            local v9 = GetUnixTime();

            if u6 == v9 then
                return;
            end;

            u6 = v9;
            local v10 = workspace:GetAttribute("PremiumBundleTime") - v9;
            local v11 = 0;

            for _, v in Controller.Player.PurchaseHistory do
                if v == 3310332425 then
                    v11 = v11 + 1;
                end;
            end;

            local v12;

            if v11 >= 2 then
                v12 = false;
            else
                v12 = GetUnixTime() < workspace:GetAttribute("PremiumBundleTime");
            end;

            if not v12 then
                task.spawn(OnDataChanged);

                return;
            end;

            HUD.Right.PremiumBundle.Timer.Text = NumberUtil.AdaptiveClockString(v10);
            HUD.Right.PremiumBundle.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
            HUD.Right.PremiumBundle.Timer.Size = UDim2.fromScale(1, 0.45);
            TweenService:Create(HUD.Right.PremiumBundle.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromScale(1, 0.293)
            }):Play();
            BuySpins.Content.Bundles.PremiumBundle.Timer.Text = NumberUtil.AdaptiveClockString(v10);
            BuySpins.Content.Bundles.PremiumBundle.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
            BuySpins.Content.Bundles.PremiumBundle.Timer.Size = UDim2.fromScale(1, 0.45);
            TweenService:Create(BuySpins.Content.Bundles.PremiumBundle.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromScale(1, 0.293)
            }):Play();
        end));
        local v13 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3310332425 then
                v13 = v13 + 1;
            end;
        end;

        PremiumBundle.BG.AmountPurchased.Text = `{v13}/2 PURCHASED`;
        HUD.Right.PremiumBundle.Visible = true;
        BuySpins.Content.Bundles.PremiumBundle.Visible = true;
    end;

    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 115
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
    HUD.Right.PremiumBundle.Button.MouseButton1Down:Connect(function() -- Line: 119
        -- upvalues: PremiumBundle (copy), Controller2 (copy)
        PremiumBundle.Enabled = not PremiumBundle.Enabled;
        Controller2:Focus(PremiumBundle.Enabled, PremiumBundle);
    end);
    BuySpins.Content.Bundles.PremiumBundle.Button.MouseButton1Down:Connect(function() -- Line: 125
        -- upvalues: PremiumBundle (copy), Controller2 (copy)
        PremiumBundle.Enabled = not PremiumBundle.Enabled;
        Controller2:Focus(PremiumBundle.Enabled, PremiumBundle);
    end);
    local v14 = Controller3.RepeatGetProductInfo(3310332425, Enum.InfoType.Product);
    PremiumBundle.BG.RobuxButton.Text.Text = v14.PriceInRobux;
    PremiumBundle.BG.RobuxButton.MouseButton1Down:Connect(function() -- Line: 134
        -- upvalues: Service (copy)
        Service:PromptPremiumBundle();
    end);
end;

return v1;