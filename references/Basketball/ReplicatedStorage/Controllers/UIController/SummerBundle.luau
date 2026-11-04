 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local v1 = Knit.CreateController({
    Name = "SummerBundle"
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
    local SummerBundle = LocalPlayer.PlayerGui:WaitForChild("SummerBundle");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local BuySpins = LocalPlayer.PlayerGui:WaitForChild("BuySpins");
    LocalPlayer.PlayerGui:WaitForChild("Quests");

    local function IsElegible() -- Line: 32
        -- upvalues: Controller (copy), GetUnixTime (ref)
        local v5 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3310332519 then
                v5 = v5 + 1;
            end;
        end;

        if v5 >= 2 then
            return false;
        end;

        return GetUnixTime() < workspace:GetAttribute("SummerBundleTime");
    end;

    local u6 = nil;

    local function OnDataChanged() -- Line: 50
        -- upvalues: u4 (copy), Controller (copy), GetUnixTime (ref), SummerBundle (copy), Controller2 (copy), HUD (copy), BuySpins (copy), RunService (ref), u6 (ref), OnDataChanged (copy), NumberUtil (ref), TweenService (ref)
        u4:Clean();
        local v7 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3310332519 then
                v7 = v7 + 1;
            end;
        end;

        local v8;

        if v7 >= 2 then
            v8 = false;
        else
            v8 = GetUnixTime() < workspace:GetAttribute("SummerBundleTime");
        end;

        if not v8 then
            if SummerBundle.Enabled == true then
                Controller2:Focus(false, SummerBundle);
            end;

            SummerBundle.Enabled = false;
            HUD.Right.SummerBundle.Visible = false;
            BuySpins.Content.Bundles.SummerBundle.Visible = false;

            return;
        end;

        u4:Add(RunService.Heartbeat:Connect(function() -- Line: 65
            -- upvalues: GetUnixTime (ref), u6 (ref), Controller (ref), OnDataChanged (ref), HUD (ref), NumberUtil (ref), TweenService (ref), BuySpins (ref)
            local v9 = GetUnixTime();

            if u6 == v9 then
                return;
            end;

            u6 = v9;
            local v10 = workspace:GetAttribute("SummerBundleTime") - v9;
            local v11 = 0;

            for _, v in Controller.Player.PurchaseHistory do
                if v == 3310332519 then
                    v11 = v11 + 1;
                end;
            end;

            local v12;

            if v11 >= 2 then
                v12 = false;
            else
                v12 = GetUnixTime() < workspace:GetAttribute("SummerBundleTime");
            end;

            if not v12 then
                task.spawn(OnDataChanged);

                return;
            end;

            HUD.Right.SummerBundle.Timer.Text = NumberUtil.AdaptiveClockString(v10);
            HUD.Right.SummerBundle.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
            HUD.Right.SummerBundle.Timer.Size = UDim2.fromScale(1, 0.45);
            TweenService:Create(HUD.Right.SummerBundle.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromScale(1, 0.293)
            }):Play();
            BuySpins.Content.Bundles.SummerBundle.Timer.Text = NumberUtil.AdaptiveClockString(v10);
            BuySpins.Content.Bundles.SummerBundle.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
            BuySpins.Content.Bundles.SummerBundle.Timer.Size = UDim2.fromScale(1, 0.45);
            TweenService:Create(BuySpins.Content.Bundles.SummerBundle.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromScale(1, 0.293)
            }):Play();
        end));
        local v13 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3310332519 then
                v13 = v13 + 1;
            end;
        end;

        SummerBundle.BG.AmountPurchased.Text = `{v13}/2 PURCHASED`;
        HUD.Right.SummerBundle.Visible = true;
        BuySpins.Content.Bundles.SummerBundle.Visible = true;
    end;

    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 116
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
    HUD.Right.SummerBundle.Button.MouseButton1Down:Connect(function() -- Line: 120
        -- upvalues: SummerBundle (copy), Controller2 (copy)
        SummerBundle.Enabled = not SummerBundle.Enabled;
        Controller2:Focus(SummerBundle.Enabled, SummerBundle);
    end);
    BuySpins.Content.Bundles.SummerBundle.Button.MouseButton1Down:Connect(function() -- Line: 126
        -- upvalues: SummerBundle (copy), Controller2 (copy)
        SummerBundle.Enabled = not SummerBundle.Enabled;
        Controller2:Focus(SummerBundle.Enabled, SummerBundle);
    end);
    local v14 = Controller3.RepeatGetProductInfo(3310332519, Enum.InfoType.Product);
    SummerBundle.BG.RobuxButton.Text.Text = v14.PriceInRobux;
    SummerBundle.BG.RobuxButton.MouseButton1Down:Connect(function() -- Line: 135
        -- upvalues: Service (copy)
        Service:PromptSummerBundle();
    end);
end;

return v1;