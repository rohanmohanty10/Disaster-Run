 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local v1 = Knit.CreateController({
    Name = "StarterPack"
});

function v1.KnitInit(p2) -- Line: 15
end;

function v1.KnitStart(p3) -- Line: 19
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), GetUnixTime (copy), RunService (copy), NumberUtil (copy), TweenService (copy), ReplicatedStorage (copy)
    local Service = Knit.GetService("MarketService");
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local u4 = Trove.new();
    local u5 = nil;
    local u6 = nil;
    local StarterPack = LocalPlayer.PlayerGui:WaitForChild("StarterPack");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");

    local function IsElegibleForStarterPack() -- Line: 31
        -- upvalues: Controller (copy), GetUnixTime (ref)
        local v7;

        if Controller.Player.ClaimedStarterPack == true or (Controller.Player.StarterPackPromptTime == nil or (GetUnixTime() - Controller.Player.StarterPackPromptTime >= workspace:GetAttribute("StarterPackLifetime") or Controller.Player.RobuxSpent ~= 0)) then
            v7 = false;
        else
            v7 = not workspace:GetAttribute("IsPrivateServer");
        end;

        return v7;
    end;

    local function OnDataChanged(p8: boolean) -- Line: 40
        -- upvalues: Controller (copy), u5 (ref), u6 (ref), u4 (copy), IsElegibleForStarterPack (copy), StarterPack (copy), Controller2 (copy), HUD (copy), RunService (ref), GetUnixTime (ref), OnDataChanged (copy), NumberUtil (ref), TweenService (ref)
        local StarterPackPromptTime = Controller.Player.StarterPackPromptTime;

        if p8 ~= true and (u5 == StarterPackPromptTime and u6 == Controller.Player.ClaimedStarterPack) then
            return;
        end;

        u6 = Controller.Player.ClaimedStarterPack;
        u5 = StarterPackPromptTime;
        u4:Clean();

        if IsElegibleForStarterPack() then
            local u9 = nil;
            u4:Add(RunService.Heartbeat:Connect(function() -- Line: 65
                -- upvalues: GetUnixTime (ref), u9 (ref), StarterPackPromptTime (copy), IsElegibleForStarterPack (ref), OnDataChanged (ref), HUD (ref), NumberUtil (ref), TweenService (ref)
                local v10 = GetUnixTime();

                if u9 == v10 then
                    return;
                end;

                u9 = v10;
                local v11 = workspace:GetAttribute("StarterPackLifetime") - (v10 - StarterPackPromptTime);

                if not IsElegibleForStarterPack() then
                    task.spawn(OnDataChanged, true);

                    return;
                end;

                HUD.Right.StarterPack.Timer.Text = NumberUtil.AdaptiveClockString(v11, true);
                HUD.Right.StarterPack.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
                HUD.Right.StarterPack.Timer.Size = UDim2.fromScale(1, 0.55);
                TweenService:Create(HUD.Right.StarterPack.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.fromScale(1, 0.393)
                }):Play();
            end));
            HUD.Right.StarterPack.Visible = true;

            return;
        end;

        if StarterPack.Enabled == true then
            Controller2:Focus(false, StarterPack);
        end;

        StarterPack.Enabled = false;
        HUD.Right.StarterPack.Visible = false;
    end;

    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 96
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
    HUD.Right.StarterPack.MouseButton1Down:Connect(function() -- Line: 100
        -- upvalues: StarterPack (copy), Controller2 (copy)
        StarterPack.Enabled = not StarterPack.Enabled;
        Controller2:Focus(StarterPack.Enabled, StarterPack);
    end);
    StarterPack.BG.Background.Content.Buy.MouseButton1Down:Connect(function() -- Line: 106
        -- upvalues: Service (copy)
        Service:PromptStarterPack();
    end);
end;

return v1;