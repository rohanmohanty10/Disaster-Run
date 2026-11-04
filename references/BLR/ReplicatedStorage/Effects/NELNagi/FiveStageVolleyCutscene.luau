  

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
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy)
    local CutsceneData, v3 = MoonCutsceneStreamer.getCutsceneData("NEL Nagi5Stage");

    if not (CutsceneData and v3) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local u4 = v3.VFX:Clone();

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
    SoundManager.SpawnSound("FiveStageNagi", 0.6, workspace, 150);
    local EnemyChar1 = p2.EnemyChar1;
    local EnemyChar2 = p2.EnemyChar2;

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

    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 93
        -- upvalues: Char (copy), u4 (copy), u5 (ref), Controller (copy), Players (ref)
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

        local Cam = u4:FindFirstChild("Cam");

        if Cam then
            Cam:Destroy();
        end;
    end);
    local Pivot = u4:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u4:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u4;
    local v6 = Moonlite.CreatePlayer(CutsceneData, u4);
    local v7 = {};

    for _, child in u4.Neo_Hex:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    u4.Neo_Hex:Destroy();

    if EnemyChar1 then
        u4.Isagi:Destroy();
    end;

    if EnemyChar2 then
        u4.Kaizer:Destroy();
    end;

    if v6._moduleInfo and Char then
        for i, v in v6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "Neo_Hex" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif EnemyChar1 and v9.InstanceNames[2] == "Isagi" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar1);
            elseif EnemyChar2 and v9.InstanceNames[2] == "Kaizer" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar2);
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

    local function timestampToFrame(p10) -- Line: 185
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 194
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 197
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
            task.delay(u14, function() -- Line: 227
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

    for _, child in u4:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 248
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 254
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

    u4.Parent = workspace;
    local v24 = {};
    local u25 = script.ImpactFrames.FiveStage1:Clone();
    local u26 = script.ImpactFrames.FiveStage2:Clone();
    local u27 = script.ImpactFrames.FiveStage3:Clone();
    u25.Parent = Players.LocalPlayer.PlayerGui;
    u26.Parent = Players.LocalPlayer.PlayerGui;
    u27.Parent = Players.LocalPlayer.PlayerGui;
    table.insert(v24, u25);
    table.insert(v24, u26);
    table.insert(v24, u27);
    local v28 = {};

    for _, v in v24 do
        for _, child in v:GetChildren() do
            if child:IsA("ImageLabel") then
                table.insert(v28, child);
            end;
        end;
    end;

    for _, v in v28 do
        if v:IsA("ImageLabel") then
            task.spawn(function() -- Line: 303
                -- upvalues: v (copy), RunService (ref)
                local v29 = { v };
                game:GetService("ContentProvider"):PreloadAsync(v29);
                v.ImageTransparency = 0.999;
                local v30 = RunService.PreRender:Connect(function() -- Line: 309
                    -- upvalues: v (ref)
                    v.Visible = true;
                end);

                while not v.IsLoaded and v:IsDescendantOf(game) do
                    task.wait();
                end;

                v30:Disconnect();
                v.Visible = false;
                v.ImageTransparency = 0;
            end);
        end;
    end;

    local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
    local UDim2_new_ret2 = UDim2.new(2, 0, 2, 0);

    local function playFlipbook(p31, p32) -- Line: 329
        -- upvalues: UDim2_new_ret2 (copy), UDim2_new_ret (copy)
        local v33 = {};

        for _, child in p31:GetChildren() do
            if child:IsA("ImageLabel") and tonumber(child.Name) then
                table.insert(v33, child);
            end;
        end;

        table.sort(v33, function(p34, p35) -- Line: 337
            return tonumber(p34.Name) < tonumber(p35.Name);
        end);

        for _, v in v33 do
            v.Position = UDim2_new_ret2;
            v.Visible = true;
        end;

        for _, v in v33 do
            v.Position = UDim2_new_ret;
            task.wait(p32);
            v.Position = UDim2_new_ret2;
        end;
    end;

    task.delay(22.25, function() -- Line: 355
        -- upvalues: playFlipbook (copy), u25 (copy)
        playFlipbook(u25, 0.03);
    end);
    task.delay(28.75, function() -- Line: 360
        -- upvalues: playFlipbook (copy), u26 (copy)
        playFlipbook(u26, 0.08);
    end);
    task.delay(29.35, function() -- Line: 365
        -- upvalues: playFlipbook (copy), u27 (copy)
        playFlipbook(u27, 0.03);
    end);
    local Character = game.Players.LocalPlayer.Character;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p36: string) -- Line: 372
            -- upvalues: Camera (copy)
            if p36 ~= "CFrame" and p36 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p36] = Camera[p36];
        end);
    end;

    local v37, v38 = ("3:00"):match("^(%d+):(%d+)$");
    local v39;

    if v37 and v38 then
        v39 = tonumber(v37) + tonumber(v38) / 1000;
    else
        v39 = tonumber("3:00") or 0;
    end;

    local u40 = "Thank you, Isagi";
    local u41 = nil;
    local u42 = 1;
    task.delay(v39, function() -- Line: 197
        -- upvalues: ReplicatedStorage (ref), Players (ref), u40 (copy), u41 (copy), TweenService (ref), u42 (copy), Debris (ref)
        local u43 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u43.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u43.Position = UDim2.new(0.5, 0, 0.8, 0);
        u43.AnchorPoint = Vector2.new(0.5, 0.5);
        u43.Size = UDim2.new(1, 0, 0.1, 0);
        u43.BackgroundTransparency = 1;
        u43.Font = Enum.Font.ArialBold;
        u43.Text = u40;
        u43.TextColor3 = u41 or Color3.new(1, 1, 1);
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
            MaxVisibleGraphemes = #u40
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u42, function() -- Line: 227
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
    local v44, v45 = ("7:00"):match("^(%d+):(%d+)$");
    local v46;

    if v44 and v45 then
        v46 = tonumber(v44) + tonumber(v45) / 1000;
    else
        v46 = tonumber("7:00") or 0;
    end;

    local u47 = "Faint";
    local u48 = nil;
    local u49 = 0.5;
    task.delay(v46, function() -- Line: 197
        -- upvalues: ReplicatedStorage (ref), Players (ref), u47 (copy), u48 (copy), TweenService (ref), u49 (copy), Debris (ref)
        local u50 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u50.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u50.Position = UDim2.new(0.5, 0, 0.8, 0);
        u50.AnchorPoint = Vector2.new(0.5, 0.5);
        u50.Size = UDim2.new(1, 0, 0.1, 0);
        u50.BackgroundTransparency = 1;
        u50.Font = Enum.Font.ArialBold;
        u50.Text = u47;
        u50.TextColor3 = u48 or Color3.new(1, 1, 1);
        u50.TextTransparency = 0;
        u50.TextStrokeTransparency = 0;
        u50.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u50;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u50, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u47
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u49, function() -- Line: 227
            -- upvalues: TweenService (ref), u50 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u50, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u50, 1);
        end);
    end);
    local v51, v52 = ("8:00"):match("^(%d+):(%d+)$");
    local v53;

    if v51 and v52 then
        v53 = tonumber(v51) + tonumber(v52) / 1000;
    else
        v53 = tonumber("8:00") or 0;
    end;

    local u54 = "Volley!";
    local u55 = nil;
    local u56 = 0.5;
    task.delay(v53, function() -- Line: 197
        -- upvalues: ReplicatedStorage (ref), Players (ref), u54 (copy), u55 (copy), TweenService (ref), u56 (copy), Debris (ref)
        local u57 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u57.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u57.Position = UDim2.new(0.5, 0, 0.8, 0);
        u57.AnchorPoint = Vector2.new(0.5, 0.5);
        u57.Size = UDim2.new(1, 0, 0.1, 0);
        u57.BackgroundTransparency = 1;
        u57.Font = Enum.Font.ArialBold;
        u57.Text = u54;
        u57.TextColor3 = u55 or Color3.new(1, 1, 1);
        u57.TextTransparency = 0;
        u57.TextStrokeTransparency = 0;
        u57.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u57;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u57, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u54
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u56, function() -- Line: 227
            -- upvalues: TweenService (ref), u57 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u57, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u57, 1);
        end);
    end);
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
    u4:Destroy();

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

    if EnemyChar1 then
        EnemyChar1:Destroy();
    end;

    if EnemyChar2 then
        EnemyChar2:Destroy();
    end;

    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;