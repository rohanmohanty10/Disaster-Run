  

 

local Players = game:GetService("Players");
local CurrentCamera = game.Workspace.CurrentCamera;
local min = math.min;
local tan = math.tan;
local rad = math.rad;
local new = Ray.new;

local function getTotalTransparency(p1) -- Line: 16
    return 1 - (1 - p1.Transparency) * (1 - p1.LocalTransparencyModifier);
end;

local function eraseFromEnd(p2, p3) -- Line: 20
    for i = #p2, p3 + 1, -1 do
        p2[i] = nil;
    end;
end;

local u4 = nil;
local u5 = nil;

local function updateProjection() -- Line: 27
    -- upvalues: CurrentCamera (copy), rad (copy), u5 (ref), tan (copy), u4 (ref)
    local v6 = rad(CurrentCamera.FieldOfView);
    local ViewportSize = CurrentCamera.ViewportSize;
    local v7 = ViewportSize.X / ViewportSize.Y;
    u5 = tan(v6 / 2) * 2;
    u4 = v7 * u5;
end;

CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(updateProjection);
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateProjection);
local v8 = rad(CurrentCamera.FieldOfView);
local ViewportSize = CurrentCamera.ViewportSize;
local v9 = ViewportSize.X / ViewportSize.Y;
u5 = tan(v8 / 2) * 2;
u4 = v9 * u5;
local NearPlaneZ = CurrentCamera.NearPlaneZ;
CurrentCamera:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() -- Line: 42
    -- upvalues: NearPlaneZ (ref), CurrentCamera (copy)
    NearPlaneZ = CurrentCamera.NearPlaneZ;
end);
local u10 = {};
local u11 = {};

local function refreshIgnoreList() -- Line: 50
    -- upvalues: u10 (ref), u11 (copy)
    local v12 = 1;
    u10 = {};

    for _, v in pairs(u11) do
        u10[v12] = v;
        v12 = v12 + 1;
    end;
end;

local function playerAdded(u13) -- Line: 59
    -- upvalues: u11 (copy), u10 (ref)
    local function characterRemoving() -- Line: 64
        -- upvalues: u11 (ref), u13 (copy), u10 (ref)
        u11[u13] = nil;
        local v14 = 1;
        u10 = {};

        for _, v in pairs(u11) do
            u10[v14] = v;
            v14 = v14 + 1;
        end;
    end;

    u13.CharacterAdded:Connect(function(p15) -- Line: 60, Name: characterAdded
        -- upvalues: u11 (ref), u13 (copy), u10 (ref)
        u11[u13] = p15;
        local v16 = 1;
        u10 = {};

        for _, v in pairs(u11) do
            u10[v16] = v;
            v16 = v16 + 1;
        end;
    end);
    u13.CharacterRemoving:Connect(characterRemoving);

    if u13.Character then
        u11[u13] = u13.Character;
        local v17 = 1;
        u10 = {};

        for _, v in pairs(u11) do
            u10[v17] = v;
            v17 = v17 + 1;
        end;
    end;
end;

local function playerRemoving(p18) -- Line: 76
    -- upvalues: u11 (copy), u10 (ref)
    u11[p18] = nil;
    local v19 = 1;
    u10 = {};

    for _, v in pairs(u11) do
        u10[v19] = v;
        v19 = v19 + 1;
    end;
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);

for _, v in ipairs(Players:GetPlayers()) do
    playerAdded(v);
end;

local v20 = 1;
u10 = {};

for _, v in pairs(u11) do
    u10[v20] = v;
    v20 = v20 + 1;
end;

local u21 = nil;
local u22 = nil;
CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 110
    -- upvalues: CurrentCamera (copy), u22 (ref)
    local CameraSubject = CurrentCamera.CameraSubject;

    if CameraSubject:IsA("Humanoid") then
        u22 = CameraSubject.RootPart;

        return;
    end;

    if CameraSubject:IsA("BasePart") then
        u22 = CameraSubject;

        return;
    end;

    u22 = nil;
end);

local function canOcclude(p23) -- Line: 121
    -- upvalues: u21 (ref)
    local v24;

    if 1 - (1 - p23.Transparency) * (1 - p23.LocalTransparencyModifier) < 0.25 then
        v24 = p23.CanCollide;

        if v24 then
            if u21 == (p23:GetRootPart() or p23) then
                v24 = false;
            else
                v24 = not p23:IsA("TrussPart");
            end;
        end;
    else
        v24 = false;
    end;

    return v24;
end;

local u25 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
};

