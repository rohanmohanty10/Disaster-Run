 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 205, 112);

local function label(p2, p3, p4, p5, p6, p7, p8) -- Line: 13
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p3;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0, p5);
    TextLabel.Size = UDim2.fromScale(1, p6);
    TextLabel.Font = p8 or Enum.Font.FredokaOne;
    TextLabel.Text = p4;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = p7;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 4;
    UIStroke.Color = Color3.fromRGB(30, 20, 10);
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = p2;

    return TextLabel;
end;

local function board(p9, p10, p11) -- Line: 32
    -- upvalues: label (copy), Color3_fromRGB_ret (copy)
    local Head = p9:FindFirstChild("Head");
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "SpotlightBoard";
    BillboardGui.Adornee = Head;
    BillboardGui.Size = UDim2.fromScale(90, 30);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, (Head and Head.Size.Y or 14) * 0.5 + 22, 0);
    BillboardGui.MaxDistance = 5000;
    BillboardGui.LightInfluence = 0;
    label(BillboardGui, "Title", "⭐ SPOTLIGHT ⭐", 0, 0.24, Color3_fromRGB_ret);
    local v12 = label(BillboardGui, "PlayerName", p10, 0.24, 0.52, Color3.new(1, 1, 1));
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 244, 196), Color3_fromRGB_ret);
    UIGradient.Rotation = 90;
    UIGradient.Parent = v12;

    if p11 ~= "" and p11 ~= p10 then
        label(BillboardGui, "Username", "@" .. p11, 0.76, 0.22, Color3.fromRGB(230, 230, 230), Enum.Font.GothamBold);
    end;

    BillboardGui.Parent = p9;
end;

local function lights(p13) -- Line: 54
    -- upvalues: Color3_fromRGB_ret (copy)
    local HumanoidRootPart = p13:FindFirstChild("HumanoidRootPart");
    local v14 = p13:FindFirstChild("Torso") or HumanoidRootPart;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Range = 60;
    PointLight.Brightness = 3;
    PointLight.Parent = v14;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "BeamTop";
    Attachment.Position = Vector3.new(0, 7, 0);
    Attachment.Parent = v14;

    for i, v in { -1, 1 } do
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Name = "BeamFoot" .. i;
        Attachment2.Position = Vector3.new(v * 14, -42, -28);
        Attachment2.Parent = HumanoidRootPart;
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment2;
        Beam.Attachment1 = Attachment;
        Beam.Color = ColorSequence.new(Color3_fromRGB_ret);
        Beam.LightEmission = 1;
        Beam.Transparency = NumberSequence.new(0.55, 0.95);
        Beam.Width0 = 6;
        Beam.Width1 = 40;
        Beam.FaceCamera = true;
        Beam.Segments = 1;
        Beam.Parent = HumanoidRootPart;
    end;

    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Sparkles";
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new(4, 0);
    ParticleEmitter.Lifetime = NumberRange.new(1.5, 2.5);
    ParticleEmitter.Rate = 25;
    ParticleEmitter.Speed = NumberRange.new(4, 10);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Parent = v14;
end;

local function place(p15, p16) -- Line: 97
    local HumanoidRootPart = p15:FindFirstChild("HumanoidRootPart");
    local v17 = 3 * p15:GetScale();
    p15:PivotTo((p16 + Vector3.new(0, v17, 0)) * HumanoidRootPart.CFrame:Inverse() * p15:GetPivot());
end;

