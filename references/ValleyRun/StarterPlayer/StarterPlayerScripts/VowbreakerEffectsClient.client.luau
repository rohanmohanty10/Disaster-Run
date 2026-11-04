 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local VowbreakerFX = Weapons:WaitForChild("VowbreakerFX");
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local RescueConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("RescueConfig"));
local u1 = GearCatalog.Items.BrokenVow.SealSeconds or 1;
local LocalPlayer = Players.LocalPlayer;
local u2 = nil;
local Color3_fromRGB_ret = Color3.fromRGB(255, 80, 150);
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = nil;
local EmitModule = game.ReplicatedStorage:WaitForChild("EmitModule", 30);
local success, result = pcall(require, EmitModule);

if EmitModule and success then
    u6 = result;
else
    warn("VowbreakerEffectsClient: the revive effect is off (EmitModule: " .. tostring(not EmitModule and "missing" or result) .. ")");
end;

local u7 = nil;

local function emitReady() -- Line: 48
    -- upvalues: u7 (ref), u6 (ref)
    if u7 == nil and u6 then
        local success2, result2 = pcall(u6.init);
        u7 = success2;

        if not success2 then
            warn("VowbreakerEffectsClient: the revive effect is off (EmitModule.init: " .. tostring(result2) .. ")");
        end;
    end;

    return u7 == true;
end;

local u8 = (-1 / 0);

local function near(p9) -- Line: 60
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v10;

    if workspace_CurrentCamera == nil then
        v10 = false;
    else
        v10 = (workspace_CurrentCamera.CFrame.Position - p9).Magnitude <= 220;
    end;

    return v10;
end;

