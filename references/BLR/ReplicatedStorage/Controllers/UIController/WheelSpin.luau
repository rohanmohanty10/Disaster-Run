  

game:GetService("Players");
game:GetService("RunService");
game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local SpinWheelData = require(ReplicatedStorage.Shared.Configs.SpinWheelData);
local PlayerData = require(ReplicatedStorage.ClientModules.ClientGlobals).PlayerData;
local LocalPlayer = game.Players.LocalPlayer;
local Random_new_ret = Random.new();
local u1 = KnitClient.CreateController({
    Name = "WheelSpin"
});
local u2 = false;

local function GetRotationForSliceCenter(p3) -- Line: 27
    return ({ 0, -60, -120, -180, -240, -300 })[p3];
end;

local function GetSliceNumFromRotation(p4) -- Line: 41
    return math.floor((p4 - 30) % 360 / 60) + 1;
end;

local function RotateTo(p5, p6, p7) -- Line: 49
    p6.Rotation = p7 % 360;
end;

local function Lerp(p8, p9, p10) -- Line: 56
    return p8 + (p9 - p8) * p10;
end;

function u1.Spin(p11, p12, p13) -- Line: 60
    -- upvalues: u2 (ref), Random_new_ret (copy), TweenService (copy)
    local Slices = p11.Instance.Main.Slices;
    u2 = true;
    local v14 = Random_new_ret:NextInteger(7, 10) * 360;
    local Rotation = Slices.Rotation;
    local v15 = Random_new_ret:NextNumber(3, 12);
    local v16 = Random_new_ret:NextInteger(1, 2) == 1 and -1 or 1;
    local v17 = ({ 0, -60, -120, -180, -240, -300 })[p12] + v15 * v16 + v14;

    local function ease(p18) -- Line: 70
        -- upvalues: TweenService (ref)
        return TweenService:GetValue(p18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;

    local v19 = math.floor((Rotation - 30) % 360 / 60) + 1;
    local v20 = 0;

    while true do
        v20 = v20 + task.wait();
        local v21 = v20 / p13;
        local Value = TweenService:GetValue(v21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if v21 >= 1 then
            break;
        end;

        local v22 = Rotation + (v17 - Rotation) * Value;
        local v23 = math.floor((v22 - 30) % 360 / 60) + 1;

        if v23 == v19 then
            v23 = v19;
        else
            p11.TickerTween:Cancel();
            p11.TickerTween:Play();
        end;

        Slices.Rotation = v22 % 360;
        v19 = v23;
    end;

    Slices.Rotation = v17 % 360;
    task.wait(0.3);
    u2 = false;
end;

function u1.KnitStart(u24) -- Line: 105
    -- upvalues: KnitClient (copy), LocalPlayer (copy), RngUtil (copy), SpinWheelData (copy), TweenService (copy), MarketplaceService (copy), u2 (ref), u1 (copy), PlayerData (copy), FormatNumber (copy)
    local Service = KnitClient.GetService("SpinwheelService");
    local Controller = KnitClient.GetController("DiscountController");
    u24.Instance = LocalPlayer.PlayerGui:WaitForChild("SpinWheel").Frame;
    local Slices = u24.Instance.Main.Slices;
    u24.tiles = {};

    for _, child in Slices:GetChildren() do
        u24.tiles[tonumber(child.Name)] = child.Main.ItemName;
    end;

    local v27 = RngUtil.ConvertToWeightMap(SpinWheelData.Rewards, function(p25, p26) -- Line: 119
        return p25, p26[2];
    end);
    RngUtil.ToChances(v27);
    u24.TickerTween = TweenService:Create(u24.Instance.Main.Ticker, TweenInfo.new(0.06, Enum.EasingStyle.Quart), {
        Rotation = -12
    });
    u24.ResetTween = TweenService:Create(u24.Instance.Main.Ticker, TweenInfo.new(0.04), {
        Rotation = 11
    });

    for _, child in u24.Instance.BuyMore:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 131
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), child (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, child:GetAttribute("ID"));
            end);
        end;
    end;

    u24.TickerTween.Completed:Connect(function(p28) -- Line: 137
        -- upvalues: u24 (copy)
        if p28 == Enum.PlaybackState.Completed then
            u24.ResetTween:Play();
        end;
    end);
    u24.Instance.Spin.Activated:Connect(function() -- Line: 143
        -- upvalues: u2 (ref), Service (copy)
        if u2 then
            return;
        end;

        Service:Spin();
    end);
    Service.SpinResults:Connect(function(p29) -- Line: 153
        -- upvalues: u1 (ref)
        u1:Spin(p29.prize, 6);
    end);
    Controller:ObserveDiscount("SpinWheel", function(p30) -- Line: 157
        -- upvalues: u24 (copy)
        for _, child in u24.Instance.BuyMore:GetChildren() do
            if child:IsA("GuiObject") then
                if child.Name:match("FDD") then
                    child.Visible = p30 == true;
                else
                    child.Visible = not p30;
                end;
            end;
        end;

        u24.Instance.BuyMore.SaleLabel.Visible = p30;
    end);
    task.spawn(function() -- Line: 171
        -- upvalues: PlayerData (ref), u24 (copy), FormatNumber (ref)
        PlayerData:WaitForLoaded();

        while true do
            local WheelSpins = PlayerData.Data.WheelSpins;
            local v31 = WheelSpins.lastClaimed + 86400 - workspace:GetServerTimeNow();

            if WheelSpins.Amount == 0 and v31 > 0 then
                u24.Instance.Spin.SpinText.Text = FormatNumber.AdaptiveClockString(v31);
            else
                u24.Instance.Spin.SpinText.Text = "Spin (" .. WheelSpins.Amount .. ")";
            end;

            u24.LastFreeSpin = WheelSpins.lastClaimed;
            task.wait();
        end;
    end);
    task.spawn(function() -- Line: 188
        -- upvalues: u2 (ref), Slices (copy), u24 (copy)
        while true do
            local v32;

            repeat
                v32 = task.wait();
            until not u2;

            Slices.Rotation = (Slices.Rotation + v32 * 20) % 360;

            for _, _ in u24.tiles do

            end;
        end;
    end);
    Slices:GetPropertyChangedSignal("Rotation"):Connect(function() -- Line: 201
        -- upvalues: u24 (copy), Slices (copy)
        u24.Instance.Main.InnerCircle.Rotation = Slices.Rotation + 10;
    end);

    return u24;
end;

return u1;