function v1.start(p18) -- Line: 103
    -- upvalues: Players (copy), place (copy), board (copy), lights (copy), RunService (copy)
    local EmotePlayback = require(p18.package:WaitForChild("Emotes"):WaitForChild("EmotePlayback"));
    local Shared = p18.Shared;
    local state = p18.state;
    local Folder = Instance.new("Folder");
    Folder.Name = "TrollSpotlightLocal";
    Folder.Parent = workspace;
    local u19 = nil;
    local u20 = 0;
    local u21 = 0;

    local function clear() -- Line: 113
        -- upvalues: u20 (ref), u19 (ref), EmotePlayback (copy)
        u20 = u20 + 1;

        if u19 then
            if u19.track then
                EmotePlayback.dispose(u19.track);
            end;

            if u19.model then
                u19.model:Destroy();
            end;

            u19 = nil;
        end;
    end;

    local function build(p22, p23) -- Line: 126
        -- upvalues: state (copy), Players (ref), u20 (ref), place (ref), board (ref), lights (ref), Folder (copy), u19 (ref)
        local Attribute = state:GetAttribute("SpotlightUserId");
        local Attribute2 = state:GetAttribute("SpotlightName");
        local Attribute3 = state:GetAttribute("SpotlightUsername");
        local Attribute4 = state:GetAttribute("SpotlightCFrame");

        if type(Attribute) ~= "number" or (type(Attribute2) ~= "string" or typeof(Attribute4) ~= "CFrame") then
            return;
        end;

        local SpotlightLook = state:FindFirstChild("SpotlightLook");
        local v24;

        if SpotlightLook and SpotlightLook:IsA("HumanoidDescription") then
            v24 = SpotlightLook:Clone();
        else
            local success, result = pcall(Players.GetHumanoidDescriptionFromUserIdAsync, Players, Attribute);
            v24 = success and result and result or Instance.new("HumanoidDescription");
        end;

        local success, result = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, v24, Enum.HumanoidRigType.R6);
        v24:Destroy();

        if not (success and result) then
            local CreateHumanoidModelFromDescriptionAsync = Players.CreateHumanoidModelFromDescriptionAsync;
            local HumanoidDescription = Instance.new("HumanoidDescription");
            local v25;
            v25, result = pcall(CreateHumanoidModelFromDescriptionAsync, Players, HumanoidDescription, Enum.HumanoidRigType.R6);

            if not (v25 and result) then
                return;
            end;
        end;

        if u20 ~= p23 then
            result:Destroy();

            return;
        end;

        for _, descendant in result:GetDescendants() do
            if descendant:IsA("LuaSourceContainer") or (descendant:IsA("ForceField") or descendant:IsA("Tool")) then
                descendant:Destroy();
            elseif descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Anchored = descendant.Name == "HumanoidRootPart";
            end;
        end;

        local v26 = result:FindFirstChildOfClass("Humanoid");

        if not (v26 and result:FindFirstChild("HumanoidRootPart")) then
            result:Destroy();

            return;
        end;

        v26.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        v26.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
        v26.BreakJointsOnDeath = false;
        v26:SetStateEnabled(Enum.HumanoidStateType.Dead, false);

        if not v26:FindFirstChildOfClass("Animator") then
            Instance.new("Animator").Parent = v26;
        end;

        result.Name = "TrollSpotlight";
        pcall(result.ScaleTo, result, 14);
        place(result, Attribute4);
        board(result, Attribute2, type(Attribute3) == "string" and Attribute3 and Attribute3 or "");
        lights(result);
        result.Parent = Folder;
        u19 = {
            at = p22,
            model = result,
            cframe = Attribute4
        };
    end;

    local u27 = 0;
    RunService.Heartbeat:Connect(function(p28) -- Line: 187
        -- upvalues: u27 (ref), state (copy), u19 (ref), u20 (ref), EmotePlayback (copy), u21 (ref), build (copy), place (ref), Shared (copy)
        u27 = u27 + p28;

        if u27 < 0.3 then
            return;
        end;

        u27 = 0;
        local Attribute = state:GetAttribute("SpotlightAt");

        if type(Attribute) ~= "number" then
            if u19 or u20 > 0 then
                u20 = u20 + 1;

                if u19 then
                    if u19.track then
                        EmotePlayback.dispose(u19.track);
                    end;

                    if u19.model then
                        u19.model:Destroy();
                    end;

                    u19 = nil;
                end;
            end;

            return;
        end;

        if not u19 or u19.at ~= Attribute then
            if not u19 and os.clock() < u21 then
                return;
            end;

            if not (u19 and (u19.at == Attribute or u19.pending)) then
                u20 = u20 + 1;

                if u19 then
                    if u19.track then
                        EmotePlayback.dispose(u19.track);
                    end;

                    if u19.model then
                        u19.model:Destroy();
                    end;

                    u19 = nil;
                end;

                u20 = u20 + 1;
                local u29 = u20;
                u19 = {
                    pending = true,
                    at = Attribute
                };
                task.spawn(function() -- Line: 209
                    -- upvalues: build (ref), Attribute (copy), u29 (copy), u20 (ref), u19 (ref), u21 (ref)
                    local success, result = pcall(build, Attribute, u29);

                    if not success then
                        warn("Spotlight:", result);
                    end;

                    if u20 == u29 and (u19 and u19.pending) then
                        u19 = nil;
                        u21 = os.clock() + 5;
                    end;
                end);
            end;

            return;
        end;

        if u19.pending or not u19.model then
            return;
        end;

        local Attribute2 = state:GetAttribute("SpotlightCFrame");

        if typeof(Attribute2) == "CFrame" and Attribute2 ~= u19.cframe then
            u19.cframe = Attribute2;
            place(u19.model, Attribute2);
        end;

        local Attribute3 = state:GetAttribute("SpotlightDance");

        if type(Attribute3) ~= "string" or not Shared.dance(Attribute3) then
            return;
        end;

        if u19.dance ~= Attribute3 then
            if u19.track then
                EmotePlayback.dispose(u19.track);
            end;

            local v30 = u19.model:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator");
            u19.track = EmotePlayback.load(v30, Attribute3);
            u19.dance = Attribute3;

            if u19.track then
                u19.track:Play(0.2);
            end;
        end;

        local track = u19.track;

        if not track then
            return;
        end;

        if not track.IsPlaying then
            track:Play(0.1);
        end;

        local Length = track.Length;

        if Length > 0 then
            local v31 = Shared.loopTime(Attribute, Length);
            local math_abs_ret = math.abs(track.TimePosition - v31);

            if math_abs_ret > 0.12 and math_abs_ret < Length - 0.12 then
                track.TimePosition = v31;
            end;
        end;
    end);
end;

return v1;