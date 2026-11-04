 

 

local TweenService = game:GetService("TweenService");
local u1 = {};

local function getTextures(p2: userdata) -- Line: 61
    local Children = p2:GetChildren();
    table.sort(Children, function(p3, p4) -- Line: 64
        return (tonumber(p3.Name) or (1 / 0)) < (tonumber(p4.Name) or (1 / 0));
    end);
    local v5 = {};

    for _, v in ipairs(Children) do
        if v:IsA("Decal") or v:IsA("Texture") then
            table.insert(v5, v.Texture);
        end;
    end;

    return v5;
end;

local function createWeld(p6: userdata, p7: userdata, p8) -- Line: 80
    local Weld = Instance.new("Weld");
    Weld.Part0 = p6;
    Weld.Part1 = p7;
    Weld.C0 = p8 or p6.CFrame:ToObjectSpace(p7.CFrame);
    Weld.Parent = p7;

    return Weld;
end;

local function toVector3(p9) -- Line: 89
    if typeof(p9) == "Vector3" then
        return p9;
    end;

    return Vector3.new(p9, p9, p9);
end;

local function createTweenInfo(p10: table?) -- Line: 96
    if p10 then
        return TweenInfo.new(p10.Time or 0.3, p10.EasingStyle or Enum.EasingStyle.Quad, p10.EasingDirection or Enum.EasingDirection.Out, 0, false, p10.DelayTime or 0);
    end;

    return TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
end;

