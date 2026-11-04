 
 

local Players = game:GetService("Players");
local CommonUtils = script.Parent.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraWrapper = require(CommonUtils:WaitForChild("CameraWrapper"));
local UserFlag = FlagUtil.getUserFlag("UserRaycastUpdateAPI");
local UserFlag2 = FlagUtil.getUserFlag("UserCurrentCameraUpdate");
local u1;

if UserFlag2 then
    u1 = CameraWrapper.new();
else
    u1 = nil;
end;

local u2;

if UserFlag2 then
    u2 = nil;
else
    u2 = game.Workspace.CurrentCamera;
end;

if UserFlag2 then
    u1:Enable();
end;

local math_min = math.min;
local math_tan = math.tan;
local math_rad = math.rad;
local Ray_new = Ray.new;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IgnoreWater = true;
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
local RaycastParams_new_ret2 = RaycastParams.new();
RaycastParams_new_ret2.IgnoreWater = true;
RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;

local function getTotalTransparency(p3) -- Line: 38
    return 1 - (1 - p3.Transparency) * (1 - p3.LocalTransparencyModifier);
end;

local function eraseFromEnd(p4, p5) -- Line: 42
    for i = #p4, p5 + 1, -1 do
        p4[i] = nil;
        local _ = i;
    end;
end;

local u6 = nil;
local u7 = nil;
local u8;

if UserFlag2 then
    local function updateProjection() -- Line: 52
        -- upvalues: u1 (copy), math_rad (copy), u7 (ref), math_tan (copy), u6 (ref)
        local Camera = u1:getCamera();
        local v9 = math_rad(Camera.FieldOfView);
        local ViewportSize = Camera.ViewportSize;
        local v10 = ViewportSize.X / ViewportSize.Y;
        u7 = math_tan(v9 / 2) * 2;
        u6 = v10 * u7;
    end;

    u1:Connect("FieldOfView", updateProjection);
    u1:Connect("ViewportSize", updateProjection);
    local Camera = u1:getCamera();
    local v11 = math_rad(Camera.FieldOfView);
    local ViewportSize = Camera.ViewportSize;
    local v12 = ViewportSize.X / ViewportSize.Y;
    u7 = math_tan(v11 / 2) * 2;
    u6 = v12 * u7;
    u8 = u1:getCamera().NearPlaneZ;
    u1:Connect("NearPlaneZ", function() -- Line: 68
        -- upvalues: u8 (ref), u1 (copy)
        u8 = u1:getCamera().NearPlaneZ;
    end);
else
    local function v15() -- Line: 74
        -- upvalues: u2 (ref), math_rad (copy), u7 (ref), math_tan (copy), u6 (ref)
        local v13 = math_rad(u2.FieldOfView);
        local ViewportSize = u2.ViewportSize;
        local v14 = ViewportSize.X / ViewportSize.Y;
        u7 = math_tan(v13 / 2) * 2;
        u6 = v14 * u7;
    end;

    u2:GetPropertyChangedSignal("FieldOfView"):Connect(v15);
    u2:GetPropertyChangedSignal("ViewportSize"):Connect(v15);
    local v16 = math_rad(u2.FieldOfView);
    local ViewportSize = u2.ViewportSize;
    local v17 = ViewportSize.X / ViewportSize.Y;
    u7 = math_tan(v16 / 2) * 2;
    u6 = v17 * u7;
    u8 = u2.NearPlaneZ;
    u2:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() -- Line: 88
        -- upvalues: u8 (ref), u2 (ref)
        u8 = u2.NearPlaneZ;
    end);
end;

local u18 = {};
local u19 = {};

local function refreshIgnoreList() -- Line: 97
    -- upvalues: u18 (ref), u19 (copy)
    local v20 = 1;
    u18 = {};

    for _, v in pairs(u19) do
        u18[v20] = v;
        v20 = v20 + 1;
    end;
end;

