 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local PickASide = LocalPlayer.PlayerGui:WaitForChild("PickASide");
local v1 = Knit.CreateController({
    Name = "PickASide"
});

function v1.KnitInit(p2) -- Line: 17
end;

function v1.KnitStart(p3) -- Line: 21
    -- upvalues: Knit (copy), PickASide (copy), ReplicatedStorage (copy), LocalPlayer (copy), RunService (copy), GetUnixTime (copy), NumberUtil (copy), TweenService (copy)
    local Controller = Knit.GetController("Network");
    local Service = Knit.GetService("PickASideService");
    local Controller2 = Knit.GetController("UIController");
    local u4 = Service.SideAName:Get();
    local u5 = Service.SideBName:Get();

    local function OnDataChanged() -- Line: 29
        -- upvalues: Controller (copy), u4 (ref), u5 (ref), PickASide (ref)
        local v6 = Controller.Player[`{u4}Vs{u5}Choice`];
        PickASide.BG.SideA.Warning.Visible = v6 == nil;
        PickASide.BG.SideA.YourSide.Visible = v6 == u4;
        PickASide.BG.SideB.Warning.Visible = v6 == nil;
        PickASide.BG.SideB.YourSide.Visible = v6 == u5;
        PickASide.BG.Warning.Visible = v6 == nil;
    end;

    task.spawn(OnDataChanged);
    Service.SideAName:Observe(function(p7) -- Line: 43
        -- upvalues: u4 (ref), OnDataChanged (copy)
        u4 = p7;
        OnDataChanged();
    end);
    Service.SideBName:Observe(function(p8) -- Line: 48
        -- upvalues: u5 (ref), OnDataChanged (copy)
        u5 = p8;
        OnDataChanged();
    end);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(OnDataChanged);
    local Timer = PickASide.BG.Timer;
    local PickASide2 = LocalPlayer.PlayerGui:WaitForChild("HUD").Right:WaitForChild("PickASide");
    local u9 = PickASide2:Clone();
    u9.Parent = LocalPlayer.PlayerGui:WaitForChild("BuySpins").Content.Bundles;
    local u10 = nil;
    RunService.Heartbeat:Connect(function() -- Line: 65
        -- upvalues: Service (copy), GetUnixTime (ref), u10 (ref), NumberUtil (ref), Timer (copy), PickASide (ref), Controller2 (copy), PickASide2 (copy), u9 (copy), TweenService (ref)
        local v11 = (Service.Expiry:Get() or 0) - GetUnixTime();

        if u10 == v11 then
            return;
        end;

        u10 = v11;
        Timer.Text = `EVENT ENDS {v11 <= 0 and "SOON" or `IN {NumberUtil.AdaptiveClockString(v11)}`}`;

        if v11 <= 0 then
            if PickASide.Enabled == true then
                Controller2:Focus(false, PickASide);
            end;

            PickASide.Enabled = false;
            PickASide2.Visible = false;
            u9.Visible = false;

            return;
        end;

        if v11 <= 604800 then
            PickASide.BG.Warning.Text = "ENTRIES HAVE CLOSED";
        end;

        PickASide2.Visible = true;
        u9.Visible = true;
        PickASide2.Timer.Text = NumberUtil.AdaptiveClockString(v11);
        PickASide2.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
        PickASide2.Timer.Size = UDim2.fromScale(1, 0.45);
        TweenService:Create(PickASide2.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.fromScale(1, 0.293)
        }):Play();
        u9.Timer.Text = NumberUtil.AdaptiveClockString(v11);
        u9.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
        u9.Timer.Size = UDim2.fromScale(1, 0.45);
        TweenService:Create(u9.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.fromScale(1, 0.293)
        }):Play();
    end);
    PickASide.BG.SideA.MouseButton1Click:Connect(function() -- Line: 119
        -- upvalues: Service (copy), u4 (ref)
        Service:PickSide(u4);
    end);
    PickASide.BG.SideB.MouseButton1Click:Connect(function() -- Line: 122
        -- upvalues: Service (copy), u5 (ref)
        Service:PickSide(u5);
    end);
    PickASide2.Button.MouseButton1Down:Connect(function() -- Line: 126
        -- upvalues: PickASide (ref), Controller2 (copy)
        PickASide.Enabled = not PickASide.Enabled;
        Controller2:Focus(PickASide.Enabled, PickASide);
    end);
    u9.Button.MouseButton1Down:Connect(function() -- Line: 131
        -- upvalues: PickASide (ref), Controller2 (copy)
        PickASide.Enabled = not PickASide.Enabled;
        Controller2:Focus(PickASide.Enabled, PickASide);
    end);
    Service.SideA:Observe(function(p12) -- Line: 137
        -- upvalues: PickASide (ref), NumberUtil (ref)
        if p12 == "???" then
            return;
        end;

        PickASide.BG.SideA.Score.InnerText.Text = `{NumberUtil.WithCommas(p12 or 0)} POINTS`;
    end);
    Service.SideB:Observe(function(p13) -- Line: 142
        -- upvalues: PickASide (ref), NumberUtil (ref)
        if p13 == "???" then
            return;
        end;

        PickASide.BG.SideB.Score.InnerText.Text = `{NumberUtil.WithCommas(p13 or 0)} POINTS`;
    end);
end;

return v1;