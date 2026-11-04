  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

return function(p1) -- Line: 19
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("YukimiyaGoalInTime");

    if not (CutsceneData and v2) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local u3 = v2.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Humanoid = Char:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    SoundManager.SpawnSound("GoalInTime", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u4 = true;
    task.spawn(function() -- Line: 51
        -- upvalues: Char (copy), u3 (copy), u4 (ref), Controller (copy), Players (ref)
        local Character = game.Players.LocalPlayer.Character;

        if not Character.Values.Goalie.Value or Char == Character then
            while u4 do
                task.wait();

                if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                end;

                Controller.Cutscene = true;
                Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            end;

            return;
        end;

        local Cam = u3:FindFirstChild("Cam");

        if Cam then
            Cam:Destroy();
        end;
    end);
    HumanoidRootPart.Anchored = true;
    local Pivot = u3:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u3:PivotTo(Pivot2);

    for _, child in u3.CutsceneVFX:GetChildren() do
        if not child:IsA("MeshPart") then
            child.CFrame = child.CFrame * CFrame.new(0, 5.8, 0);
        end;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u3;
    local v5 = Moonlite.CreatePlayer(CutsceneData, u3);
    local v6 = {};

    for _, child in u3.Yukimiya:GetChildren() do
        local v7 = Char:FindFirstChild(child.Name);

        if v7 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v7;
                table.insert(v6, child2);
            end;
        end;
    end;

    u3.Yukimiya:Destroy();

    if v5._moduleInfo and Char then
        for i, v in v5._moduleInfo.Compiled do
            local v8 = v.Path or i;

            if v8.InstanceNames[2] == "Yukimiya" then
                local table_clone_ret = table.clone(v8);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame3 = v.Props.CFrame;

            if CFrame3 and v8.ItemType ~= "Attachment" then
                CFrame3.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame3.Default));

                for _, v3 in CFrame3.Sequence do
                    v3.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v3.Value));
                end;
            end;
        end;
    end;

    v5:Compile();

    local function timestampToFrame(p9) -- Line: 131
        local v10, v11 = p9:match("^(%d+):(%d+)$");

        return not (v10 and v11) and (tonumber(p9) or 0) or tonumber(v10) + tonumber(v11) / 1000;
    end;

    local function showCutsceneText(p12: string, u13: number, u14: string, u15) -- Line: 140
        -- upvalues: Players (ref), ReplicatedStorage (ref), TweenService (ref), Debris (ref)
        local v16, v17 = p12:match("^(%d+):(%d+)$");
        local v18;

        if v16 and v17 then
            v18 = tonumber(v16) + tonumber(v17) / 1000;
        else
            v18 = tonumber(p12) or 0;
        end;

        task.delay(v18, function() -- Line: 143
            -- upvalues: Players (ref), ReplicatedStorage (ref), u14 (copy), u15 (copy), TweenService (ref), u13 (copy), Debris (ref)
            local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

            if Popup then
                Popup:Destroy();
            end;

            local u19 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u19.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u19.Position = UDim2.new(0.5, 0, 0.8, 0);
            u19.AnchorPoint = Vector2.new(0.5, 0.5);
            u19.Size = UDim2.new(1, 0, 0.1, 0);
            u19.BackgroundTransparency = 1;
            u19.Font = Enum.Font.ArialBold;
            u19.Text = u14;
            u19.TextColor3 = u15 or Color3.new(1, 1, 1);
            u19.TextTransparency = 0;
            u19.TextStrokeTransparency = 0;
            u19.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u19;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u19, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u14
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u13, function() -- Line: 175
                -- upvalues: TweenService (ref), u19 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u19, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u19, 1);
            end);
        end);
    end;

    for _, child in u3:GetChildren() do
        local v20;

        if child:IsA("LayerCollector") then
            v20 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 196
                        -- upvalues: child2 (copy), RunService (ref)
                        local v21 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v21);
                        child2.ImageTransparency = 0.999;
                        local v22 = RunService.PreRender:Connect(function() -- Line: 202
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v22:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v20.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v20 = child;
        else
            v20 = child;
        end;

        table.insert(v6, v20);
    end;

    u3.Parent = workspace;
    local Character = game.Players.LocalPlayer.Character;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p23: string) -- Line: 228
            -- upvalues: Camera (copy)
            if p23 ~= "CFrame" and p23 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p23] = Camera[p23];
        end);
    end;

    local v24, v25 = ("0:01"):match("^(%d+):(%d+)$");
    local v26;

    if v24 and v25 then
        v26 = tonumber(v24) + tonumber(v25) / 1000;
    else
        v26 = tonumber("0:01") or 0;
    end;

    local u27 = "I see it. My... best angle for a shot.";
    local u28 = nil;
    local u29 = 2;
    task.delay(v26, function() -- Line: 143
        -- upvalues: Players (ref), ReplicatedStorage (ref), u27 (copy), u28 (copy), TweenService (ref), u29 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u30 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u30.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u30.Position = UDim2.new(0.5, 0, 0.8, 0);
        u30.AnchorPoint = Vector2.new(0.5, 0.5);
        u30.Size = UDim2.new(1, 0, 0.1, 0);
        u30.BackgroundTransparency = 1;
        u30.Font = Enum.Font.ArialBold;
        u30.Text = u27;
        u30.TextColor3 = u28 or Color3.new(1, 1, 1);
        u30.TextTransparency = 0;
        u30.TextStrokeTransparency = 0;
        u30.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u30;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u30, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u27
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u29, function() -- Line: 175
            -- upvalues: TweenService (ref), u30 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u30, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u30, 1);
        end);
    end);
    local v31, v32 = ("3:00"):match("^(%d+):(%d+)$");
    local v33;

    if v31 and v32 then
        v33 = tonumber(v31) + tonumber(v32) / 1000;
    else
        v33 = tonumber("3:00") or 0;
    end;

    local u34 = "This will lead me to \'Flow\'!";
    local u35 = nil;
    local u36 = 2;
    task.delay(v33, function() -- Line: 143
        -- upvalues: Players (ref), ReplicatedStorage (ref), u34 (copy), u35 (copy), TweenService (ref), u36 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u37 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u37.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u37.Position = UDim2.new(0.5, 0, 0.8, 0);
        u37.AnchorPoint = Vector2.new(0.5, 0.5);
        u37.Size = UDim2.new(1, 0, 0.1, 0);
        u37.BackgroundTransparency = 1;
        u37.Font = Enum.Font.ArialBold;
        u37.Text = u34;
        u37.TextColor3 = u35 or Color3.new(1, 1, 1);
        u37.TextTransparency = 0;
        u37.TextStrokeTransparency = 0;
        u37.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u37;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u37, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u34
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u36, function() -- Line: 175
            -- upvalues: TweenService (ref), u37 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u37, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u37, 1);
        end);
    end);
    local Color3_fromRGB_ret = Color3.fromRGB(255, 170, 0);
    local v38, v39 = ("6:00"):match("^(%d+):(%d+)$");
    local v40;

    if v38 and v39 then
        v40 = tonumber(v38) + tonumber(v39) / 1000;
    else
        v40 = tonumber("6:00") or 0;
    end;

    local u41 = "Goal in time";
    local u42 = 2;
    task.delay(v40, function() -- Line: 143
        -- upvalues: Players (ref), ReplicatedStorage (ref), u41 (copy), Color3_fromRGB_ret (copy), TweenService (ref), u42 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u43 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u43.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u43.Position = UDim2.new(0.5, 0, 0.8, 0);
        u43.AnchorPoint = Vector2.new(0.5, 0.5);
        u43.Size = UDim2.new(1, 0, 0.1, 0);
        u43.BackgroundTransparency = 1;
        u43.Font = Enum.Font.ArialBold;
        u43.Text = u41;
        u43.TextColor3 = Color3_fromRGB_ret or Color3.new(1, 1, 1);
        u43.TextTransparency = 0;
        u43.TextStrokeTransparency = 0;
        u43.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u43;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u43, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u41
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u42, function() -- Line: 175
            -- upvalues: TweenService (ref), u43 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u43, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u43, 1);
        end);
    end);
    Char:SetAttribute("CutsceneChar", true);
    v5:Play();
    require(script.CodeEvents)(v5);

    if game.Players.LocalPlayer.Character == Char or not game.Players.LocalPlayer.Character.Values.Goalie.Value then
        v5.Completed:Wait();
    else
        task.wait(v5:GetTimeLength() - 2);
    end;

    v5:Stop();
    u4 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v5:Destroy();
    u3:Destroy();

    for _, v in v6 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CFrame = CFrame2;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;