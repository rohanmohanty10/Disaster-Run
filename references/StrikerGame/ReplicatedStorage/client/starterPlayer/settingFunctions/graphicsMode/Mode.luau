 

 

local Lighting = game:GetService("Lighting");
local workspace_map = workspace.map;
local v1 = {};
local u2 = {};
local u3 = nil;

local function createMapData() -- Line: 9
    -- upvalues: u2 (copy), u3 (ref), workspace_map (copy)
    for _, v in u2 do
        v:Destroy();
    end;

    table.clear(u2);

    if not u3 then
        u3 = {};

        for _, descendant in workspace_map:GetDescendants() do
            if not (descendant:GetAttribute("IgnoreLow") or descendant.Parent:GetAttribute("IgnoreLow")) then
                if descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("SurfaceAppearance") or descendant:IsA("Beam"))) then
                    u3[descendant] = {
                        Type = "VisualTexture",
                        Parent = descendant.Parent
                    };
                elseif descendant:IsA("BasePart") then
                    u3[descendant] = {
                        Type = "Part",
                        Material = descendant.Material,
                        Parent = descendant.Parent
                    };
                end;
            end;
        end;
    end;

    return u3;
end;

local function replaceMesh(p4: userdata, p5: any) -- Line: 39
    local Part = Instance.new("Part");
    Part.CFrame = p4.CFrame;
    Part.Color = p4.Color;
    Part.Material = p5 and Enum.Material.SmoothPlastic or p4.Material;
    Part.CanCollide = p4.CanCollide;
    Part.CanTouch = p4.CanTouch;
    Part.CanQuery = p4.CanQuery;
    Part.CollisionGroup = p4.CollisionGroup;
    Part.Anchored = p4.Anchored;
    Part.Transparency = p4.Transparency;
    Part.Massless = p4.Massless;
    Part.Reflectance = p4.Reflectance;

    for _, v in p4:GetTags() do
        Part:AddTag(v);
    end;

    for i, v in p4:GetAttributes() do
        Part:SetAttribute(i, v);
    end;

    return Part;
end;

function v1.High() -- Line: 64
    -- upvalues: createMapData (copy), Lighting (copy)
    local v6 = createMapData();
    Lighting.GlobalShadows = true;

    if Lighting:FindFirstChild("SunRays") then
        Lighting.SunRays.Enabled = true;
    end;

    for i, v in v6 do
        if v.Type == "Part" then
            i.Material = v.Material;
        elseif v.Type == "VisualTexture" then
            i.Parent = v.Parent;
        end;
    end;
end;

function v1.Low() -- Line: 82
    -- upvalues: createMapData (copy), Lighting (copy)
    local v7 = createMapData();
    Lighting.GlobalShadows = true;

    if Lighting:FindFirstChild("SunRays") then
        Lighting.SunRays.Enabled = true;
    end;

    for i, v in v7 do
        if v.Type == "Part" then
            i.Material = v.Material;
        elseif v.Type == "VisualTexture" then
            i.Parent = v.Parent;
        end;
    end;
end;

function v1.Potato() -- Line: 100
    -- upvalues: createMapData (copy), Lighting (copy)
    local v8 = createMapData();
    Lighting.GlobalShadows = false;

    if Lighting:FindFirstChild("SunRays") then
        Lighting.SunRays.Enabled = false;
    end;

    for i, v in v8 do
        if v.Type == "Part" then
            i.Material = Enum.Material.SmoothPlastic;
        elseif v.Type == "VisualTexture" then
            i.Parent = nil;
        end;
    end;
end;

return v1;