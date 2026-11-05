  

 

local Physics = require(script:WaitForChild("Physics"));

local function getHorizontalFov() -- Line: 3
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize;
    local v1 = ViewportSize.X / ViewportSize.Y;
    local v2 = math.rad(game.Workspace.CurrentCamera.FieldOfView) * 0.5;
    local v3 = math.tan(v2) * v1;
    local v4 = math.atan(v3) * 2;

    return math.deg(v4);
end;

local function createViewModel(p5) -- Line: 12
    -- upvalues: Physics (copy)
    local u6 = {};
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize;
    local v7 = ViewportSize.X / ViewportSize.Y;
    local v8 = math.rad(game.Workspace.CurrentCamera.FieldOfView) * 0.5;
    local v9 = math.tan(v8) * v7;
    local v10 = math.atan(v9) * 2;
    local v11 = FieldOfView + (math.deg(v10) - FieldOfView) / 1.65;
    local v12 = {
        topLeft = CFrame.new() * CFrame.Angles(math.rad(FieldOfView / 2), math.rad(v11 / 2), 0) * CFrame.new(0, 0, -5),
        topRight = CFrame.new() * CFrame.Angles(math.rad(FieldOfView / 2), -math.rad(v11 / 2), 0) * CFrame.new(0, 0, -5),
        bottomLeft = CFrame.new() * CFrame.Angles(-math.rad(FieldOfView / 2), math.rad(v11 / 2), 0) * CFrame.new(0, 0, -5),
        bottomRight = CFrame.new() * CFrame.Angles(-math.rad(FieldOfView / 2), -math.rad(v11 / 2), 0) * CFrame.new(0, 0, -5)
    };
    local magnitude = (v12.topLeft.Position - v12.topRight.Position).magnitude;
    local magnitude2 = (v12.topLeft.Position - v12.bottomLeft.Position).magnitude;
    u6.sides = {
        Top = {
            Size = Vector3.new(0.2, 0.2, magnitude),
            Corners = { "topLeft", "topRight" }
        },
        Bottom = {
            Size = Vector3.new(0.2, 0.2, magnitude),
            Corners = { "bottomRight", "bottomLeft" }
        },
        Right = {
            Size = Vector3.new(0.2, 0.2, magnitude2),
            Corners = { "topRight", "bottomRight" }
        },
        Left = {
            Size = Vector3.new(0.2, 0.2, magnitude2),
            Corners = { "topLeft", "bottomLeft" }
        }
    };
    u6.sideInstances = {};
    u6.corePart = Instance.new("Part");
    u6.corePart.Size = Vector3.new(0.2, 0.2, 0.2);
    u6.corePart.Transparency = 1;
    u6.corePart.CanCollide = false;
    u6.corePart.Parent = game.Workspace;
    u6.Connection = game:GetService("RunService").RenderStepped:connect(function() -- Line: 61, Name: updateCorePart
        -- upvalues: u6 (copy)
        u6.corePart.CFrame = game.Workspace.CurrentCamera.CFrame;
    end);

    for i, v in next, u6.sides do
        local Part = Instance.new("Part");
        Part.Anchored = false;
        print(v.Size);
        Part.Size = v.Size;
        Part.Transparency = 1;
        Part.Parent = game.Workspace;
        Part.CanCollide = false;
        local v13 = CFrame.new(v12[v.Corners[1]].Position, v12[v.Corners[2]].Position) * CFrame.new(0, 0, -v.Size.Z / 2);
        local v14 = Physics.joint.new(Part, u6.corePart, CFrame.new(), v13);
        u6.sideInstances[i] = {
            Object = Part,
            Joint = v14
        };

        for _, v2 in ipairs(p5) do
            v2:Clone().Parent = Part;
        end;
    end;

    return u6;
end;

