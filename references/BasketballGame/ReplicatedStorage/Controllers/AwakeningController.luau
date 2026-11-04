 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = v1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local v3 = Knit.CreateController({
    Name = "AwakeningController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;

function v3.JustBeganCutscene(p9) -- Line: 32
    if p9.AwakeningCutsceneInputTick == nil then
        return false;
    end;

    return tick() - p9.AwakeningCutsceneInputTick < 0.5;
end;

function v3.UI(p10) -- Line: 40
    -- upvalues: LocalPlayer (copy), Knit (copy), TweenService (copy), u7 (ref), ReplicatedStorage (copy)
    local BG = LocalPlayer.PlayerGui.InGame.BG;
    local Controller = Knit.GetController("KeybindsController");

    local function UpdateUI() -- Line: 45
        -- upvalues: TweenService (ref), BG (copy), u7 (ref), LocalPlayer (ref), ReplicatedStorage (ref), Controller (copy)
        TweenService:Create(BG.Bars.AwakeningBar.AwakeningBar.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-0.7 + u7.CharValues.AwakeningBar / 100, 0)
        }):Play();

        if u7.CharValues.AwakeningBar > 0.1 then
            LocalPlayer.PlayerGui.Mobile.NoBall.Awaken.Visible = true;
            LocalPlayer.PlayerGui.Mobile.Ball.Awaken.Visible = true;
            BG.Bars.AwakeningBar.Visible = true;
        else
            LocalPlayer.PlayerGui.Mobile.NoBall.Awaken.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Ball.Awaken.Visible = false;
            BG.Bars.AwakeningBar.Visible = false;
        end;

        local AwakeningBar = BG.Bars.AwakeningBar.AwakeningBar;

        if u7.CharValues.InAwakening then
            AwakeningBar.Input.Visible = false;
            AwakeningBar.Key2.Visible = false;
            local Key = AwakeningBar.Key;
            local math_round_ret = math.round(u7.CharValues.AwakeningBar);
            Key.Text = `{tostring(math_round_ret)}%`;
        elseif ReplicatedStorage.Controllers.Device.Value == "Mobile" then
            AwakeningBar.Input.Visible = false;
            AwakeningBar.Key2.Visible = false;
            AwakeningBar.Key.Text = "AWAKENING IS READY";
        else
            AwakeningBar.Input.Visible = true;
            AwakeningBar.Key2.Visible = true;
            AwakeningBar.Key.Text = "PRESS";
            AwakeningBar.Key2.Text = "TO AWAKEN";
            AwakeningBar.Input.Image = Controller.GetKeybindIcon("Awaken");
        end;

        if u7.CharValues.InAwakening == false and u7.CharValues.AwakeningBar < 50 then
            LocalPlayer.PlayerGui.Mobile.NoBall.Awaken.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Ball.Awaken.Visible = false;
            BG.Bars.AwakeningBar.Visible = false;
        end;
    end;

    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(UpdateUI);
    Controller.PlatformChanged:Connect(UpdateUI);
end;