local function playSound(p11, p12) -- Line: 66
    -- upvalues: VowbreakerFX (copy), TweenService (copy)
    local v13 = VowbreakerFX:FindFirstChild(p11);

    if not (v13 and v13:IsA("Sound")) then
        return;
    end;

    local u14 = v13:Clone();
    u14.Parent = p12;
    u14:Play();
    local Attribute = u14:GetAttribute("Seconds");

    if type(Attribute) == "number" then
        task.delay(Attribute, function() -- Line: 76
            -- upvalues: u14 (copy), TweenService (ref)
            if u14.Parent then
                TweenService:Create(u14, TweenInfo.new(0.4), {
                    Volume = 0
                }):Play();
            end;
        end);
        task.delay(Attribute + 0.45, function() -- Line: 81
            -- upvalues: u14 (copy)
            u14:Destroy();
        end);

        return;
    end;

    u14.Ended:Once(function() -- Line: 85
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
    task.delay(6, function() -- Line: 88
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
end;

local function eachEffect(p15, p16) -- Line: 95
    for _, child in p15[1]:GetChildren() do
        p16(child);
    end;

    if p15[2] then
        p16(p15[2]);
    end;
end;

local function destroyStream(p17) -- Line: 104
    p17[1]:Destroy();

    if p17[2] then
        p17[2]:Destroy();
    end;
end;

local function stopStream(p18, p19) -- Line: 112
    -- upvalues: u5 (copy), TweenService (copy), destroyStream (copy)
    local v20 = u5[p18];
    u5[p18] = nil;

    if not v20 then
        return;
    end;

    local function v22(p21) -- Line: 118
        -- upvalues: TweenService (ref)
        if p21:IsA("ParticleEmitter") then
            p21.Enabled = false;

            return;
        end;

        if p21:IsA("PointLight") then
            TweenService:Create(p21, TweenInfo.new(0.3), {
                Brightness = 0
            }):Play();
        end;
    end;

    for _, child in v20[1]:GetChildren() do
        v22(child);
    end;

    if v20[2] then
        v22(v20[2]);
    end;

    if p19 then
        task.delay(2, destroyStream, v20);

        return;
    end;

    v20[1]:Destroy();

    if v20[2] then
        v20[2]:Destroy();
    end;
end;

local function startStream(u23, p24) -- Line: 132
    -- upvalues: u5 (copy), TweenService (copy), VowbreakerFX (copy), playSound (copy), destroyStream (copy)
    local v25 = u5[u23];
    u5[u23] = nil;

    if v25 then
        local function v27(p26) -- Line: 118
            -- upvalues: TweenService (ref)
            if p26:IsA("ParticleEmitter") then
                p26.Enabled = false;

                return;
            end;

            if p26:IsA("PointLight") then
                TweenService:Create(p26, TweenInfo.new(0.3), {
                    Brightness = 0
                }):Play();
            end;
        end;

        for _, child in v25[1]:GetChildren() do
            v27(child);
        end;

        if v25[2] then
            v27(v25[2]);
        end;

        v25[1]:Destroy();

        if v25[2] then
            v25[2]:Destroy();
        end;
    end;

    local Character = u23.Character;

    if Character then
        Character = Character:FindFirstChild("EquippedDagger");
    end;

    if Character then
        Character = Character:FindFirstChild("Blade");
    end;

    if Character and Character:IsA("BasePart") then
        local Position = Character.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v28;

        if workspace_CurrentCamera == nil then
            v28 = false;
        else
            v28 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
        end;

        if v28 then
            local v29 = VowbreakerFX.Knife:Clone();
            local PetalsPink = v29:FindFirstChild("PetalsPink");

            if PetalsPink then
                PetalsPink.Parent = Character;
            end;

            v29.Parent = Character;
            local u30 = { v29, PetalsPink };

            local function v32(p31) -- Line: 148
                -- upvalues: TweenService (ref)
                if p31:IsA("ParticleEmitter") then
                    p31.Enabled = true;

                    return;
                end;

                if p31:IsA("PointLight") then
                    p31.Enabled = true;
                    TweenService:Create(p31, TweenInfo.new(0.2), {
                        Brightness = 2.2
                    }):Play();
                end;
            end;

            for _, child in u30[1]:GetChildren() do
                v32(child);
            end;

            if u30[2] then
                v32(u30[2]);
            end;

            u5[u23] = u30;
            playSound("ActivateSound", Character);
            local task_delay = task.delay;
            local v33 = p24 - workspace:GetServerTimeNow();
            task_delay(math.max(0, v33), function() -- Line: 158
                -- upvalues: u5 (ref), u23 (copy), u30 (copy), TweenService (ref), destroyStream (ref)
                if u5[u23] == u30 then
                    local v34 = u23;
                    local v35 = u5[v34];
                    u5[v34] = nil;

                    if not v35 then
                        return;
                    end;

                    local function v37(p36) -- Line: 118
                        -- upvalues: TweenService (ref)
                        if p36:IsA("ParticleEmitter") then
                            p36.Enabled = false;

                            return;
                        end;

                        if p36:IsA("PointLight") then
                            TweenService:Create(p36, TweenInfo.new(0.3), {
                                Brightness = 0
                            }):Play();
                        end;
                    end;

                    for _, child in v35[1]:GetChildren() do
                        v37(child);
                    end;

                    if v35[2] then
                        v37(v35[2]);
                    end;

                    task.delay(2, destroyStream, v35);
                end;
            end);
        end;
    end;
end;

local function watch(u38) -- Line: 165
    -- upvalues: startStream (copy), u5 (copy), TweenService (copy), destroyStream (copy), u4 (copy)
    local function changed() -- Line: 166
        -- upvalues: u38 (copy), startStream (ref), u5 (ref), TweenService (ref), destroyStream (ref)
        local Attribute = u38:GetAttribute("VowUntil");

        if type(Attribute) == "number" and workspace:GetServerTimeNow() < Attribute then
            startStream(u38, Attribute);

            return;
        end;

        local v39 = u38;
        local v40 = u5[v39];
        u5[v39] = nil;

        if not v40 then
            return;
        end;

        local function v42(p41) -- Line: 118
            -- upvalues: TweenService (ref)
            if p41:IsA("ParticleEmitter") then
                p41.Enabled = false;

                return;
            end;

            if p41:IsA("PointLight") then
                TweenService:Create(p41, TweenInfo.new(0.3), {
                    Brightness = 0
                }):Play();
            end;
        end;

        for _, child in v40[1]:GetChildren() do
            v42(child);
        end;

        if v40[2] then
            v42(v40[2]);
        end;

        task.delay(2, destroyStream, v40);
    end;

    u4[u38] = u38:GetAttributeChangedSignal("VowUntil"):Connect(changed);
    local Attribute = u38:GetAttribute("VowUntil");

    if type(Attribute) == "number" and workspace:GetServerTimeNow() < Attribute then
        startStream(u38, Attribute);

        return;
    end;

    local v43 = u5[u38];
    u5[u38] = nil;

    if not v43 then
        return;
    end;

    local function v45(p44) -- Line: 118
        -- upvalues: TweenService (ref)
        if p44:IsA("ParticleEmitter") then
            p44.Enabled = false;

            return;
        end;

        if p44:IsA("PointLight") then
            TweenService:Create(p44, TweenInfo.new(0.3), {
                Brightness = 0
            }):Play();
        end;
    end;

    for _, child in v43[1]:GetChildren() do
        v45(child);
    end;

    if v43[2] then
        v45(v43[2]);
    end;

    task.delay(2, destroyStream, v43);
end;

local function characterOf(p46) -- Line: 179
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p46);

    if PlayerByUserId then
        return PlayerByUserId.Character;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    for _, v in not ClientBots and {} or ClientBots:GetChildren() do
        if v:GetAttribute("BotUserId") == p46 then
            return v;
        end;
    end;

    return nil;
end;

local function rootOf(p47) -- Line: 194
    -- upvalues: characterOf (copy)
    local v48;

    if type(p47) == "number" then
        v48 = characterOf(p47);
    else
        v48 = false;
    end;

    local v49;

    if v48 then
        v49 = v48:FindFirstChild("HumanoidRootPart");
    else
        v49 = v48;
    end;

    if v49 and v49:IsA("BasePart") then
        local Position = v49.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v50;

        if workspace_CurrentCamera == nil then
            v50 = false;
        else
            v50 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
        end;

        if v50 then
            return v49, v48;
        end;
    end;

    return nil;
end;

local u51 = setmetatable({}, {
    __mode = "k"
});

local function glow(p52, p53) -- Line: 205
    -- upvalues: u51 (copy), VowbreakerFX (copy), TweenService (copy)
    if u51[p52] and u51[p52].Parent then
        return;
    end;

    local u54 = VowbreakerFX.Converted:Clone();
    u51[p52] = u54;
    u54.Parent = p52;

    for _, child in u54:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child.Enabled = true;
        elseif child:IsA("PointLight") then
            child.Enabled = true;
            TweenService:Create(child, TweenInfo.new(0.25), {
                Brightness = 2.5
            }):Play();
        end;
    end;

    local v55 = (u54:GetAttribute("Seconds") or 3) + p53;
    task.delay(v55, function() -- Line: 221
        -- upvalues: u54 (copy), TweenService (ref)
        if not u54.Parent then
            return;
        end;

        for _, child in u54:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            elseif child:IsA("PointLight") then
                TweenService:Create(child, TweenInfo.new(0.5), {
                    Brightness = 0
                }):Play();
            end;
        end;
    end);
    task.delay(v55 + 2, function() -- Line: 233
        -- upvalues: u54 (copy)
        u54:Destroy();
    end);
end;

local u56 = {};

local function stopRevive(p57) -- Line: 242
    -- upvalues: u56 (copy)
    local v58 = u56[p57];
    u56[p57] = nil;

    if v58 then
        v58.follow:Disconnect();
        v58.model:Destroy();
    end;
end;

local function reviveEffect(u59, u60, p61) -- Line: 251
    -- upvalues: u6 (ref), u56 (copy), VowbreakerFX (copy), RunService (copy), u7 (ref), u8 (ref)
    if not u6 then
        return;
    end;

    local u62 = u56[u59];

    if not u62 then
        local v63 = VowbreakerFX.ReviveEffect:Clone();

        if u60 then
            u60 = u60:FindFirstChild("Head");
        end;

        local u64 = {};

        for _, child in v63:GetChildren() do
            if child:IsA("BasePart") then
                local Attribute = child:GetAttribute("HeadOffset");
                local v65 = {
                    part = child
                };

                if not (u60 and (typeof(Attribute) == "Vector3" and Attribute)) then
                    Attribute = nil;
                end;

                v65.offset = Attribute;
                local v66 = child:GetAttribute("Lift") or 0;
                v65.lift = Vector3.new(0, v66, 0);
                v65.turn = child.CFrame.Rotation;
                table.insert(u64, v65);
            end;
        end;

        local function place() -- Line: 271
            -- upvalues: u64 (copy), u60 (copy), u59 (copy)
            for _, v in u64 do
                local v67;

                if v.offset and u60.Parent then
                    v67 = u60.CFrame:PointToWorldSpace(v.offset);
                else
                    v67 = u59.Position + v.lift;
                end;

                v.part.CFrame = CFrame.new(v67) * v.turn;
            end;
        end;

        place();
        v63.Parent = workspace;
        u62 = {
            endAt = 0,
            model = v63
        };
        u62.follow = RunService.RenderStepped:Connect(function() -- Line: 282
            -- upvalues: u59 (copy), u62 (ref), u56 (ref), place (copy)
            if u59.Parent and os.clock() < u62.endAt then
                place();
            else
                local v68 = u59;
                local v69 = u56[v68];
                u56[v68] = nil;

                if v69 then
                    v69.follow:Disconnect();
                    v69.model:Destroy();
                end;
            end;
        end);
        u56[u59] = u62;
    end;

    local v70 = u62.model:FindFirstChild(p61);

    if not v70 then
        return;
    end;

    local endAt = u62.endAt;
    local v71 = os.clock() + 2.5;
    u62.endAt = math.max(endAt, v71);

    if u7 == nil and u6 then
        local success2, result2 = pcall(u6.init);
        u7 = success2;

        if not success2 then
            warn("VowbreakerEffectsClient: the revive effect is off (EmitModule.init: " .. tostring(result2) .. ")");
        end;
    end;

    if u7 ~= true then
        return;
    end;

    local success2, result2 = pcall(u6.emit, v70);

    if not success2 and os.clock() - u8 > 30 then
        u8 = os.clock();
        warn("VowbreakerEffectsClient: the revive effect failed to fire: " .. tostring(result2));
    end;
end;

local function sealed(p72) -- Line: 307
    -- upvalues: characterOf (copy), reviveEffect (copy)
    local v73;

    if type(p72) == "number" then
        v73 = characterOf(p72);
    else
        v73 = false;
    end;

    local v74;

    if v73 then
        v74 = v73:FindFirstChild("HumanoidRootPart");
    else
        v74 = v73;
    end;

    if v74 and v74:IsA("BasePart") then
        local Position = v74.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v75;

        if workspace_CurrentCamera == nil then
            v75 = false;
        else
            v75 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
        end;

        if not v75 then
            v74 = nil;
            v73 = nil;
        end;
    else
        v74 = nil;
        v73 = nil;
    end;

    if v74 then
        reviveEffect(v74, v73, "Part2");
    end;
end;

local function rising(p76, p77, p78, p79) -- Line: 316
    -- upvalues: characterOf (copy), glow (copy), reviveEffect (copy), playSound (copy)
    local v80;

    if type(p76) == "number" then
        v80 = characterOf(p76);
    else
        v80 = false;
    end;

    if v80 and (v80:GetAttribute("ClientBot") == true and type(p77) == "number") then
        v80:SetAttribute("KnockLiftHeight", p78);
        v80:SetAttribute("KnockLiftTime", p79);
        v80:SetAttribute("KnockLiftAt", p77);
    end;

    local v81;

    if type(p76) == "number" then
        v81 = characterOf(p76);
    else
        v81 = false;
    end;

    local v82;

    if v81 then
        v82 = v81:FindFirstChild("HumanoidRootPart");
    else
        v82 = v81;
    end;

    if v82 and v82:IsA("BasePart") then
        local Position = v82.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v83;

        if workspace_CurrentCamera == nil then
            v83 = false;
        else
            v83 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
        end;

        if not v83 then
            v82 = nil;
            v81 = nil;
        end;
    else
        v82 = nil;
        v81 = nil;
    end;

    if v82 then
        glow(v82, 0.8);
        reviveEffect(v82, v81, "Part1");
        playSound("ReviveChime", v82);
    end;
end;

local function revived(p84) -- Line: 332
    -- upvalues: characterOf (copy), u56 (copy), reviveEffect (copy), playSound (copy), glow (copy), Color3_fromRGB_ret (copy), TweenService (copy)
    local v85;

    if type(p84) == "number" then
        v85 = characterOf(p84);
    else
        v85 = false;
    end;

    local v86;

    if v85 then
        v86 = v85:FindFirstChild("HumanoidRootPart");
    else
        v86 = v85;
    end;

    if v86 and v86:IsA("BasePart") then
        local Position = v86.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v87;

        if workspace_CurrentCamera == nil then
            v87 = false;
        else
            v87 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
        end;

        if not v87 then
            v86 = nil;
            v85 = nil;
        end;
    else
        v86 = nil;
        v85 = nil;
    end;

    if not v86 then
        return;
    end;

    if not u56[v86] then
        reviveEffect(v86, v85, "Part1");
    end;

    playSound("ShatterSound", v86);
    glow(v86, 0);
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "VowRevive";
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.OutlineColor = Color3.fromRGB(255, 220, 235);
    Highlight.FillTransparency = 0.2;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = v85;
    TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.delay(1.05, function() -- Line: 354
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
end;

local function fizzle(p88) -- Line: 362
    -- upvalues: characterOf (copy), glow (copy), VowbreakerFX (copy), reviveEffect (copy), u56 (copy), playSound (copy)
    local v89;

    if type(p88) == "number" then
        v89 = characterOf(p88);
    else
        v89 = false;
    end;

    local u90;

    if v89 then
        u90 = v89:FindFirstChild("HumanoidRootPart");
    else
        u90 = v89;
    end;

    if u90 and u90:IsA("BasePart") then
        local Position = u90.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v91;

        if workspace_CurrentCamera == nil then
            v91 = false;
        else
            v91 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
        end;

        if not v91 then
            u90 = nil;
            v89 = nil;
        end;
    else
        u90 = nil;
        v89 = nil;
    end;

    if not u90 then
        return;
    end;

    glow(u90, 1 - (VowbreakerFX.Converted:GetAttribute("Seconds") or 3));
    reviveEffect(u90, v89, "Part1");
    local v92 = u56[u90];

    if v92 then
        v92.endAt = os.clock() + 1;
    end;

    playSound("ReviveChime", u90);
    task.delay(1, function() -- Line: 374
        -- upvalues: u90 (copy), playSound (ref)
        if u90.Parent then
            playSound("ShatterSound", u90);
        end;
    end);
end;

local u93 = {};
local u94 = nil;
local u95 = 0;
local u96 = nil;
local u97 = nil;
local u98 = nil;

local function bodyPart(p99) -- Line: 389
    if p99 then
        p99 = p99:FindFirstChild("Torso") or (p99:FindFirstChild("UpperTorso") or p99:FindFirstChild("HumanoidRootPart"));
    end;

    return p99;
end;

local function setEmitting(p100, p101) -- Line: 394
    for _, v in p100 do
        for _, child in v:GetChildren() do
            if child:IsA("ParticleEmitter") or child:IsA("Light") then
                child.Enabled = p101;
            end;
        end;
    end;
end;

local function buildPrompt() -- Line: 404
    -- upvalues: LocalPlayer (copy), Color3_fromRGB_ret (copy), u1 (copy)
    local v102 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v102 then
        return nil;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "VowSeal";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 24;
    ScreenGui.IgnoreGuiInset = true;
    local Frame = Instance.new("Frame");
    Frame.Name = "SealVow";
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.fromScale(0.22, 0.1);
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.fromScale(0.5, 0.78);
    Frame.Visible = false;
    Frame.Parent = ScreenGui;
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MinSize = Vector2.new(180, 60);
    UISizeConstraint.MaxSize = Vector2.new(240, 74);
    UISizeConstraint.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Hold";
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundColor3 = Color3.fromRGB(46, 12, 30);
    TextButton.BackgroundTransparency = 0.12;
    TextButton.BorderSizePixel = 0;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 5);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret;
    UIStroke.Thickness = 1.5;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = TextButton;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0.05, 0.08);
    TextLabel.Size = UDim2.fromScale(0.9, 0.32);
    TextLabel.Font = Enum.Font.Gotham;
    TextLabel.TextColor3 = Color3.fromRGB(255, 190, 215);
    TextLabel.TextSize = 12;
    TextLabel.Text = ("BROKEN VOW · %.1fs"):format(u1);
    TextLabel.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromScale(0.03, 0.39);
    TextLabel2.Size = UDim2.fromScale(0.94, 0.4);
    TextLabel2.Font = Enum.Font.GothamBold;
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3.fromRGB(255, 236, 244);
    TextLabel2.Parent = TextButton;
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;
    Frame2.BackgroundColor3 = Color3.fromRGB(110, 60, 85);
    Frame2.BackgroundTransparency = 0.4;
    Frame2.Position = UDim2.fromScale(0.04, 0.89);
    Frame2.Size = UDim2.fromScale(0.92, 0.045);
    Frame2.Parent = TextButton;
    local Frame3 = Instance.new("Frame");
    Frame3.BorderSizePixel = 0;
    Frame3.BackgroundColor3 = Color3_fromRGB_ret;
    Frame3.Size = UDim2.fromScale(0, 1);
    Frame3.Parent = Frame2;
    ScreenGui.Parent = v102;

    return {
        gui = ScreenGui,
        frame = Frame,
        button = TextButton,
        action = TextLabel2,
        fill = Frame3
    };
