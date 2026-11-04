  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Shared.LightingStorage);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

local function changeLighting(p1) -- Line: 20
    -- upvalues: Lighting (copy)
    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for i, v in p1:GetAttributes() do
        Lighting[i] = v;
    end;

    for _, child in p1:GetChildren() do
        child:Clone().Parent = Lighting;
    end;
end;

return function(p2) -- Line: 35
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), changeLighting (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), ReplicatedStorage2 (copy)
    local CutsceneData, v3 = MoonCutsceneStreamer.getCutsceneData("BunnyHareInTheAir");

    if not (CutsceneData and v3) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local v4 = v3.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p2.Char;

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
    local EnemyChar1 = p2.EnemyChar1;
    local EnemyChar2 = p2.EnemyChar2;
    local EnemyChar3 = p2.EnemyChar3;
    local EnemyChar4 = p2.EnemyChar4;

    if EnemyChar1 then
        EnemyChar1.Archivable = true;
        EnemyChar1 = EnemyChar1:Clone();
        EnemyChar1.HumanoidRootPart.Anchored = true;
        EnemyChar1:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar1.Parent = workspace;
    end;

    if EnemyChar2 then
        EnemyChar2.Archivable = true;
        EnemyChar2 = EnemyChar2:Clone();
        EnemyChar2.HumanoidRootPart.Anchored = true;
        EnemyChar2:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar2.Parent = workspace;
    end;

    if EnemyChar3 then
        EnemyChar3.Archivable = true;
        EnemyChar3 = EnemyChar3:Clone();
        EnemyChar3.HumanoidRootPart.Anchored = true;
        EnemyChar3:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar3.Parent = workspace;
    end;

    if EnemyChar4 then
        EnemyChar4.Archivable = true;
        EnemyChar4 = EnemyChar4:Clone();
        EnemyChar4.HumanoidRootPart.Anchored = true;
        EnemyChar4:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar4.Parent = workspace;
    end;

    SoundManager.SpawnSound("BunnyHare", 0.6, workspace, 150);
    changeLighting(script.LightingConfig);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    HumanoidRootPart.Anchored = true;
    local u5 = true;
    task.spawn(function() -- Line: 112
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
    local Pivot = v4:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v4:PivotTo(Pivot2);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v4;
    local v6 = Moonlite.CreatePlayer(CutsceneData, v4);
    local v7 = {};

    for _, child in v4.Bunny:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    v4.Bunny:Destroy();

    if v6._moduleInfo and Char then
        for i, v in v6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "Bunny" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif EnemyChar1 and v9.InstanceNames[2] == "1" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar1);
            elseif EnemyChar2 and v9.InstanceNames[2] == "2" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar2);
            elseif EnemyChar3 and v9.InstanceNames[2] == "3" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar3);
            elseif EnemyChar4 and v9.InstanceNames[2] == "4" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar4);
            end;

            local CFrame2 = v.Props.CFrame;

            if CFrame2 and v9.ItemType ~= "Attachment" then
                CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                for _, v2 in CFrame2.Sequence do
                    v2.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v2.Value));
                end;
            end;
        end;
    end;

    v6:Compile();

    local function timestampToFrame(p10) -- Line: 200
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 209
        -- upvalues: Players (ref), ReplicatedStorage (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 212
            -- upvalues: Players (ref), ReplicatedStorage (ref), u15 (copy), u16 (copy), TweenService (ref), u14 (copy), Debris (ref)
            local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

            if Popup then
                Popup:Destroy();
            end;

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
            task.delay(u14, function() -- Line: 244
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

    for _, child in v4:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 265
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 271
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

    v4.Parent = workspace;
    Camera.Changed:Connect(function(p24: string) -- Line: 297
        -- upvalues: Camera (copy)
        if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p24] = Camera[p24];
    end);
    Char:SetAttribute("CutsceneChar", true);
    v6:Play();
    task.delay(5.1, function() -- Line: 315
        game.Players.LocalPlayer.PlayerGui.BunnyHareVideo.Enabled = true;
        local BunnyImpactFrames = game.Players.LocalPlayer.PlayerGui.BunnyHareVideo.BunnyImpactFrames;
        BunnyImpactFrames:Play();
        task.delay(2, function() -- Line: 319
            -- upvalues: BunnyImpactFrames (copy)
            game.Players.LocalPlayer.PlayerGui.BunnyHareVideo.Enabled = false;
            BunnyImpactFrames.Playing = false;
            BunnyImpactFrames.TimePosition = 0;
        end);
    end);
    require(script.CodeEvents)(v6);

    if game.Players.LocalPlayer.Character == Char or not game.Players.LocalPlayer.Character.Values.Goalie.Value then
        v6.Completed:Wait();
    else
        task.wait(v6:GetTimeLength() - 2);
    end;

    v6:Stop();
    u5 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    changeLighting(ReplicatedStorage2.Assets.MainLighting);
    v6:Destroy();
    v4:Destroy();

    for _, v in v7 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CFrame = CFrame;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;

    if Players.LocalPlayer.Character == EnemyChar1 then
        EnemyChar1.HumanoidRootPart.HumanoidRootPart.CFrame = p2.OriginalPos[1];
    end;

    if Players.LocalPlayer.Character == EnemyChar2 then
        EnemyChar2.HumanoidRootPart.HumanoidRootPart.CFrame = p2.OriginalPos[2];
    end;

    if Players.LocalPlayer.Character == EnemyChar3 then
        EnemyChar3.HumanoidRootPart.HumanoidRootPart.CFrame = p2.OriginalPos[3];
    end;

    if Players.LocalPlayer.Character == EnemyChar4 then
        EnemyChar4.HumanoidRootPart.HumanoidRootPart.CFrame = p2.OriginalPos[4];
    end;

    if EnemyChar1 then
        EnemyChar1:Destroy();
    end;

    if EnemyChar2 then
        EnemyChar2:Destroy();
    end;

    if EnemyChar3 then
        EnemyChar3:Destroy();
    end;

    if EnemyChar4 then
        EnemyChar4:Destroy();
    end;

    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;