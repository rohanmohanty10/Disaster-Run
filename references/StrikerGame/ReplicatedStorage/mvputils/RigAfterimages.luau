 

 

local TweenService = game:GetService("TweenService");
local u1 = {
    Head = true,
    Torso = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true
};
local Random_new_ret = Random.new();

local function applyMode(p2: string?, p3: vector, p4: boolean) -- Line: 14
    if p2 == "inward" then
        return -p3, p4;
    end;

    if p2 ~= "outandin" then
        return p3, p4;
    end;

    local v5 = not p4;

    if not v5 then
        p3 = -p3;
    end;

    return p3, v5;
end;

local function applySpread(p6: vector, p7) -- Line: 27
    -- upvalues: Random_new_ret (copy)
    if p6.Magnitude == 0 or (not p7 or p7 == Vector2.zero) then
        return p6;
    end;

    local v8 = Random_new_ret:NextNumber(-math.rad(p7.X * 0.5), (math.rad(p7.X * 0.5)));
    local v9 = Random_new_ret:NextNumber(-math.rad(p7.Y * 0.5), (math.rad(p7.Y * 0.5)));

    return (CFrame.lookAt(Vector3.new(0, 0, 0), p6) * CFrame.Angles(v9, v8, 0)).LookVector;
end;

local function meshId(p10: userdata) -- Line: 38
    if p10:IsA("MeshPart") and p10.MeshId ~= "" then
        return p10.MeshId;
    end;

    local v11 = p10:FindFirstChildOfClass("SpecialMesh");
    local v12;

    if v11 then
        v12 = v11.MeshId ~= "" and v11.MeshId or nil;
    else
        v12 = nil;
    end;

    return v12;
end;

local function templateMatches(p13: userdata, p14: userdata) -- Line: 46
    local v15 = p13:FindFirstChild("HumanoidRootPart", true) or p13:FindFirstChild("Torso", true);
    local v16 = p14:FindFirstChild("HumanoidRootPart", true) or p14:FindFirstChild("Torso", true);
    local v17 = {};
    local v18 = {};

    for _, descendant in p14:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v19 = descendant;
            local v20 = (1 / 0);
            local v21 = nil;

            for _, descendant2 in p13:GetDescendants() do
                if descendant2:IsA("BasePart") and (descendant2.Name == v19.Name and not v17[descendant2]) then
                    local v22;

                    if v19:IsA("MeshPart") and v19.MeshId ~= "" then
                        v22 = v19.MeshId;
                    else
                        local v23 = v19:FindFirstChildOfClass("SpecialMesh");

                        if v23 then
                            v22 = v23.MeshId ~= "" and v23.MeshId or nil;
                        else
                            v22 = nil;
                        end;
                    end;

                    local v24;

                    if descendant2:IsA("MeshPart") and descendant2.MeshId ~= "" then
                        v24 = descendant2.MeshId;
                    else
                        local v25 = descendant2:FindFirstChildOfClass("SpecialMesh");

                        if v25 then
                            v24 = v25.MeshId ~= "" and v25.MeshId or nil;
                        else
                            v24 = nil;
                        end;
                    end;

                    local v26 = 0;

                    if v22 and v24 then
                        v26 = v26 + (v22 == v24 and -100000 or 100000);
                    end;

                    local v27 = v26 + (((v16 and v16.CFrame:PointToObjectSpace(v19.Position) or v19.Position) - (v15 and v15.CFrame:PointToObjectSpace(descendant2.Position) or descendant2.Position)).Magnitude * 100 + (v19.Size - descendant2.Size).Magnitude * 10);

                    if v27 < v20 then
                        v21 = descendant2;
                        v20 = v27;
                    end;
                end;
            end;

            if v21 then
                v18[v19] = v21;
                v17[v21] = true;
            end;
        end;
    end;

    return v18;
end;

