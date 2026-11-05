  

 

local LocalPlayer = game.Players.LocalPlayer;
local RunService = game:GetService("RunService");
game:GetService("StarterGui");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local Trove = require(PathShortcuts.KnitPath.Trove);
local Promise = require(PathShortcuts.KnitPath.Promise);
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local u2 = {};

local function CutsceneFunc(u3) -- Line: 19
    -- upvalues: Trove (copy), u2 (copy), LocalPlayer (copy), Promise (copy), UserInputService (copy), CurrentCamera (copy), u1 (copy), AnimationHandler (copy), RunService (copy), TweenService (copy), CutsceneFunc (copy)
    local Target = u3.Target;
    local Character = u3.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    local AbilityName = u3.AbilityName;
    local SkinName = u3.SkinName;
    local AnimationName = u3.AnimationName;
    local AnimationId = u3.AnimationId;
    local JointData = u3.JointData;
    local _ = u3.Offset;
    local Debug = u3.Debug;
    local u4 = u3.EasingTime or 0;
    local u5 = u3.EasingStyle or "Sine";
    local u6 = u3.EasingDirection or "Out";
    local StartTimePosition = u3.StartTimePosition;
    local u7 = Trove.new();
    local u8 = u3.Prefix or AbilityName .. AnimationName;

    if u3.Stop then
        local v9 = u2[u8];

        if v9 then
            v9:Stop();
        end;

        return;
    end;

    if not u3.Bypass and LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    if u3.Interrupt then
        for _, v in pairs(u2) do
            v:Stop();
        end;
    end;

    if u2[u8] then
        u2[u8]:Stop();

        return;
    end;

    Promise.try(function() -- Line: 67
        -- upvalues: UserInputService (ref), LocalPlayer (ref), u7 (copy), Debug (copy), CurrentCamera (ref), u1 (ref), u3 (copy), JointData (copy), HumanoidRootPart (copy), AnimationId (copy), AnimationHandler (ref), AbilityName (copy), SkinName (copy), AnimationName (copy), u2 (ref), u8 (copy), StartTimePosition (copy), RunService (ref), u4 (copy), TweenService (ref), u5 (copy), u6 (copy), Character (copy), Target (copy)
        if not UserInputService.TouchEnabled then
            local UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI");
            UI.Enabled = false;
            u7:Add(function() -- Line: 74
                -- upvalues: UI (copy)
                UI.Enabled = true;
            end);
        end;

        if not Debug then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        end;

        local u10 = u7:Clone(u1.Universal.NewCameraRig);
        u10.Name = u3.DisplayName or u10.Name;
        u10.CameraBars.Transparency = u3.BarsVisible == true and 0 or 1;

        if u3.RigProperties then
            for i, v in pairs(u3.RigProperties) do
                if u10:FindFirstChild(i) then
                    local v11 = u10[i];

                    for i2, v2 in pairs(v) do
                        v11[i2] = v2;
                    end;
                end;
            end;
        end;

        if JointData then
            local v12 = u7:Add(Instance.new("Motor6D"));
            v12.Part0 = JointData.Part0 or HumanoidRootPart;
            v12.Part1 = u10.RootPart;
            v12.C0 = (JointData.Offset or CFrame.identity) * CFrame.fromEulerAngles(0, 3.141592653589793, 0, Enum.RotationOrder.YXZ);
            v12.Parent = JointData.Parent or (JointData.Part0 or HumanoidRootPart);
        else
            u10.RootPart.Anchored = true;

            if u3.Origin then
                u10.RootPart:PivotTo(u3.Origin * (u3.Offset or CFrame.identity) * CFrame.fromEulerAngles(0, 3.141592653589793, 0, Enum.RotationOrder.YXZ));
            else
                u10.RootPart:PivotTo(HumanoidRootPart.CFrame * (u3.Offset or CFrame.identity) * CFrame.fromEulerAngles(0, 3.141592653589793, 0, Enum.RotationOrder.YXZ));
            end;
        end;

        u10.Parent = workspace.Effects;
        local Animator = u10.AnimationController.Animator;
        local v13;

        if AnimationId then
            v13 = AnimationHandler.CreateAnimationById(AnimationName, AnimationId);
        else
            v13 = AnimationHandler.CreateAnimationByName(AbilityName, SkinName, AnimationName);
        end;

        local u14 = Animator:LoadAnimation((u7:Add(v13)));
        u2[u8] = u14;
        u14:Play(u3.FadeTime, u3.Weight, u3.Speed or 1);

        if StartTimePosition then
            u14.TimePosition = StartTimePosition;
        end;

        u7:Add(function() -- Line: 123
            -- upvalues: u2 (ref), u8 (ref)
            u2[u8] = nil;
        end);
        u7:Add(function() -- Line: 127
            -- upvalues: u2 (ref), u14 (copy), CurrentCamera (ref), LocalPlayer (ref)
            for _, v in pairs(u2) do
                if v ~= u14 then
                    return;
                end;
            end;

            CurrentCamera.CameraType = Enum.CameraType.Custom;
            CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
        end);

        if u3.MarkerEvents then
            for i, v in u3.MarkerEvents do
                if typeof(v) == "function" then
                    u7:Connect(u14:GetMarkerReachedSignal(i), v);
                end;
            end;
        end;

        local u15 = u3.FoVPropertyName or "FieldOfView";
        local u16 = 0;
        u7:Connect(RunService.RenderStepped, function(p17) -- Line: 149
            -- upvalues: u16 (ref), u10 (copy), u4 (ref), TweenService (ref), u5 (ref), u6 (ref), CurrentCamera (ref), u15 (copy), Character (ref), u7 (ref), Target (ref)
            u16 = u16 + p17;
            local v18 = u10.RootPart.Main.TransformedWorldCFrame * CFrame.Angles(0, 3.141592653589793, 0);
            local v19 = 70 + u10.RootPart.Main.FOV.TransformedCFrame.Y * 100;

            if u4 and u4 > 0 then
                local v20 = TweenService:GetValue(math.clamp(u16 / u4, 0, 1), u5, u6);

                if v20 >= 1 then
                    CurrentCamera.CFrame = v18;
                    CurrentCamera[u15] = v19;
                else
                    CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v18, v20);
                    CurrentCamera[u15] = math.lerp(CurrentCamera[u15], v19, v20);
                end;
            else
                CurrentCamera[u15] = v19;
                CurrentCamera.CFrame = v18;
            end;

            if Character and not Character.Parent then
                u7:Destroy();
            end;

            if Target and not Target.Parent then
                u7:Destroy();
            end;
        end);
        u14.Stopped:Wait();
    end):catch(warn):finallyCall(u7.Destroy, u7):await();
    u2[u8] = nil;

    if u3.NextCutscene then
        CutsceneFunc(u3.NextCutscene);
    end;
end;

return CutsceneFunc;