 

 

local Players = game:GetService("Players");
local u1 = {};

local function track(u2) -- Line: 18
    -- upvalues: u1 (copy)
    if u1[u2] or (not u2:IsA("BasePart") or u2.Name ~= "Main") then
        return;
    end;

    local Parent = u2.Parent;

    if not (Parent and (Parent:IsA("Model") and Parent.Name == "Seesaw")) then
        return;
    end;

    local Size = u2.Size;
    local X = Size.X;
    local v3;

    if X < Size.Y then
        X = Size.Y;
        v3 = Vector3.new(0, 1, 0);
    else
        v3 = Vector3.new(1, 0, 0);
    end;

    if X < Size.Z then
        X = Size.Z;
        v3 = Vector3.new(0, 0, 1);
    end;

    local CFrame2 = u2.CFrame;
    local v4 = CFrame2:VectorToWorldSpace(v3);
    local Vector3_new_ret = Vector3.new(v4.X, 0, v4.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return;
    end;

    local Unit = Vector3_new_ret.Unit;
    local v5 = {
        angle = 0,
        base = CFrame2,
        along = Unit,
        hinge = Unit:Cross(Vector3.new(0, 1, 0)).Unit,
        half = X / 2,
        width = Size.X + Size.Y + Size.Z - X - math.min(Size.X, Size.Y, Size.Z),
        since = {}
    };
    v5.sign = (CFrame.fromAxisAngle(v5.hinge, 0.1) * Unit).Y < 0 and 1 or -1;
    v5.connection = u2.AncestryChanged:Connect(function() -- Line: 55
        -- upvalues: u2 (copy), u1 (ref)
        if not u2:IsDescendantOf(workspace) then
            local v6 = u1[u2];
            u1[u2] = nil;

            if v6 then
                v6.connection:Disconnect();
            end;
        end;
    end);
    u1[u2] = v5;
end;

local function lean(p7) -- Line: 68
    -- upvalues: Players (copy)
    local Position = p7.base.Position;
    local v8 = {};

    for _, v in Players:GetPlayers() do
        local v9 = v.Character and v.Character:FindFirstChild("HumanoidRootPart");

        if v9 then
            local v10 = v9.Position - Position;

            if v10.Y > -6 and v10.Y < 8 then
                local Vector3_new_ret = Vector3.new(v10.X, 0, v10.Z);

                for _, v2 in { 1, -1 } do
                    if (Vector3_new_ret - p7.along * v2 * (p7.half - 1.5)).Magnitude <= 6 then
                        v8[v2] = true;
                    end;
                end;
            end;
        end;
    end;

    local os_clock_ret = os.clock();

    for _, v in { 1, -1 } do
        if v8[v] then
            if not p7.since[v] then
                p7.since[v] = os_clock_ret;
            end;
        else
            p7.since[v] = nil;
        end;
    end;

    local v11 = p7.since[1];
    local v12 = p7.since[-1];

    return v11 and v12 and (v12 <= v11 and 1 or -1) or (v11 and 1 or (v12 and -1 or 0));
end;

game:GetService("RunService").Heartbeat:Connect(function(p13) -- Line: 101
    -- upvalues: u1 (copy), lean (copy)
    if next(u1) == nil then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    local v14 = 1 - math.exp(-4 * p13);

    for i, v in u1 do
        if workspace_CurrentCamera and (v.base.Position - workspace_CurrentCamera).Magnitude <= 160 then
            local v15 = lean(v) * 0.24434609527920614;
            local v16 = v.angle + (v15 - v.angle) * v14;

            if math.abs(v15 - v16) >= 0.0005 then
                v15 = v16;
            end;

            if v15 ~= v.angle then
                v.angle = v15;
                local Position = v.base.Position;
                i.CFrame = CFrame.new(Position) * CFrame.fromAxisAngle(v.hinge, v15 * v.sign) * (CFrame.new(-Position) * v.base);
            end;
        end;
    end;
end);
workspace.DescendantAdded:Connect(track);

for _, descendant in workspace:GetDescendants() do
    if descendant.Name == "Main" then
        track(descendant);
    end;
end;