end;

local function cancelSeal() -- Line: 476
    -- upvalues: u97 (ref), u2 (ref), u96 (ref)
    if u97 and (not u97.sent and u2) then
        u2:FireServer("Seal", u97.id, "Cancel");
    end;

    u97 = nil;

    if u96 then
        u96.fill.Size = UDim2.fromScale(0, 1);
    end;
end;

local function beginSeal(p103) -- Line: 486
    -- upvalues: u97 (ref), u98 (ref), u2 (ref), u96 (ref)
    if u97 or not (u98 and (u2 and (u96 and u96.frame.Visible))) then
        return;
    end;

    u97 = {
        id = u98,
        started = os.clock(),
        press = p103
    };
    u2:FireServer("Seal", u97.id, "Begin");
end;

local function updatePrompt(p104) -- Line: 495
    -- upvalues: u97 (ref), u2 (ref), u96 (ref), u98 (ref), buildPrompt (copy), beginSeal (copy), UserInputService (copy), u1 (copy)
    if u97 and u97.id ~= p104 then
        if u97 and (not u97.sent and u2) then
            u2:FireServer("Seal", u97.id, "Cancel");
        end;

        u97 = nil;

        if u96 then
            u96.fill.Size = UDim2.fromScale(0, 1);
        end;
    end;

    u98 = p104;

    if not p104 then
        if u96 then
            u96.frame.Visible = false;
        end;

        return;
    end;

    if not u96 then
        u96 = buildPrompt();

        if not u96 then
            return;
        end;

        u96.button.InputBegan:Connect(function(p105) -- Line: 511
            -- upvalues: beginSeal (ref)
            if p105.UserInputType == Enum.UserInputType.Touch or p105.UserInputType == Enum.UserInputType.MouseButton1 then
                beginSeal(p105);
            end;
        end);
    end;

    u96.frame.Visible = true;
    local PreferredInput = UserInputService.PreferredInput;
    local v106;

    if u97 then
        v106 = u97.sent and "SEALING…" or "HOLD…";
    else
        v106 = PreferredInput == Enum.PreferredInput.Touch and "HOLD TO SEAL VOW" or (PreferredInput == Enum.PreferredInput.Gamepad and "HOLD X · SEAL VOW" or "HOLD F · SEAL VOW");
    end;

    u96.action.Text = v106;

    if u97 then
        local v107 = (os.clock() - u97.started) / u1;
        local math_clamp_ret = math.clamp(v107, 0, 1);
        u96.fill.Size = UDim2.fromScale(math_clamp_ret, 1);

        if math_clamp_ret >= 1 and not u97.sent then
            u97.sent = true;
            u2:FireServer("Seal", u97.id, "Finish");
        end;
    end;
