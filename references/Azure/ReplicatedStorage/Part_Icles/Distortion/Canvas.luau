 

 

local Lighting = game:GetService("Lighting");
local Field = require(script.Parent.Field);
local PlaneBuilder = require(script.Parent.PlaneBuilder);
local VisualHost = require(script.Parent.Parent.VisualHost);
local Log = require(script.Parent.Parent.Log);
local v1 = {};
local CFrame_new_ret = CFrame.new(0, 0, -1);
local table_create_ret = table.create(64);
local table_create_ret2 = table.create(64);
local table_create_ret3 = table.create(64);
local table_create_ret4 = table.create(64);
local table_create_ret5 = table.create(64);
local table_create_ret6 = table.create(64);
local table_create_ret7 = table.create(64);
local table_create_ret8 = table.create(64);
local table_create_ret9 = table.create(64);
local table_create_ret10 = table.create(64);
local table_create_ret11 = table.create(64);
local table_create_ret12 = table.create(64);
local table_create_ret13 = table.create(64);
local table_create_ret14 = table.create(64);
local u2 = 0;
local u3 = false;
local u4 = nil;
local u5 = nil;
local u6 = false;
local u7 = nil;
local u8 = false;
local u9 = nil;
local u10 = false;
local u11 = false;
local v12 = os.clock() % 1000 * 1000000;
local math_floor_ret = math.floor(v12);
local u13 = nil;
local table_create_ret15 = table.create(PlaneBuilder.TILE_W * PlaneBuilder.TILE_H);
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;

local function buildNormCoords(p19, p20) -- Line: 105
    local table_create_ret16 = table.create(p19 * p20);
    local table_create_ret17 = table.create(p19 * p20);

    for i = 0, p20 - 1 do
        local v21 = i;

        for i2 = 0, p19 - 1 do
            local v22 = v21 * p19 + i2 + 1;
            table_create_ret16[v22] = i2 / (p19 - 1);
            table_create_ret17[v22] = v21 / (p20 - 1);
            local _ = i2;
        end;
    end;

    return table_create_ret16, table_create_ret17;
end;

local function buildEdgeWindow(p23, p24, p25) -- Line: 119
    local table_create_ret16 = table.create(p25);

    for i = 1, p25 do
        local v26 = math.min(p23[i], 1 - p23[i], p24[i], 1 - p24[i]) / 0.12;
        local v27 = v26 > 1 and 1 or v26;
        table_create_ret16[i] = v27 * v27 * (3 - v27 * 2);
        local _ = i;
    end;

    return table_create_ret16;
end;

local u28 = false;

local function applyDimToMesh() -- Line: 135
    -- upvalues: u4 (ref), u28 (ref)
    if not u4 then
        return;
    end;

    local part = u4.part;
    part.Material = u28 and Enum.Material.SmoothPlastic or Enum.Material.Glass;

    if u28 then
        part.Transparency = 1;
    end;

    if u4.highlight then
        u4.highlight.Enabled = not u28;
    end;
end;

local function setDimmed(p29) -- Line: 142
    -- upvalues: u28 (ref), u4 (ref), u5 (ref)
    if u28 == p29 then
        return;
    end;

    u28 = p29;

    if u4 then
        local part = u4.part;
        part.Material = u28 and Enum.Material.SmoothPlastic or Enum.Material.Glass;

        if u28 then
            part.Transparency = 1;
        end;

        if u4.highlight then
            u4.highlight.Enabled = not u28;
        end;
    end;

    if u5 then
        local v30 = p29 and Enum.Material.SmoothPlastic or Enum.Material.Glass;

        for i = 1, u5.count do
            u5.tiles[i].Material = v30;

            if p29 then
                u5.tiles[i].Transparency = 1;
            end;

            local v31 = u5.highlights[i];
            local v32;

            if v31 then
                v31.Enabled = not p29;
                v32 = i;
            else
                v32 = i;
            end;
        end;
    end;
end;

