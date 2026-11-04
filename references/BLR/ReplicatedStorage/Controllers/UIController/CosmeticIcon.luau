  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "CosmeticIcon"
});

local function hasBasePart(p2: userdata) -- Line: 10
    for _, descendant in ipairs(p2:GetDescendants()) do
        if descendant:IsA("BasePart") then
            return true;
        end;
    end;

    return false;
end;

function v1.CreateCosmeticIcon(p3: table, p4: userdata) -- Line: 19
    -- upvalues: hasBasePart (copy)
    local v5 = typeof(p4) == "Instance";
    assert(v5, "CosmeticIcon:CreateCosmeticIcon expected an Instance");
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame.Size = UDim2.new(1, 0, 1, 0);
    ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5);
    ViewportFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CosmeticIconWorld";
    WorldModel.Parent = ViewportFrame;
    local v6 = p4:Clone();
    local Model = Instance.new("Model");
    Model.Name = "CosmeticIconModel";
    v6.Parent = Model;
    Model.Parent = WorldModel;

    if not hasBasePart(Model) then
        return ViewportFrame;
    end;

    local BoundingBox, _ = Model:GetBoundingBox();
    local LookVector = BoundingBox.LookVector;
    local v7 = LookVector.Magnitude < 0.0001 and Vector3.new(0, 0, -1) or LookVector.Unit;
    local CFrame_new_ret = CFrame.new(BoundingBox.Position);

    for _, descendant in ipairs(Model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CFrame = CFrame_new_ret:ToObjectSpace(descendant.CFrame);
        end;
    end;

    local _, v8 = Model:GetBoundingBox();
    local math_max_ret = math.max(v8.X, v8.Y, v8.Z);
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;
    local math_rad_ret = math.rad(Camera.FieldOfView);
    local v9 = math_max_ret / 2 / math.tan(math_rad_ret / 2) * 1.2;
    local v10 = (Vector3.new(0, 1, 0)):Cross(v7);
    Camera.CFrame = CFrame.new((v7 - (v10.Magnitude < 0.001 and Vector3.new(1, 0, 0) or v10.Unit) * 0.75 + Vector3.new(0, 0.4, 0)).Unit * v9, Vector3.new(0, 0, 0));
    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;

    return ViewportFrame;
end;

v1.createcosmeticicon = v1.CreateCosmeticIcon;

function v1.KnitStart(p11) -- Line: 97
    print("(CLIENT) CosmeticIcon started");
end;

return v1;