end;

local function step(p108) -- Line: 533
    -- upvalues: u95 (ref), LocalPlayer (copy), RescueConfig (copy), u93 (copy), characterOf (copy), setEmitting (copy), updatePrompt (copy)
    u95 = u95 + p108 * 1;
    local os_clock_ret = os.clock();
    local v109;

    if LocalPlayer:GetAttribute("GameRole") == "Catcher" then
        v109 = LocalPlayer:GetAttribute("RunState") == "Active";
    else
        v109 = false;
    end;

    local Character = LocalPlayer.Character;
    local v110 = v109 and (Character and not Character:GetAttribute("Ragdolled")) and Character:FindFirstChild("HumanoidRootPart");
    local v111 = RescueConfig.Range - 0.25;
    local v112 = nil;

    for i, v in u93 do
        if not (v.character and v.character.Parent) and v.lookAt <= os_clock_ret then
            v.lookAt = os_clock_ret + 0.5;
            v.character = characterOf(i);
        end;

        local character = v.character;

        if character then
            character = character:FindFirstChild("Torso") or (character:FindFirstChild("UpperTorso") or character:FindFirstChild("HumanoidRootPart"));
        end;

        local v113;

        if character == nil then
            v113 = false;
        else
            local Position = character.Position;
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if workspace_CurrentCamera == nil then
                v113 = false;
            else
                v113 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
            end;
        end;

        if v.shown ~= v113 then
            v.shown = v113;
            setEmitting(v.parts, v113);
        end;

        if v113 then
            local v114 = v.parts[1];
            local Position = character.Position;
            local v115 = math.cos(u95) * 2.1;
            local v116 = math.sin(u95 * 1.5) * 0.35 + 1.3;
            local v117 = math.sin(u95) * 2.1;
            v114.Position = Position + Vector3.new(v115, v116, v117);
            v.parts[2].Position = character.Position;
        end;

        if character and (v110 and v.catcher == LocalPlayer.UserId) then
            local Magnitude = (v110.Position - character.Position).Magnitude;

            if Magnitude <= v111 then
                v112 = i;
                v111 = Magnitude;
            end;
        end;
    end;

    updatePrompt(v112);