local function playerAdded(u21) -- Line: 106
    -- upvalues: u19 (copy), u18 (ref)
    local function characterRemoving() -- Line: 111
        -- upvalues: u19 (ref), u21 (copy), u18 (ref)
        u19[u21] = nil;
        local v22 = 1;
        u18 = {};

        for _, v in pairs(u19) do
            u18[v22] = v;
            v22 = v22 + 1;
        end;
    end;

    u21.CharacterAdded:Connect(function(p23) -- Line: 107, Name: characterAdded
        -- upvalues: u19 (ref), u21 (copy), u18 (ref)
        u19[u21] = p23;
        local v24 = 1;
        u18 = {};

        for _, v in pairs(u19) do
            u18[v24] = v;
            v24 = v24 + 1;
        end;
    end);
    u21.CharacterRemoving:Connect(characterRemoving);

    if u21.Character then
        u19[u21] = u21.Character;
        local v25 = 1;
        u18 = {};

        for _, v in pairs(u19) do
            u18[v25] = v;
            v25 = v25 + 1;
        end;
    end;
end;

local function playerRemoving(p26) -- Line: 123
    -- upvalues: u19 (copy), u18 (ref)
    u19[p26] = nil;
    local v27 = 1;
    u18 = {};

    for _, v in pairs(u19) do
        u18[v27] = v;
        v27 = v27 + 1;
    end;
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);

for _, v in ipairs(Players:GetPlayers()) do
    playerAdded(v);
end;

local v28 = 1;
u18 = {};

for _, v in pairs(u19) do
    u18[v28] = v;
    v28 = v28 + 1;
end;

local u29 = nil;
local u30 = nil;

if UserFlag2 then
    u1:Connect("CameraSubject", function() -- Line: 158
        -- upvalues: u1 (copy), u30 (ref)
        local CameraSubject = u1:getCamera().CameraSubject;

        if CameraSubject:IsA("Humanoid") then
            u30 = CameraSubject.RootPart;

            return;
        end;

        if CameraSubject:IsA("BasePart") then
            u30 = CameraSubject;

            return;
        end;

        u30 = nil;
    end);
else
    u2:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 169
        -- upvalues: u2 (ref), u30 (ref)
        local CameraSubject = u2.CameraSubject;

        if CameraSubject:IsA("Humanoid") then
            u30 = CameraSubject.RootPart;

            return;
        end;

        if CameraSubject:IsA("BasePart") then
            u30 = CameraSubject;

            return;
        end;

        u30 = nil;
    end);
end;

local function canOcclude(p31) -- Line: 181
    -- upvalues: u29 (ref)
    local v32;

    if 1 - (1 - p31.Transparency) * (1 - p31.LocalTransparencyModifier) < 0.25 then
        v32 = p31.CanCollide;

        if v32 then
            if u29 == (p31:GetRootPart() or p31) then
                v32 = false;
            else
                v32 = not p31:IsA("TrussPart");
            end;
        end;
    else
        v32 = false;
    end;

    return v32;
end;

local u33 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
};

