  

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
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Shared.LightingStorage);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);

return function(p1) -- Line: 21
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), Players (copy), Knit (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), ReplicatedStorage2 (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("YukimiyaAwk");

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
    SoundManager.SpawnSound("YukimiyaAwk", 0.6, workspace, 150);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    Players.LocalPlayer.PlayerGui.YukimiyaVignette.Enabled = true;
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    HumanoidRootPart.Anchored = true;
    local u4 = true;
    task.spawn(function() -- Line: 62
        -- upvalues: u4 (ref), Controller (copy), Players (ref)
        while u4 do
            task.wait();

            if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;

            Controller.Cutscene = true;
            Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            workspace.CurrentCamera.FieldOfView = 55;
        end;
    end);
    local Pivot = v3:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v3:PivotTo(Pivot2);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v3;
    local v5 = Moonlite.CreatePlayer(CutsceneData, v3);
    local v6 = {};

    for _, child in v3.reekais:GetChildren() do
        local v7 = Char:FindFirstChild(child.Name);

        if v7 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v7;
                table.insert(v6, child2);
            end;
        end;
    end;

    v3.reekais:Destroy();

    if v5._moduleInfo and Char then
        for i, v in v5._moduleInfo.Compiled do
            local v8 = v.Path or i;

            if v8.InstanceNames[2] == "reekais" then
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

    local function timestampToFrame(p9) -- Line: 129
        local v10, v11 = p9:match("^(%d+):(%d+)$");

        return not (v10 and v11) and (tonumber(p9) or 0) or tonumber(v10) + tonumber(v11) / 1000;
    end;

    local function showCutsceneText(p12: string, u13: number, u14: string, u15) -- Line: 138
        -- upvalues: Players (ref), ReplicatedStorage (ref), TweenService (ref), Debris (ref)
        local v16, v17 = p12:match("^(%d+):(%d+)$");
        local v18;

        if v16 and v17 then
            v18 = tonumber(v16) + tonumber(v17) / 1000;
        else
            v18 = tonumber(p12) or 0;
        end;

        task.delay(v18, function() -- Line: 141
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
            task.delay(u13, function() -- Line: 173
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
                    task.spawn(function() -- Line: 194
                        -- upvalues: child2 (copy), RunService (ref)
                        local v21 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v21);
                        child2.ImageTransparency = 0.999;
                        local v22 = RunService.PreRender:Connect(function() -- Line: 200
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
    v3.CutsceneVFX.Cry.WeldConstraint.Part1 = Char.Head;
    Camera.Changed:Connect(function(p23: string) -- Line: 226
        -- upvalues: Camera (copy)
        if p23 ~= "CFrame" and p23 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p23] = Camera[p23];
    end);
    local v24, v25 = ("1:00"):match("^(%d+):(%d+)$");
    local v26;

    if v24 and v25 then
        v26 = tonumber(v24) + tonumber(v25) / 1000;
    else
        v26 = tonumber("1:00") or 0;
    end;

    local u27 = "Tunnel vision and blind spots when you\'re fatigued..";
    local u28 = nil;
    local u29 = 2;
    task.delay(v26, function() -- Line: 141
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
        task.delay(u29, function() -- Line: 173
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
    local v31, v32 = ("4:00"):match("^(%d+):(%d+)$");
    local v33;

    if v31 and v32 then
        v33 = tonumber(v31) + tonumber(v32) / 1000;
    else
        v33 = tonumber("4:00") or 0;
    end;

    local u34 = "It\'s..";
    local u35 = nil;
    local u36 = 1.5;
    task.delay(v33, function() -- Line: 141
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
        task.delay(u36, function() -- Line: 173
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
    local v38, v39 = ("7:50"):match("^(%d+):(%d+)$");
    local v40;

    if v38 and v39 then
        v40 = tonumber(v38) + tonumber(v39) / 1000;
    else
        v40 = tonumber("7:50") or 0;
    end;

    local u41 = "Optic Neuropathy..";
    local u42 = nil;
    local u43 = 2;
    task.delay(v40, function() -- Line: 141
        -- upvalues: Players (ref), ReplicatedStorage (ref), u41 (copy), u42 (copy), TweenService (ref), u43 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u44 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u44.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u44.Position = UDim2.new(0.5, 0, 0.8, 0);
        u44.AnchorPoint = Vector2.new(0.5, 0.5);
        u44.Size = UDim2.new(1, 0, 0.1, 0);
        u44.BackgroundTransparency = 1;
        u44.Font = Enum.Font.ArialBold;
        u44.Text = u41;
        u44.TextColor3 = u42 or Color3.new(1, 1, 1);
        u44.TextTransparency = 0;
        u44.TextStrokeTransparency = 0;
        u44.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u44;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u44, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u41
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u43, function() -- Line: 173
            -- upvalues: TweenService (ref), u44 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u44, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u44, 1);
        end);
    end);
    local v45, v46 = ("9:22"):match("^(%d+):(%d+)$");
    local v47;

    if v45 and v46 then
        v47 = tonumber(v45) + tonumber(v46) / 1000;
    else
        v47 = tonumber("9:22") or 0;
    end;

    local u48 = "Out of my way. I\'m running out of time.";
    local u49 = nil;
    local u50 = 2;
    task.delay(v47, function() -- Line: 141
        -- upvalues: Players (ref), ReplicatedStorage (ref), u48 (copy), u49 (copy), TweenService (ref), u50 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u51 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u51.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u51.Position = UDim2.new(0.5, 0, 0.8, 0);
        u51.AnchorPoint = Vector2.new(0.5, 0.5);
        u51.Size = UDim2.new(1, 0, 0.1, 0);
        u51.BackgroundTransparency = 1;
        u51.Font = Enum.Font.ArialBold;
        u51.Text = u48;
        u51.TextColor3 = u49 or Color3.new(1, 1, 1);
        u51.TextTransparency = 0;
        u51.TextStrokeTransparency = 0;
        u51.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u51;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u51, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u48
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u50, function() -- Line: 173
            -- upvalues: TweenService (ref), u51 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u51, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u51, 1);
        end);
    end);
    Char:SetAttribute("CutsceneChar", true);
    v5:Play();
    require(script.CodeEvents)(v5);
    v5.Completed:Wait();
    v5:Stop();
    u4 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
    Players.LocalPlayer.PlayerGui.YukimiyaVignette.Enabled = false;
    v5:Destroy();
    v3:Destroy();

    for _, v in v6 do
        v:Destroy();
    end;

    Camera:Destroy();
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