local function adjustViewModel(p15, p16) -- Line: 95
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize;
    local v17 = ViewportSize.X / ViewportSize.Y;
    local v18 = math.rad(game.Workspace.CurrentCamera.FieldOfView) * 0.5;
    local v19 = math.tan(v18) * v17;
    local v20 = math.atan(v19) * 2;
    local v21 = FieldOfView + (math.deg(v20) - FieldOfView) / 1.65;
    local v22 = {
        topLeft = CFrame.new() * CFrame.Angles(math.rad(FieldOfView / 2), math.rad(v21 / 2), 0) * CFrame.new(0, 0, -p16),
        topRight = CFrame.new() * CFrame.Angles(math.rad(FieldOfView / 2), -math.rad(v21 / 2), 0) * CFrame.new(0, 0, -p16),
        bottomLeft = CFrame.new() * CFrame.Angles(-math.rad(FieldOfView / 2), math.rad(v21 / 2), 0) * CFrame.new(0, 0, -p16),
        bottomRight = CFrame.new() * CFrame.Angles(-math.rad(FieldOfView / 2), -math.rad(v21 / 2), 0) * CFrame.new(0, 0, -p16)
    };
    local magnitude = (v22.topLeft.Position - v22.topRight.Position).magnitude;
    local magnitude2 = (v22.topLeft.Position - v22.bottomLeft.Position).magnitude;
    p15.sides.Top.Size = Vector3.new(0.2, 0.2, magnitude);
    p15.sides.Bottom.Size = Vector3.new(0.2, 0.2, magnitude);
    p15.sides.Right.Size = Vector3.new(0.2, 0.2, magnitude2);
    p15.sides.Left.Size = Vector3.new(0.2, 0.2, magnitude2);

    for i, v in next, p15.sides do
        local v23 = CFrame.new(v22[v.Corners[1]].Position, v22[v.Corners[2]].Position) * CFrame.new(0, 0, -v.Size.Z / 2);
        p15.sideInstances[i].Object.Size = v.Size;
        p15.sideInstances[i].Joint.C1 = v23;
        print("done");
    end;
end;

local v24 = {};
local u25 = {};

function u25.new(p26) -- Line: 134
    -- upvalues: u25 (copy)
    local v27 = setmetatable({}, {
        __index = u25
    });
    v27.viewmodel = p26;
    v27.effects = {};
    v27.enabled = true;
    v27.distance = 5;
    v27.updating = false;
    v27.updateConnections = {
        viewport = nil,
        fov = nil
    };

    for _, v in next, p26.sideInstances do
        for _, child in ipairs(v.Object:GetChildren()) do
            print("added effect...");
            table.insert(v27.effects, child);
        end;
    end;

    return v27;
end;

function u25.Enabled(p28, p29) -- Line: 158
    p28.enabled = p29;

    for _, v in ipairs(p28.effects) do
        v.Enabled = p28.enabled;
    end;
end;

function u25.SetDistance(p30, p31) -- Line: 166
    -- upvalues: adjustViewModel (copy)
    adjustViewModel(p30.viewmodel, p31);
    p30.distance = p31;
end;

function u25.UpdateEnabled(u32, p33) -- Line: 171
    -- upvalues: adjustViewModel (copy)
    u32.updating = p33;

    if u32.updating then
        u32.updateConnections.viewport = game.Workspace.CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function() -- Line: 174
            -- upvalues: adjustViewModel (ref), u32 (copy)
            adjustViewModel(u32.viewmodel, u32.distance);
        end);
        u32.updateConnections.fov = game.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 178
            -- upvalues: adjustViewModel (ref), u32 (copy)
            adjustViewModel(u32.viewmode, u32.distance);
        end);

        return;
    end;

    if u32.updateConnections.fov then
        u32.updateConnections.fov:Disconnect();
    end;

    if u32.upateConnections.viewport then
        u32.updateConnections.viewport:Disconnect();
    end;
end;

function u25.Destroy(p34) -- Line: 191
    for _, v in next, p34.viewmodel.sideInstances do
        v.Object:Destroy();
    end;

    p34.viewmodel.Connection:Disconnect();
    p34.viewmodel.corePart:Destroy();
end;

function v24.CreateVignette(p35, p36) -- Line: 199
    -- upvalues: createViewModel (copy), u25 (copy)
    local v37 = typeof(p36) == "table";
    assert(v37, "CreateVignette only accepts a table of \'ParticleEmitter\' objects!");

    for _, v in ipairs(p36) do
        local v38 = typeof(v) == "Instance";
        local v39 = "All objects provided must be an instance \'ParticleEmitter\'! You provided a " .. typeof(v);
        assert(v38, v39);
        local v40 = v:IsA("ParticleEmitter");
        assert(v40, "All objects provided must be an instance \'ParticleEmitter\'! You provided a " .. v.ClassName);
    end;

    local v41 = createViewModel(p36);

    return u25.new(v41);
end;

return v24;