end;

local function marked(p118, p119) -- Line: 567
    -- upvalues: u93 (copy), VowbreakerFX (copy), characterOf (copy), u94 (ref), RunService (copy), step (copy)
    if type(p118) ~= "number" or (type(p119) ~= "number" or u93[p118]) then
        return;
    end;

    local v120 = { VowbreakerFX.ReadyToRevive:Clone(), VowbreakerFX.MarkedGlow:Clone() };
    v120[1].Parent = workspace.Terrain;
    v120[2].Parent = workspace.Terrain;
    u93[p118] = {
        lookAt = 0,
        shown = false,
        catcher = p119,
        parts = v120,
        character = characterOf(p118)
    };

    if not u94 then
        u94 = RunService.RenderStepped:Connect(step);
    end;
end;

local function unmarked(p121) -- Line: 580
    -- upvalues: u93 (copy), setEmitting (copy), u94 (ref), u97 (ref), u2 (ref), u96 (ref), u98 (ref)
    local u122 = u93[p121];

    if not u122 then
        return;
    end;

    u93[p121] = nil;
    setEmitting(u122.parts, false);
    task.delay(1.8, function() -- Line: 588
        -- upvalues: u122 (copy)
        for _, v in u122.parts do
            v:Destroy();
        end;
    end);

    if next(u93) == nil and u94 then
        u94:Disconnect();
        u94 = nil;

        if u97 and u97.id ~= nil then
            if u97 and (not u97.sent and u2) then
                u2:FireServer("Seal", u97.id, "Cancel");
            end;

            u97 = nil;

            if u96 then
                u96.fill.Size = UDim2.fromScale(0, 1);
            end;
        end;

        u98 = nil;

        if u96 then
            u96.frame.Visible = false;
        end;
    end;
