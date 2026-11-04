 

 

local UserInputService = game:GetService("UserInputService");
local Parent = script.Parent.Parent.Parent;
local Models = Parent.Weapons:WaitForChild("Models");
local Assets = Parent.Gear:WaitForChild("Assets");
local u1 = {};
u1.__index = u1;
local CFrame_Angles_ret = CFrame.Angles(-0.4363323129985824, -0.20943951023931956, -0.5585053606381855);
local u2 = { "LuaSourceContainer", "JointInstance", "WeldConstraint", "Sound", "ParticleEmitter", "Beam", "Trail", "Light", "Fire", "Smoke", "Sparkles" };
local u3 = {};
local u4 = 0;
local u5 = nil;
local u6 = nil;

local function onChanged(p7) -- Line: 17
    -- upvalues: u3 (copy)
    if p7.UserInputType == Enum.UserInputType.MouseMovement or p7.UserInputType == Enum.UserInputType.Touch then
        for i in u3 do
            if i.held then
                i.rotation = i.rotation + (p7.Position.X - i.lastX) * 0.012;
                i.lastX = p7.Position.X;
            end;
        end;
    end;
end;

local function onEnded(p8) -- Line: 28
    -- upvalues: u3 (copy)
    if p8.UserInputType == Enum.UserInputType.MouseButton1 or p8.UserInputType == Enum.UserInputType.Touch then
        for i in u3 do
            i.held = false;
        end;
    end;
end;

local function clean(p9) -- Line: 36
    -- upvalues: u2 (copy)
    local v10 = p9:IsA("BasePart") and ({ p9 } or {}) or {};

    for _, descendant in p9:GetDescendants() do
        local v11 = descendant;
        local v12 = false;

        for _, v in u2 do
            if v11:IsA(v) then
                v11:Destroy();
                v12 = true;
                break;
            end;
        end;

        if not v12 and v11:IsA("BasePart") then
            table.insert(v10, v11);
        end;
    end;

    for _, v in v10 do
        v.Anchored = true;
        v.CanCollide = false;
        v.CanTouch = false;
        v.CanQuery = false;
    end;
end;

function u1.new(p13, p14, p15) -- Line: 60
    -- upvalues: clean (copy), u1 (copy), u3 (copy), u4 (ref), u5 (ref), UserInputService (copy), onChanged (copy), u6 (ref), onEnded (copy)
    local v16 = p14:Clone();
    clean(v16);

    if v16:IsA("BasePart") and p15.rotation then
        local v17 = {};

        for _, descendant in v16:GetDescendants() do
            if descendant:IsA("BasePart") then
                if descendant.Transparency >= 1 then
                    descendant:Destroy();
                else
                    v17[descendant] = v16.CFrame:ToObjectSpace(descendant.CFrame);
                end;
            end;
        end;

        v16.Transparency = 0;
        v16.CFrame = p15.rotation;

        for i, v in v17 do
            if i.Parent then
                i.CFrame = v16.CFrame * v;
            end;
        end;
    end;

    local WorldModel = Instance.new("WorldModel");
    local Model = Instance.new("Model");
    v16.Parent = Model;
    Model.Parent = WorldModel;
    local BoundingBox, v18 = Model:GetBoundingBox();
    Model:PivotTo(Model:GetPivot() - BoundingBox.Position);
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = p15.gear and 35 or 33;
    Camera.Parent = p13;
    WorldModel.Parent = p13;
    p13.CurrentCamera = Camera;
    local v19 = {
        elapsed = 0,
        held = false,
        lastX = 0,
        viewport = p13,
        world = WorldModel,
        camera = Camera,
        extent = math.max(v18.X, v18.Y, v18.Z, 0.5),
        gear = p15.gear == true,
        phase = p15.phase or 0,
        rotation = p15.phase or 0
    };
    local u20 = setmetatable(v19, u1);

    if p15.drag then
        local u21 = p15.drag == "Any";
        u20.press = p13.InputBegan:Connect(function(p22) -- Line: 109
            -- upvalues: u21 (copy), u20 (copy)
            if p22.UserInputType == Enum.UserInputType.MouseButton1 or u21 and p22.UserInputType == Enum.UserInputType.Touch then
                u20.held = true;
                u20.lastX = p22.Position.X;
            end;
        end);
        u3[u20] = true;
        u4 = u4 + 1;

        if u4 == 1 then
            u5 = UserInputService.InputChanged:Connect(onChanged);
            u6 = UserInputService.InputEnded:Connect(onEnded);
        end;
    end;

    u20:step(0);

    return u20;
end;

function u1.step(p23, p24) -- Line: 129
    local math_min_ret = math.min(p24, 0.1);
    local extent = p23.extent;

    if not p23.gear then
        if not p23.held then
            p23.rotation = p23.rotation + math_min_ret * 0.18;
        end;

        local camera = p23.camera;
        local CFrame_lookAt = CFrame.lookAt;
        local v25 = math.sin(p23.rotation) * extent * 2;
        local v26 = math.cos(p23.rotation) * extent * 2;
        camera.CFrame = CFrame_lookAt(Vector3.new(v25, 0.1 * extent, v26), Vector3.new(0, 0, 0));

        return;
    end;

    p23.elapsed = p23.elapsed + math_min_ret;
    local v27 = p23.elapsed * 0.28 + p23.phase;
    local camera = p23.camera;
    local CFrame_lookAt = CFrame.lookAt;
    local v28 = math.sin(v27) * extent * 2;
    local v29 = extent * (math.sin(p23.elapsed * 1.6 + p23.phase) * 0.06 + 0.45);
    local v30 = math.cos(v27) * extent * 2;
    camera.CFrame = CFrame_lookAt(Vector3.new(v28, v29, v30), Vector3.new(0, 0, 0));
end;

function u1.destroy(p31) -- Line: 154
    -- upvalues: u3 (copy), u4 (ref), u5 (ref), u6 (ref)
    if p31.press then
        p31.press:Disconnect();
        p31.press = nil;
    end;

    if u3[p31] then
        u3[p31] = nil;
        u4 = u4 - 1;

        if u4 == 0 then
            u5:Disconnect();
            u6:Disconnect();
            u5 = nil;
            u6 = nil;
        end;
    end;

    if p31.viewport.CurrentCamera == p31.camera then
        p31.viewport.CurrentCamera = nil;
    end;

    p31.world:Destroy();
    p31.camera:Destroy();
end;

function u1.knife(p32, p33, p34) -- Line: 176
    -- upvalues: Models (copy), u1 (copy), CFrame_Angles_ret (copy)
    if p33 then
        p33 = Models:FindFirstChild(p33.Model);
    end;

    local v35;

    if p33 then
        v35 = p33:FindFirstChild("Blade") or p33:FindFirstChildWhichIsA("MeshPart", true);
    else
        v35 = p33;
    end;

    if v35 then
        return u1.new(p32, v35, {
            rotation = p33:GetAttribute("PreviewRotation") or CFrame_Angles_ret,
            drag = p34
        });
    end;

    return nil;
end;

function u1.gear(p36, p37, p38) -- Line: 189
    -- upvalues: Assets (copy), u1 (copy)
    local v39 = p37 and p37.Preview and Assets:FindFirstChild(p37.Preview);

    if v39 then
        return u1.new(p36, v39, {
            gear = true,
            phase = p38
        });
    end;

    return nil;
end;

return u1;