function v1.accumulate(p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47) -- Line: 162
    -- upvalues: u10 (ref), u2 (ref), u3 (ref), Log (copy), table_create_ret (copy), table_create_ret2 (copy), table_create_ret3 (copy), table_create_ret4 (copy), table_create_ret5 (copy), table_create_ret6 (copy), table_create_ret7 (copy), table_create_ret8 (copy), table_create_ret9 (copy), table_create_ret10 (copy), table_create_ret11 (copy), table_create_ret12 (copy), table_create_ret13 (copy), table_create_ret14 (copy), PlaneBuilder (copy)
    if u10 then
        return;
    end;

    if u2 >= 64 then
        if not u3 then
            u3 = true;
            Log.warn("[Part-Icles] Distortion: more than " .. 64 .. " simultaneous effects; extras dropped this frame");
        end;

        return;
    end;

    u2 = u2 + 1;
    table_create_ret[u2] = p33;
    table_create_ret2[u2] = p34;
    table_create_ret3[u2] = p35;
    table_create_ret4[u2] = p36;
    table_create_ret5[u2] = p37;
    table_create_ret6[u2] = p38;
    table_create_ret7[u2] = p39;
    table_create_ret8[u2] = p40;
    table_create_ret9[u2] = p41;
    table_create_ret10[u2] = p42;
    table_create_ret11[u2] = p43;
    table_create_ret12[u2] = p44;
    local math_clamp_ret = math.clamp(p45 or 0.3, 0, 10);
    local math_clamp_ret2 = math.clamp(p46 or 1, 0, 1);
    table_create_ret13[u2] = 1 - (1 - math_clamp_ret) * math_clamp_ret2;
    table_create_ret14[u2] = p47 or PlaneBuilder.RES_W;
end;

local function foreignCanvasLive() -- Line: 193
    -- upvalues: VisualHost (copy), math_floor_ret (copy)
    local __PartIclesDistortion = VisualHost.root():FindFirstChild("__PartIclesDistortion");

    if not __PartIclesDistortion then
        return false;
    end;

    if __PartIclesDistortion:GetAttribute("_ownerSerial") == math_floor_ret then
        return false;
    end;

    local Attribute = __PartIclesDistortion:GetAttribute("_hb");

    if typeof(Attribute) == "number" and os.clock() - Attribute < 1 then
        return true;
    end;

    pcall(function() -- Line: 202
        -- upvalues: __PartIclesDistortion (copy)
        __PartIclesDistortion:Destroy();
    end);

    return false;
end;

local function goDormant() -- Line: 206
    -- upvalues: u10 (ref), u11 (ref), Log (copy)
    u10 = true;

    if not u11 then
        u11 = true;
        Log.warn("[Part-Icles] Distortion: another Part-Icles engine owns the screen canvas; this engine\'s distortions are disabled");
    end;
end;

local u48 = 0;

local function deriveResH(p49) -- Line: 219
    -- upvalues: PlaneBuilder (copy)
    local math_floor_ret2 = math.floor(p49 * PlaneBuilder.RES_H / PlaneBuilder.RES_W + 0.5);

    return math.max(4, math_floor_ret2);
end;

local function installMeshBuild(p50) -- Line: 226
    -- upvalues: u4 (ref), math_floor_ret (copy), VisualHost (copy), u14 (ref), u15 (ref), buildNormCoords (copy), u18 (ref), buildEdgeWindow (copy), u13 (ref), u28 (ref)
    local u51 = u4;
    u4 = nil;

    if u51 then
        pcall(function() -- Line: 230
            -- upvalues: u51 (copy)
            u51.part:Destroy();
        end);
        pcall(function() -- Line: 231
            -- upvalues: u51 (copy)
            u51.em:Destroy();
        end);
    end;

    p50.part:SetAttribute("_ownerSerial", math_floor_ret);
    p50.part:SetAttribute("_PartIcleEmit", true);
    p50.part.Transparency = 0.3;
    p50.part.Parent = VisualHost.getCanvasParent();
    u4 = p50;
    local v52 = p50.resW * p50.resH;
    local v53, v54 = buildNormCoords(p50.resW, p50.resH);
    u14 = v53;
    u15 = v54;
    u18 = buildEdgeWindow(u14, u15, v52);
    u13 = table.create(v52);

    if not u4 then
        return;
    end;

    local part = u4.part;
    part.Material = u28 and Enum.Material.SmoothPlastic or Enum.Material.Glass;

    if u28 then
        part.Transparency = 1;
    end;

    if u4.highlight then
        u4.highlight.Enabled = not u28;
    end;
