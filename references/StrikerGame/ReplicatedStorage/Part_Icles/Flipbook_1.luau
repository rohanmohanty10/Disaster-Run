 
 

local Range = require(script.Parent.Range);
local Log = require(script.Parent.Log);
local Preload = require(script.Parent.Preload);
local u1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function sameFrames(p3, p4) -- Line: 13
    if not p3 or #p3 ~= #p4 then
        return false;
    end;

    for i = 1, #p4 do
        if p3[i] ~= p4[i] then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function u1.GetSortedTextures(p5: userdata) -- Line: 24
    -- upvalues: u2 (copy), Preload (copy)
    local v6 = {};

    for _, child in pairs(p5:GetChildren()) do
        if child:IsA("Decal") then
            table.insert(v6, child);
        end;
    end;

    if #v6 == 0 then
        return {};
    end;

    table.sort(v6, function(p7, p8) -- Line: 33
        return (tonumber(p7.Name) or 0) < (tonumber(p8.Name) or 0);
    end);
    local v9 = {};

    for _, v in ipairs(v6) do
        table.insert(v9, v.Texture);
    end;

    local v10 = u2[p5];
    local v11;

    if v10 and #v10 == #v9 then
        v11 = true;

        for i = 1, #v9 do
            if v10[i] ~= v9[i] then
                v11 = false;
                break;
            end;

            local _ = i;
        end;
    else
        v11 = false;
    end;

    if not v11 then
        u2[p5] = table.clone(v9);
        Preload.ask(v6);
    end;

    return v9;
end;

u1.GetSortedBeamTextures = u1.GetSortedTextures;
local u12 = false;

local function _writeFrame(u13, u14, u15) -- Line: 55
    -- upvalues: u12 (ref), Log (copy)
    local success, result = pcall(function() -- Line: 56
        -- upvalues: u13 (copy), u14 (copy), u15 (copy)
        u13[u14] = u15;
    end);

    if not (success or (u14 ~= "ColorMap" or u12)) then
        u12 = true;
        Log.warn(("[Part-Icles] SurfaceAppearance flipbook ColorMap write failed (%s). ColorMap is PluginSecurity  -  SurfaceAppearance flipbooks only animate in plugin context. For runtime games, use Decal / Texture flipbooks instead."):format((tostring(result))));
    end;
end;

local function _texProp(p16) -- Line: 67
    return p16 and p16:IsA("SurfaceAppearance") and "ColorMap" or (p16 and p16:IsA("MeshPart") and "TextureID" or "Texture");
end;

function u1.layerState(p17, p18, p19, p20, p21, p22) -- Line: 75
    if typeof(p19) == "EnumItem" then
        p19 = p19.Name;
    end;

    local v23 = #p18;

    return {
        lastFrame = -1,
        target = p17,
        frames = p18,
        n = v23,
        mode = p19,
        frameDelay = 1 / ((not p20 or p20 < 0.1) and 0.1 or p20),
        startOffset = p21 and math.random(0, v23 - 1) or 0,
        reverse = p22 == true
    };
end;

function u1.frameIndex(p24, p25, p26) -- Line: 91
    local n = p24.n;
    local v27;

    if p24.mode == "Loop" then
        v27 = (math.floor(p25 / p24.frameDelay) + p24.startOffset) % n + 1;
    elseif p24.mode == "PingPong" and n > 1 then
        local v28 = 2 * n - 2;
        local v29 = (math.floor(p25 / p24.frameDelay) + p24.startOffset) % v28;

        if n <= v29 then
            v29 = v28 - v29;
        end;

        v27 = v29 + 1;
    else
        local v30 = p25 / math.max(p26, 0.001) * n;
        local v31 = math.floor(v30) + 1;
        v27 = (math.min(v31, n) - 1 + p24.startOffset) % n + 1;
    end;

    if p24.reverse then
        v27 = n - v27 + 1;
    end;

    return v27;
end;

function u1.finalFrame(p32) -- Line: 110
    local n = p32.n;
    local v33 = (n - 1 + p32.startOffset) % n + 1;

    if p32.reverse then
        v33 = n - v33 + 1;
    end;

    return v33;
end;

local function _isOneShot(p34) -- Line: 117
    local v35;

    if p34.mode == "Loop" then
        v35 = false;
    else
        v35 = p34.mode ~= "PingPong";
    end;

    return v35;
end;

