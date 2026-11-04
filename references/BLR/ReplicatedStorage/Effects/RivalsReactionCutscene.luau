  

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
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage2.Shared.LightingStorage);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

local function changeLighting(p1) -- Line: 21
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

return function(p2) -- Line: 36
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), changeLighting (copy), ReplicatedStorage2 (copy)
    print("Rivals Cutscene");
    local CutsceneData, v3 = MoonCutsceneStreamer.getCutsceneData("RivalsReaction");

    if not (CutsceneData and v3) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local u4 = v3.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Isagi = p2.Isagi;

    if not Isagi then
        return;
    end;

    local HumanoidRootPart = Isagi:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Humanoid = Isagi:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 68
        -- upvalues: u5 (ref), Controller (copy), Players (ref)
        while u5 do
            task.wait();

            if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;

            Controller.Cutscene = true;
            Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            workspace.CurrentCamera.FieldOfView = 30;
        end;
    end);
    local Pivot = u4:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u4:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local u6 = {};
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u4;
    local u7 = Moonlite.CreatePlayer(CutsceneData, u4);

    local function replaceChar(p8, p9) -- Line: 98
        -- upvalues: u4 (copy), u6 (copy), u7 (copy), Moonlite (ref), Pivot2 (copy), Pivot (copy)
        if not u4:FindFirstChild(p8) then
            warn("Could not find " .. p8 .. " in vfx model");

            return;
        end;

        for _, child in u4[p8]:GetChildren() do
            local v10 = p9:FindFirstChild(child.Name);

            if v10 then
                for _, child2 in child:GetChildren() do
                    child2.Parent = v10;
                    table.insert(u6, child2);
                end;
            end;
        end;

        u4[p8]:Destroy();

        if u7._moduleInfo and p9 then
            for i, v in u7._moduleInfo.Compiled do
                local v11 = v.Path or i;

                if v11.InstanceNames[2] == p8 then
                    local table_clone_ret = table.clone(v11);
                    table.remove(table_clone_ret.InstanceNames, 2);
                    table.remove(table_clone_ret.InstanceTypes, 2);
                    v.Override = Moonlite.resolveAnimPath(table_clone_ret, p9);
                end;

                local CFrame2 = v.Props.CFrame;

                if CFrame2 and v11.ItemType ~= "Attachment" then
                    CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                    for _, v2 in CFrame2.Sequence do
                        v2.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v2.Value));
                    end;
                end;
            end;
        end;
    end;

    replaceChar("Isagi", Isagi);
    p2.Rin.HumanoidRootPart.CFrame = u4.Rin.HumanoidRootPart.CFrame;
    replaceChar("Rin", p2.Rin);
    u7:Compile();

    local function timestampToFrame(p12) -- Line: 148
        local v13, v14 = p12:match("^(%d+):(%d+)$");

        return not (v13 and v14) and (tonumber(p12) or 0) or tonumber(v13) + tonumber(v14) / 1000;
    end;

    local function showCutsceneText(p15: string, u16: number, u17: string, u18) -- Line: 157
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v19, v20 = p15:match("^(%d+):(%d+)$");
        local v21;

        if v19 and v20 then
            v21 = tonumber(v19) + tonumber(v20) / 1000;
        else
            v21 = tonumber(p15) or 0;
        end;

        task.delay(v21, function() -- Line: 160
            -- upvalues: ReplicatedStorage (ref), Players (ref), u17 (copy), u18 (copy), TweenService (ref), u16 (copy), Debris (ref)
            local u22 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u22.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u22.Position = UDim2.new(0.5, 0, 0.8, 0);
            u22.AnchorPoint = Vector2.new(0.5, 0.5);
            u22.Size = UDim2.new(1, 0, 0.1, 0);
            u22.BackgroundTransparency = 1;
            u22.Font = Enum.Font.ArialBold;
            u22.Text = u17;
            u22.TextColor3 = u18 or Color3.new(1, 1, 1);
            u22.TextTransparency = 0;
            u22.TextStrokeTransparency = 0;
            u22.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u22;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u22, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u17
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u16, function() -- Line: 190
                -- upvalues: TweenService (ref), u22 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u22, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u22, 1);
            end);
        end);
    end;

    for _, child in u4:GetChildren() do
        local v23;

        if child:IsA("LayerCollector") then
            v23 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 211
                        -- upvalues: child2 (copy), RunService (ref)
                        local v24 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v24);
                        child2.ImageTransparency = 0.999;
                        local v25 = RunService.PreRender:Connect(function() -- Line: 217
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v25:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v23.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v23 = child;
        else
            v23 = child;
        end;

        table.insert(u6, v23);
    end;

    u4.Parent = workspace;
    Camera.Changed:Connect(function(p26: string) -- Line: 243
        -- upvalues: Camera (copy)
        if p26 ~= "CFrame" and p26 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p26] = Camera[p26];
    end);
    local v27, v28 = ("3:09"):match("^(%d+):(%d+)$");
    local v29;

    if v27 and v28 then
        v29 = tonumber(v27) + tonumber(v28) / 1000;
    else
        v29 = tonumber("3:09") or 0;
    end;

    local u30 = "You\'ve been wanting me, right?";
    local u31 = nil;
    local u32 = 1;
    task.delay(v29, function() -- Line: 160
        -- upvalues: ReplicatedStorage (ref), Players (ref), u30 (copy), u31 (copy), TweenService (ref), u32 (copy), Debris (ref)
        local u33 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u33.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u33.Position = UDim2.new(0.5, 0, 0.8, 0);
        u33.AnchorPoint = Vector2.new(0.5, 0.5);
        u33.Size = UDim2.new(1, 0, 0.1, 0);
        u33.BackgroundTransparency = 1;
        u33.Font = Enum.Font.ArialBold;
        u33.Text = u30;
        u33.TextColor3 = u31 or Color3.new(1, 1, 1);
        u33.TextTransparency = 0;
        u33.TextStrokeTransparency = 0;
        u33.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u33;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u33, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u30
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u32, function() -- Line: 190
            -- upvalues: TweenService (ref), u33 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u33, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u33, 1);
        end);
    end);
    local v34, v35 = ("4:70"):match("^(%d+):(%d+)$");
    local v36;

    if v34 and v35 then
        v36 = tonumber(v34) + tonumber(v35) / 1000;
    else
        v36 = tonumber("4:70") or 0;
    end;

    local u37 = "IF YOU\'RE A GENIUS MONSTER...";
    local u38 = nil;
    local u39 = 1;
    task.delay(v36, function() -- Line: 160
        -- upvalues: ReplicatedStorage (ref), Players (ref), u37 (copy), u38 (copy), TweenService (ref), u39 (copy), Debris (ref)
        local u40 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u40.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u40.Position = UDim2.new(0.5, 0, 0.8, 0);
        u40.AnchorPoint = Vector2.new(0.5, 0.5);
        u40.Size = UDim2.new(1, 0, 0.1, 0);
        u40.BackgroundTransparency = 1;
        u40.Font = Enum.Font.ArialBold;
        u40.Text = u37;
        u40.TextColor3 = u38 or Color3.new(1, 1, 1);
        u40.TextTransparency = 0;
        u40.TextStrokeTransparency = 0;
        u40.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u40;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u40, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u37
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u39, function() -- Line: 190
            -- upvalues: TweenService (ref), u40 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u40, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u40, 1);
        end);
    end);
    local v41, v42 = ("6:21"):match("^(%d+):(%d+)$");
    local v43;

    if v41 and v42 then
        v43 = tonumber(v41) + tonumber(v42) / 1000;
    else
        v43 = tonumber("6:21") or 0;
    end;

    local u44 = "THEN I\'LL BE A TALENTED LEARNER MONSTER!";
    local u45 = nil;
    local u46 = 1;
    task.delay(v43, function() -- Line: 160
        -- upvalues: ReplicatedStorage (ref), Players (ref), u44 (copy), u45 (copy), TweenService (ref), u46 (copy), Debris (ref)
        local u47 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u47.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u47.Position = UDim2.new(0.5, 0, 0.8, 0);
        u47.AnchorPoint = Vector2.new(0.5, 0.5);
        u47.Size = UDim2.new(1, 0, 0.1, 0);
        u47.BackgroundTransparency = 1;
        u47.Font = Enum.Font.ArialBold;
        u47.Text = u44;
        u47.TextColor3 = u45 or Color3.new(1, 1, 1);
        u47.TextTransparency = 0;
        u47.TextStrokeTransparency = 0;
        u47.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u47;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u47, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u44
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u46, function() -- Line: 190
            -- upvalues: TweenService (ref), u47 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u47, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u47, 1);
        end);
    end);
    local v48, v49 = ("7:45"):match("^(%d+):(%d+)$");
    local v50;

    if v48 and v49 then
        v50 = tonumber(v48) + tonumber(v49) / 1000;
    else
        v50 = tonumber("7:45") or 0;
    end;

    local u51 = "THAT\'S NOT ENOUGH FOR A FREAK LIKE YOU, RIGHT?";
    local u52 = nil;
    local u53 = 2;
    task.delay(v50, function() -- Line: 160
        -- upvalues: ReplicatedStorage (ref), Players (ref), u51 (copy), u52 (copy), TweenService (ref), u53 (copy), Debris (ref)
        local u54 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u54.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u54.Position = UDim2.new(0.5, 0, 0.8, 0);
        u54.AnchorPoint = Vector2.new(0.5, 0.5);
        u54.Size = UDim2.new(1, 0, 0.1, 0);
        u54.BackgroundTransparency = 1;
        u54.Font = Enum.Font.ArialBold;
        u54.Text = u51;
        u54.TextColor3 = u52 or Color3.new(1, 1, 1);
        u54.TextTransparency = 0;
        u54.TextStrokeTransparency = 0;
        u54.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u54;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u54, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u51
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u53, function() -- Line: 190
            -- upvalues: TweenService (ref), u54 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u54, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u54, 1);
        end);
    end);
    Isagi:SetAttribute("CutsceneChar", true);
    changeLighting(script.LightingConfig);
    u7:Play();
    require(script.CodeEvents)(u7);
    u7.Completed:Wait();
    u7:Stop();
    u5 = false;
    task.wait();
    u7:Destroy();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    u4:Destroy();

    for _, v in u6 do
        v:Destroy();
    end;

    changeLighting(ReplicatedStorage2.Assets.MainLighting);
    Camera:Destroy();
    workspace.CurrentCamera.CFrame = CFrame;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    Isagi:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;