end;

local function ensureCanvas(u55) -- Line: 245
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), foreignCanvasLive (copy), u10 (ref), u11 (ref), Log (copy), u7 (ref), PlaneBuilder (copy), u48 (ref), installMeshBuild (copy), math_floor_ret (copy), VisualHost (copy), u16 (ref), u17 (ref), buildNormCoords (copy)
    if u4 or (u5 or u6) then
        return;
    end;

    if foreignCanvasLive() then
        u10 = true;

        if not u11 then
            u11 = true;
            Log.warn("[Part-Icles] Distortion: another Part-Icles engine owns the screen canvas; this engine\'s distortions are disabled");
        end;

        return;
    end;

    if u7 == nil then
        u7 = PlaneBuilder.probeMesh();
    end;

    u6 = true;
    local u56 = u48;
    task.spawn(function() -- Line: 256
        -- upvalues: u7 (ref), PlaneBuilder (ref), u55 (copy), u48 (ref), u56 (copy), installMeshBuild (ref), u6 (ref), math_floor_ret (ref), VisualHost (ref), u5 (ref), u16 (ref), u17 (ref), buildNormCoords (ref)
        if u7 then
            local buildMesh = PlaneBuilder.buildMesh;
            local math_floor_ret2 = math.floor(u55 * PlaneBuilder.RES_H / PlaneBuilder.RES_W + 0.5);
            local u57 = buildMesh(u55, (math.max(4, math_floor_ret2)));

            if u48 ~= u56 then
                if u57 then
                    pcall(function() -- Line: 262
                        -- upvalues: u57 (copy)
                        u57.part:Destroy();
                    end);
                    pcall(function() -- Line: 263
                        -- upvalues: u57 (copy)
                        u57.em:Destroy();
                    end);
                end;

                return;
            end;

            if u57 then
                installMeshBuild(u57);
                u6 = false;

                return;
            end;

            u7 = false;
        end;

        if u48 ~= u56 then
            return;
        end;

        local v58 = PlaneBuilder.buildTiles();
        v58.model:SetAttribute("_ownerSerial", math_floor_ret);
        v58.model:SetAttribute("_PartIcleEmit", true);
        v58.model.Parent = VisualHost.getCanvasParent();
        u5 = v58;
        local v59, v60 = buildNormCoords(PlaneBuilder.TILE_W, PlaneBuilder.TILE_H);
        u16 = v59;
        u17 = v60;
        u6 = false;
    end);
end;

local function upgradeMesh(u61) -- Line: 289
    -- upvalues: u6 (ref), u48 (ref), PlaneBuilder (copy), installMeshBuild (copy)
    u6 = true;
    local u62 = u48;
    task.spawn(function() -- Line: 292
        -- upvalues: PlaneBuilder (ref), u61 (copy), u48 (ref), u62 (copy), installMeshBuild (ref), u6 (ref)
        local buildMesh = PlaneBuilder.buildMesh;
        local math_floor_ret2 = math.floor(u61 * PlaneBuilder.RES_H / PlaneBuilder.RES_W + 0.5);
        local u63 = buildMesh(u61, (math.max(4, math_floor_ret2)));

        if u48 ~= u62 then
            if u63 then
                pcall(function() -- Line: 296
                    -- upvalues: u63 (copy)
                    u63.part:Destroy();
                end);
                pcall(function() -- Line: 297
                    -- upvalues: u63 (copy)
                    u63.em:Destroy();
                end);
            end;

            return;
        end;

        if u63 then
            installMeshBuild(u63);
        end;

        u6 = false;
    end);
end;

local function resolveTransparency() -- Line: 313
    -- upvalues: u2 (ref), u8 (ref), table_create_ret12 (copy), table_create_ret11 (copy), table_create_ret13 (copy)
    if u2 == 0 then
        return 1;
    end;

    if not u8 then
        local v64 = 0;
        local v65 = true;

        for i = 1, u2 do
            if not table_create_ret12[i] then
                v65 = false;
                break;
            end;

            local v66;

            if v64 < table_create_ret11[i] then
                v64 = table_create_ret11[i];
                v66 = i;
            else
                v66 = i;
            end;
        end;

        if v65 and v64 > 0 then
            return math.clamp(v64, 4, 10);
        end;
    end;

    local v67 = 10;

    for i = 1, u2 do
        local v68;

        if table_create_ret13[i] < v67 then
            v67 = table_create_ret13[i];
            v68 = i;
        else
            v68 = i;
        end;
    end;

    return u8 and v67 > 1 and 0.3 or math.clamp(v67, 0, 10);
