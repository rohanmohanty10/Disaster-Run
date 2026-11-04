 
 

local Pool = require(script.Parent.Parent.Pool);
local Graph = require(script.Parent.Parent.Graph);
local BoltGen = require(script.Parent.BoltGen);
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local u1 = {
    MAX_BOLT_PARTS = 64,
    FAR_CFRAME = CFrame_new_ret,
    Rigs = setmetatable({}, {
        __mode = "k"
    })
};

local function buildSegment(p2) -- Line: 26
    -- upvalues: Pool (copy)
    local v3 = Pool.copyBare(p2);
    v3.Anchored = true;
    v3.CanCollide = false;
    v3.CanQuery = false;
    v3.CanTouch = false;
    v3.Massless = true;
    v3.Locked = true;
    v3.Archivable = false;
    v3.Transparency = 0;

    return v3, v3:FindFirstChildWhichIsA("Decal") or v3:FindFirstChildWhichIsA("Texture");
end;

function u1.layoutFor(p4) -- Line: 42
    -- upvalues: BoltGen (copy)
    return BoltGen.layout(p4.SegmentCount.Max, p4.ForkDepth.Max, p4.ForkChance.Max, 64);
end;

function u1.buildRig(p5) -- Line: 48
    -- upvalues: u1 (copy), Pool (copy), CFrame_new_ret (copy)
    local v6, v7, v8, v9 = u1.layoutFor(p5);
    local Model = Instance.new("Model");
    Model.Name = "LightningBolt";
    Model.Archivable = false;
    Model:SetAttribute("_lightningBolt", true);
    local v10 = {
        partCount = v6,
        mainSegs = v7,
        forkSegs = v8,
        forkSlots = v9,
        parts = table.create(v6),
        rollCFs = table.create(v6),
        writeCFs = table.create(v6),
        segLen = table.create(v6),
        revealDist = table.create(v6),
        revealOrder = table.create(v6),
        widthScale = table.create(v6),
        decals = table.create(v6),
        slotDepth = table.create((math.max(v9, 1))),
        ptBuf = table.create(v7 + 1),
        basePtBuf = table.create(v7 + 1),
        forkPtBuf = table.create(v8 + 1),
        forkAnchorPos = {},
        forkAnchorDir = {},
        forkAnchorReveal = {},
        forkAnchorSlot = {},
        forkAnchorPtIdx = {},
        forkOriginIdx = {},
        forkParentSlot = {},
        forkParentPtIdx = {},
        forkLen = {},
        forkU = {},
        forkV = {},
        forkSeedU = {},
        forkSeedV = {},
        forkStartReveal = {},
        forkStartFrac = {},
        forkLocalPts = {},
        forkWorldPts = {},
        prevLive = table.create(v6),
        lastWrittenLen = table.create(v6),
        sizeWriteIdx = table.create(v6),
        newlyLiveIdx = table.create(v6),
        gradColor = table.create(v6),
        taper = table.create(v6)
    };

    for i = 1, v9 do
        v10.forkLocalPts[i] = table.create(v8 + 1);
        v10.forkWorldPts[i] = table.create(v8 + 1);
        v10.forkOriginIdx[i] = 0;
        v10.forkParentSlot[i] = 0;
        local _ = i;
    end;

    local v11;

    if v9 > 0 then
        local math_ceil_ret = math.ceil(v9 / 2);
        v11 = math.max(1, math_ceil_ret) or 0;
    else
        v11 = 0;
    end;

    for i = 1, v9 do
        v10.slotDepth[i] = i <= v11 and 1 or 2;
        local _ = i;
    end;

    local math_max_ret = math.max(0.45, p5.ForkLengthScale and (p5.ForkLengthScale.Max or 0.4) or 0.4);

    for i = 1, v6 do
        local v12 = Pool.copyBare(p5.RenderTemplate);
        v12.Anchored = true;
        v12.CanCollide = false;
        v12.CanQuery = false;
        v12.CanTouch = false;
        v12.Massless = true;
        v12.Locked = true;
        v12.Archivable = false;
        v12.Transparency = 0;
        local v13 = v12:FindFirstChildWhichIsA("Decal") or v12:FindFirstChildWhichIsA("Texture");
        v12.Name = "Seg" .. i;
        v12.CFrame = CFrame_new_ret;
        v12.Parent = Model;
        v10.parts[i] = v12;
        v10.decals[i] = v13;
        v10.rollCFs[i] = CFrame_new_ret;
        v10.writeCFs[i] = CFrame_new_ret;
        v10.segLen[i] = 0.05;
        v10.revealDist[i] = (1 / 0);
        v10.revealOrder[i] = i;
        v10.prevLive[i] = false;
        v10.lastWrittenLen[i] = -1;
        v10.taper[i] = 1;
        local v14;

        if i <= v7 then
            v10.widthScale[i] = 1;
            v14 = i;
        else
            local v15 = math.floor((i - v7 - 1) / v8) + 1;
            v10.widthScale[i] = math_max_ret ^ (v10.slotDepth[v15] or 1);
            v14 = i;
        end;
    end;

    u1.Rigs[Model] = v10;

    return Model, v10;