local function spawnAfterimage(p28: userdata, p29: boolean, p30: any, p31: any, p32) -- Line: 79
    -- upvalues: applySpread (copy), Random_new_ret (copy), u1 (copy), TweenService (copy)
    local Pivot = p28:GetPivot();
    local v33 = Pivot:VectorToWorldSpace(p31.direction or Vector3.new(0, 0, 0));

    if v33.Magnitude > 0 then
        local mode = p31.mode;

        if mode == "inward" then
            v33 = -v33;
        elseif mode == "outandin" then
            p29 = not p29;

            if not p29 then
                v33 = -v33;
            end;
        end;

        v33 = applySpread(v33, p31.spread);
    end;

    local v34 = v33 * (p31.distance and (Random_new_ret:NextNumber(p31.distance.Min, p31.distance.Max) or 0) or 0) + Pivot:VectorToWorldSpace(p31.positionOffset or Vector3.new(0, 0, 0));
    local Model = Instance.new("Model");
    Model.Name = p31.name or "RigAfterimage";
    local TweenInfo_new_ret = TweenInfo.new(p31.fadeTime or p31.lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, p31.fadeDelay or 0);
    local TweenInfo_new_ret2 = TweenInfo.new(p31.colorFadeTime or p31.lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, p31.colorFadeDelay or 0);

    for _, descendant in (p31.template or p28):GetDescendants() do
        if descendant:IsA("BasePart") and (p31.template or (p31.includeInvisible or descendant.Transparency < 1)) and not (p31.bodyOnly and not (u1[descendant.Name] or p31.includeAccessories and descendant:FindFirstAncestorOfClass("Accessory")) or p31.excludeParts and p31.excludeParts[descendant.Name]) then
            local v35;

            if p31.template then
                v35 = p31.matches[descendant];
            else
                v35 = descendant;
            end;

            if v35 then
                local v36 = descendant:Clone();

                if v36 then
                    for _, descendant2 in v36:GetDescendants() do
                        if descendant2:IsA("JointInstance") or (descendant2:IsA("Constraint") or (descendant2:IsA("LuaSourceContainer") or (descendant2:IsA("BasePart") or not p31.template and (descendant2:IsA("Decal") or (descendant2:IsA("Texture") or descendant2:IsA("SurfaceAppearance")))))) or (descendant2:IsA("SurfaceGui") or (descendant2:IsA("Highlight") or (descendant2:IsA("ParticleEmitter") or (descendant2:IsA("Trail") or (descendant2:IsA("Beam") or descendant2:IsA("Light")))))) then
                            descendant2:Destroy();
                        elseif descendant2:IsA("SpecialMesh") and not p31.template then
                            descendant2.TextureId = "";
                        end;
                    end;

                    if v36:IsA("MeshPart") and not p31.template then
                        v36.TextureID = "";
                    end;

                    v36.Anchored = true;
                    v36.CanCollide = false;
                    v36.CanTouch = false;
                    v36.CanQuery = false;
                    v36.CastShadow = false;
                    v36.Massless = true;
                    v36.Material = Enum.Material.Neon;
                    v36.Color = p32 or p31.startColor;
                    v36.Transparency = p31.initialTransparency;
                    v36.CFrame = v35.CFrame + v34;
                    v36.Parent = Model;

                    if p31.fadeOut ~= false then
                        TweenService:Create(v36, TweenInfo_new_ret, {
                            Transparency = 1
                        }):Play();
                    end;

                    if not p31.colorOverEmit and p31.endColor then
                        TweenService:Create(v36, TweenInfo_new_ret2, {
                            Color = p31.endColor
                        }):Play();
                    end;
                end;
            end;
        end;
    end;

    Model.Parent = p30;
    task.delay(p31.lifetime, function() -- Line: 157
        -- upvalues: Model (copy)
        if Model.Parent then
            Model:Destroy();
        end;
    end);

    return p29;
end;

local function playAfterimages(u37: userdata, p38: any, p39: any) -- Line: 166
    -- upvalues: templateMatches (copy), spawnAfterimage (copy)
    local u40 = {};

    for i, v in p39 do
        u40[i:gsub("_(%l)", string.upper)] = v;
    end;

    local v41;

    if type(u40.imagesPerSecond) == "number" then
        v41 = u40.imagesPerSecond > 0;
    else
        v41 = false;
    end;

    assert(v41, "imagesPerSecond must be positive");
    local v42;

    if type(u40.lifetime) == "number" then
        v42 = u40.lifetime > 0;
    else
        v42 = false;
    end;

    assert(v42, "lifetime must be positive");

    if u40.template then
        u40.matches = templateMatches(u37, u40.template);
    end;

    local v43 = p38:Extend();
    local u44 = v43:Add(Instance.new("Folder"));
    u44.Name = u40.name or "RigAfterimages";
    u44.Parent = u40.parent or workspace.Effects;
    v43:Add(task.spawn(function() -- Line: 182
        -- upvalues: u40 (copy), u37 (copy), u44 (copy), spawnAfterimage (ref)
        local v45 = 1 / u40.imagesPerSecond;
        local os_clock_ret = os.clock();
        local v46 = false;

        while u37.Parent and (u44.Parent and (not u40.emitDuration or os.clock() - os_clock_ret < u40.emitDuration)) do
            local v47;

            if u40.colorOverEmit then
                local startColor = u40.startColor;
                local endColor = u40.endColor;
                local v48 = (os.clock() - os_clock_ret) / u40.emitDuration;
                v47 = startColor:Lerp(endColor, (math.clamp(v48, 0, 1)));
            else
                v47 = nil;
            end;

            v46 = spawnAfterimage(u37, v46, u44, u40, v47);
            task.wait(v45);
        end;
    end));

    return v43;