end;

table.insert(u3, UserInputService.InputBegan:Connect(function(p123, p124) -- Line: 602
    -- upvalues: u98 (ref), UserInputService (copy), beginSeal (copy)
    if not (p124 or (not u98 or (UserInputService:GetFocusedTextBox() or p123.KeyCode ~= Enum.KeyCode.F and p123.KeyCode ~= Enum.KeyCode.ButtonX))) then
        beginSeal(p123);
    end;
end));
table.insert(u3, UserInputService.InputEnded:Connect(function(p125) -- Line: 615
    -- upvalues: u97 (ref), u2 (ref), u96 (ref)
    if u97 and not (u97.sent or p125 ~= u97.press and (p125.KeyCode == Enum.KeyCode.None or p125.KeyCode ~= u97.press.KeyCode)) then
        if u97 and (not u97.sent and u2) then
            u2:FireServer("Seal", u97.id, "Cancel");
        end;

        u97 = nil;

        if u96 then
            u96.fill.Size = UDim2.fromScale(0, 1);
        end;
    end;
end));
local u126 = nil;
task.spawn(function() -- Line: 630
    -- upvalues: LocalPlayer (copy), u126 (ref)
    local success2, result2 = pcall(function() -- Line: 631
        -- upvalues: LocalPlayer (ref)
        return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule", 30)):GetControls();
    end);

    if not success2 then
        result2 = nil;
    end;

    u126 = result2;
end);
local u127 = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Down,
    Enum.KeyCode.Left,
    Enum.KeyCode.Right
};

