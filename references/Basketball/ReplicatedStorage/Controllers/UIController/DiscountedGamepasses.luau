 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Promise = require(ReplicatedStorage.Packages.Promise);
local UnixTimestamp = DateTime.fromUniversalTime(2025, 9, 1, 16, 30, 0).UnixTimestamp;
local u1 = { 1070764799, 1070998282, 1070581223 };
local v2 = Knit.CreateController({
    Name = "DiscountedGamepasses"
});

function v2.KnitInit(p3) -- Line: 24
end;

function v2.KnitStart(p4) -- Line: 28
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), GetUnixTime (copy), UnixTimestamp (copy), MarketplaceService (copy), RunService (copy), NumberUtil (copy), TweenService (copy), u1 (copy), Promise (copy), ReplicatedStorage (copy)
    Knit.GetService("MarketService");
    local Controller = Knit.GetController("Network");
    Knit.GetController("UIController");
    local u5 = Trove.new();
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local u6 = {};

    local function IsElegible(p7: number) -- Line: 38
        -- upvalues: GetUnixTime (ref), UnixTimestamp (ref), Controller (copy)
        local v8;

        if GetUnixTime() < UnixTimestamp then
            v8 = Controller.Player.OwnedGamepasses[tostring(p7)] == nil;
        else
            v8 = false;
        end;

        return v8;
    end;

    local function CreateButtonFromProductId(p9: number) -- Line: 42
        -- upvalues: GetUnixTime (ref), UnixTimestamp (ref), Controller (copy), MarketplaceService (ref), HUD (copy), LocalPlayer (ref), u6 (copy)
        local v10;

        if GetUnixTime() < UnixTimestamp then
            v10 = Controller.Player.OwnedGamepasses[tostring(p9)] == nil;
        else
            v10 = false;
        end;

        if not v10 then
            return;
        end;

        local ProductInfo = MarketplaceService:GetProductInfo(p9, Enum.InfoType.GamePass);
        local v11 = script.Template:Clone();
        v11.Name = tostring(p9);
        v11.Button.Image = `rbxassetid://{ProductInfo.IconImageAssetId}`;
        v11.Parent = HUD.Right;
        v11.Button.MouseButton1Down:Connect(function() -- Line: 54
            -- upvalues: LocalPlayer (ref)
            if LocalPlayer.Team ~= game:GetService("Teams").Visitor then
                return;
            end;

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = script.TP.CFrame;
            end;
        end);
        local v12 = v11:Clone();
        v12.Name = tostring(p9);
        v12.Parent = LocalPlayer.PlayerGui:WaitForChild("BuySpins").Content.Bundles;
        v12.Button.MouseButton1Down:Connect(function() -- Line: 70
            -- upvalues: LocalPlayer (ref)
            if LocalPlayer.Team ~= game:GetService("Teams").Visitor then
                return;
            end;

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = script.TP.CFrame;
            end;
        end);
        table.insert(u6, v11);
        table.insert(u6, v12);
    end;

    local u13 = nil;

    local function OnDataChanged() -- Line: 88
        -- upvalues: u5 (copy), u6 (copy), GetUnixTime (ref), UnixTimestamp (ref), Controller (copy), RunService (ref), u13 (ref), NumberUtil (ref), TweenService (ref)
        u5:Clean();

        if #u6 == 0 then
            return;
        end;

        for _, v in u6 do
            local v14 = tonumber(v.Name);
            local v15;

            if GetUnixTime() < UnixTimestamp then
                v15 = Controller.Player.OwnedGamepasses[tostring(v14)] == nil;
            else
                v15 = false;
            end;

            if not v15 then
                table.remove(u6, table.find(u6, v));
                v:Destroy();
            end;
        end;

        u5:Add(RunService.Heartbeat:Connect(function() -- Line: 105
            -- upvalues: GetUnixTime (ref), u13 (ref), UnixTimestamp (ref), u6 (ref), Controller (ref), NumberUtil (ref), TweenService (ref)
            local v16 = GetUnixTime();

            if u13 == v16 then
                return;
            end;

            u13 = v16;
            local v17 = UnixTimestamp - v16;

            for _, v in u6 do
                local v18 = tonumber(v.Name);
                local v19;

                if GetUnixTime() < UnixTimestamp then
                    v19 = Controller.Player.OwnedGamepasses[tostring(v18)] == nil;
                else
                    v19 = false;
                end;

                if v19 then
                    v.Timer.Text = NumberUtil.AdaptiveClockString(v17);
                    v.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
                    v.Timer.Size = UDim2.fromScale(1, 0.45);
                    TweenService:Create(v.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Size = UDim2.fromScale(1, 0.293)
                    }):Play();
                else
                    table.remove(u6, table.find(u6, v));
                    v:Destroy();
                end;
            end;
        end));
    end;

    local v20 = {};

    for _, v in u1 do
        table.insert(v20, Promise.new(function(p21) -- Line: 142
            -- upvalues: CreateButtonFromProductId (copy), v (copy)
            CreateButtonFromProductId(v);
            p21();
        end));
    end;

    Promise.allSettled(v20):await();
    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 151
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
end;

return v2;