end;

local function evalContributions(p69, p70, p71, p72, p73, p74) -- Line: 335
    -- upvalues: Field (copy), u2 (ref), table_create_ret2 (copy), table_create_ret (copy), table_create_ret3 (copy), table_create_ret4 (copy), table_create_ret5 (copy), table_create_ret6 (copy), table_create_ret7 (copy), table_create_ret8 (copy), table_create_ret9 (copy), table_create_ret10 (copy)
    Field.zero(p69, p72);

    for i = 1, u2 do
        local v75;

        if table_create_ret2[i] == 0 then
            v75 = i;
        else
            Field.accumulate(table_create_ret[i], p69, p70, p71, p72, p73, table_create_ret2[i] * p74, table_create_ret3[i], table_create_ret4[i], table_create_ret5[i], table_create_ret6[i], table_create_ret7[i], table_create_ret8[i], table_create_ret9[i], table_create_ret10[i]);
            v75 = i;
        end;
    end;
end;

local function applyMesh(p76, p77) -- Line: 347
    -- upvalues: u4 (ref), CFrame_new_ret (copy), u8 (ref), evalContributions (copy), u13 (ref), u14 (ref), u15 (ref), Lighting (copy), u18 (ref)
    local v78 = u4;
    local v79 = math.rad(p76.FieldOfView) * 0.5;
    local v80 = math.tan(v79) * 1 * 1.15;
    local ViewportSize = p76.ViewportSize;
    local v81 = ViewportSize.X / math.max(1, ViewportSize.Y);
    local part = v78.part;
    part.CFrame = p76.CFrame * CFrame_new_ret;
    part:SetAttribute("_hb", os.clock());
    part.Size = Vector3.new(v80 * v81 * 2, v80 * 2, v78.meshSizeZ);
    part.Transparency = p77;

    if p77 > 1 and math.abs(part.Transparency - p77) > 0.01 then
        u8 = true;
        part.Transparency = 0.3;
    end;

    local v82 = v78.resW * v78.resH;
    evalContributions(u13, u14, u15, v82, v81, v80 * 0.22);
    local v83, v84 = p76:WorldToViewportPoint(p76.CFrame.Position + Lighting:GetSunDirection() * 1000);
    local v85, v86, v87;

    if v84 and v83.Z > 0 then
        v85 = v83.X / math.max(1, ViewportSize.X);
        v86 = 1 - v83.Y / math.max(1, ViewportSize.Y);
        v87 = true;
    else
        v87 = false;
        v85 = 0;
        v86 = 0;
    end;

    local em = v78.em;
    local ids = v78.ids;
    local baseX = v78.baseX;
    local baseY = v78.baseY;

    for i = 1, v82 do
        local v88 = u13[i] * u18[i];

        if v87 then
            local v89 = (u14[i] - v85) * v81;
            local v90 = u15[i] - v86;
            local v91 = v89 * v89 + v90 * v90;

            if v91 < 0.06760000000000001 then
                if v91 <= 0.0081 then
                    v88 = 0;
                else
                    local v92 = (v91 - 0.0081) / 0.05950000000000001;
                    v88 = v88 * v92 * v92 * (3 - 2 * v92);
                end;
            end;
        end;

        em:SetPosition(ids[i], (Vector3.new(baseX[i], baseY[i], v88 > 0.45 and 0.45 or (v88 < -0.45 and -0.45 or v88))));
        local _ = i;
    end;
end;

