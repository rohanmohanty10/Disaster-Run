 

 

local RunService = game:GetService("RunService");
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 40, 20);

local function emitter(p2, p3) -- Line: 20
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in p3 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = p2;

    return ParticleEmitter;
end;

local function ghost(p4, p5, p6, p7, p8, p9) -- Line: 29
    local Part = Instance.new("Part");
    Part.Name = p4;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = p5;
    Part.Color = p6;
    Part.Material = p7;
    Part.Transparency = p8;
    Part.Parent = p9;

    return Part;
end;

local function puff(p10, p11, p12, p13, p14) -- Line: 46
    local SmoothPlastic = Enum.Material.SmoothPlastic;
    local Part = Instance.new("Part");
    Part.Name = "Puff";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Color = p11;
    Part.Material = SmoothPlastic;
    Part.Transparency = 1;
    Part.Parent = p14;
    Part.Position = p10;
    local v15 = {
        Rate = 0,
        Texture = p12,
        Color = ColorSequence.new(p11),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 5) }),
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1) }),
        Lifetime = NumberRange.new(0.6, 1.2),
        Speed = NumberRange.new(4, 9),
        SpreadAngle = Vector2.new(180, 40),
        LightEmission = p12 == "rbxasset://textures/particles/fire_main.dds" and 1 or 0
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in v15 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p13);
    task.delay(1.6, function() -- Line: 61
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

function v1.start(u16) -- Line: 66
    -- upvalues: RunService (copy), puff (copy), Color3_fromRGB_ret (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Folder = Instance.new("Folder");
    Folder.Name = "TrollLavaLocal";
    Folder.Parent = workspace;
    local u17 = nil;
    local u18 = false;

    local function teardown() -- Line: 74
        -- upvalues: u17 (ref), Folder (copy), u18 (ref), RunService (ref)
        if u17 then
            for _, child in Folder:GetChildren() do
                child:Destroy();
            end;

            u17 = nil;
        end;

        if u18 then
            u18 = false;
            RunService:UnbindFromRenderStep("TrollLavaShake");
        end;
    end;

    local function addPillar(p19) -- Line: 87
        -- upvalues: u17 (ref)
        if not p19:IsA("BasePart") or u17.pillars[p19] then
            return;
        end;

        local Attribute = p19:GetAttribute("Delay");
        local Attribute2 = p19:GetAttribute("FloorY");
        u17.pillars[p19] = {
            offset = nil,
            puffed = false,
            floorY = type(Attribute2) == "number" and Attribute2 and Attribute2 or p19.Position.Y - p19.Size.Y / 2 + 2,
            final = p19.CFrame,
            height = p19.Size.Y + 0.2,
            delay = type(Attribute) == "number" and Attribute and Attribute or 0
        };
        local lastDelay = u17.lastDelay;
        local v20 = type(Attribute) == "number" and Attribute and Attribute or 0;
        u17.lastDelay = math.max(lastDelay, v20);
        u17.settled = false;
    end;

    local function addArea(p21) -- Line: 106
        -- upvalues: Folder (copy), u17 (ref)
        local Attribute = p21:GetAttribute("AreaCFrame");
        local Attribute2 = p21:GetAttribute("AreaSize");

        if typeof(Attribute) ~= "CFrame" or typeof(Attribute2) ~= "Vector3" then
            return;
        end;

        local v22 = {
            lava = p21,
            frame = p21.CFrame,
            areaFrame = Attribute
        };
        local Color3_fromRGB_ret2 = Color3.fromRGB(255, 70, 25);
        local Vector3_new_ret = Vector3.new(p21.Size.X, 0.2, p21.Size.Z);
        local Color3_fromRGB_ret3 = Color3.fromRGB(255, 45, 15);
        local Neon = Enum.Material.Neon;
        local Part = Instance.new("Part");
        Part.Name = "LavaGlow";
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Size = Vector3_new_ret;
        Part.Color = Color3_fromRGB_ret3;
        Part.Material = Neon;
        Part.Transparency = 0.82;
        Part.Parent = Folder;
        v22.glow = Part;
        local Attribute3 = p21:GetAttribute("SpillCFrame");
        local Attribute4 = p21:GetAttribute("SpillWidth");

        if typeof(Attribute3) == "CFrame" and type(Attribute4) == "number" then
            local WedgePart = Instance.new("WedgePart");
            WedgePart.Name = "LavaSpill";
            WedgePart.Anchored = true;
            WedgePart.CanCollide = false;
            WedgePart.CanQuery = false;
            WedgePart.CanTouch = false;
            WedgePart.CastShadow = false;
            WedgePart.Color = p21.Color;
            WedgePart.Material = p21.Material;
            WedgePart.MaterialVariant = p21.MaterialVariant;
            WedgePart.Size = Vector3.new(Attribute4, 1, 16);
            WedgePart.Parent = Folder;
            v22.spill = WedgePart;
            v22.spillFrame = Attribute3;
        end;

        local Vector3_new_ret2 = Vector3.new(Attribute2.X + 30, 0.2, Attribute2.Z + 30);
        local SmoothPlastic = Enum.Material.SmoothPlastic;
        local Part2 = Instance.new("Part");
        Part2.Name = "LavaSurface";
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        Part2.Size = Vector3_new_ret2;
        Part2.Color = Color3_fromRGB_ret2;
        Part2.Material = SmoothPlastic;
        Part2.Transparency = 1;
        Part2.Parent = Folder;
        v22.surface = Part2;
        local math_clamp_ret = math.clamp(Attribute2.X * Attribute2.Z / 10000, 1, 4);
        local v23 = {
            Texture = "rbxasset://textures/particles/sparkles_main.dds",
            LightEmission = 1,
            Acceleration = Vector3.new(0, 2, 0),
            Color = ColorSequence.new(Color3.fromRGB(255, 200, 80), Color3.fromRGB(255, 70, 20)),
            Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 0) }),
            Lifetime = NumberRange.new(1.2, 2.6),
            Speed = NumberRange.new(4, 11),
            SpreadAngle = Vector2.new(25, 25),
            Rate = math_clamp_ret * 45,
            EmissionDirection = Enum.NormalId.Top
        };
        local ParticleEmitter = Instance.new("ParticleEmitter");

        for i, v in v23 do
            ParticleEmitter[i] = v;
        end;

        ParticleEmitter.Parent = Part2;
        local v24 = {
            Texture = "rbxasset://textures/particles/fire_main.dds",
            LightEmission = 1,
            Color = ColorSequence.new(Color3.fromRGB(255, 120, 30)),
            Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.8), NumberSequenceKeypoint.new(1, 0) }),
            Lifetime = NumberRange.new(0.4, 0.9),
            Speed = NumberRange.new(1, 3),
            Rate = math_clamp_ret * 30,
            EmissionDirection = Enum.NormalId.Top
        };
        local ParticleEmitter2 = Instance.new("ParticleEmitter");

        for i, v in v24 do
            ParticleEmitter2[i] = v;
        end;

        ParticleEmitter2.Parent = Part2;
        local v25 = {
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            Color = ColorSequence.new(Color3.fromRGB(70, 60, 60)),
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1) }),
            Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3), NumberSequenceKeypoint.new(1, 9) }),
            Lifetime = NumberRange.new(3, 5),
            Speed = NumberRange.new(2, 4),
            Rate = math_clamp_ret * 6,
            EmissionDirection = Enum.NormalId.Top
        };
        local ParticleEmitter3 = Instance.new("ParticleEmitter");

        for i, v in v25 do
            ParticleEmitter3[i] = v;
        end;

        ParticleEmitter3.Parent = Part2;

        for _, v in { -0.35, 0, 0.35 } do
            local v26 = v;

            for _, v2 in { -0.35, 0, 0.35 } do
                local Attachment = Instance.new("Attachment");
                Attachment.Position = Vector3.new(v26 * Attribute2.X, 1.5, v2 * Attribute2.Z);
                local PointLight = Instance.new("PointLight");
                PointLight.Color = Color3_fromRGB_ret2;
                PointLight.Range = 32;
                PointLight.Brightness = 1.6;
                PointLight.Parent = Attachment;
                Attachment.Parent = Part2;
            end;
        end;

        table.insert(u17.areas, v22);
    end;

    local function setup(u27) -- Line: 189
        -- upvalues: u17 (ref), addPillar (copy), addArea (copy)
        local Pillars = u27:FindFirstChild("Pillars");
        local Areas = u27:FindFirstChild("Areas");

        if not (Pillars and (Areas and #Areas:GetChildren() ~= 0)) then
            return false;
        end;

        u17 = {
            lastDelay = 0,
            settled = false,
            sounds = 0,
            folder = u27,
            areas = {},
            pillars = {}
        };

        for _, child in Pillars:GetChildren() do
            addPillar(child);
        end;

        Pillars.ChildAdded:Connect(function(p28) -- Line: 206
            -- upvalues: u17 (ref), u27 (copy), addPillar (ref)
            if u17 and u17.folder == u27 then
                addPillar(p28);
            end;
        end);

        for _, child in Areas:GetChildren() do
            if child:IsA("BasePart") then
                addArea(child);
            end;
        end;

        return #u17.areas > 0;
    end;

    local function number(p29, p30) -- Line: 219
        -- upvalues: u17 (ref)
        local Attribute = u17.folder:GetAttribute(p29);

        return type(Attribute) == "number" and Attribute and Attribute or p30;
    end;

    local function lavaTop(p31, p32) -- Line: 225
        -- upvalues: u17 (ref)
        local v33 = p31:GetAttribute("LavaFrom") or 0;
        local v34 = p31:GetAttribute("LavaTo") or 0;
        local Attribute = u17.folder:GetAttribute("LavaStart");
        local v35 = type(Attribute) == "number" and Attribute and Attribute or p32;
        local Attribute2 = u17.folder:GetAttribute("LavaEnd");
        local v36 = type(Attribute2) == "number" and Attribute2 and Attribute2 or p32 + 1;
        local Attribute3 = u17.folder:GetAttribute("DrainAt");

        if type(Attribute3) ~= "number" or Attribute3 > p32 then
            local v37 = (p32 - v35) / math.max(v36 - v35, 0.1);
            local math_clamp_ret = math.clamp(v37, 0, 1);

            return v33 + (v34 - v33) * math_clamp_ret;
        end;

        local Attribute4 = u17.folder:GetAttribute("Drain");
        local v38 = type(Attribute4) == "number" and Attribute4 and Attribute4 or 6;
        local math_clamp_ret = math.clamp((p32 - Attribute3) / v38, 0, 1);
        local Attribute5 = u17.folder:GetAttribute("DrainFraction");
        local v39 = v33 + (v34 - v33) * (type(Attribute5) == "number" and Attribute5 and Attribute5 or 0);

        return v39 + (v33 - 3 - v39) * math_clamp_ret;
    end;

    local function shake() -- Line: 238
        -- upvalues: u17 (ref), workspace_CurrentCamera (copy)
        if not u17 then
            return;
        end;

        local ServerTimeNow = workspace:GetServerTimeNow();
        local Attribute = u17.folder:GetAttribute("StartAt");
        local v40 = type(Attribute) == "number" and Attribute and Attribute or ServerTimeNow;
        local v41 = v40 + u17.lastDelay;
        local Attribute2 = u17.folder:GetAttribute("PillarRise");
        local v42 = v41 + (type(Attribute2) == "number" and Attribute2 and Attribute2 or 1.4) + 0.3;

        if ServerTimeNow < v40 or v42 < ServerTimeNow then
            return;
        end;

        local v43 = 0.35 * (1 - (ServerTimeNow - v40) / (v42 - v40) * 0.6);
        local Random_new_ret = Random.new();
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(Random_new_ret:NextNumber(-1, 1) * v43, Random_new_ret:NextNumber(-1, 1) * v43, 0) * CFrame.Angles(0, 0, Random_new_ret:NextNumber(-1, 1) * v43 * 0.02);
    end;

    local function step() -- Line: 255
        -- upvalues: u17 (ref), puff (ref), Folder (copy), u16 (copy), lavaTop (copy), u18 (ref), RunService (ref), shake (copy)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local Attribute = u17.folder:GetAttribute("StartAt");
        local v44 = type(Attribute) == "number" and Attribute and Attribute or ServerTimeNow;
        local Attribute2 = u17.folder:GetAttribute("PillarRise");
        local v45 = type(Attribute2) == "number" and Attribute2 and Attribute2 or 1.4;
        local Attribute3 = u17.folder:GetAttribute("DrainAt");
        local Attribute4 = u17.folder:GetAttribute("Drain");
        local v46 = type(Attribute4) == "number" and Attribute4 and Attribute4 or 6;
        local v47;

        if type(Attribute3) == "number" then
            v47 = Attribute3 + v46 * 0.45 <= ServerTimeNow;
        else
            v47 = false;
        end;

        if not u17.settled or v47 then
            local v48 = true;

            for i, v in u17.pillars do
                if i.Parent then
                    local math_clamp_ret = math.clamp((ServerTimeNow - (v44 + v.delay)) / v45, 0, 1);
                    local v49 = v47 and (math.clamp((ServerTimeNow - (Attribute3 + v46 * 0.45)) / (v46 * 0.55), 0, 1) or 0) or 0;
                    local v50 = -v.height * (1 - (1 - (1 - math_clamp_ret) ^ 3)) - v.height * v49;

                    if math_clamp_ret < 1 then
                        v48 = false;
                    end;

                    if math_clamp_ret > 0 and not v.puffed then
                        v.puffed = true;
                        puff(v.final.Position * Vector3.new(1, 0, 1) + Vector3.new(0, v.floorY + 0.5, 0), Color3.fromRGB(150, 130, 110), "rbxasset://textures/particles/smoke_main.dds", 8, Folder);

                        if u17.sounds < 6 then
                            local v51 = u17;
                            v51.sounds = v51.sounds + 1;
                            u16.sound("03_Catching/CatchImpact", nil, 0.5);
                        end;
                    end;

                    if v50 ~= v.offset then
                        v.offset = v50;
                        i.CFrame = v.final + Vector3.new(0, v50, 0);
                    end;
                else
                    u17.pillars[i] = nil;
                end;
            end;

            if v48 then
                v48 = not v47;
            end;

            u17.settled = v48;
        end;

        local v52;

        if type(Attribute3) == "number" then
            v52 = Attribute3 + v46 * 0.6 < ServerTimeNow;
        else
            v52 = false;
        end;

        for _, v in u17.areas do
            local lava = v.lava;
            local v53 = lavaTop(lava, ServerTimeNow);
            local frame = v.frame;
            local v54 = lava:GetAttribute("Thickness") or lava.Size.Y;
            lava.CFrame = CFrame.new(frame.X, v53 - v54 / 2, frame.Z) * frame.Rotation;
            v.glow.CFrame = CFrame.new(frame.X, v53 + 0.12, frame.Z) * frame.Rotation;
            v.surface.CFrame = CFrame.new(v.areaFrame.X, v53 + 0.15, v.areaFrame.Z) * v.areaFrame.Rotation;
            local v55 = lava:GetAttribute("FloorY") or v53;

            if v.spill then
                local v56 = v55 - 18;
                local math_max_ret = math.max(0.2, v53 - v56);
                local spill = v.spill;
                spill.Size = Vector3.new(spill.Size.X, math_max_ret, spill.Size.Z);
                spill.CFrame = v.spillFrame * CFrame.new(0, v56 + math_max_ret / 2, -spill.Size.Z / 2);
            end;

            local v57;

            if v55 - 1 < v53 then
                v57 = not v52;
            else
                v57 = false;
            end;

            for _, child in v.surface:GetChildren() do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = v57;
                end;
            end;
        end;

        local v58 = not u16.exempt();

        if v58 then
            if v44 <= ServerTimeNow then
                v58 = ServerTimeNow <= v44 + u17.lastDelay + v45 + 0.3;
            else
                v58 = false;
            end;
        end;

        if v58 ~= u18 then
            u18 = v58;

            if v58 then
                RunService:BindToRenderStep("TrollLavaShake", Enum.RenderPriority.Camera.Value + 1, shake);

                return;
            end;

            RunService:UnbindFromRenderStep("TrollLavaShake");
        end;
    end;

    local u59 = {};
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "TrollLavaFlash";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 60;
    ScreenGui:SetAttribute("SelfManagedText", true);
    ScreenGui.Parent = u16.player:WaitForChild("PlayerGui");
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3_fromRGB_ret;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    local u60 = setmetatable({}, {
        __mode = "k"
    });

    local function bodies() -- Line: 346
        local v61 = {};

        for _, v in game:GetService("Players"):GetPlayers() do
            if v.Character and v.Character:GetAttribute("LavaBurning") then
                table.insert(v61, v.Character);
            end;
        end;

        local ClientBots = workspace:FindFirstChild("ClientBots");

        for _, v in ClientBots and ClientBots:GetChildren() or {} do
            if v:IsA("Model") and v:GetAttribute("LavaBurning") then
                table.insert(v61, v);
            end;
        end;

        return v61;
    end;

    local function oof(p62, p63) -- Line: 362
        local HumanoidRootPart = p62:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxasset://sounds/uuhhh.mp3";
        Sound.Volume = p63;
        Sound.RollOffMaxDistance = 60;
        Sound.Parent = HumanoidRootPart;
        Sound:Play();
        Sound.Ended:Once(function() -- Line: 373
            -- upvalues: Sound (copy)
            Sound:Destroy();
        end);
        task.delay(4, function() -- Line: 376
            -- upvalues: Sound (copy)
            if Sound.Parent then
                Sound:Destroy();
            end;
        end);
    end;

    local function burning(p64) -- Line: 383
        -- upvalues: u16 (copy), bodies (copy), u59 (copy), Color3_fromRGB_ret (ref), Folder (copy), u60 (copy), oof (copy), Frame (copy)
        local Character = u16.player.Character;
        local v65 = bodies();
        local Position = workspace.CurrentCamera.Focus.Position;
        table.sort(v65, function(p66, p67) -- Line: 387
            -- upvalues: Position (copy)
            return (p66:GetPivot().Position - Position).Magnitude < (p67:GetPivot().Position - Position).Magnitude;
        end);
        local v68 = math.sin(p64 * 9) * 0.5 + 0.5;
        local v69 = {};

        for i, v in v65 do
            if i > 10 then
                break;
            end;

            v69[v] = true;
            local v70 = u59[v];

            if not (v70 and v70.Parent) then
                v70 = Instance.new("Highlight");
                v70.Name = "LavaBurn";
                v70.FillColor = Color3_fromRGB_ret;
                v70.OutlineColor = Color3.fromRGB(255, 140, 60);
                v70.DepthMode = Enum.HighlightDepthMode.Occluded;
                v70.Adornee = v;
                v70.Parent = Folder;
                u59[v] = v70;
            end;

            v70.FillTransparency = v68 * 0.45 + 0.25;
            v70.OutlineTransparency = v68 * 0.5 + 0.3;

            if os.clock() >= (u60[v] or 0) then
                u60[v] = os.clock() + (v == Character and 1.1 or 1.6);
                oof(v, v == Character and 0.6 or 0.35);
            end;
        end;

        for i, v in u59 do
            if not v69[i] then
                v:Destroy();
                u59[i] = nil;
            end;
        end;

        local v71;

        if Character == nil then
            v71 = false;
        else
            v71 = v69[Character] == true;
        end;

        Frame.BackgroundTransparency = v71 and v68 * 0.2 + 0.72 or 1;
    end;

    RunService.RenderStepped:Connect(function() -- Line: 425
        -- upvalues: burning (copy), u17 (ref), teardown (copy), setup (copy), step (copy)
        local success, result = pcall(burning, os.clock());

        if not success then
            warn("Lava burning:", result);
        end;

        local TrollLava = workspace:FindFirstChild("TrollLava");

        if u17 and u17.folder ~= TrollLava then
            teardown();
        end;

        if TrollLava and not (u17 or setup(TrollLava)) then
            return;
        end;

        if u17 then
            local success2, result2 = pcall(step);

            if not success2 then
                warn("Floor is lava:", result2);
                teardown();
            end;
        end;
    end);
    u16.on("Burn", function(p72) -- Line: 448
        -- upvalues: puff (ref), Folder (copy)
        if typeof(p72) ~= "Vector3" then
            return;
        end;

        puff(p72, Color3.fromRGB(255, 110, 30), "rbxasset://textures/particles/fire_main.dds", 25, Folder);
        puff(p72, Color3.fromRGB(80, 70, 70), "rbxasset://textures/particles/smoke_main.dds", 10, Folder);
    end);
end;

return v1;