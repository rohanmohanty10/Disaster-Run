 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SocialService = game:GetService("SocialService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local v1 = Knit.CreateController({
    Name = "ZoneSlot"
});

function v1.KnitInit(p2) -- Line: 17
end;

function v1.KnitStart(p3) -- Line: 21
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), GetUnixTime (copy), Essentials (copy), RunService (copy), NumberUtil (copy), TweenService (copy), ReplicatedStorage (copy), SocialService (copy)
    local Service = Knit.GetService("MarketService");
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local u4 = Trove.new();
    local ZoneSlot = LocalPlayer.PlayerGui:WaitForChild("ZoneSlot");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");

    local function IsElegible() -- Line: 31
        -- upvalues: Controller (copy), GetUnixTime (ref)
        if Controller.Player.RedeemedFreeZoneSlot then
            return false;
        end;

        if Controller.Player.MaxZoneSlots >= 7 then
            return false;
        end;

        return GetUnixTime() < workspace:GetAttribute("ZoneSlotTime");
    end;

    local u5 = nil;

    local function OnDataChanged() -- Line: 45
        -- upvalues: u4 (copy), Controller (copy), GetUnixTime (ref), ZoneSlot (copy), Controller2 (copy), HUD (copy), Essentials (ref), RunService (ref), u5 (ref), OnDataChanged (copy), NumberUtil (ref), TweenService (ref)
        u4:Clean();
        local v6;

        if Controller.Player.RedeemedFreeZoneSlot or Controller.Player.MaxZoneSlots >= 7 then
            v6 = false;
        else
            v6 = GetUnixTime() < workspace:GetAttribute("ZoneSlotTime");
        end;

        if not v6 then
            if ZoneSlot.Enabled == true then
                Controller2:Focus(false, ZoneSlot);
            end;

            ZoneSlot.Enabled = false;
            HUD.Right.ZoneSlot.Visible = false;

            return;
        end;

        local v7 = Essentials:TableLength(Controller.Player.InvitedUsers);
        local math_clamp_ret = math.clamp(v7, 0, 3);
        ZoneSlot.Content.ProgressBar.Bar.Size = UDim2.fromScale(math_clamp_ret / 3, 1);
        ZoneSlot.Content.ProgressBar.Progress.Text = `{math_clamp_ret} / 3 FRIENDS INVITED`;
        ZoneSlot.Content.RedeemButton.Visible = math_clamp_ret == 3;
        ZoneSlot.Content.InviteFriends.Visible = not ZoneSlot.Content.RedeemButton.Visible;
        u4:Add(RunService.Heartbeat:Connect(function() -- Line: 66
            -- upvalues: GetUnixTime (ref), u5 (ref), Controller (ref), OnDataChanged (ref), HUD (ref), NumberUtil (ref), TweenService (ref)
            local v8 = GetUnixTime();

            if u5 == v8 then
                return;
            end;

            u5 = v8;
            local v9 = workspace:GetAttribute("ZoneSlotTime") - v8;
            local v10;

            if Controller.Player.RedeemedFreeZoneSlot or Controller.Player.MaxZoneSlots >= 7 then
                v10 = false;
            else
                v10 = GetUnixTime() < workspace:GetAttribute("ZoneSlotTime");
            end;

            if not v10 then
                task.spawn(OnDataChanged);

                return;
            end;

            HUD.Right.ZoneSlot.Timer.Text = NumberUtil.AdaptiveClockString(v9);
            HUD.Right.ZoneSlot.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
            HUD.Right.ZoneSlot.Timer.Size = UDim2.fromScale(1, 0.45);
            TweenService:Create(HUD.Right.ZoneSlot.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromScale(1, 0.293)
            }):Play();
        end));
        HUD.Right.ZoneSlot.Visible = true;
    end;

    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 97
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
    ZoneSlot.Content.RedeemButton.MouseButton1Click:Connect(function() -- Line: 101
        -- upvalues: Service (copy)
        Service:RedeemFreeZoneSlot();
    end);
    local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
    ExperienceInviteOptions.PromptMessage = "Invite 3 Friends for a FREE ZONE SLOT";
    ZoneSlot.Content.InviteFriends.MouseButton1Down:Connect(function() -- Line: 108
        -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
        SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
    end);
    HUD.Right.ZoneSlot.Button.MouseButton1Down:Connect(function() -- Line: 112
        -- upvalues: ZoneSlot (copy), Controller2 (copy)
        ZoneSlot.Enabled = not ZoneSlot.Enabled;
        Controller2:Focus(ZoneSlot.Enabled, ZoneSlot);
    end);
end;

return v1;