local function moving() -- Line: 638
    -- upvalues: u126 (ref), u127 (copy), UserInputService (copy)
    if u126 then
        local success2, result2 = pcall(u126.GetMoveVector, u126);

        if success2 and typeof(result2) == "Vector3" then
            return result2.Magnitude > 0.5, result2.Magnitude < 0.1;
        end;
    end;

    for _, v in u127 do
        if UserInputService:IsKeyDown(v) then
            return true, false;
        end;
    end;

    return false, true;
end;

local u128 = nil;
local u129 = nil;

local function stopBreakFree() -- Line: 654
    -- upvalues: u129 (ref)
    if u129 then
        u129:Disconnect();
        u129 = nil;
    end;
end;

local function heldDown(u130) -- Line: 660
    -- upvalues: u129 (ref), u128 (ref), RunService (copy), moving (copy), u2 (ref)
    if u129 then
        u129:Disconnect();
        u129 = nil;
    end;

    if u128 then
        u128:Disconnect();
        u128 = nil;
    end;

    if not u130 then
        return;
    end;

    local function v134() -- Line: 669
        -- upvalues: u129 (ref), u130 (copy), RunService (ref), moving (ref), u2 (ref)
        if u129 then
            u129:Disconnect();
            u129 = nil;
        end;

        if u130:GetAttribute("VowDisplayDown") ~= true then
            return;
        end;

        local os_clock_ret = os.clock();
        local u131 = false;
        u129 = RunService.Heartbeat:Connect(function() -- Line: 675
            -- upvalues: moving (ref), u131 (ref), u2 (ref), os_clock_ret (copy), u129 (ref)
            local v132, v133 = moving();

            if v133 then
                u131 = true;

                return;
            end;

            if v132 and (u131 and (u2 and os.clock() - os_clock_ret >= 0.4)) then
                if u129 then
                    u129:Disconnect();
                    u129 = nil;
                end;

                u2:FireServer("BreakFree");
            end;
        end);
    end;

    u128 = u130:GetAttributeChangedSignal("VowDisplayDown"):Connect(v134);
    v134();
end;

table.insert(u3, LocalPlayer.CharacterAdded:Connect(heldDown));

if LocalPlayer.Character then
    heldDown(LocalPlayer.Character);
end;

table.insert(u3, Players.PlayerAdded:Connect(watch));
table.insert(u3, Players.PlayerRemoving:Connect(function(p135) -- Line: 696
    -- upvalues: u4 (copy), u5 (copy), TweenService (copy)
    local v136 = u4[p135];
    u4[p135] = nil;

    if v136 then
        v136:Disconnect();
    end;

    local v137 = u5[p135];
    u5[p135] = nil;

    if not v137 then
        return;
    end;

    local function v139(p138) -- Line: 118
        -- upvalues: TweenService (ref)
        if p138:IsA("ParticleEmitter") then
            p138.Enabled = false;

            return;
        end;

        if p138:IsA("PointLight") then
            TweenService:Create(p138, TweenInfo.new(0.3), {
                Brightness = 0
            }):Play();
        end;
    end;

    for _, child in v137[1]:GetChildren() do
        v139(child);
    end;

    if v137[2] then
        v139(v137[2]);
    end;

    v137[1]:Destroy();

    if v137[2] then
        v137[2]:Destroy();
    end;
end));