local function getCollisionPoint(p34, p35) -- Line: 209
    -- upvalues: UserFlag (copy), RaycastParams_new_ret (copy), u18 (ref), Ray_new (copy)
    if UserFlag then
        RaycastParams_new_ret.FilterDescendantsInstances = u18;
        local v36;

        repeat
            v36 = workspace:Raycast(p34, p35, RaycastParams_new_ret);

            if v36 then
                if v36.Instance.CanCollide then
                    return v36.Position, true;
                end;

                RaycastParams_new_ret:AddToFilter(v36.Instance);
            end;
        until not v36;
    else
        local v37 = #u18;
        local v38;

        repeat
            local v39;
            v38, v39 = workspace:FindPartOnRayWithIgnoreList(Ray_new(p34, p35), u18, false, true);

            if v38 then
                if v38.CanCollide then
                    local v40 = u18;

                    for i = #v40, v37 + 1, -1 do
                        v40[i] = nil;
                        local _ = i;
                    end;

                    return v39, true;
                end;

                u18[#u18 + 1] = v38;
            end;
        until not v38;

        local v41 = u18;

        for i = #v41, v37 + 1, -1 do
            v41[i] = nil;
            local _ = i;
        end;
    end;

    return p34 + p35, false;
end;

local function queryPoint(p42, p43, p44, p45) -- Line: 247
    -- upvalues: u18 (ref), u8 (ref), UserFlag (copy), RaycastParams_new_ret (copy), u29 (ref), RaycastParams_new_ret2 (copy), Ray_new (copy)
    debug.profilebegin("queryPoint");
    local v46 = #u18;
    local v47 = p44 + u8;
    local v48 = p42 + p43 * v47;
    local v49 = (1 / 0);
    local v50 = (1 / 0);
    local v51 = 0;
    local v52;

    if UserFlag then
        RaycastParams_new_ret.FilterDescendantsInstances = u18;
        local v53 = p42;

        while true do
            local v54 = workspace:Raycast(p42, v48 - p42, RaycastParams_new_ret);

            if not v54 then
                v52 = v49;
                break;
            end;

            v51 = v51 + 1;
            local Instance = v54.Instance;
            local Position = v54.Position;
            v52 = (Position - v53).Magnitude;

            if v51 >= 64 then
                v50 = v52;
                v52 = v49;
            else
                local v55;

                if 1 - (1 - Instance.Transparency) * (1 - Instance.LocalTransparencyModifier) < 0.25 then
                    v55 = Instance.CanCollide;

                    if v55 then
                        if u29 == (Instance:GetRootPart() or Instance) then
                            v55 = false;
                        else
                            v55 = not Instance:IsA("TrussPart");
                        end;
                    end;
                else
                    v55 = false;
                end;

                if v55 then
                    RaycastParams_new_ret2.FilterDescendantsInstances = { Instance };

                    if workspace:Raycast(v48, Position - v48, RaycastParams_new_ret2) then
                        local v56;

                        if p45 then
                            v56 = workspace:Raycast(p45, v48 - p45, RaycastParams_new_ret2) or workspace:Raycast(v48, p45 - v48, RaycastParams_new_ret2);
                        else
                            v56 = false;
                        end;

                        if v56 then
                            v50 = v52;
                            v52 = v49;
                        elseif v47 >= v49 then
                            v52 = v49;
                        end;
                    else
                        v50 = v52;
                        v52 = v49;
                    end;
                else
                    v52 = v49;
                end;
            end;

            RaycastParams_new_ret:AddToFilter(Instance);
            p42 = Position - p43 * 0.001;

            if v50 < (1 / 0) or not Instance then
                break;
            end;

            v49 = v52;
        end;
    else
        local v57 = p42;

        while true do
            local v58;

            if true then
                local v59;
                v58, v59 = workspace:FindPartOnRayWithIgnoreList(Ray_new(p42, v48 - p42), u18, false, true);
                v51 = v51 + 1;

                if v58 then
                    local v60 = v51 >= 64;
                    local v61;

                    if 1 - (1 - v58.Transparency) * (1 - v58.LocalTransparencyModifier) < 0.25 then
                        v61 = v58.CanCollide;

                        if v61 then
                            if u29 == (v58:GetRootPart() or v58) then
                                v61 = false;
                            else
                                v61 = not v58:IsA("TrussPart");
                            end;
                        end;
                    else
                        v61 = false;
                    end;

                    if v61 or v60 then
                        local v62 = { v58 };
                        local v63 = workspace:FindPartOnRayWithWhitelist(Ray_new(v48, v59 - v48), v62, true);
                        v52 = (v59 - v57).Magnitude;

                        if v63 and not v60 then
                            local v64;

                            if p45 then
                                v64 = workspace:FindPartOnRayWithWhitelist(Ray_new(p45, v48 - p45), v62, true) or workspace:FindPartOnRayWithWhitelist(Ray_new(v48, p45 - v48), v62, true);
                            else
                                v64 = false;
                            end;

                            if v64 then
                                v50 = v52;
                                v52 = v49;
                            elseif v47 >= v49 then
                                v52 = v49;
                            end;
                        else
                            v50 = v52;
                            v52 = v49;
                        end;
                    else
                        v52 = v49;
                    end;

                    u18[#u18 + 1] = v58;
                    p42 = v59 - p43 * 0.001;
                else
                    v52 = v49;
                end;
            end;

            if v50 < (1 / 0) or not v58 then
                break;
            end;

            v49 = v52;
        end;

        local v65 = u18;

        for i = #v65, v46 + 1, -1 do
            v65[i] = nil;
            local _ = i;
        end;
    end;

    debug.profileend();

    return v52 - u8, v50 - u8;
end;

local function queryViewport(p66, p67) -- Line: 350
    -- upvalues: u2 (ref), UserFlag2 (copy), u1 (copy), u6 (ref), u7 (ref), u8 (ref), queryPoint (copy)
    debug.profilebegin("queryViewport");
    local p = p66.p;
    local rightVector = p66.rightVector;
    local upVector = p66.upVector;
    local v68 = -p66.lookVector;
    local v69;

    if UserFlag2 then
        v69 = u1:getCamera();
    else
        v69 = u2;
    end;

    u2 = v69;
    local ViewportSize = u2.ViewportSize;
    local v70 = (1 / 0);
    local v71 = (1 / 0);

    for i = 0, 1 do
        local v72 = rightVector * ((i - 0.5) * u6);
        local v73 = i;

        for i2 = 0, 1 do
            local v74, v75 = queryPoint(p + u8 * (v72 + upVector * ((i2 - 0.5) * u7)), v68, p67, u2:ViewportPointToRay(ViewportSize.x * v73, ViewportSize.y * i2).Origin);

            if v75 >= v70 then
                v75 = v70;
            end;

            local v76;

            if v74 < v71 then
                v71 = v74;
                v70 = v75;
                v76 = i2;
            else
                v70 = v75;
                v76 = i2;
            end;
        end;
    end;

    debug.profileend();

    return v71, v70;
end;

local function testPromotion(p77, p78, p79) -- Line: 393
    -- upvalues: getCollisionPoint (copy), math_min (copy), queryPoint (copy), u33 (copy)
    debug.profilebegin("testPromotion");
    local p = p77.p;
    local rightVector = p77.rightVector;
    local upVector = p77.upVector;
    local v80 = -p77.lookVector;
    debug.profilebegin("extrapolate");
    local Magnitude = (getCollisionPoint(p, p79.posVelocity * 1.25) - p).Magnitude;

    for i = 0, math_min(1.25, p79.rotVelocity.magnitude + Magnitude / p79.posVelocity.magnitude), 0.0625 do
        local v81 = p79.extrapolate(i);

        if p78 <= queryPoint(v81.p, -v81.lookVector, p78) then
            return false;
        end;

        local _ = i;
    end;

    debug.profileend();
    debug.profilebegin("testOffsets");

    for _, v in ipairs(u33) do
        local v82 = getCollisionPoint(p, rightVector * v.x + upVector * v.y);

        if queryPoint(v82, (p + v80 * p78 - v82).Unit, p78) == (1 / 0) then
            return false;
        end;
    end;

    debug.profileend();
    debug.profileend();

    return true;
end;

return function(p83, p84, p85) -- Line: 442, Name: Popper
    -- upvalues: u29 (ref), u30 (ref), queryViewport (copy), testPromotion (copy)
    debug.profilebegin("popper");
    u29 = u30 and u30:GetRootPart() or u30;
    local v86, v87 = queryViewport(p83, p84);

    if v87 >= p84 then
        v87 = p84;
    end;

    if v86 < v87 then
        if not testPromotion(p83, p84, p85) then
            v86 = v87;
        end;
    else
        v86 = v87;
    end;

    u29 = nil;
    debug.profileend();

    return v86;
end;