local function applyTiles(p93) -- Line: 404
    -- upvalues: u5 (ref), evalContributions (copy), table_create_ret15 (copy), u16 (ref), u17 (ref), u2 (ref), table_create_ret13 (copy)
    local v94 = u5;
    local count = v94.count;
    local ViewportSize = p93.ViewportSize;
    evalContributions(table_create_ret15, u16, u17, count, ViewportSize.X / math.max(1, ViewportSize.Y), 1);
    v94.model:SetAttribute("_hb", os.clock());
    local v95 = 1;

    for i = 1, u2 do
        local v96;

        if table_create_ret13[i] < v95 then
            v95 = table_create_ret13[i];
            v96 = i;
        else
            v96 = i;
        end;
    end;

    local v97 = 1 - math.clamp(v95, 0, 1);
    local CFrame2 = p93.CFrame;

    for i = 1, count do
        local v98 = CFrame2 * CFrame.Angles(v94.pitchAng[i], v94.yawAng[i], 0);
        v94.writeCFs[i] = CFrame.lookAt(CFrame2.Position + v98.LookVector * 3.5, CFrame2.Position);
        local v99 = math.abs(table_create_ret15[i]) * 2;
        local math_clamp_ret = math.clamp(v99, 0, 1);
        v94.tiles[i].Transparency = 1 - math_clamp_ret * 0.5 * v97;
        local _ = i;
    end;

    workspace:BulkMoveTo(v94.tiles, v94.writeCFs, Enum.BulkMoveMode.FireCFrameChanged);
end;

local u100 = nil;
local u101 = nil;

local function relockToCam() -- Line: 436
    -- upvalues: u4 (ref), u101 (ref), CFrame_new_ret (copy)
    if u4 and (u101 and u4.part.Parent) then
        u4.part.CFrame = u101.CFrame * CFrame_new_ret;
    end;
end;

local function ensureCamWeld(p102) -- Line: 441
    -- upvalues: u101 (ref), u100 (ref), relockToCam (copy)
    if u101 == p102 then
        return;
    end;

    if u100 then
        u100:Disconnect();
    end;

    u101 = p102;
    u100 = p102:GetPropertyChangedSignal("CFrame"):Connect(relockToCam);
end;

local function dropCamWeld() -- Line: 447
    -- upvalues: u100 (ref), u101 (ref)
    if u100 then
        u100:Disconnect();
        u100 = nil;
    end;

    u101 = nil;
end;

local function parkCanvas() -- Line: 455
    -- upvalues: u100 (ref), u101 (ref), u4 (ref), u5 (ref)
    if u100 then
        u100:Disconnect();
        u100 = nil;
    end;

    u101 = nil;

    if u4 then
        pcall(function() -- Line: 458
            -- upvalues: u4 (ref)
            u4.part.Parent = nil;
        end);
    end;

    if u5 then
        pcall(function() -- Line: 461
            -- upvalues: u5 (ref)
            u5.model.Parent = nil;
        end);
    end;
end;

local function unparkCanvas() -- Line: 468
    -- upvalues: u4 (ref), VisualHost (copy), u5 (ref)
    if u4 and not (u4.part.Parent or pcall(function() -- Line: 470
        -- upvalues: u4 (ref), VisualHost (ref)
        u4.part.Parent = VisualHost.getCanvasParent();
    end)) then
        pcall(function() -- Line: 472
            -- upvalues: u4 (ref)
            u4.em:Destroy();
        end);
        u4 = nil;
    end;

    if u5 and not (u5.model.Parent or pcall(function() -- Line: 477
        -- upvalues: u5 (ref), VisualHost (ref)
        u5.model.Parent = VisualHost.getCanvasParent();
    end)) then
        u5 = nil;
    end;
end;

