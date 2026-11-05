  

 

local function CreateItemBeam(p1, p2, p3) -- Line: 2
    local Beam = Instance.new("Beam");
    Beam.Texture = "rbxassetid://15548917159";
    Beam.TextureMode = "Static";
    Beam.TextureSpeed = 5;
    Beam.Transparency = NumberSequence.new(0);
    Beam.FaceCamera = true;
    Beam.Attachment0 = p1;
    Beam.Attachment1 = p2;
    Beam.Name = "ItemWaypoint";
    Beam.Enabled = true;
    Beam.Parent = p3;

    return Beam;
end;

local u5 = {
    __index = {
        Destroy = function(p4) -- Line: 21, Name: Destroy
            if typeof(p4.Attachment0) == "Instance" then
                p4.Attachment0:Destroy();
            end;

            p4.Attachment1:Destroy();
        end
    }
};
local u6 = {};

return function(p7) -- Line: 30
    -- upvalues: u5 (copy), u6 (copy)
    local v8 = typeof(p7.Attachment0) == "Vector3" and true or typeof(p7.Attachment1) == "Vector3";
    local v9 = setmetatable({}, u5);
    local Attachment0 = p7.Attachment0;
    local v10;

    if typeof(Attachment0) == "Vector3" then
        v10 = Instance.new("Attachment");
        v10.CFrame = CFrame.new(Attachment0);
        v10.Parent = workspace.Terrain;
        v9.Attachment0 = v10;
    else
        v10 = Attachment0;
    end;

    local Attachment1 = p7.Attachment1;
    local v11;

    if typeof(Attachment1) == "Vector3" then
        v11 = Instance.new("Attachment");
        v11.CFrame = CFrame.new(Attachment1);
        v11.Parent = workspace.Terrain;
        v9.Attachment1 = v11;
    else
        v11 = Attachment1;
    end;

    local v12 = p7.Parent or workspace.Effects;
    local v13 = p7.Identifier or "Generic";

    if p7.Destroying then
        if u6[v13] then
            u6[v13]:Destroy();
            u6[v13] = nil;
        end;

        for _, child in v12:GetChildren() do
            if child.Name == `{v13}ItemWaypoint` then
                child:Destroy();
            end;
        end;

        return;
    end;

    if v8 then
        u6[v13] = v9;
    end;

    local Beam = Instance.new("Beam");
    Beam.Texture = "rbxassetid://15548917159";
    Beam.TextureMode = "Static";
    Beam.TextureSpeed = 5;
    Beam.Transparency = NumberSequence.new(0);
    Beam.FaceCamera = true;
    Beam.Attachment0 = v10;
    Beam.Attachment1 = v11;
    Beam.Name = "ItemWaypoint";
    Beam.Enabled = true;
    Beam.Parent = v12;
    Beam.Name = `{v13}ItemWaypoint`;
end;