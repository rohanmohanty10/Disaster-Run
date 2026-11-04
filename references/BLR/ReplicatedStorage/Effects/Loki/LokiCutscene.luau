  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
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
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), ReplicatedStorage (copy), TweenService (copy), Knit (copy), Players (copy), RunService (copy), Moonlite (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("Loki Awakening");

    if not (CutsceneData and v2) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local v3 = v2["Loki Awakening"]:Clone();

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

    HumanoidRootPart.Anchored = true;
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    SoundManager.SpawnSound("Loki Awk Sfx", 0.6, workspace, 150);
    task.spawn(function() -- Line: 48
        -- upvalues: ReplicatedStorage (ref), TweenService (ref)
        task.wait(2.06);
        local v4 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v4.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        v4.Position = UDim2.new(0.5, 0, 0.8, 0);
        v4.Size = UDim2.new(1, 0, 0.1, 0);
        v4.BackgroundTransparency = 1;
        v4.AnchorPoint = Vector2.new(0.5, 0.5);
        v4.Font = Enum.Font.ArialBold;
        v4.TextColor3 = Color3.new(1, 1, 1);
        v4.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v4;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v4.MaxVisibleGraphemes = 0;
        v4.TextTransparency = 0;
        v4.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v4.Text = "Uhh...";
        TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v4.Text
        }):Play();
        task.wait(1);
        v4.MaxVisibleGraphemes = 0;
        v4.TextTransparency = 0;
        v4.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(1.1);
        v4.Text = "Is this okay??";
        TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v4.Text
        }):Play();
        task.wait(1);
        v4.MaxVisibleGraphemes = 0;
        v4.TextTransparency = 0;
        v4.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v4.Text = "At this distance...";
        TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v4.Text
        }):Play();
        task.wait(1);
        v4.MaxVisibleGraphemes = 0;
        v4.TextTransparency = 0;
        v4.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v4.Text = "you\'ve got nothing but weak spots!";
        TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v4.Text
        }):Play();
        task.wait(2);
        v4:Destroy();
    end);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 118
        -- upvalues: u5 (ref), Controller (copy), Players (ref)
        while u5 do
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
    local v6 = RunService.PostSimulation:Connect(function() -- Line: 134
    end);
    local CameraSubject = workspace.CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v3;
    local v7 = Moonlite.CreatePlayer(CutsceneData, v3);
    local v8 = {};

    for _, child in v3.Neo_Hex:GetChildren() do
        local v9 = Char:FindFirstChild(child.Name);

        if v9 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v9;
                table.insert(v8, child2);
            end;
        end;
    end;

    v3.Neo_Hex:Destroy();

    if v7._moduleInfo and Char then
        for i, v in v7._moduleInfo.Compiled do
            local v10 = v.Path or i;

            if v10.InstanceNames[2] == "Neo_Hex" then
                local table_clone_ret = table.clone(v10);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame = v.Props.CFrame;

            if CFrame and v10.ItemType ~= "Attachment" then
                CFrame.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame.Default));

                for _, v4 in CFrame.Sequence do
                    v4.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v4.Value));
                end;
            end;
        end;
    end;

    v7:Compile();

    for _, child in v3:GetChildren() do
        local v11;

        if child:IsA("LayerCollector") then
            v11 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 198
                        -- upvalues: child2 (copy), RunService (ref)
                        local v12 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v12);
                        child2.ImageTransparency = 0.999;
                        local v13 = RunService.PreRender:Connect(function() -- Line: 204
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v13:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v11.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v11 = child;
        else
            v11 = child;
        end;

        table.insert(v8, v11);
    end;

    v3.Parent = workspace;
    Camera.Changed:Connect(function(p14: string) -- Line: 228
        -- upvalues: Camera (copy)
        if p14 ~= "CFrame" and p14 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p14] = Camera[p14];
    end);
    v7:Play();
    v7.Completed:Wait();
    u5 = false;
    task.wait();
    v6:Disconnect();
    HumanoidRootPart:PivotTo(Pivot2);
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v7:Destroy();
    v3:Destroy();

    for _, v in v8 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    HumanoidRootPart.Massless = true;
    task.wait();
    HumanoidRootPart.Massless = false;
end;