local function getCollisionPoint(p26, p27) -- Line: 149
    -- upvalues: u10 (ref), new (copy)
    local v28 = #u10;

    while true do
        local v29, v30 = workspace:FindPartOnRayWithIgnoreList(new(p26, p27), u10, false, true);

        if v29 then
            if v29.CanCollide then
                local v31 = u10;

                for i = #v31, v28 + 1, -1 do
                    v31[i] = nil;
                end;

                return v30, true;
            end;

            u10[#u10 + 1] = v29;
        end;

        if not v29 then
            local v32 = u10;

            for i = #v32, v28 + 1, -1 do
                v32[i] = nil;
            end;

            return p26 + p27, false;
        end;
    end;
end;

local function queryPoint(p33, p34, p35, p36) -- Line: 171
    -- upvalues: u10 (ref), NearPlaneZ (ref), new (copy), u21 (ref)
    debug.profilebegin("queryPoint");
    local v37 = #u10;
    local v38 = p35 + NearPlaneZ;
    local v39 = p33 + p34 * v38;
    local v40 = p33;
    local v41 = 0;
    local v42 = (1 / 0);
    local v43 = (1 / 0);

    while true do
        local v44, v45 = workspace:FindPartOnRayWithIgnoreList(new(p33, v39 - p33), u10, false, true);
        v41 = v41 + 1;
        local v46;

        if v44 then
            local v47 = v41 >= 64;
            local v48;

            if 1 - (1 - v44.Transparency) * (1 - v44.LocalTransparencyModifier) < 0.25 then
                v48 = v44.CanCollide;

                if v48 then
                    if u21 == (v44:GetRootPart() or v44) then
                        v48 = false;
                    else
                        v48 = not v44:IsA("TrussPart");
                    end;
                end;
            else
                v48 = false;
            end;

            if v48 or v47 then
                local v49 = { v44 };
                local v50 = workspace:FindPartOnRayWithWhitelist(new(v39, v45 - v39), v49, true);
                v46 = (v45 - v40).Magnitude;

                if v50 and not v47 then
                    local v51;

                    if p36 then
                        v51 = workspace:FindPartOnRayWithWhitelist(new(p36, v39 - p36), v49, true) or workspace:FindPartOnRayWithWhitelist(new(v39, p36 - v39), v49, true);
                    else
                        v51 = false;
                    end;

                    if v51 then
                        v42 = v46;
                        v46 = v43;
                    elseif v38 >= v43 then
                        v46 = v43;
                    end;
                else
                    v42 = v46;
                    v46 = v43;
                end;
            else
                v46 = v43;
            end;

            u10[#u10 + 1] = v44;
            p33 = v45 - p34 * 0.001;
        else
            v46 = v43;
        end;

        if v42 < (1 / 0) or not v44 then
            local v52 = u10;

            for i = #v52, v37 + 1, -1 do
                v52[i] = nil;
            end;

            debug.profileend();

            return v46 - NearPlaneZ, v42 - NearPlaneZ;
        end;

        v43 = v46;
    end;
end;

local function queryViewport(p53, p54) -- Line: 231
    -- upvalues: CurrentCamera (copy), u4 (ref), u5 (ref), NearPlaneZ (ref), queryPoint (copy)
    debug.profilebegin("queryViewport");
    local p = p53.p;
    local rightVector = p53.rightVector;
    local upVector = p53.upVector;
    local v55 = -p53.lookVector;
    local ViewportSize2 = CurrentCamera.ViewportSize;
    local v56 = (1 / 0);
    local v57 = (1 / 0);

    for i = 0, 1 do
        local v58 = rightVector * ((i - 0.5) * u4);

        for i2 = 0, 1 do
            local v59, v60 = queryPoint(p + NearPlaneZ * (v58 + upVector * ((i2 - 0.5) * u5)), v55, p54, CurrentCamera:ViewportPointToRay(ViewportSize2.x * i, ViewportSize2.y * i2).Origin);

            if v60 >= v57 then
                v60 = v57;
            end;

            if v59 < v56 then
                v57 = v60;
                v56 = v59;
            else
                v57 = v60;
            end;
        end;
    end;

    debug.profileend();

    return v56, v57;
end;

local function testPromotion(p61, p62, p63) -- Line: 272
    -- upvalues: getCollisionPoint (copy), min (copy), queryPoint (copy), u25 (copy)
    debug.profilebegin("testPromotion");
    local p = p61.p;
    local rightVector = p61.rightVector;
    local upVector = p61.upVector;
    local v64 = -p61.lookVector;
    debug.profilebegin("extrapolate");
    local Magnitude = (getCollisionPoint(p, p63.posVelocity * 1.25) - p).Magnitude;

    for i = 0, min(1.25, p63.rotVelocity.magnitude + Magnitude / p63.posVelocity.magnitude), 0.0625 do
        local v65 = p63.extrapolate(i);

        if p62 <= queryPoint(v65.p, -v65.lookVector, p62) then
            return false;
        end;
    end;

    debug.profileend();
    debug.profilebegin("testOffsets");

    for _, v in ipairs(u25) do
        local v66 = getCollisionPoint(p, rightVector * v.x + upVector * v.y);

        if queryPoint(v66, (p + v64 * p62 - v66).Unit, p62) == (1 / 0) then
            return false;
        end;
    end;

    debug.profileend();
    debug.profileend();

    return true;
end;

return function(p67, p68, p69) -- Line: 321, Name: Popper
    -- upvalues: u21 (ref), u22 (ref), queryViewport (copy), testPromotion (copy)
    debug.profilebegin("popper");
    u21 = u22 and u22:GetRootPart() or u22;
    local v70, v71 = queryViewport(p67, p68);

    if v71 >= p68 then
        v71 = p68;
    end;

    if v70 < v71 then
        if not testPromotion(p67, p68, p69) then
            v70 = v71;
        end;
    else
        v70 = v71;
    end;

    u21 = nil;
    debug.profileend();

    return v70;
end;