  

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
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), ReplicatedStorage2 (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("CharlesLokiCR");

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
    SoundManager.SpawnSound("CharlesLokiCR", 0.6, workspace, 150);
    local EnemyChar = p1.EnemyChar;
    local v4;

    if EnemyChar then
        EnemyChar.Archivable = true;
        v4 = EnemyChar:Clone();
        v4.HumanoidRootPart.Anchored = true;
        v4:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0));
        v4.Parent = workspace;
    else
        v4 = EnemyChar;
    end;

    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 62
        -- upvalues: Char (copy), u3 (copy), u5 (ref), Controller (copy), Players (ref)
        local Character = game.Players.LocalPlayer.Character;

        if not Character.Values.Goalie.Value or Char == Character then
            while u5 do
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
    local Pivot = u3:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u3:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u3;
    local v6 = Moonlite.CreatePlayer(CutsceneData, u3);
    local v7 = {};

    for _, child in u3.Charles:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    u3.Charles:Destroy();

    if v4 then
        u3["3"]:Destroy();
    end;

    if v6._moduleInfo and Char then
        for i, v in v6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "Charles" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif v4 and v9.InstanceNames[2] == "3" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, v4);
            end;

            local CFrame3 = v.Props.CFrame;

            if CFrame3 and v9.ItemType ~= "Attachment" then
                CFrame3.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame3.Default));

                for _, v3 in CFrame3.Sequence do
                    v3.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v3.Value));
                end;
            end;
        end;
    end;

    v6:Compile();

    local function timestampToFrame(p10) -- Line: 145
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 154
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 157
            -- upvalues: ReplicatedStorage (ref), Players (ref), u15 (copy), u16 (copy), TweenService (ref), u14 (copy), Debris (ref)
            local u20 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u20.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u20.Position = UDim2.new(0.5, 0, 0.8, 0);
            u20.AnchorPoint = Vector2.new(0.5, 0.5);
            u20.Size = UDim2.new(1, 0, 0.1, 0);
            u20.BackgroundTransparency = 1;
            u20.Font = Enum.Font.ArialBold;
            u20.Text = u15;
            u20.TextColor3 = u16 or Color3.new(1, 1, 1);
            u20.TextTransparency = 0;
            u20.TextStrokeTransparency = 0;
            u20.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u20;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u20, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u15
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u14, function() -- Line: 187
                -- upvalues: TweenService (ref), u20 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u20, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u20, 1);
            end);
        end);
    end;

    for _, child in u3:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 208
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 214
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v23:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v21.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v21 = child;
        else
            v21 = child;
        end;

        table.insert(v7, v21);
    end;

    u3.Parent = workspace;
    local Character = game.Players.LocalPlayer.Character;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p24: string) -- Line: 240
            -- upvalues: Camera (copy)
            if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p24] = Camera[p24];
        end);
    end;

    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Parent = workspace;
    EnemyChar.Parent = ViewportFrame;
    u3["BL:R Rig Pack"].CameraRig.AnimationController.Animator:LoadAnimation(script.Camera):Play();
    Char:SetAttribute("CutsceneChar", true);
    v6:Play();
    require(script.CodeEvents)(v6);
    v6.Completed:Wait();
    v6:Stop();
    u5 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v6:Destroy();
    u3:Destroy();

    for _, v in v7 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CFrame = CFrame2;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;

    if v4 then
        v4:Destroy();
    end;

    EnemyChar.Parent = ReplicatedStorage2;
    EnemyChar.Parent = workspace;
    ViewportFrame:Destroy();
    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;