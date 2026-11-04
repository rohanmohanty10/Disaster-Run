 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local v1 = Knit.CreateController({
    Name = "StyleSlot"
});

function v1.KnitInit(p2) -- Line: 16
end;

function v1.KnitStart(p3) -- Line: 20
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), GetUnixTime (copy), Essentials (copy), RunService (copy), NumberUtil (copy), TweenService (copy), ReplicatedStorage (copy)
    local Service = Knit.GetService("MarketService");
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local u4 = Trove.new();
    local StyleSlot = LocalPlayer.PlayerGui:WaitForChild("StyleSlot");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");

    local function IsElegible() -- Line: 30
        -- upvalues: Controller (copy), GetUnixTime (ref)
        if Controller.Player.RedeemedFreeStyleSlot then
            return false;
        end;

        if Controller.Player.MaxStyleSlots >= 7 then
            return false;
        end;

        return GetUnixTime() < workspace:GetAttribute("StyleSlotTime");
    end;

    local u5 = nil;

    local function OnDataChanged() -- Line: 44
        -- upvalues: u4 (copy), Controller (copy), GetUnixTime (ref), StyleSlot (copy), Controller2 (copy), HUD (copy), Essentials (ref), RunService (ref), u5 (ref), OnDataChanged (copy), NumberUtil (ref), TweenService (ref)
        u4:Clean();
        local v6;

        if Controller.Player.RedeemedFreeStyleSlot or Controller.Player.MaxStyleSlots >= 7 then
            v6 = false;
        else
            v6 = GetUnixTime() < workspace:GetAttribute("StyleSlotTime");
        end;

        if not v6 then
            if StyleSlot.Enabled == true then
                Controller2:Focus(false, StyleSlot);
            end;

            StyleSlot.Enabled = false;
            HUD.Right.StyleSlot.Visible = false;

            return;
        end;

        local v7 = Essentials:TableLength(Controller.Player.InvitedUsers);
        local math_clamp_ret = math.clamp(v7, 0, 5);
        StyleSlot.Content.ProgressBar.Bar.Size = UDim2.fromScale(math_clamp_ret / 5, 1);
        StyleSlot.Content.ProgressBar.Progress.Text = `{math_clamp_ret} / 5 FRIENDS INVITED`;
        StyleSlot.Content.RedeemButton.Visible = math_clamp_ret == 5;
        u4:Add(RunService.Heartbeat:Connect(function() -- Line: 64
            -- upvalues: GetUnixTime (ref), u5 (ref), Controller (ref), OnDataChanged (ref), HUD (ref), NumberUtil (ref), TweenService (ref)
            local v8 = GetUnixTime();

            if u5 == v8 then
                return;
            end;

            u5 = v8;
            local v9 = workspace:GetAttribute("StyleSlotTime") - v8;
            local v10;

            if Controller.Player.RedeemedFreeStyleSlot or Controller.Player.MaxStyleSlots >= 7 then
                v10 = false;
            else
                v10 = GetUnixTime() < workspace:GetAttribute("StyleSlotTime");
            end;

            if not v10 then
                task.spawn(OnDataChanged);

                return;
            end;

            HUD.Right.StyleSlot.Timer.Text = NumberUtil.AdaptiveClockString(v9);
            HUD.Right.StyleSlot.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
            HUD.Right.StyleSlot.Timer.Size = UDim2.fromScale(1, 0.45);
            TweenService:Create(HUD.Right.StyleSlot.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromScale(1, 0.293)
            }):Play();
        end));
        HUD.Right.StyleSlot.Visible = true;
    end;

    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 95
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
    StyleSlot.Content.RedeemButton.MouseButton1Click:Connect(function() -- Line: 99
        -- upvalues: Service (copy)
        Service:RedeemFreeStyleSlot();
    end);
    HUD.Right.StyleSlot.Button.MouseButton1Down:Connect(function() -- Line: 103
        -- upvalues: StyleSlot (copy), Controller2 (copy)
        StyleSlot.Enabled = not StyleSlot.Enabled;
        Controller2:Focus(StyleSlot.Enabled, StyleSlot);
    end);
end;

return v1;