local function _run(u36, p37, u38, u39, u40, p41) -- Line: 124
    -- upvalues: Range (copy), u1 (copy), _writeFrame (copy)
    if #u38 == 0 then
        return;
    end;

    local v42 = Range.RandomValueFromRange(p37.FlipbookFramerate);
    local u43 = u1.layerState(u39, u38, p41, v42, p37.FlipbookStartRandom, p37.FlipbookReverse);
    local os_clock_ret = os.clock();
    local u44 = u39 and u39:IsA("SurfaceAppearance") and "ColorMap" or (u39 and u39:IsA("MeshPart") and "TextureID" or "Texture");
    task.spawn(function() -- Line: 131
        -- upvalues: os_clock_ret (copy), u40 (copy), u39 (copy), u36 (copy), u1 (ref), u43 (copy), _writeFrame (ref), u44 (copy), u38 (copy)
        while os.clock() - os_clock_ret < u40 * 4 do
            if not (u39 and u39.Parent) then
                return;
            end;

            if u36 and not (u36.VisualPart and u36.VisualPart.Parent) then
                break;
            end;

            if u36 and u36._handedOver then
                return;
            end;

            local v45 = u36 and u36._effectiveElapsed or os.clock() - os_clock_ret;
            local v46 = u1.frameIndex(u43, v45, u40);

            if v46 ~= u43.lastFrame then
                _writeFrame(u39, u44, u38[v46]);
                u43.lastFrame = v46;
            end;

            task.wait();
        end;

        local v47 = u43;
        local v48;

        if v47.mode == "Loop" then
            v48 = false;
        else
            v48 = v47.mode ~= "PingPong";
        end;

        if v48 and (u39 and u39.Parent) then
            _writeFrame(u39, u44, u38[u1.finalFrame(u43)]);
        end;
    end);
end;

local function _playable(p49) -- Line: 151
    return (p49 == Enum.ParticleFlipbookMode.Loop or p49 == Enum.ParticleFlipbookMode.OneShot) and true or p49 == Enum.ParticleFlipbookMode.PingPong;
end;

function u1.Flip(p50: any, p51: any, p52: table, p53: any, p54: any) -- Line: 159
    -- upvalues: _run (copy)
    if p51 then
        local FlipbookMode = p51.FlipbookMode;

        if (FlipbookMode == Enum.ParticleFlipbookMode.Loop or FlipbookMode == Enum.ParticleFlipbookMode.OneShot) and true or FlipbookMode == Enum.ParticleFlipbookMode.PingPong then
            _run(p50, p51, p52, p53, p54, p51.FlipbookMode.Name);
        end;
    end;
end;

function u1.GetFlipbookSets(p55: userdata) -- Line: 166
    -- upvalues: u1 (copy)
    local v56 = {};
    local SortedTextures = u1.GetSortedTextures(p55);

    if #SortedTextures > 0 then
        v56[""] = SortedTextures;
    end;

    for _, child in ipairs(p55:GetChildren()) do
        if child:IsA("Folder") then
            local SortedTextures2 = u1.GetSortedTextures(child);

            if #SortedTextures2 > 0 then
                v56[child.Name] = SortedTextures2;
            end;
        end;
    end;

    return v56;
end;

function u1.FlipLayers(u57, p58, u59) -- Line: 181
    -- upvalues: u1 (copy), _writeFrame (copy)
    local u60 = {};

    for _, v in ipairs(p58) do
        if v.flip then
            table.insert(u60, v.flip);
        end;
    end;

    if #u60 == 0 then
        return;
    end;

    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 188
        -- upvalues: os_clock_ret (copy), u59 (copy), u57 (copy), u60 (copy), u1 (ref), _writeFrame (ref)
        while os.clock() - os_clock_ret < u59 * 4 do
            if not (u57.VisualPart and u57.VisualPart.Parent) then
                return;
            end;

            if u57._handedOver then
                return;
            end;

            local v61 = u57._effectiveElapsed or os.clock() - os_clock_ret;

            for i = 1, #u60 do
                local v62 = u60[i];
                local v63;

                if v62.target.Parent then
                    local v64 = u1.frameIndex(v62, v61, u59);

                    if v64 == v62.lastFrame then
                        v63 = i;
                    else
                        _writeFrame(v62.target, "Texture", v62.frames[v64]);
                        v62.lastFrame = v64;
                        v63 = i;
                    end;
                else
                    v63 = i;
                end;
            end;

            task.wait();
        end;

        for i = 1, #u60 do
            local v65 = u60[i];
            local v66;

            if v65.mode == "Loop" then
                v66 = false;
            else
                v66 = v65.mode ~= "PingPong";
            end;

            local v67;

            if v66 and v65.target.Parent then
                _writeFrame(v65.target, "Texture", v65.frames[u1.finalFrame(v65)]);
                v67 = i;
            else
                v67 = i;
            end;
        end;
    end);
end;

function u1.FlipBeam(p68: any, p69: any, p70: table, p71: any, p72: any) -- Line: 215
    -- upvalues: _run (copy)
    if p69 and p70 then
        local FlipbookMode = p69.FlipbookMode;

        if (FlipbookMode == Enum.ParticleFlipbookMode.Loop or FlipbookMode == Enum.ParticleFlipbookMode.OneShot) and true or FlipbookMode == Enum.ParticleFlipbookMode.PingPong then
            _run(p68, p69, p70, p71, p72, p69.FlipbookMode.Name);
        end;
    end;
end;

return u1;