function v3.Input(u11) -- Line: 95
    -- upvalues: HumanoidRootPart (copy), u5 (ref), u7 (ref), Effects (copy), Styles (copy), LocalPlayer (copy), ReplicatedStorage (copy), u2 (copy), u8 (ref), Knit (copy), UserInputService (copy)
    local _ = HumanoidRootPart.CFrame;

    local function Awaken() -- Line: 97
        -- upvalues: u5 (ref), u7 (ref), Effects (ref), Styles (ref), LocalPlayer (ref), ReplicatedStorage (ref), u2 (ref), u11 (copy), u8 (ref)
        if u5:NoAction() then
            return;
        end;

        if u7.Gamemode ~= "Match-2v2" and u7:SomeoneScoredWithinXSecondsAgo(7) then
            Effects:Popup((`Can't awaken within {7} seconds of scoring!`));

            return;
        end;

        if Styles.Styles[LocalPlayer.Style.Value].NoBallAwakening then
            if u7.CharValues.HasBall then
                Effects:Popup("Must not have ball for this style to awaken!");

                return;
            end;

            if workspace:GetServerTimeNow() - u7.CharValues.LastHadBall < 2 then
                Effects:Popup("Must not have ball for at least 2 seconds to awaken!");

                return;
            end;
        elseif u7.CharValues.HasBall == false then
            Effects:Popup("Must have ball to awaken!");

            return;
        end;

        if not (ReplicatedStorage.GameTweaks:GetAttribute("JumpAbilities") or u2:GetState() ~= Enum.HumanoidStateType.Jumping and u2:GetState() ~= Enum.HumanoidStateType.Freefall) then
            Effects:Popup("Must be on the ground to awaken!");

            return;
        end;

        if u7.CharValues.InAwakening then
            return;
        end;

        if u7.CharValues.AwakeningBar <= 80 then
            return;
        end;

        u11.AwakeningCutsceneInputTick = tick();

        if LocalPlayer.Style.Value == "BasketballGod" then
            for _, child in workspace.Barriers:GetChildren() do
                child.CanCollide = false;
            end;
        end;

        u8.Awaken:Fire({
            TimeSent = workspace:GetServerTimeNow()
        });
    end;

    LocalPlayer.PlayerGui.Mobile.NoBall.Awaken.MouseButton1Click:Connect(Awaken);
    LocalPlayer.PlayerGui.Mobile.Ball.Awaken.MouseButton1Click:Connect(Awaken);
    local Controller = Knit.GetController("KeybindsController");
    UserInputService.InputBegan:Connect(function(p12, p13) -- Line: 146
        -- upvalues: Controller (copy), Awaken (copy)
        if p13 then
            return;
        end;

        if Controller.IsInputValid(p12, "Awaken") then
            Awaken();
        end;
    end);
    u8.Awaken:Connect(function(p14) -- Line: 153
        for _, child in workspace.Barriers:GetChildren() do
            child.CanCollide = true;
        end;
    end);
    task.spawn(function() -- Line: 159
        -- upvalues: u11 (copy)
        local v15 = false;

        while task.wait(0.5) do
            local CamRig = workspace:FindFirstChild("CamRig");

            if v15 and CamRig == nil then
                u11._LastCutsceneEndedTimestamp = tick();
                v15 = false;

                for i, _ in u11._CutsceneStateChangedCallbacks do
                    i(v15);
                end;
            elseif not v15 and CamRig then
                u11._LastCutsceneStartedTimestamp = tick();
                v15 = true;

                for i, _ in u11._CutsceneStateChangedCallbacks do
                    i(v15);
                end;
            end;
        end;
    end);
end;

function v3.CutsceneEndedLessThanXSecondsAgo(p16, p17) -- Line: 191
    return p16._LastCutsceneStartedTimestamp > p16._LastCutsceneEndedTimestamp and true or tick() - p16._LastCutsceneEndedTimestamp < p17;
end;

function v3.OnCutsceneStateChangedConnect(u18, u19, p20) -- Line: 200
    local v21 = p20 == nil and true or p20;

    if typeof(u19) ~= "function" then
        error((`{u19} is not a function!`));
    end;

    if typeof(v21) ~= "boolean" then
        error((`{v21} is not a boolean!`));
    end;

    u18._CutsceneStateChangedCallbacks[u19] = true;

    if v21 then
        u19(u18:CutsceneEndedLessThanXSecondsAgo(0));
    end;

    return function() -- Line: 216
        -- upvalues: u18 (copy), u19 (copy)
        u18._CutsceneStateChangedCallbacks[u19] = nil;
    end;
end;

function v3.KnitStart(p22) -- Line: 221
    -- upvalues: u4 (ref), Knit (copy), u6 (ref), u5 (ref), u7 (ref), u8 (ref)
    u4 = Knit.GetController("CameraController");
    u6 = Knit.GetController("AnimationController");
    u5 = Knit.GetController("BallController");
    u7 = Knit.GetController("Network");
    u8 = Knit.GetService("AwakeningService");
    p22._LastCutsceneEndedTimestamp = tick();
    p22._LastCutsceneStartedTimestamp = tick() - 10;
    p22._CutsceneStateChangedCallbacks = {};
    p22:Input();
    p22:UI();
end;

return v3;