function v1.applyFrame() -- Line: 484
    -- upvalues: u2 (ref), u4 (ref), u5 (ref), u101 (ref), u100 (ref), relockToCam (copy), u9 (ref), applyMesh (copy), applyTiles (copy), setDimmed (copy), parkCanvas (copy), CFrame_new_ret (copy), u10 (ref), foreignCanvasLive (copy), u11 (ref), Log (copy), unparkCanvas (copy), PlaneBuilder (copy), table_create_ret14 (copy), ensureCanvas (copy), u6 (ref), u48 (ref), installMeshBuild (copy), resolveTransparency (copy)
    local v103 = u2 > 0;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        u2 = 0;

        return;
    end;

    if not v103 then
        if u4 and u4.part.Parent or u5 and u5.model.Parent then
            if u4 and u101 ~= workspace_CurrentCamera then
                if u100 then
                    u100:Disconnect();
                end;

                u101 = workspace_CurrentCamera;
                u100 = workspace_CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(relockToCam);
            end;

            if u9 == nil then
                u9 = os.clock();

                if u4 then
                    applyMesh(workspace_CurrentCamera, 1);
                else
                    applyTiles(workspace_CurrentCamera);
                end;

                setDimmed(true);

                return;
            end;

            if os.clock() - u9 >= 2 then
                parkCanvas();

                return;
            end;

            if u4 then
                u4.part.CFrame = workspace_CurrentCamera.CFrame * CFrame_new_ret;
                u4.part:SetAttribute("_hb", os.clock());

                return;
            end;

            if u5 then
                applyTiles(workspace_CurrentCamera);
            end;
        end;

        return;
    end;

    u9 = nil;

    if u10 then
        if foreignCanvasLive() then
            u2 = 0;

            return;
        end;

        u10 = false;
    end;

    if (u4 and not u4.part.Parent or u5 and not u5.model.Parent) and foreignCanvasLive() then
        u10 = true;

        if not u11 then
            u11 = true;
            Log.warn("[Part-Icles] Distortion: another Part-Icles engine owns the screen canvas; this engine\'s distortions are disabled");
        end;

        u2 = 0;

        return;
    end;

    unparkCanvas();
    local RES_W = PlaneBuilder.RES_W;

    for i = 1, u2 do
        local v104;

        if RES_W < table_create_ret14[i] then
            RES_W = table_create_ret14[i];
            v104 = i;
        else
            v104 = i;
        end;
    end;

    ensureCanvas(RES_W);

    if u10 or not (u4 or u5) then
        u2 = 0;

        return;
    end;

    if u4 and (not u6 and u4.resW < RES_W) then
        u6 = true;
        local u105 = u48;
        task.spawn(function() -- Line: 292
            -- upvalues: PlaneBuilder (ref), RES_W (copy), u48 (ref), u105 (copy), installMeshBuild (ref), u6 (ref)
            local buildMesh = PlaneBuilder.buildMesh;
            local math_floor_ret2 = math.floor(RES_W * PlaneBuilder.RES_H / PlaneBuilder.RES_W + 0.5);
            local u106 = buildMesh(RES_W, (math.max(4, math_floor_ret2)));

            if u48 ~= u105 then
                if u106 then
                    pcall(function() -- Line: 296
                        -- upvalues: u106 (copy)
                        u106.part:Destroy();
                    end);
                    pcall(function() -- Line: 297
                        -- upvalues: u106 (copy)
                        u106.em:Destroy();
                    end);
                end;

                return;
            end;

            if u106 then
                installMeshBuild(u106);
            end;

            u6 = false;
        end);
    end;

    local v107 = resolveTransparency();
    local v108;

    if v107 >= 0.999 then
        v108 = v107 <= 1;
    else
        v108 = false;
    end;

    setDimmed(v108);

    if u4 then
        if u101 ~= workspace_CurrentCamera then
            if u100 then
                u100:Disconnect();
            end;

            u101 = workspace_CurrentCamera;
            u100 = workspace_CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(relockToCam);
        end;

        applyMesh(workspace_CurrentCamera, v107);
    else
        applyTiles(workspace_CurrentCamera);
    end;

    u2 = 0;
end;

function v1.reset() -- Line: 567
    -- upvalues: u100 (ref), u101 (ref), u4 (ref), u5 (ref), u2 (ref), u6 (ref), u48 (ref), u7 (ref), u8 (ref), u9 (ref), u28 (ref), u10 (ref), u11 (ref), u3 (ref)
    if u100 then
        u100:Disconnect();
        u100 = nil;
    end;

    u101 = nil;

    if u4 then
        pcall(function() -- Line: 570
            -- upvalues: u4 (ref)
            u4.part:Destroy();
        end);
        pcall(function() -- Line: 571
            -- upvalues: u4 (ref)
            u4.em:Destroy();
        end);
        u4 = nil;
    end;

    if u5 then
        pcall(function() -- Line: 575
            -- upvalues: u5 (ref)
            u5.model:Destroy();
        end);
        u5 = nil;
    end;

    u2 = 0;
    u6 = false;
    u48 = u48 + 1;
    u7 = nil;
    u8 = false;
    u9 = nil;
    u28 = false;
    u10 = false;
    u11 = false;
    u3 = false;
end;

return v1;