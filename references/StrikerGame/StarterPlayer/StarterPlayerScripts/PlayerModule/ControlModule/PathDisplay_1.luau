 
 

local u1 = {
    spacing = 8,
    image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    imageSize = Vector2.new(2, 2)
};
local Model = Instance.new("Model");
Model.Name = "PathDisplayPoints";
local Part = Instance.new("Part");
Part.Anchored = true;
Part.CanCollide = false;
Part.Transparency = 1;
Part.Name = "PathDisplayAdornee";
Part.CFrame = CFrame.new(0, 0, 0);
Part.Parent = Model;
local u2 = 30;
local u3 = {};
local u4 = {};
local u5 = {};

for i = 1, u2 do
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment.Archivable = false;
    ImageHandleAdornment.Adornee = Part;
    ImageHandleAdornment.Image = u1.image;
    ImageHandleAdornment.Size = u1.imageSize;
    u3[i] = ImageHandleAdornment;
    local _ = i;
end;

local function retrieveFromPool() -- Line: 34
    -- upvalues: u3 (copy), u2 (ref)
    local v6 = u3[1];

    if not v6 then
        return nil;
    end;

    u3[1] = u3[u2];
    u3[u2] = nil;
    u2 = u2 - 1;

    return v6;
end;

local function returnToPool(p7: userdata) -- Line: 45
    -- upvalues: u2 (ref), u3 (copy)
    u2 = u2 + 1;
    u3[u2] = p7;
end;

local function renderPoint(p8: vector, p9: any) -- Line: 50
    -- upvalues: u2 (ref), u3 (copy), Model (copy)
    if u2 == 0 then
        return nil;
    end;

    local Ray_new_ret = Ray.new(p8 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0));
    local v10, v11, v12 = workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, { game.Players.LocalPlayer.Character, workspace.CurrentCamera });

    if not v10 then
        return nil;
    end;

    local CFrame_new_ret = CFrame.new(v11, v11 + v12);
    local v13 = u3[1];

    if v13 then
        u3[1] = u3[u2];
        u3[u2] = nil;
        u2 = u2 - 1;
    else
        v13 = nil;
    end;

    v13.CFrame = CFrame_new_ret;
    v13.Parent = Model;

    return v13;
end;

function u1.setCurrentPoints(p14) -- Line: 69
    -- upvalues: u4 (ref)
    if typeof(p14) == "table" then
        u4 = p14;

        return;
    end;

    u4 = {};
end;

function u1.clearRenderedPath() -- Line: 77
    -- upvalues: u5 (ref), u2 (ref), u3 (copy), Model (copy)
    for _, v in ipairs(u5) do
        v.Parent = nil;
        u2 = u2 + 1;
        u3[u2] = v;
    end;

    u5 = {};
    Model.Parent = nil;
end;

function u1.renderPath() -- Line: 86
    -- upvalues: u1 (copy), u4 (ref), u5 (ref), renderPoint (copy), Model (copy)
    u1.clearRenderedPath();

    if not u4 or #u4 == 0 then
        return;
    end;

    local v15 = #u4;
    u5[1] = renderPoint(u4[v15], true);

    if not u5[1] then
        return;
    end;

    local v16 = 0;

    while true do
        local v17 = u4[v15];

        if v15 < 2 then
            break;
        end;

        local v18 = u4[v15 - 1] - v17;
        local magnitude = v18.magnitude;

        if magnitude < v16 then
            v16 = v16 - magnitude;
            v15 = v15 - 1;
        else
            local v19 = renderPoint(v17 + v18.unit * v16, false);

            if v19 then
                u5[#u5 + 1] = v19;
            end;

            v16 = v16 + u1.spacing;
        end;
    end;

    Model.Parent = workspace.CurrentCamera;
end;

return u1;