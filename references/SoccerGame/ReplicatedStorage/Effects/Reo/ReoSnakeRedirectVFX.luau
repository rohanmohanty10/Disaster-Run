  

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
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("NEL ReoSnakeRedirect");

    if not (CutsceneData and v2) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local v3 = v2.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Character ~= Char and game.Players.LocalPlayer.Character.Values.Goalie.Value then
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
    SoundManager.SpawnSound("Reo Serpent", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u4 = true;
    task.spawn(function() -- Line: 56
        -- upvalues: u4 (ref), Controller (copy), Players (ref)
        while u4 do
            task.wait();

            if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;

            Controller.Cutscene = true;
            Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        end;
    end);
    local Pivot = v3:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v3:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v3;
    local v5 = Moonlite.CreatePlayer(CutsceneData, v3);
    local v6 = {};

    for _, child in v3.Neo_Hex:GetChildren() do
        local v7 = Char:FindFirstChild(child.Name);

        if v7 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v7;
                table.insert(v6, child2);
            end;
        end;
    end;

    v3.Neo_Hex:Destroy();

    if v5._moduleInfo and Char then
        for i, v in v5._moduleInfo.Compiled do
            local v8 = v.Path or i;

            if v8.InstanceNames[2] == "Neo_Hex" then
                local table_clone_ret = table.clone(v8);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame2 = v.Props.CFrame;

            if CFrame2 and v8.ItemType ~= "Attachment" then
                CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                for _, v4 in CFrame2.Sequence do
                    v4.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v4.Value));
                end;
            end;
        end;
    end;

    v5:Compile();

    local function timestampToFrame(p9) -- Line: 123
        local v10, v11 = p9:match("^(%d+):(%d+)$");

        return not (v10 and v11) and (tonumber(p9) or 0) or tonumber(v10) + tonumber(v11) / 1000;
    end;

    local function showCutsceneText(p12: string, u13: number, u14: string, u15) -- Line: 132
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v16, v17 = p12:match("^(%d+):(%d+)$");
        local v18;

        if v16 and v17 then
            v18 = tonumber(v16) + tonumber(v17) / 1000;
        else
            v18 = tonumber(p12) or 0;
        end;

        task.delay(v18, function() -- Line: 135
            -- upvalues: ReplicatedStorage (ref), Players (ref), u14 (copy), u15 (copy), TweenService (ref), u13 (copy), Debris (ref)
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
            task.delay(u13, function() -- Line: 165
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

    for _, child in v3:GetChildren() do
        local v20;

        if child:IsA("LayerCollector") then
            v20 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 186
                        -- upvalues: child2 (copy), RunService (ref)
                        local v21 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v21);
                        child2.ImageTransparency = 0.999;
                        local v22 = RunService.PreRender:Connect(function() -- Line: 192
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

    v3.Parent = workspace;
    Camera.Changed:Connect(function(p23: string) -- Line: 216
        -- upvalues: Camera (copy)
        if p23 ~= "CFrame" and p23 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p23] = Camera[p23];
    end);
    v5:Play();
    local v24 = script.VFX:Clone();
    v24:PivotTo(Char.HumanoidRootPart.CFrame);
    local v25 = {};

    for _, child in v24:GetChildren() do
        table.insert(v25, child);
        child.Parent = workspace;
    end;

    require(script["SnakeRedirect Code Events"])(v5);
    v5.Completed:Wait();
    u4 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v5:Destroy();
    v3:Destroy();
    v24:Destroy();

    for _, v in v25 do
        v:Destroy();
    end;

    for _, v in v6 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CFrame = CFrame;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;