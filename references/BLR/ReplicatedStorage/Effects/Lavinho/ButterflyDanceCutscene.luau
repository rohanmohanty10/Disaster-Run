  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Shared.Moonlite);

local function timestampToFrame(p1) -- Line: 19
    local v2, v3 = p1:match("^(%d+):(%d+)$");

    return not (v2 and v3) and (tonumber(p1) or 0) or tonumber(v2) + tonumber(v3) / 1000;
end;

local function showCutsceneText(p4: string, u5: number, u6: string, u7) -- Line: 28
    -- upvalues: Players (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    local v8, v9 = p4:match("^(%d+):(%d+)$");
    local v10;

    if v8 and v9 then
        v10 = tonumber(v8) + tonumber(v9) / 1000;
    else
        v10 = tonumber(p4) or 0;
    end;

    task.delay(v10, function() -- Line: 31
        -- upvalues: Players (ref), ReplicatedStorage (ref), u6 (copy), u7 (copy), TweenService (ref), u5 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u11 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u11.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u11.Position = UDim2.new(0.5, 0, 0.8, 0);
        u11.AnchorPoint = Vector2.new(0.5, 0.5);
        u11.Size = UDim2.new(1, 0, 0.1, 0);
        u11.BackgroundTransparency = 1;
        u11.Font = Enum.Font.ArialBold;
        u11.Text = u6;
        u11.TextColor3 = u7 or Color3.new(1, 1, 1);
        u11.TextTransparency = 0;
        u11.TextStrokeTransparency = 0;
        u11.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u11;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u11, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u6
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u5, function() -- Line: 63
            -- upvalues: TweenService (ref), u11 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u11, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u11, 1);
        end);
    end);
end;

local script_PlayCutscene = require(script.PlayCutscene);
local LocalPlayer = Players.LocalPlayer;

return function(p12) -- Line: 80
    -- upvalues: Players (copy), Knit (copy), LocalPlayer (copy), RunService (copy), script_PlayCutscene (copy)
    print("Butterfly dance Cutscene");
    local Char = p12.Char;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local HumanoidRootPart = Char.HumanoidRootPart;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;

    local function cleanup() -- Line: 93
        -- upvalues: Controller (copy), LocalPlayer (ref), CFrame (copy), CameraSubject (copy)
        local VFX = workspace:FindFirstChild("VFX");

        if VFX then
            VFX:Destroy();
        end;

        Controller.Cutscene = false;
        LocalPlayer.Character.Values.InCutscene.Value = false;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        workspace.CurrentCamera.CFrame = CFrame;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace.CurrentCamera.CameraSubject = CameraSubject;
    end;

    HumanoidRootPart.Anchored = true;
    local u13 = true;
    task.spawn(function() -- Line: 114
        -- upvalues: Players (ref), RunService (ref), Controller (copy), u13 (ref), PlayerFromCharacter (copy), cleanup (copy)
        Players.LocalPlayer:SetAttribute("ForceCursor", true);
        local v14 = RunService.PreRender:Connect(function() -- Line: 117
            -- upvalues: Controller (ref), Players (ref)
            if not Controller.Shiftlock then
                Players.LocalPlayer.PlayerGui.Misc.CURSOR.Visible = true;

                return;
            end;

            print("shift lock off");
            Controller:SetShiftlock(false);
        end);

        while u13 do
            task.wait();

            if not PlayerFromCharacter.Character then
                cleanup();
                break;
            end;

            if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;

            Controller.Cutscene = true;
            Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        end;

        v14:Disconnect();
        Players.LocalPlayer:SetAttribute("ForceCursor", false);
    end);
    task.delay(1, function() -- Line: 143
        -- upvalues: LocalPlayer (ref)
        local ButterflyDanceUI = LocalPlayer.PlayerGui:FindFirstChild("ButterflyDanceUI");

        if ButterflyDanceUI then
            ButterflyDanceUI.LeftArrow.Visible = true;
            ButterflyDanceUI.RightArrow.Visible = true;
            ButterflyDanceUI.TopArrow.Visible = true;
        end;
    end);
    script_PlayCutscene(Char, "LavinhoBD1", require(script.CodeEvents1), "1", nil, 1);

    if not PlayerFromCharacter.Character then
        cleanup();

        return;
    end;

    local BDChoice = PlayerFromCharacter:FindFirstChild("BDChoice");
    local v15 = not BDChoice and 1 or BDChoice.Value;
    local script_CodeEvents2 = require(script.CodeEvents2);
    local script_CodeEvents3 = require(script.CodeEvents3);
    local script_CodeEvents4 = require(script.CodeEvents4);

    if v15 == 1 then
        script_PlayCutscene(Char, "LavinhoBD2", script_CodeEvents2, "2", 1.15, 2);
    elseif v15 == 2 then
        if not PlayerFromCharacter.Character then
            cleanup();

            return;
        end;

        script_PlayCutscene(Char, "LavinhoBD3", script_CodeEvents3, "2", 1.2, 3);
    elseif v15 == 3 then
        if not PlayerFromCharacter.Character then
            cleanup();

            return;
        end;

        script_PlayCutscene(Char, "LavinhoBD4", script_CodeEvents4, "2", 1.15, 4);
    end;

    if not PlayerFromCharacter.Character then
        cleanup();

        return;
    end;

    task.delay(2, function() -- Line: 194
        -- upvalues: LocalPlayer (ref)
        local ButterflyDanceUI = LocalPlayer.PlayerGui:FindFirstChild("ButterflyDanceUI");

        if ButterflyDanceUI then
            ButterflyDanceUI.Buttons.Visible = true;
        end;
    end);
    script_PlayCutscene(Char, "LavinhoBD5", require(script.CodeEvents5), "3", 5, 5);

    if not PlayerFromCharacter.Character then
        cleanup();

        return;
    end;

    local LastChoice = PlayerFromCharacter:FindFirstChild("LastChoice");
    local v16 = not LastChoice and 1 or LastChoice.Value;
    local script_CodeEvents6 = require(script.CodeEvents6);
    local script_CodeEvents7 = require(script.CodeEvents7);
    local script_CodeEvents8 = require(script.CodeEvents8);

    if v16 == 1 then
        script_PlayCutscene(Char, "LavinhoBD6", script_CodeEvents6, "4", 1.25, 6);
    elseif v16 == 2 then
        if not PlayerFromCharacter.Character then
            cleanup();

            return;
        end;

        script_PlayCutscene(Char, "LavinhoBD7", script_CodeEvents7, "4", 7.43, 7);
    elseif v16 == 3 then
        if not PlayerFromCharacter.Character then
            cleanup();

            return;
        end;

        script_PlayCutscene(Char, "LavinhoBD8", script_CodeEvents8, "4", 2.16, 8);
    end;

    if not PlayerFromCharacter.Character then
        cleanup();

        return;
    end;

    script_PlayCutscene(Char, "LavinhoBD9", require(script.CodeEvents9), "5");
    task.wait(0.5);
    u13 = false;
    HumanoidRootPart.Anchored = false;
    LocalPlayer.Character.HumanoidRootPart.Massless = true;
    task.wait();
    LocalPlayer.Character.HumanoidRootPart.Massless = false;
    cleanup();
end;