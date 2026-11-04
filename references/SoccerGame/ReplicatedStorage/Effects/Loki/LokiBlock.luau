  

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
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

return function(p1) -- Line: 18
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), ReplicatedStorage (copy), TweenService (copy), Knit (copy), Players (copy), RunService (copy), Moonlite (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("Loki Block");

    if not (CutsceneData and v2) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local v3 = v2["Loki Block"]:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v4 = Char:FindFirstChildWhichIsA("Humanoid");

    if not v4 then
        return;
    end;

    if not v4:FindFirstChildWhichIsA("Animator") then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if not Char:IsDescendantOf(workspace) then
        return;
    end;

    if game.Players.LocalPlayer.Character ~= Char and game.Players.LocalPlayer.Character.Values.Goalie.Value then
        return;
    end;

    SoundManager.SpawnSound("Loki Its Slow", 0.6, workspace, 150);
    task.spawn(function() -- Line: 58
        -- upvalues: ReplicatedStorage (ref), TweenService (ref)
        task.wait(10.31);
        local v5 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v5.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        v5.Position = UDim2.new(0.5, 0, 0.8, 0);
        v5.Size = UDim2.new(1, 0, 0.1, 0);
        v5.BackgroundTransparency = 1;
        v5.AnchorPoint = Vector2.new(0.5, 0.5);
        v5.Font = Enum.Font.ArialBold;
        v5.TextColor3 = Color3.new(1, 1, 1);
        v5.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v5;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v5.MaxVisibleGraphemes = 0;
        v5.TextTransparency = 0;
        v5.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v5.Text = "The Kaiser Impact...";
        TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v5.Text
        }):Play();
        task.wait(1.5);
        v5.MaxVisibleGraphemes = 0;
        v5.TextTransparency = 0;
        v5.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(0.67);
        v5.Text = "Is Too Slow!";
        TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v5.Text
        }):Play();
        task.wait(2);
        v5:Destroy();
    end);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u6 = true;
    task.spawn(function() -- Line: 106
        -- upvalues: u6 (ref), Controller (copy), Players (ref)
        while u6 do
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
    local v7 = RunService.PostSimulation:Connect(function() -- Line: 122
        -- upvalues: HumanoidRootPart (copy), Pivot2 (copy)
        HumanoidRootPart:PivotTo(Pivot2);
    end);
    local CameraSubject = workspace.CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v3;
    local v8 = Moonlite.CreatePlayer(CutsceneData, v3);
    local v9 = {};

    for _, child in v3.Neo_Hex:GetChildren() do
        local v10 = Char:FindFirstChild(child.Name);

        if v10 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v10;
                table.insert(v9, child2);
            end;
        end;
    end;

    v3.Neo_Hex:Destroy();

    if v8._moduleInfo and Char then
        for i, v in v8._moduleInfo.Compiled do
            local v11 = v.Path or i;

            if v11.InstanceNames[2] == "Neo_Hex" then
                local table_clone_ret = table.clone(v11);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame = v.Props.CFrame;

            if CFrame and v11.ItemType ~= "Attachment" then
                CFrame.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame.Default));

                for _, v5 in CFrame.Sequence do
                    v5.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v5.Value));
                end;
            end;
        end;
    end;

    v8:Compile();

    for _, child in v3:GetChildren() do
        local v12;

        if child:IsA("LayerCollector") then
            v12 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 182
                        -- upvalues: child2 (copy), RunService (ref)
                        local v13 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v13);
                        child2.ImageTransparency = 0.999;
                        local v14 = RunService.PreRender:Connect(function() -- Line: 188
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v14:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v12.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v12 = child;
        else
            v12 = child;
        end;

        table.insert(v9, v12);
    end;

    v3.Parent = workspace;
    Camera.Changed:Connect(function(p15: string) -- Line: 212
        -- upvalues: Camera (copy)
        if p15 ~= "CFrame" and p15 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p15] = Camera[p15];
    end);
    v8:Play();
    v8.Completed:Wait();
    u6 = false;
    v7:Disconnect();
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v8:Destroy();
    v3:Destroy();

    for _, v in v9 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Massless = true;
    task.wait();
    HumanoidRootPart.Massless = false;
end;