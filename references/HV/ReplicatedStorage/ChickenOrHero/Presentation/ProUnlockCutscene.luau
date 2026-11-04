 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local script_Parent = script.Parent;
local CutsceneScreen = require(script_Parent:WaitForChild("CutsceneScreen"));
local CreatorVisibility = require(script_Parent:WaitForChild("CreatorVisibility"));
local LocalHide = require(script_Parent:WaitForChild("LocalHide"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local u1 = {
    LockBody = true,
    LockFace = true,
    Keyhole = true
};

local function sound(p2, p3, p4, p5, p6) -- Line: 32
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p2);
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p3);
    end;

    if not (GameAudio and GameAudio:IsA("Sound")) then
        return;
    end;

    local v7 = GameAudio:Clone();
    v7.Volume = p4;
    v7.PlaybackSpeed = p5 or 1;
    v7.Looped = false;
    v7.Parent = p6;
    v7:Play();
end;

local function asset(p8, p9, p10) -- Line: 48
    -- upvalues: SoundService (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p8;
    Sound.Volume = p9;
    Sound.Parent = SoundService;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 54
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    table.insert(p10, Sound);
end;

local function make(p11, p12, p13) -- Line: 59
    local Instance_new_ret = Instance.new(p11);

    for i, v in p13 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p12;

    return Instance_new_ret;
end;

local function tween(p14, p15, p16, p17, p18) -- Line: 67
    -- upvalues: TweenService (copy)
    local v19 = TweenService:Create(p14, TweenInfo.new(p15, p17 or Enum.EasingStyle.Sine, p18 or Enum.EasingDirection.Out), p16);
    v19:Play();

    return v19;
end;

local function stage(p20, p21) -- Line: 74
    local v22 = p20:Clone();
    local v23 = {};

    for _, descendant in v22:GetDescendants() do
        local Attribute = descendant:GetAttribute("ProEffectOn");

        if Attribute ~= nil then
            descendant.Enabled = Attribute;
        end;

        if descendant:IsA("BillboardGui") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.LocalTransparencyModifier = 0;
            v23[descendant.Name] = descendant;
        end;
    end;

    for _, descendant in p20:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 1;
        end;
    end;

    if not p21 then
        v22.Parent = workspace;
    end;

    return v22, v23;
end;

local function grounded(p24) -- Line: 103
    local BoundingBox, v25 = p24:GetBoundingBox();
    p24.WorldPivot = CFrame.new(BoundingBox.Position - Vector3.new(0, v25.Y / 2, 0));
end;

local function burst(p26, p27, p28, p29) -- Line: 107
    local v30 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        Drag = 3,
        Rate = 0,
        Color = ColorSequence.new(p27),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0) }),
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }),
        Lifetime = NumberRange.new(0.6, 1.1),
        Speed = NumberRange.new(p29 * 0.5, p29),
        SpreadAngle = Vector2.new(180, 180)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in v30 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = p26;
    ParticleEmitter:Emit(p28);
end;