end;

function u1.applyTaper(p16, p17, p18, p19) -- Line: 135
    -- upvalues: Graph (copy)
    local v20 = 1 / math.max(p19 or 0, 0.0001);

    for i = 1, p16.partCount do
        local v21 = p16.revealDist[i];
        local v22;

        if p17 and v21 ~= (1 / 0) then
            local v23;

            if i <= p16.mainSegs then
                v23 = (v21 + p16.segLen[i] * 0.5) * v20;
            else
                local v24 = math.floor((i - p16.mainSegs - 1) / p16.forkSegs) + 1;
                local v25 = p16.forkStartFrac[v24] or 0;
                local v26 = (v21 - (p16.forkStartReveal[v24] or 0) + p16.segLen[i] * 0.5) / math.max(p16.forkLen[v24] or 1, 0.0001);
                v23 = v25 + math.clamp(v26, 0, 1) * (1 - v25);
            end;

            local v27 = Graph.QueryPointsWithTime(math.clamp(v23, 0, 1), p17, p18);
            v22 = math.max(v27, 0);
        else
            v22 = 1;
        end;

        local v28;

        if v22 == p16.taper[i] then
            v28 = i;
        else
            p16.taper[i] = v22;
            p16.lastWrittenLen[i] = -1;
            v28 = i;
        end;
    end;
end;

local function rebuildRevealMask(p29, p30, p31) -- Line: 164
    -- upvalues: CFrame_new_ret (copy)
    local v32 = p29.maxReveal or 0;
    local v33 = 0;

    for i = 1, p29.partCount do
        local v34 = p29.revealOrder[i];
        local v35 = p29.revealDist[v34];
        local v36;

        if p31 then
            if v35 == (1 / 0) then
                v36 = false;
            else
                v36 = v35 + p29.segLen[v34] >= v32 - p30;
            end;
        else
            v36 = v35 <= p30;
        end;

        local v37;

        if v36 then
            p29.writeCFs[v34] = p29.rollCFs[v34];
            v33 = i;
            v37 = v33;
            local v38 = v33;
            v33 = v37;
            v38 = v37;
        else
            p29.writeCFs[v34] = CFrame_new_ret;
            v37 = i;
        end;
    end;

    return v33;
end;

function u1.flushCFrames(p39, p40) -- Line: 189
    -- upvalues: rebuildRevealMask (copy)
    local _rig = p39._rig;
    local v41 = p39._lSpeed ~= 0;

    if v41 then
        p39._revealPtr = rebuildRevealMask(_rig, p39._tipDist or 0, p39._growReversed);
    end;

    local v42 = v41 and _rig.writeCFs or _rig.rollCFs;

    if p40 then
        for i = 1, _rig.partCount do
            _rig.parts[i].CFrame = v42[i];
            local _ = i;
        end;

        return;
    end;

    workspace:BulkMoveTo(_rig.parts, v42, Enum.BulkMoveMode.FireCFrameChanged);
end;

function u1.acquireBolt(p43) -- Line: 205
    -- upvalues: u1 (copy), Pool (copy)
    local v44 = u1.layoutFor(p43);
    local u45 = p43.Pool ~= false and Pool.acquire(p43.RenderTemplate, "Lightning");

    if u45 then
        local v46 = u1.Rigs[u45];

        if v46 and (v46.partCount == v44 and (v46.parts[1] and v46.parts[1].Parent == u45)) then
            u45:SetAttribute("_PartIcleEmit", true);

            return u45, v46;
        end;

        pcall(function() -- Line: 215
            -- upvalues: u45 (copy)
            u45:Destroy();
        end);
    end;

    local v47, v48 = u1.buildRig(p43);
    v47:SetAttribute("_PartIcleEmit", true);

    return v47, v48;
end;

return u1;