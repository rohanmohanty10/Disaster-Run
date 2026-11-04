  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local TweenService2 = game:GetService("TweenService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage2.Shared.LightingStorage);
require(ReplicatedStorage2.Modules.CutsceneUtils);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

return function(p1) -- Line: 23
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), TweenService2 (copy), ReplicatedStorage2 (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("ShidouAwakening");

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
    local Shidou = Char:FindFirstChild("Shidou");

    if Shidou:IsA("Sound") then
        Shidou.Volume = 0;
    end;

    local u4 = SoundManager.SpawnSound("ShidouAwkCutsceneNew", 0.6, workspace, 150);
    u4.TimePosition = 2.5;
    task.delay(14, function() -- Line: 55
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 63
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
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v3;
    local v6 = Moonlite.CreatePlayer(CutsceneData, v3);
    local v7 = {};

    for _, child in v3.reekais:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    v3.reekais:Destroy();

    if v6._moduleInfo and Char then
        for i, v in v6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "reekais" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame2 = v.Props.CFrame;

            if CFrame2 and v9.ItemType ~= "Attachment" then
                CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                for _, v4 in CFrame2.Sequence do
                    v4.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v4.Value));
                end;
            end;
        end;
    end;

    v6:Compile();

    local function timestampToFrame(p10) -- Line: 131
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 140
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 143
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
            task.delay(u14, function() -- Line: 173
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

    for _, child in v3:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 194
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 200
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

    v3.Parent = workspace;
    Camera.Changed:Connect(function(p24: string) -- Line: 224
        -- upvalues: Camera (copy)
        if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p24] = Camera[p24];
    end);
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Parent = workspace;

    for _, v in Players:GetPlayers() do
        if v.Character ~= Char then
            v.Character.Parent = ViewportFrame;
        end;
    end;

    local v25 = v3["BL:R Rig Pack"].CameraRig.AnimationController:LoadAnimation(script.Camera);
    v25:Play();
    v25.TimePosition = 1.5;
    local v26, v27 = ("3:00"):match("^(%d+):(%d+)$");
    local v28;

    if v26 and v27 then
        v28 = tonumber(v26) + tonumber(v27) / 1000;
    else
        v28 = tonumber("3:00") or 0;
    end;

    local u29 = "GET ME OUT OF HERE!";
    local u30 = nil;
    local u31 = 1;
    task.delay(v28, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u29 (copy), u30 (copy), TweenService (ref), u31 (copy), Debris (ref)
        local u32 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u32.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u32.Position = UDim2.new(0.5, 0, 0.8, 0);
        u32.AnchorPoint = Vector2.new(0.5, 0.5);
        u32.Size = UDim2.new(1, 0, 0.1, 0);
        u32.BackgroundTransparency = 1;
        u32.Font = Enum.Font.ArialBold;
        u32.Text = u29;
        u32.TextColor3 = u30 or Color3.new(1, 1, 1);
        u32.TextTransparency = 0;
        u32.TextStrokeTransparency = 0;
        u32.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u32;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u32, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u29
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u31, function() -- Line: 173
            -- upvalues: TweenService (ref), u32 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u32, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u32, 1);
        end);
    end);
    local v33, v34 = ("7:00"):match("^(%d+):(%d+)$");
    local v35;

    if v33 and v34 then
        v35 = tonumber(v33) + tonumber(v34) / 1000;
    else
        v35 = tonumber("7:00") or 0;
    end;

    local u36 = "What\'s up devil boy.";
    local u37 = nil;
    local u38 = 1;
    task.delay(v35, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u36 (copy), u37 (copy), TweenService (ref), u38 (copy), Debris (ref)
        local u39 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u39.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u39.Position = UDim2.new(0.5, 0, 0.8, 0);
        u39.AnchorPoint = Vector2.new(0.5, 0.5);
        u39.Size = UDim2.new(1, 0, 0.1, 0);
        u39.BackgroundTransparency = 1;
        u39.Font = Enum.Font.ArialBold;
        u39.Text = u36;
        u39.TextColor3 = u37 or Color3.new(1, 1, 1);
        u39.TextTransparency = 0;
        u39.TextStrokeTransparency = 0;
        u39.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u39;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u39, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u36
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u38, function() -- Line: 173
            -- upvalues: TweenService (ref), u39 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u39, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u39, 1);
        end);
    end);
    local v40, v41 = ("11:00"):match("^(%d+):(%d+)$");
    local v42;

    if v40 and v41 then
        v42 = tonumber(v40) + tonumber(v41) / 1000;
    else
        v42 = tonumber("11:00") or 0;
    end;

    local u43 = "I want your ego.";
    local u44 = nil;
    local u45 = 1;
    task.delay(v42, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u43 (copy), u44 (copy), TweenService (ref), u45 (copy), Debris (ref)
        local u46 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u46.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u46.Position = UDim2.new(0.5, 0, 0.8, 0);
        u46.AnchorPoint = Vector2.new(0.5, 0.5);
        u46.Size = UDim2.new(1, 0, 0.1, 0);
        u46.BackgroundTransparency = 1;
        u46.Font = Enum.Font.ArialBold;
        u46.Text = u43;
        u46.TextColor3 = u44 or Color3.new(1, 1, 1);
        u46.TextTransparency = 0;
        u46.TextStrokeTransparency = 0;
        u46.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u46;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u46, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u43
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u45, function() -- Line: 173
            -- upvalues: TweenService (ref), u46 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u46, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u46, 1);
        end);
    end);
    Char:SetAttribute("CutsceneChar", true);
    local Brightness = game.Lighting.Brightness;
    game.Lighting.Brightness = 0.5;
    local u47 = script.ScreenGui:Clone();
    u47.Parent = Players.LocalPlayer.PlayerGui;
    u47.Fade.BackgroundTransparency = 0;
    TweenService2:Create(u47.Fade, TweenInfo.new(5), {
        BackgroundTransparency = 1
    }):Play();
    v6:Play();
    v6.TimePosition = 1.5;
    task.delay(v6:GetTimeLength() - 3.5, function() -- Line: 264
        -- upvalues: TweenService2 (ref), u47 (copy), Debris (ref)
        print("anotha one");
        TweenService2:Create(u47.Fade, TweenInfo.new(2), {
            BackgroundTransparency = 0
        }):Play();
        Debris:AddItem(u47, 3);
    end);
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
    v3:Destroy();

    for _, v in v7 do
        v:Destroy();
    end;

    Camera:Destroy();
    game.Lighting.Brightness = Brightness;

    for _, v in Players:GetPlayers() do
        v.Character.Parent = ReplicatedStorage2;
        v.Character.Parent = workspace;
    end;

    if Shidou:IsA("Sound") then
        TweenService2:Create(Shidou, TweenInfo.new(1), {
            Volume = 0.5
        }):Play();
    end;

    ViewportFrame:Destroy();
    workspace.CurrentCamera.CFrame = CFrame;
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