return {
    play = function(p31, u32) -- Line: 125, Name: play
        -- upvalues: LocalPlayer (copy), LocalHide (copy), CutsceneScreen (copy), Color3_fromRGB_ret (copy), CreatorVisibility (copy), stage (copy), TweenService (copy), RunService (copy), sound (copy), asset (copy), u1 (copy), burst (copy)
        local Base = p31:FindFirstChild("Base");
        local Podium = p31:FindFirstChild("Podium");
        local Star = p31:FindFirstChild("Star");
        local SmallPodium = p31:FindFirstChild("SmallPodium");
        local v33 = SmallPodium and SmallPodium:FindFirstChild("Lock") or p31:FindFirstChild("Lock");
        local Character = LocalPlayer.Character;

        if not (Base and (v33 and Character)) then
            u32();

            return;
        end;

        local Position = v33:GetBoundingBox().Position;
        local v34 = Base.CFrame.LookVector * Vector3.new(1, 0, 1);
        local u35 = v34.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v34.Unit;
        local u36 = u35:Cross(Vector3.new(0, 1, 0));
        local u37;

        if Podium then
            u37 = Podium:GetBoundingBox().Position;
        else
            u37 = Position + Vector3.new(0, 4, 0);
        end;

        local function look(p38, p39, p40, p41, p42) -- Line: 142
            -- upvalues: u36 (copy), u35 (ref)
            return CFrame.lookAt(p38 + u36 * p39 + u35 * p40 + Vector3.new(0, 1, 0) * p41, p42);
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        local u43 = { workspace_CurrentCamera.CameraType, workspace_CurrentCamera.FieldOfView };
        local u44 = false;
        local u45 = false;
        local u46 = LocalHide.new();
        local BindableEvent = Instance.new("BindableEvent");
        LocalPlayer:SetAttribute("ProUnlockActive", true);

        local function open() -- Line: 155
            -- upvalues: u45 (ref), u32 (copy)
            if not u45 then
                u45 = true;
                u32();
            end;
        end;

        local ProUnlock = CutsceneScreen.new("ProUnlock", 125);
        ProUnlock:SetAttribute("CreatorCaptureExempt", true);
        ProUnlock:SetAttribute("SelfManagedText", true);
        local u47 = {};
        local u48 = {};
        local u49 = nil;
        local u50 = {};
        local u51 = {};
        local u52 = nil;

        for _, v in { "Top", "Bottom" } do
            local v53 = {
                BorderSizePixel = 0,
                ZIndex = 2,
                Name = v,
                AnchorPoint = Vector2.new(0.5, v == "Top" and 0 or 1),
                Position = UDim2.fromScale(0.5, v == "Top" and 0 or 1),
                Size = UDim2.fromScale(1.5, 0),
                BackgroundColor3 = Color3.new(0, 0, 0)
            };
            local Frame = Instance.new("Frame");

            for i, v2 in v53 do
                Frame[i] = v2;
            end;

            Frame.Parent = ProUnlock;
            u47[v] = Frame;
        end;

        local v54 = {
            Name = "Flash",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1.5, 1.5),
            BackgroundColor3 = Color3.fromRGB(255, 240, 200)
        };
        local Frame = Instance.new("Frame");

        for i, v in v54 do
            Frame[i] = v;
        end;

        Frame.Parent = ProUnlock;

        local function text(p55, p56, p57, p58, p59, p60, p61) -- Line: 188
            -- upvalues: ProUnlock (copy)
            local v62 = {
                BackgroundTransparency = 1,
                TextScaled = true,
                TextTransparency = 1,
                ZIndex = 3,
                Name = p55,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, p57),
                Size = UDim2.fromScale(0.86, p58),
                Font = p61,
                Text = p56,
                TextColor3 = p59
            };
            local TextLabel = Instance.new("TextLabel");

            for i, v in v62 do
                TextLabel[i] = v;
            end;

            TextLabel.Parent = ProUnlock;
            local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

            for i, v in {
                MaxTextSize = p60
            } do
                UITextSizeConstraint[i] = v;
            end;

            UITextSizeConstraint.Parent = TextLabel;
            local v63 = {
                Thickness = 3,
                Transparency = 1,
                Color = Color3.new(0, 0, 0)
            };
            local UIStroke = Instance.new("UIStroke");

            for i, v in v63 do
                UIStroke[i] = v;
            end;

            UIStroke.Parent = TextLabel;

            return TextLabel;
        end;

        local u64 = text("Title", "PRO SERVERS UNLOCKED", 0.73, 0.085, Color3_fromRGB_ret, 72, Enum.Font.GothamBlack);
        local UIScale = Instance.new("UIScale");

        for i, v in {
            Scale = 1.35
        } do
            UIScale[i] = v;
        end;

        UIScale.Parent = u64;
        local u65 = text("Subtitle", "LEVEL 25 REACHED  ·  OPEN THE STAND IN THE LOBBY", 0.8, 0.034, Color3.new(1, 1, 1), 26, Enum.Font.GothamBold);
        local Bottom = u47.Bottom;
        local v66 = {
            Name = "Skip",
            BackgroundTransparency = 1,
            Text = "SKIP",
            TextScaled = true,
            ZIndex = 3,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(0.8333333333333334, -20, 0.5, 0),
            Size = UDim2.new(0, 90, 0.4, 0),
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(190, 190, 196),
            TextXAlignment = Enum.TextXAlignment.Right
        };
        local TextButton = Instance.new("TextButton");

        for i, v in v66 do
            TextButton[i] = v;
        end;

        TextButton.Parent = Bottom;
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

        for i, v in {
            MaxTextSize = 16
        } do
            UITextSizeConstraint[i] = v;
        end;

        UITextSizeConstraint.Parent = TextButton;
        ProUnlock.Parent = LocalPlayer:WaitForChild("PlayerGui");
        local u67 = {};

        for _, descendant in p31:GetDescendants() do
            if descendant:IsA("BillboardGui") then
                descendant:SetAttribute("CreatorCaptureExempt", true);
                table.insert(u67, descendant);
            end;
        end;

        if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
            u52 = CreatorVisibility.new(LocalPlayer);
            u52:setHidden(true);
        end;

        u46:sweep();
        u46:model(Character);
        local success, result = pcall(function() -- Line: 240
            -- upvalues: LocalPlayer (ref)
            return require(LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("PlayerModule")):GetControls();
        end);

        if success and result then
            u49 = result;
            pcall(u49.Disable, u49);
        end;

        local u68 = {};
        local u69 = nil;
        local u70;

        if SmallPodium and v33:IsDescendantOf(SmallPodium) then
            local v71, v72 = stage(SmallPodium);
            u69 = v71;
            local v73 = v72;
            table.insert(u68, u69);
            local v74 = u69;
            local BoundingBox, v75 = v74:GetBoundingBox();
            v74.WorldPivot = CFrame.new(BoundingBox.Position - Vector3.new(0, v75.Y / 2, 0));
            u70 = {};

            for _, descendant in v33:GetDescendants() do
                if descendant:IsA("BasePart") and v73[descendant.Name] then
                    u70[descendant.Name] = v73[descendant.Name];
                end;
            end;
        else
            local v76;
            v76, u70 = stage(v33);
            table.insert(u68, v76);
        end;

        local u77 = u69 ~= nil;

        if Podium then
            Podium = stage(Podium, u77);
        end;

        local u78, u79;

        if Star then
            u78, u79 = stage(Star, u77);
        else
            u78 = nil;
            u79 = nil;
        end;

        for _, v in { Podium, u78 } do
            if v then
                table.insert(u68, v);
                local BoundingBox, v80 = v:GetBoundingBox();
                v.WorldPivot = CFrame.new(BoundingBox.Position - Vector3.new(0, v80.Y / 2, 0));
            end;
        end;

        for _, v in u67 do
            local Status = v:FindFirstChild("Status");
            local v81 = not u77;

            if v81 then
                local v82;

                if SmallPodium then
                    v82 = v:IsDescendantOf(SmallPodium);
                else
                    v82 = SmallPodium;
                end;

                v81 = not v82;
            end;

            v.Enabled = v81;

            if Status and Status:IsA("TextLabel") then
                Status.Text = "Locked - Level 25";
                Status.TextColor3 = Color3.fromRGB(255, 92, 92);
            end;
        end;

        local u83 = u70.Shackle and u70.Shackle.CFrame or CFrame.new(Position + Vector3.new(0, 0.5, 0));
        local u84 = {};

        for i, v in u70 do
            u84[i] = v.CFrame;
        end;

        local Position2 = (u78 and u78:GetBoundingBox() or CFrame.new(u37 + Vector3.new(0, 4, 0))).Position;
        local u85 = {};

        for i, v in u79 or {} do
            u85[i] = v.CFrame;
        end;

        local function finish(p86) -- Line: 302
            -- upvalues: u44 (ref), u51 (copy), u50 (copy), u48 (copy), u68 (copy), u45 (ref), u32 (copy), u67 (copy), u52 (ref), u46 (copy), u49 (ref), workspace_CurrentCamera (copy), u43 (copy), LocalPlayer (ref), ProUnlock (copy), BindableEvent (copy)
            if u44 then
                return;
            end;

            u44 = true;

            if p86 ~= true then
                for _, v in u51 do
                    v:Destroy();
                end;
            end;

            table.clear(u51);

            for _, v in u50 do
                v:Disconnect();
            end;

            for _, v in u48 do
                v:Cancel();
            end;

            for _, v in u68 do
                v:Destroy();
            end;

            table.clear(u68);

            if not u45 then
                u45 = true;
                u32();
            end;

            for _, v in u67 do
                v:SetAttribute("CreatorCaptureExempt", nil);
            end;

            if u52 then
                u52:destroy();
            end;

            u46:restore();

            if u49 then
                pcall(u49.Enable, u49);
            end;

            local v87;

            if u43[1] == Enum.CameraType.Scriptable then
                v87 = Enum.CameraType.Custom;
            else
                v87 = u43[1];
            end;

            workspace_CurrentCamera.CameraType = v87;
            local v88 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

            if v88 then
                workspace_CurrentCamera.CameraSubject = v88;
            end;

            workspace_CurrentCamera.FieldOfView = u43[2];
            ProUnlock:Destroy();
            LocalPlayer:SetAttribute("ProUnlockActive", nil);
            BindableEvent:Fire();
        end;

        table.insert(u50, TextButton.Activated:Connect(function() -- Line: 345
            -- upvalues: finish (copy)
            finish();
        end));
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
        table.insert(u50, AttributeChangedSignal:Connect(function() -- Line: 349
            -- upvalues: LocalPlayer (ref), finish (copy)
            if LocalPlayer:GetAttribute("InMatch") == true then
                finish();
            end;
        end));
        local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
        table.insert(u50, AttributeChangedSignal2:Connect(function() -- Line: 356
            -- upvalues: LocalPlayer (ref), finish (copy)
            if LocalPlayer:GetAttribute("CutsceneActive") == true then
                finish();
            end;
        end));
        table.insert(u50, Character.AncestryChanged:Connect(function() -- Line: 361
            -- upvalues: Character (copy), finish (copy)
            if not Character:IsDescendantOf(workspace) then
                finish();
            end;
        end));

        local function at(p89, u90) -- Line: 366
            -- upvalues: u44 (ref)
            task.delay(p89, function() -- Line: 367
                -- upvalues: u44 (ref), u90 (copy)
                if not u44 then
                    u90();
                end;
            end);
        end;

        local function shot(p91, p92, p93) -- Line: 373
            -- upvalues: u48 (copy), workspace_CurrentCamera (copy), TweenService (ref)
            local v94 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(p92, p93 or Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = p91
            });
            v94:Play();
            table.insert(u48, v94);
        end;

        local u95 = {};

        local function scale(u96, p97, p98, p99, p100, p101) -- Line: 380
            -- upvalues: u95 (copy), u48 (copy), TweenService (ref), RunService (ref), u44 (ref), u50 (copy)
            local v102 = u95[u96] or u96:GetScale();
            u95[u96] = v102;
            local v103 = p97 * v102;
            local u104 = p98 * v102;
            local NumberValue = Instance.new("NumberValue");

            for i, v in {
                Value = v103
            } do
                NumberValue[i] = v;
            end;

            NumberValue.Parent = nil;
            u96:ScaleTo((math.max(v103, 0.05)));
            local v105 = {
                Value = u104
            };
            local v106 = TweenService:Create(NumberValue, TweenInfo.new(p99, p100 or Enum.EasingStyle.Sine, p101 or Enum.EasingDirection.Out), v105);
            v106:Play();
            table.insert(u48, v106);
            local u107 = nil;
            u107 = RunService.RenderStepped:Connect(function() -- Line: 388
                -- upvalues: u44 (ref), u96 (copy), u107 (ref), NumberValue (copy), u104 (ref)
                if u44 or not u96.Parent then
                    u107:Disconnect();

                    return;
                end;

                u96:ScaleTo((math.max(NumberValue.Value, 0.05)));

                if NumberValue.Value == u104 then
                    u107:Disconnect();
                end;
            end);
            table.insert(u50, u107);
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.FieldOfView = 50;
        workspace_CurrentCamera.CFrame = CFrame.lookAt(Position + u36 * 9 + u35 * 24 + Vector3.new(0, 8, 0), Position + Vector3.new(0, 2.5, 0));

        for _, v in u47 do
            local v108 = {
                Size = UDim2.fromScale(1.5, 0.11)
            };
            local v109 = TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v108);
            v109:Play();
            table.insert(u48, v109);
        end;

        sound("04_UI", "Notice", 0.5, 0.9, ProUnlock);
        local CFrame_lookAt_ret = CFrame.lookAt(Position + u36 * 1.8 + u35 * 6.5 + Vector3.new(0, 1, 0), Position + Vector3.new(0, 0.5, 0));
        local v110 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.7, Enum.EasingStyle.Quad or Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = CFrame_lookAt_ret
        });
        v110:Play();
        table.insert(u48, v110);

        local function u111() -- Line: 412
            -- upvalues: asset (ref), u51 (copy)
            asset("rbxassetid://9113763639", 0.7, u51);
        end;

        task.delay(0.75, function() -- Line: 367
            -- upvalues: u44 (ref), u111 (copy)
            if not u44 then
                u111();
            end;
        end);
        local LockBody = u70.LockBody;

        if LockBody then
            local LockBody2 = u70.LockBody;
            local v112 = {
                Range = 8,
                Brightness = 0,
                Color = Color3_fromRGB_ret
            };
            LockBody = Instance.new("PointLight");

            for i, v in v112 do
                LockBody[i] = v;
            end;

            LockBody.Parent = LockBody2;
        end;

        local function u116() -- Line: 417
            -- upvalues: LockBody (copy), u48 (copy), TweenService (ref), RunService (ref), u44 (ref), u70 (ref), u1 (ref), u83 (copy), u84 (copy), u50 (copy)
            local os_clock_ret = os.clock();

            if LockBody then
                local v113 = TweenService:Create(LockBody, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Brightness = 4
                });
                v113:Play();
                table.insert(u48, v113);
            end;

            local u114 = nil;
            u114 = RunService.RenderStepped:Connect(function() -- Line: 423
                -- upvalues: os_clock_ret (copy), u44 (ref), u114 (ref), u70 (ref), u1 (ref), u83 (ref), u84 (ref)
                local v115 = os.clock() - os_clock_ret;

                if u44 or v115 >= 1 then
                    u114:Disconnect();

                    return;
                end;

                local CFrame_Angles_ret = CFrame.Angles(0, 0, math.sin(v115 * 42) * 0.17453292519943295 * v115);

                for i, v in u70 do
                    if u1[i] or i == "Shackle" then
                        v.CFrame = u83 * CFrame_Angles_ret * u83:Inverse() * u84[i];
                    end;
                end;
            end);
            table.insert(u50, u114);
        end;

        task.delay(1.7, function() -- Line: 367
            -- upvalues: u44 (ref), u116 (copy)
            if not u44 then
                u116();
            end;
        end);

        local function u127() -- Line: 440
            -- upvalues: Frame (copy), u48 (copy), TweenService (ref), asset (ref), u51 (copy), u70 (ref), burst (ref), Color3_fromRGB_ret (ref), u1 (ref), workspace_CurrentCamera (copy), Position (copy), u36 (copy), u35 (ref)
            Frame.BackgroundTransparency = 0.35;
            local v117 = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            });
            v117:Play();
            table.insert(u48, v117);
            asset("rbxassetid://132535085898211", 0.8, u51);
            local v118 = u70.LockBody or u70.Shackle;

            if v118 then
                local Attachment = Instance.new("Attachment");

                for i, v in {} do
                    Attachment[i] = v;
                end;

                Attachment.Parent = v118;
                burst(Attachment, Color3_fromRGB_ret, 45, 14);
            end;

            for i, v in u70 do
                if u1[i] then
                    local v119 = {
                        Transparency = 1,
                        CFrame = v.CFrame * CFrame.new(0.6, -3.2, -0.8) * CFrame.Angles(-0.8726646259971648, 0, 1.2217304763960306)
                    };
                    local v120 = TweenService:Create(v, TweenInfo.new(0.75, Enum.EasingStyle.Quad or Enum.EasingStyle.Sine, Enum.EasingDirection.In or Enum.EasingDirection.Out), v119);
                    v120:Play();
                    table.insert(u48, v120);
                elseif i == "Shackle" then
                    local v121 = {
                        Transparency = 1,
                        CFrame = v.CFrame * CFrame.new(-0.4, 1.4, -0.6) * CFrame.Angles(0, 0, -2.0943951023931953)
                    };
                    local v122 = TweenService:Create(v, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v121);
                    v122:Play();
                    table.insert(u48, v122);
                elseif i == "Chain" then
                    local v123 = {
                        Transparency = 1,
                        CFrame = v.CFrame * CFrame.new(0, -1.6, 0)
                    };
                    local v124 = TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Quad or Enum.EasingStyle.Sine, Enum.EasingDirection.In or Enum.EasingDirection.Out), v123);
                    v124:Play();
                    table.insert(u48, v124);
                end;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0.15, -0.1, 0) * CFrame.Angles(0, 0, 0.026179938779914945);
            local v125 = {
                CFrame = CFrame.lookAt(Position + u36 * 2.5 + u35 * 10 + Vector3.new(0, 2.5, 0), Position + Vector3.new(0, 1.8, 0))
            };
            local v126 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v125);
            v126:Play();
            table.insert(u48, v126);
        end;

        task.delay(2.7, function() -- Line: 367
            -- upvalues: u44 (ref), u127 (copy)
            if not u44 then
                u127();
            end;
        end);

        local function u131() -- Line: 470
            -- upvalues: Frame (copy), u48 (copy), TweenService (ref), sound (ref), ProUnlock (copy), u69 (ref), burst (ref), scale (copy), Podium (copy), u78 (ref), u77 (copy), u67 (copy), SmallPodium (copy), u37 (copy), u36 (copy), u35 (ref), workspace_CurrentCamera (copy)
            Frame.BackgroundColor3 = Color3.new(1, 1, 1);
            Frame.BackgroundTransparency = 0.2;
            local v128 = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            });
            v128:Play();
            table.insert(u48, v128);
            sound("04_UI", "Notice", 0.6, 1.25, ProUnlock);

            if u69 then
                local v129 = u69:FindFirstChildWhichIsA("BasePart", true);
                local Attachment = Instance.new("Attachment");

                for i, v in {} do
                    Attachment[i] = v;
                end;

                Attachment.Parent = v129;
                burst(Attachment, Color3.new(1, 1, 1), 40, 10);
                scale(u69, 1, 0.05, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                task.delay(0.26, function() -- Line: 478
                    -- upvalues: u69 (ref)
                    if u69.Parent then
                        u69.Parent = nil;
                    end;
                end);
            end;

            for _, v in { Podium, u78 } do
                if v and u77 then
                    v.Parent = workspace;
                    scale(v, 0.55, 1, 0.55, Enum.EasingStyle.Back);
                end;
            end;

            for _, v in u67 do
                if not (SmallPodium and v:IsDescendantOf(SmallPodium)) then
                    v.Enabled = true;
                    local Status = v:FindFirstChild("Status");

                    if Status and Status:IsA("TextLabel") then
                        Status.Text = "Open - Level 25+";
                        Status.TextColor3 = Color3.fromRGB(120, 230, 140);
                    end;
                end;
            end;

            local CFrame_lookAt_ret2 = CFrame.lookAt(u37 + u36 * -3 + u35 * 21 + Vector3.new(0, 2, 0), u37 + Vector3.new(0, 1.5, 0));
            local v130 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Quad or Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = CFrame_lookAt_ret2
            });
            v130:Play();
            table.insert(u48, v130);
        end;

        task.delay(3.3, function() -- Line: 367
            -- upvalues: u44 (ref), u131 (copy)
            if not u44 then
                u131();
            end;
        end);

        local function u138() -- Line: 505
            -- upvalues: asset (ref), u51 (copy), u78 (ref), Color3_fromRGB_ret (ref), u48 (copy), TweenService (ref), u44 (ref), burst (ref), Position2 (copy), RunService (ref), u79 (ref), u85 (copy), u50 (copy)
            asset("rbxassetid://93360393539898", 0.75, u51);
            local v132 = u78 and u78:FindFirstChildWhichIsA("BasePart", true);

            if v132 then
                local v133 = {
                    Range = 16,
                    Brightness = 0,
                    Color = Color3_fromRGB_ret
                };
                local PointLight = Instance.new("PointLight");

                for i, v in v133 do
                    PointLight[i] = v;
                end;

                PointLight.Parent = v132;
                local v134 = TweenService:Create(PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Brightness = 5
                });
                v134:Play();
                table.insert(u48, v134);
                task.delay(0.6, function() -- Line: 511
                    -- upvalues: u44 (ref), u48 (ref), PointLight (copy), TweenService (ref)
                    if not u44 then
                        local v135 = TweenService:Create(PointLight, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Brightness = 2
                        });
                        v135:Play();
                        table.insert(u48, v135);
                    end;
                end);
                local Attachment = Instance.new("Attachment");

                for i, v in {} do
                    Attachment[i] = v;
                end;

                Attachment.Parent = v132;
                burst(Attachment, Color3.new(1, 1, 1), 30, 9);
            end;

            local NumberValue = Instance.new("NumberValue");

            for i, v in {
                Value = 0
            } do
                NumberValue[i] = v;
            end;

            NumberValue.Parent = nil;
            local v136 = TweenService:Create(NumberValue, TweenInfo.new(1.1, Enum.EasingStyle.Quart or Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Value = 1
            });
            v136:Play();
            table.insert(u48, v136);
            local CFrame_new_ret = CFrame.new(Position2);
            local u137 = nil;
            u137 = RunService.RenderStepped:Connect(function() -- Line: 522
                -- upvalues: u44 (ref), u137 (ref), NumberValue (copy), u79 (ref), CFrame_new_ret (copy), u85 (ref)
                if u44 then
                    u137:Disconnect();

                    return;
                end;

                local CFrame_Angles_ret = CFrame.Angles(0, NumberValue.Value * 3.141592653589793 * 2, 0);

                for i, v in u79 or {} do
                    v.CFrame = CFrame_new_ret * CFrame_Angles_ret * CFrame_new_ret:Inverse() * u85[i];
                end;

                if NumberValue.Value >= 1 then
                    u137:Disconnect();
                end;
            end);
            table.insert(u50, u137);
        end;

        task.delay(3.9, function() -- Line: 367
            -- upvalues: u44 (ref), u138 (copy)
            if not u44 then
                u138();
            end;
        end);

        local function u144() -- Line: 537
            -- upvalues: u48 (copy), u64 (copy), TweenService (ref), UIScale (copy), u37 (copy), Position2 (copy), u36 (copy), u35 (ref), workspace_CurrentCamera (copy)
            local v139 = TweenService:Create(u64, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TextTransparency = 0
            });
            v139:Play();
            table.insert(u48, v139);
            local v140 = TweenService:Create(u64.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 0
            });
            v140:Play();
            table.insert(u48, v140);
            local v141 = TweenService:Create(UIScale, TweenInfo.new(0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Scale = 1
            });
            v141:Play();
            table.insert(u48, v141);
            local v142 = {
                CFrame = CFrame.lookAt(u37 + u36 * 2 + u35 * 18 + Vector3.new(0, 1.2, 0), Position2 - Vector3.new(0, 1.5, 0))
            };
            local v143 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v142);
            v143:Play();
            table.insert(u48, v143);
        end;

        task.delay(4.1, function() -- Line: 367
            -- upvalues: u44 (ref), u144 (copy)
            if not u44 then
                u144();
            end;
        end);

        local function u147() -- Line: 543
            -- upvalues: u48 (copy), u65 (copy), TweenService (ref)
            local v145 = TweenService:Create(u65, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TextTransparency = 0
            });
            v145:Play();
            table.insert(u48, v145);
            local v146 = TweenService:Create(u65.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 0.2
            });
            v146:Play();
            table.insert(u48, v146);
        end;

        task.delay(4.45, function() -- Line: 367
            -- upvalues: u44 (ref), u147 (copy)
            if not u44 then
                u147();
            end;
        end);

        local function u152() -- Line: 549
            -- upvalues: u64 (copy), u65 (copy), u48 (copy), TweenService (ref), u47 (copy)
            for _, v in { u64, u65 } do
                local v148 = TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    TextTransparency = 1
                });
                v148:Play();
                table.insert(u48, v148);
                local v149 = TweenService:Create(v.UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = 1
                });
                v149:Play();
                table.insert(u48, v149);
            end;

            for _, v in u47 do
                local v150 = {
                    Size = UDim2.fromScale(1.5, 0)
                };
                local v151 = TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v150);
                v151:Play();
                table.insert(u48, v151);
            end;
        end;

        task.delay(6.6, function() -- Line: 367
            -- upvalues: u44 (ref), u152 (copy)
            if not u44 then
                u152();
            end;
        end);

        local function u153() -- Line: 558
            -- upvalues: finish (copy)
            finish(true);
        end;

        task.delay(7.1, function() -- Line: 367
            -- upvalues: u44 (ref), u153 (copy)
            if not u44 then
                u153();
            end;
        end);

        if not u44 then
            BindableEvent.Event:Wait();
        end;

        BindableEvent:Destroy();
    end
};