for _, v in Players:GetPlayers() do
    u4[v] = v:GetAttributeChangedSignal("VowUntil"):Connect(function() -- Line: 166, Name: changed
        -- upvalues: v (copy), startStream (copy), u5 (copy), TweenService (copy), destroyStream (copy)
        local Attribute = v:GetAttribute("VowUntil");

        if type(Attribute) == "number" and workspace:GetServerTimeNow() < Attribute then
            startStream(v, Attribute);

            return;
        end;

        local v140 = v;
        local v141 = u5[v140];
        u5[v140] = nil;

        if not v141 then
            return;
        end;

        local function v143(p142) -- Line: 118
            -- upvalues: TweenService (ref)
            if p142:IsA("ParticleEmitter") then
                p142.Enabled = false;

                return;
            end;

            if p142:IsA("PointLight") then
                TweenService:Create(p142, TweenInfo.new(0.3), {
                    Brightness = 0
                }):Play();
            end;
        end;

        for _, child in v141[1]:GetChildren() do
            v143(child);
        end;

        if v141[2] then
            v143(v141[2]);
        end;

        task.delay(2, destroyStream, v141);
    end);
    local Attribute = v:GetAttribute("VowUntil");

    if type(Attribute) == "number" and workspace:GetServerTimeNow() < Attribute then
        startStream(v, Attribute);
    else
        local v144 = u5[v];
        u5[v] = nil;

        if v144 then
            local function v146(p145) -- Line: 118
                -- upvalues: TweenService (copy)
                if p145:IsA("ParticleEmitter") then
                    p145.Enabled = false;

                    return;
                end;

                if p145:IsA("PointLight") then
                    TweenService:Create(p145, TweenInfo.new(0.3), {
                        Brightness = 0
                    }):Play();
                end;
            end;

            for _, child in v144[1]:GetChildren() do
                v146(child);
            end;

            if v144[2] then
                v146(v144[2]);
            end;

            task.delay(2, destroyStream, v144);
        end;
    end;
end;

task.spawn(function() -- Line: 708
    -- upvalues: u2 (ref), Weapons (copy), u3 (copy), unmarked (copy), characterOf (copy), reviveEffect (copy), rising (copy), revived (copy), marked (copy), fizzle (copy)
    u2 = Weapons:WaitForChild("VowAbilityEvent", 60);

    if not u2 then
        return;
    end;

    table.insert(u3, u2.OnClientEvent:Connect(function(p147, p148, p149, p150, p151) -- Line: 715
        -- upvalues: unmarked (ref), characterOf (ref), reviveEffect (ref), rising (ref), revived (ref), marked (ref), fizzle (ref)
        if p147 == "Sealed" then
            unmarked(p148);
            local v152;

            if type(p148) == "number" then
                v152 = characterOf(p148);
            else
                v152 = false;
            end;

            local v153;

            if v152 then
                v153 = v152:FindFirstChild("HumanoidRootPart");
            else
                v153 = v152;
            end;

            if v153 and v153:IsA("BasePart") then
                local Position = v153.Position;
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local v154;

                if workspace_CurrentCamera == nil then
                    v154 = false;
                else
                    v154 = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude <= 220;
                end;

                if not v154 then
                    v153 = nil;
                    v152 = nil;
                end;
            else
                v153 = nil;
                v152 = nil;
            end;

            if v153 then
                reviveEffect(v153, v152, "Part2");
            end;
        else
            if p147 == "Rising" then
                rising(p148, p149, p150, p151);

                return;
            end;

            if p147 == "Revived" then
                revived(p148);

                return;
            end;

            if p147 == "Marked" then
                marked(p148, p149);

                return;
            end;

            if p147 == "Unmarked" then
                unmarked(p148);

                return;
            end;

            if p147 == "Fizzle" then
                fizzle(p148);
            end;
        end;
    end));
end);
script.Destroying:Connect(function() -- Line: 734
    -- upvalues: u3 (copy), u4 (copy), u5 (copy), TweenService (copy), u94 (ref), u93 (copy), u56 (copy), u129 (ref), u128 (ref), u96 (ref)
    for _, v in u3 do
        v:Disconnect();
    end;

    for i, v in u4 do
        v:Disconnect();
        local v155 = u5[i];
        u5[i] = nil;

        if v155 then
            local function v157(p156) -- Line: 118
                -- upvalues: TweenService (ref)
                if p156:IsA("ParticleEmitter") then
                    p156.Enabled = false;

                    return;
                end;

                if p156:IsA("PointLight") then
                    TweenService:Create(p156, TweenInfo.new(0.3), {
                        Brightness = 0
                    }):Play();
                end;
            end;

            for _, child in v155[1]:GetChildren() do
                v157(child);
            end;

            if v155[2] then
                v157(v155[2]);
            end;

            v155[1]:Destroy();

            if v155[2] then
                v155[2]:Destroy();
            end;
        end;
    end;

    table.clear(u4);

    if u94 then
        u94:Disconnect();
        u94 = nil;
    end;

    for _, v in u93 do
        for _, v2 in v.parts do
            v2:Destroy();
        end;
    end;

    table.clear(u93);

    for i in u56 do
        local v158 = u56[i];
        u56[i] = nil;

        if v158 then
            v158.follow:Disconnect();
            v158.model:Destroy();
        end;
    end;

    if u129 then
        u129:Disconnect();
        u129 = nil;
    end;

    if u128 then
        u128:Disconnect();
        u128 = nil;
    end;

    if u96 then
        u96.gui:Destroy();
        u96 = nil;
    end;
end);