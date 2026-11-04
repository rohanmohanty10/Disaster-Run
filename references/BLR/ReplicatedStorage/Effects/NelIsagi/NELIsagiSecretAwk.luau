  

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
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

return function(p1) -- Line: 21
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("NEL IsagiFinestClown");

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
    SoundManager.SpawnSound("IsagiSecretAwk", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u4 = true;
    task.spawn(function() -- Line: 52
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
    local Pivot = u3:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u3:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u3;
    local v5 = Moonlite.CreatePlayer(CutsceneData, u3);
    local v6 = script.Shirt:Clone();
    local v7 = script.Pants:Clone();
    v6.Parent = u3.Kaiser;
    v7.Parent = u3.Kaiser;
    local v8 = {};

    for _, child in u3.Isagi:GetChildren() do
        local v9 = Char:FindFirstChild(child.Name);

        if v9 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v9;
                table.insert(v8, child2);
            end;
        end;
    end;

    u3.Isagi:Destroy();

    if v5._moduleInfo and Char then
        for i, v in v5._moduleInfo.Compiled do
            local v10 = v.Path or i;

            if v10.InstanceNames[2] == "Isagi" then
                local table_clone_ret = table.clone(v10);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame2 = v.Props.CFrame;

            if CFrame2 and v10.ItemType ~= "Attachment" then
                CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                for _, v3 in CFrame2.Sequence do
                    v3.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v3.Value));
                end;
            end;
        end;
    end;

    v5:Compile();

    local function timestampToFrame(p11) -- Line: 135
        local v12, v13 = p11:match("^(%d+):(%d+)$");

        return not (v12 and v13) and (tonumber(p11) or 0) or tonumber(v12) + tonumber(v13) / 1000;
    end;

    local function showCutsceneText(p14: string, u15: number, u16: string, u17) -- Line: 144
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v18, v19 = p14:match("^(%d+):(%d+)$");
        local v20;

        if v18 and v19 then
            v20 = tonumber(v18) + tonumber(v19) / 1000;
        else
            v20 = tonumber(p14) or 0;
        end;

        task.delay(v20, function() -- Line: 147
            -- upvalues: ReplicatedStorage (ref), Players (ref), u16 (copy), u17 (copy), TweenService (ref), u15 (copy), Debris (ref)
            local u21 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u21.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u21.Position = UDim2.new(0.5, 0, 0.8, 0);
            u21.AnchorPoint = Vector2.new(0.5, 0.5);
            u21.Size = UDim2.new(1, 0, 0.1, 0);
            u21.BackgroundTransparency = 1;
            u21.Font = Enum.Font.ArialBold;
            u21.Text = u16;
            u21.TextColor3 = u17 or Color3.new(1, 1, 1);
            u21.TextTransparency = 0;
            u21.TextStrokeTransparency = 0;
            u21.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u21;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u21, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u16
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u15, function() -- Line: 177
                -- upvalues: TweenService (ref), u21 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u21, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u21, 1);
            end);
        end);
    end;

    for _, child in u3:GetChildren() do
        local v22;

        if child:IsA("LayerCollector") then
            v22 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 198
                        -- upvalues: child2 (copy), RunService (ref)
                        local v23 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v23);
                        child2.ImageTransparency = 0.999;
                        local v24 = RunService.PreRender:Connect(function() -- Line: 204
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v24:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v22.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v22 = child;
        else
            v22 = child;
        end;

        table.insert(v8, v22);
    end;

    u3.Parent = workspace;
    local Character = game.Players.LocalPlayer.Character;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p25: string) -- Line: 230
            -- upvalues: Camera (copy)
            if p25 ~= "CFrame" and p25 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p25] = Camera[p25];
        end);
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(0, 13, 255);
    local v26, v27 = ("1:8"):match("^(%d+):(%d+)$");
    local v28;

    if v26 and v27 then
        v28 = tonumber(v26) + tonumber(v27) / 1000;
    else
        v28 = tonumber("1:8") or 0;
    end;

    local u29 = "He... Devoured us";
    local u30 = 1;
    task.delay(v28, function() -- Line: 147
        -- upvalues: ReplicatedStorage (ref), Players (ref), u29 (copy), Color3_fromRGB_ret (copy), TweenService (ref), u30 (copy), Debris (ref)
        local u31 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u31.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u31.Position = UDim2.new(0.5, 0, 0.8, 0);
        u31.AnchorPoint = Vector2.new(0.5, 0.5);
        u31.Size = UDim2.new(1, 0, 0.1, 0);
        u31.BackgroundTransparency = 1;
        u31.Font = Enum.Font.ArialBold;
        u31.Text = u29;
        u31.TextColor3 = Color3_fromRGB_ret or Color3.new(1, 1, 1);
        u31.TextTransparency = 0;
        u31.TextStrokeTransparency = 0;
        u31.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u31;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u31, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u29
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u30, function() -- Line: 177
            -- upvalues: TweenService (ref), u31 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u31, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u31, 1);
        end);
    end);
    local Color3_fromRGB_ret2 = Color3.fromRGB(0, 255, 51);
    local v32, v33 = ("4:00"):match("^(%d+):(%d+)$");
    local v34;

    if v32 and v33 then
        v34 = tonumber(v32) + tonumber(v33) / 1000;
    else
        v34 = tonumber("4:00") or 0;
    end;

    local u35 = "Hey Kaiser...";
    local u36 = 3;
    task.delay(v34, function() -- Line: 147
        -- upvalues: ReplicatedStorage (ref), Players (ref), u35 (copy), Color3_fromRGB_ret2 (copy), TweenService (ref), u36 (copy), Debris (ref)
        local u37 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u37.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u37.Position = UDim2.new(0.5, 0, 0.8, 0);
        u37.AnchorPoint = Vector2.new(0.5, 0.5);
        u37.Size = UDim2.new(1, 0, 0.1, 0);
        u37.BackgroundTransparency = 1;
        u37.Font = Enum.Font.ArialBold;
        u37.Text = u35;
        u37.TextColor3 = Color3_fromRGB_ret2 or Color3.new(1, 1, 1);
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
            MaxVisibleGraphemes = #u35
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u36, function() -- Line: 177
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
    local Color3_fromRGB_ret3 = Color3.fromRGB(0, 255, 51);
    local v38, v39 = ("8:50"):match("^(%d+):(%d+)$");
    local v40;

    if v38 and v39 then
        v40 = tonumber(v38) + tonumber(v39) / 1000;
    else
        v40 = tonumber("8:50") or 0;
    end;

    local u41 = "Thanks for all your hard work,";
    local u42 = 0.8;
    task.delay(v40, function() -- Line: 147
        -- upvalues: ReplicatedStorage (ref), Players (ref), u41 (copy), Color3_fromRGB_ret3 (copy), TweenService (ref), u42 (copy), Debris (ref)
        local u43 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u43.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u43.Position = UDim2.new(0.5, 0, 0.8, 0);
        u43.AnchorPoint = Vector2.new(0.5, 0.5);
        u43.Size = UDim2.new(1, 0, 0.1, 0);
        u43.BackgroundTransparency = 1;
        u43.Font = Enum.Font.ArialBold;
        u43.Text = u41;
        u43.TextColor3 = Color3_fromRGB_ret3 or Color3.new(1, 1, 1);
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
        task.delay(u42, function() -- Line: 177
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
    local Color3_fromRGB_ret4 = Color3.fromRGB(0, 255, 51);
    local v44, v45 = ("9:65"):match("^(%d+):(%d+)$");
    local v46;

    if v44 and v45 then
        v46 = tonumber(v44) + tonumber(v45) / 1000;
    else
        v46 = tonumber("9:65") or 0;
    end;

    local u47 = "My Finest Clown";
    local u48 = 1.2;
    task.delay(v46, function() -- Line: 147
        -- upvalues: ReplicatedStorage (ref), Players (ref), u47 (copy), Color3_fromRGB_ret4 (copy), TweenService (ref), u48 (copy), Debris (ref)
        local u49 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u49.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u49.Position = UDim2.new(0.5, 0, 0.8, 0);
        u49.AnchorPoint = Vector2.new(0.5, 0.5);
        u49.Size = UDim2.new(1, 0, 0.1, 0);
        u49.BackgroundTransparency = 1;
        u49.Font = Enum.Font.ArialBold;
        u49.Text = u47;
        u49.TextColor3 = Color3_fromRGB_ret4 or Color3.new(1, 1, 1);
        u49.TextTransparency = 0;
        u49.TextStrokeTransparency = 0;
        u49.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u49;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u49, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u47
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u48, function() -- Line: 177
            -- upvalues: TweenService (ref), u49 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u49, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u49, 1);
        end);
    end);
    Char:SetAttribute("CutsceneChar", true);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
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

    v5:Destroy();
    u3:Destroy();

    for _, v in v8 do
        v:Destroy();
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
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