end;

local u49 = {
    {
        emitDuration = 0.2,
        imagesPerSecond = 20,
        lifetime = 0.2,
        mode = "outandin",
        direction = Vector3.new(1, 0, 0),
        positionOffset = Vector3.new(0, 0.1, 0.5),
        colorFadeDelay = 0.1,
        colorFadeTime = 0.2,
        fadeOut = true,
        fadeDelay = 0.05,
        fadeTime = 0.2,
        spread = Vector2.new(35, 35),
        distance = NumberRange.new(0, 0),
        startColor = Color3.fromRGB(231, 61, 64),
        endColor = Color3.fromRGB(0, 0, 0)
    },
    {
        emitDuration = 1.1,
        imagesPerSecond = 25,
        lifetime = 0.1,
        mode = "outandin",
        direction = Vector3.new(1, 0, 0),
        positionOffset = Vector3.new(0, 0.1, 0.5),
        colorFadeDelay = 0.07,
        colorFadeTime = 0.07,
        fadeOut = false,
        fadeDelay = 0.03,
        fadeTime = 0.1,
        spread = Vector2.new(35, 35),
        distance = NumberRange.new(0, 0),
        startColor = Color3.fromRGB(255, 73, 76),
        endColor = Color3.fromRGB(255, 138, 140)
    },
    {
        emitDuration = 1.1,
        imagesPerSecond = 45,
        lifetime = 0.1,
        mode = "outandin",
        direction = Vector3.new(1, 0, 0),
        positionOffset = Vector3.new(0, 0.1, 0.5),
        colorFadeDelay = 0.07,
        colorFadeTime = 0.07,
        fadeOut = true,
        fadeDelay = 0,
        fadeTime = 0.08,
        spread = Vector2.new(35, 35),
        distance = NumberRange.new(0, 5),
        startColor = Color3.fromRGB(50, 14, 15),
        endColor = Color3.fromRGB(0, 0, 0)
    },
    {
        emitDuration = 0.45,
        imagesPerSecond = 25,
        lifetime = 0.1,
        mode = "out",
        direction = Vector3.new(0, 0, 1),
        positionOffset = Vector3.new(0, 0.1, 0.5),
        colorFadeDelay = 0.07,
        colorFadeTime = 0.1,
        fadeOut = false,
        fadeDelay = 0,
        fadeTime = 0.3,
        spread = Vector2.new(25, 25),
        distance = NumberRange.new(0, 5),
        startColor = Color3.fromRGB(249, 69, 75),
        endColor = Color3.fromRGB(0, 0, 0)
    },
    {
        emitDuration = 1.1,
        imagesPerSecond = 15,
        lifetime = 0.1,
        mode = "outandin",
        direction = Vector3.new(1, 0, 0),
        positionOffset = Vector3.new(0, 0.1, 0.2),
        colorFadeDelay = 0.07,
        colorFadeTime = 0.1,
        fadeOut = false,
        fadeDelay = 0,
        fadeTime = 0.3,
        spread = Vector2.new(25, 25),
        distance = NumberRange.new(0, 1),
        startColor = Color3.fromRGB(249, 69, 75),
        endColor = Color3.fromRGB(0, 0, 0)
    },
    {
        emitDuration = 1.1,
        imagesPerSecond = 12,
        lifetime = 0.16,
        mode = "outandin",
        direction = Vector3.new(1, 0, 0),
        positionOffset = Vector3.new(0, 0.1, 0.2),
        colorFadeDelay = 0.04,
        colorFadeTime = 0.1,
        fadeOut = true,
        fadeDelay = 0.02,
        fadeTime = 0.12,
        spread = Vector2.new(30, 24),
        distance = NumberRange.new(0.25, 2),
        startColor = Color3.fromRGB(82, 8, 13),
        endColor = Color3.fromRGB(10, 0, 0)
    }
};

return {
    play = playAfterimages,

    play2011x = function(p50: userdata, p51: number, p52: any) -- Line: 304, Name: play2011x
        -- upvalues: u49 (copy), playAfterimages (copy)
        local v53 = u49[p51];

        if v53 then
            local table_clone_ret = table.clone(v53);
            table_clone_ret.name = "2011xAfterImage";
            table_clone_ret.bodyOnly = true;
            table_clone_ret.includeAccessories = true;
            table_clone_ret.includeInvisible = true;
            table_clone_ret.initialTransparency = 0;

            return playAfterimages(p50, p52, table_clone_ret);
        end;
    end
};