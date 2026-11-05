  

 

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
end;

local function retrieveFromPool() -- Line: 33
    -- upvalues: u3 (copy), u2 (ref)
    local v6 = u3[1];

    if v6 then
        u3[1] = u3[u2];
        u3[u2] = nil;
        u2 = u2 - 1;

        return v6;
    end;
end;

local function returnToPool(p7) -- Line: 44
    -- upvalues: u2 (ref), u3 (copy)
    u2 = u2 + 1;
    u3[u2] = p7;
end;

local function renderPoint(p8, p9) -- Line: 49
    -- upvalues: u2 (ref), u3 (copy), Model (copy)
    if u2 == 0 then
        return;
    end;

    local v10 = Ray.new(p8 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0));
    local v11, v12, v13 = workspace:FindPartOnRayWithIgnoreList(v10, { game.Players.LocalPlayer.Character, workspace.CurrentCamera });

    if v11 then
        local v14 = CFrame.new(v12, v12 + v13);
        local v15 = u3[1];

        if v15 then
            u3[1] = u3[u2];
            u3[u2] = nil;
            u2 = u2 - 1;
        else
            v15 = nil;
        end;

        v15.CFrame = v14;
        v15.Parent = Model;

        return v15;
    end;
end;

function u1.setCurrentPoints(p16) -- Line: 68
    -- upvalues: u4 (ref)
    if typeof(p16) == "table" then
        u4 = p16;

        return;
    end;

    u4 = {};
end;

function u1.clearRenderedPath() -- Line: 76
    -- upvalues: u5 (ref), u2 (ref), u3 (copy), Model (copy)
    for _, v in ipairs(u5) do
        v.Parent = nil;
        u2 = u2 + 1;
        u3[u2] = v;
    end;

    u5 = {};
    Model.Parent = nil;
end;

function u1.renderPath() -- Line: 85
    -- upvalues: u1 (copy), u4 (ref), u5 (ref), renderPoint (copy), Model (copy)
    u1.clearRenderedPath();

    if not u4 or #u4 == 0 then
        return;
    end;

    local v17 = #u4;
    u5[1] = renderPoint(u4[v17], true);

    if not u5[1] then
        return;
    end;

    local v18 = 0;

    while true do
        local v19 = u4[v17];

        if v17 < 2 then
            break;
        end;

        local v20 = u4[v17 - 1] - v19;
        local magnitude = v20.magnitude;

        if magnitude < v18 then
            v18 = v18 - magnitude;
            v17 = v17 - 1;
        else
            local v21 = renderPoint(v19 + v20.unit * v18, false);

            if v21 then
                u5[#u5 + 1] = v21;
            end;

            v18 = v18 + u1.spacing;
        end;
    end;

    Model.Parent = workspace.CurrentCamera;
end;

return u1;