function u1.Create(u11: table) -- Line: 109
    -- upvalues: getTextures (copy), createTweenInfo (copy), TweenService (copy)
    assert(u11.Mesh, "Mesh is required");
    assert(u11.TextureFolder, "TextureFolder is required");
    local u12 = getTextures(u11.TextureFolder);

    if #u12 == 0 then
        warn("[MeshFlipbook] No textures found in folder");

        return nil;
    end;

    local u13 = u11.FPS or 30;
    local v14 = u11.Parent or workspace;
    local v15 = u11.Color or Color3.new(1, 1, 1);
    local u16 = u11.AutoDestroy ~= false;
    local u17 = u11.Mesh:Clone();
    local u18 = u17:FindFirstChildWhichIsA("Decal");

    if not u18 then
        warn("[MeshFlipbook] No Decal found in mesh");
        u17:Destroy();

        return nil;
    end;

    u18.Color3 = v15;
    local v19 = 0;

    if typeof(u11.Transparency) == "number" then
        v19 = u11.Transparency;
    elseif typeof(u11.Transparency) == "table" then
        v19 = u11.Transparency.Start;
    end;

    u18.Transparency = v19;
    local u20 = u17:FindFirstChildWhichIsA("SpecialMesh") or u17:FindFirstChildWhichIsA("DataModelMesh");

    if u11.Scale and u20 then
        local Start = u11.Scale.Start;

        if typeof(Start) ~= "Vector3" then
            Start = Vector3.new(Start, Start, Start);
        end;

        u20.Scale = Start;
    end;

    if u11.Rotation and u11.Rotation.Start then
        u17.Orientation = u11.Rotation.Start;
    end;

    if u11.CFrame then
        u17.CFrame = u11.CFrame;
    end;

    u17.Parent = v14;

    if u11.WeldTo then
        u17.Anchored = false;
        local WeldTo = u11.WeldTo;
        local Offset = u11.Offset;
        local Weld = Instance.new("Weld");
        Weld.Part0 = WeldTo;
        Weld.Part1 = u17;
        Weld.C0 = Offset or WeldTo.CFrame:ToObjectSpace(u17.CFrame);
        Weld.Parent = u17;
    end;

    local u21 = nil;

    local function startAnimations() -- Line: 166
        -- upvalues: u11 (copy), u20 (copy), createTweenInfo (ref), TweenService (ref), u17 (copy), u18 (copy)
        if u11.Scale and u20 then
            local End = u11.Scale.End;

            if typeof(End) ~= "Vector3" then
                End = Vector3.new(End, End, End);
            end;

            TweenService:Create(u20, createTweenInfo(u11.Scale.Tween), {
                Scale = End
            }):Play();
        end;

        if u11.Rotation then
            local v22 = createTweenInfo(u11.Rotation.Tween);

            if not u11.WeldTo then
                u17.Anchored = false;
            end;

            TweenService:Create(u17, v22, {
                Orientation = u11.Rotation.End
            }):Play();
        end;

        if typeof(u11.Transparency) == "table" then
            TweenService:Create(u18, createTweenInfo(u11.Transparency.Tween), {
                Transparency = u11.Transparency.End
            }):Play();
        end;
    end;

    u21 = {
        IsPlaying = false,
        Instance = u17,
        Decal = u18,
        SpecialMesh = u20,

        Stop = function(p23) -- Line: 231, Name: Stop
            p23.IsPlaying = false;
        end,

        Play = function() -- Line: 187, Name: playAnimation
            -- upvalues: u21 (ref), startAnimations (copy), u13 (copy), u12 (copy), u17 (copy), u18 (copy), u11 (copy), u16 (copy)
            if u21.IsPlaying then
                return;
            end;

            u21.IsPlaying = true;
            startAnimations();
            task.spawn(function() -- Line: 193
                -- upvalues: u13 (ref), u12 (ref), u21 (ref), u17 (ref), u18 (ref), u11 (ref), u16 (ref)
                local v24 = 1 / u13;

                while true do
                    for _, v in ipairs(u12) do
                        if not (u21.IsPlaying and u17.Parent) then
                            u21.IsPlaying = false;

                            return;
                        end;

                        u18.Texture = v;
                        task.wait(v24);
                    end;

                    if not u11.Loop then
                        u21.IsPlaying = false;

                        if u11.OnComplete then
                            u11.OnComplete();
                        end;

                        if u16 and u17.Parent then
                            if u11.Duration then
                                task.delay(u11.Duration, function() -- Line: 215
                                    -- upvalues: u21 (ref)
                                    u21:Destroy();
                                end);

                                return;
                            end;

                            u21:Destroy();
                        end;

                        return;
                    end;
                end;
            end);
        end,

        Destroy = function(p25) -- Line: 237, Name: Destroy
            -- upvalues: u11 (copy)
            p25.IsPlaying = false;

            if p25.Instance and p25.Instance.Parent then
                p25.Instance:Destroy();
            end;

            if u11.OnDestroy then
                u11.OnDestroy();
            end;
        end,

        SetScale = function(p26, p27) -- Line: 247, Name: SetScale
            if p26.SpecialMesh then
                local SpecialMesh = p26.SpecialMesh;

                if typeof(p27) ~= "Vector3" then
                    p27 = Vector3.new(p27, p27, p27);
                end;

                SpecialMesh.Scale = p27;
            end;
        end,

        TweenScale = function(p28: any, p29: any, p30: table?) -- Line: 253, Name: TweenScale
            -- upvalues: createTweenInfo (ref), TweenService (ref)
            if p28.SpecialMesh then
                local v31 = createTweenInfo(p30);
                local SpecialMesh = p28.SpecialMesh;
                local v32 = {};

                if typeof(p29) ~= "Vector3" then
                    p29 = Vector3.new(p29, p29, p29);
                end;

                v32.Scale = p29;
                local v33 = TweenService:Create(SpecialMesh, v31, v32);
                v33:Play();

                return v33;
            end;
        end
    };
    u21:Play();

    if u11.Loop and u11.Duration then
        task.delay(u11.Duration, function() -- Line: 268
            -- upvalues: u21 (ref)
            u21:Destroy();
        end);
    end;

    return u21;
end;

function u1.Quick(p34: userdata, p35: userdata, p36, p37: userdata?) -- Line: 276
    -- upvalues: u1 (copy)
    return u1.Create({
        Mesh = p34,
        TextureFolder = p35,
        CFrame = p36,
        Parent = p37 or workspace
    });
end;

function u1.Attached(p38: userdata, p39: userdata, p40: userdata, p41, p42: table?) -- Line: 285
    -- upvalues: u1 (copy)
    local v43 = p42 or {};
    v43.Mesh = p38;
    v43.TextureFolder = p39;
    v43.WeldTo = p40;
    v43.Offset = p41;
    v43.CFrame = p40.CFrame * (p41 or CFrame.new());

    return u1.Create(v43);
end;

function u1.WithScale(p44: userdata, p45: userdata, p46, p47: any, p48: any, p49: number?, p50: userdata?) -- Line: 296
    -- upvalues: u1 (copy)
    return u1.Create({
        Mesh = p44,
        TextureFolder = p45,
        CFrame = p46,
        Parent = p50 or workspace,
        Scale = {
            Start = p47,
            End = p48,
            Tween = {
                Time = p49 or 0.3
            }
        }
    });
end;

return u1;