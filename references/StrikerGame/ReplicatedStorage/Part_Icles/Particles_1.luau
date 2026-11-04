 
 

local Range = require(script.Parent.Range);
local EngineAttr = require(script.Parent.EngineAttr);
local EmitterBursts = require(script.Parent.EmitterBursts);
local u1 = {};

local function parseDuration(p2) -- Line: 14
    -- upvalues: Range (copy)
    if p2 == nil then
        return nil;
    end;

    if typeof(p2) == "number" then
        return p2;
    end;

    local v3 = {};

    for i in tostring(p2):gmatch("[^,]+") do
        local v4 = tonumber(i:match("^%s*(.-)%s*$"));

        if v4 then
            table.insert(v3, v4);
        end;
    end;

    if #v3 == 0 then
        return nil;
    end;

    if #v3 == 1 then
        return v3[1];
    end;

    local math_min_ret = math.min(v3[1], v3[2]);
    local math_max_ret = math.max(v3[1], v3[2]);

    return Range.RandomValueFromRange(NumberRange.new(math_min_ret, math_max_ret));
end;

u1.parseDuration = parseDuration;

local function _hasTransformedAncestor(p5, p6) -- Line: 28
    local Parent = p5.Parent;

    while Parent and Parent ~= p6 do
        if Parent:GetAttribute("Transformed") then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

local function _alive(p7) -- Line: 38
    return not p7 or p7();
end;

local function _bumpCancelGen(p8) -- Line: 52
    -- upvalues: EngineAttr (copy)
    local v9 = (p8:GetAttribute("_PartIcleNativeEmitGen") or 0) + 1;
    EngineAttr.write(p8, "_PartIcleNativeEmitGen", v9);

    return v9;
end;

local function _readDurationGen(p10) -- Line: 61
    return p10:GetAttribute("_PartIcleNativeDurationGen") or 0;
end;

local function _bumpDurationGen(p11) -- Line: 64
    -- upvalues: EngineAttr (copy)
    local v12 = (p11:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
    EngineAttr.write(p11, "_PartIcleNativeDurationGen", v12);

    return v12;
end;

local function _durationGenStillCurrent(p13, p14) -- Line: 69
    local v15;

    if p13.Parent == nil then
        v15 = false;
    else
        v15 = (p13:GetAttribute("_PartIcleNativeDurationGen") or 0) == p14;
    end;

    return v15;
end;

function u1.SetEnabledForDuration(u16, p17) -- Line: 75
    -- upvalues: EngineAttr (copy)
    local u18 = (u16:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
    EngineAttr.write(u16, "_PartIcleNativeDurationGen", u18);
    EngineAttr.writeProp(u16, "Enabled", true);
    task.delay(p17, function() -- Line: 78
        -- upvalues: u16 (copy), u18 (copy), EngineAttr (ref)
        local v19 = u16;
        local v20 = u18;
        local v21;

        if v19.Parent == nil then
            v21 = false;
        else
            v21 = (v19:GetAttribute("_PartIcleNativeDurationGen") or 0) == v20;
        end;

        if v21 then
            EngineAttr.writeProp(u16, "Enabled", false);
        end;
    end);
end;

function u1.ReadNativeGen(p22) -- Line: 49
    return p22:GetAttribute("_PartIcleNativeEmitGen") or 0;
end;

function u1.IsNativeGenCurrent(p23, p24) -- Line: 57
    local v25;

    if p23.Parent == nil then
        v25 = false;
    else
        v25 = (p23:GetAttribute("_PartIcleNativeEmitGen") or 0) == p24;
    end;

    return v25;
end;

function u1.CancelNative(u26) -- Line: 91
    -- upvalues: EngineAttr (copy)
    local v27 = (u26:GetAttribute("_PartIcleNativeEmitGen") or 0) + 1;
    EngineAttr.write(u26, "_PartIcleNativeEmitGen", v27);
    local v28 = (u26:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
    EngineAttr.write(u26, "_PartIcleNativeDurationGen", v28);
    pcall(function() -- Line: 94
        -- upvalues: EngineAttr (ref), u26 (copy)
        EngineAttr.writeProp(u26, "Enabled", false);
    end);
end;

function u1.fireEmitter(u29, u30) -- Line: 102
    -- upvalues: EngineAttr (copy), EmitterBursts (copy), u1 (copy)
    local u31 = tonumber(u29:GetAttribute("EmitCount")) or 1;
    local v32 = tonumber(u29:GetAttribute("EmitDelay")) or 0;
    local u33 = tonumber(u29:GetAttribute("EmitDuration")) or 0;
    local u34 = u29:GetAttribute("EmitMode") == "Burst";

    if u31 <= 0 and (u34 or u33 <= 0) then
        return;
    end;

    local u35 = u29:GetAttribute("_PartIcleNativeEmitGen") or 0;

    local function start() -- Line: 109
        -- upvalues: u30 (copy), u29 (copy), u35 (copy), u34 (copy), EngineAttr (ref), EmitterBursts (ref), u31 (copy), u33 (copy), u1 (ref)
        local v36 = u30;

        if not v36 or v36() then
            local v37 = u29;
            local v38 = u35;
            local v39;

            if v37.Parent == nil then
                v39 = false;
            else
                v39 = (v37:GetAttribute("_PartIcleNativeEmitGen") or 0) == v38;
            end;

            if v39 then
                if not u34 then
                    if u31 > 0 then
                        u29:Emit(u31);
                    end;

                    if u33 > 0 then
                        u1.SetEnabledForDuration(u29, u33);
                    end;

                    return;
                end;

                local v40 = u29;
                local u41 = (v40:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                EngineAttr.write(v40, "_PartIcleNativeDurationGen", u41);

                if u29.Enabled then
                    EngineAttr.writeProp(u29, "Enabled", false);
                end;

                EmitterBursts.start(u29, u31, u33, function() -- Line: 116
                    -- upvalues: u30 (ref), u29 (ref), u41 (copy)
                    local v42 = u30;
                    local v43 = not v42 or v42();

                    if v43 then
                        local v44 = u29;
                        local v45 = u41;

                        if v44.Parent == nil then
                            v43 = false;
                        else
                            v43 = (v44:GetAttribute("_PartIcleNativeDurationGen") or 0) == v45;
                        end;
                    end;

                    return v43;
                end);
            end;
        end;
    end;

    if v32 > 0 then
        task.delay(v32, start);

        return;
    end;

    start();
end;

function u1.EnableEmit(p46, u47) -- Line: 129
    -- upvalues: _hasTransformedAncestor (copy), u1 (copy), parseDuration (copy), EngineAttr (copy)
    for _, descendant in p46:GetDescendants() do
        if not _hasTransformedAncestor(descendant, p46) then
            if descendant:IsA("ParticleEmitter") then
                u1.fireEmitter(descendant, u47);
            end;

            if descendant:IsA("Trail") and not descendant:GetAttribute("Transformed") then
                local u48 = parseDuration(descendant:GetAttribute("EmitDuration"));

                if u48 and u48 > 0 then
                    local u49 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;
                    task.delay(tonumber(descendant:GetAttribute("EmitDelay")) or 0.001, function() -- Line: 143
                        -- upvalues: u47 (copy), descendant (copy), u49 (copy), EngineAttr (ref), u48 (copy)
                        local v50 = u47;

                        if not v50 or v50() then
                            local v51 = descendant;
                            local v52 = u49;
                            local v53;

                            if v51.Parent == nil then
                                v53 = false;
                            else
                                v53 = (v51:GetAttribute("_PartIcleNativeEmitGen") or 0) == v52;
                            end;

                            if v53 then
                                local v54 = descendant;
                                local u55 = (v54:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                EngineAttr.write(v54, "_PartIcleNativeDurationGen", u55);
                                EngineAttr.writeProp(descendant, "Enabled", true);
                                task.delay(u48, function() -- Line: 147
                                    -- upvalues: descendant (ref), u55 (copy), EngineAttr (ref)
                                    local v56 = descendant;
                                    local v57 = u55;
                                    local v58;

                                    if v56.Parent == nil then
                                        v58 = false;
                                    else
                                        v58 = (v56:GetAttribute("_PartIcleNativeDurationGen") or 0) == v57;
                                    end;

                                    if v58 then
                                        EngineAttr.writeProp(descendant, "Enabled", false);
                                    end;
                                end);
                            end;
                        end;
                    end);
                end;
            end;

            if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                local u59 = tonumber(descendant:GetAttribute("EmitDuration")) or 0;
                local v60 = tonumber(descendant:GetAttribute("EmitDelay")) or 0;

                if u59 > 0 then
                    local u61 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;

                    local function doEmit() -- Line: 161
                        -- upvalues: u47 (copy), descendant (copy), u61 (copy), EngineAttr (ref), u59 (copy)
                        local v62 = u47;

                        if not v62 or v62() then
                            local v63 = descendant;
                            local v64 = u61;
                            local v65;

                            if v63.Parent == nil then
                                v65 = false;
                            else
                                v65 = (v63:GetAttribute("_PartIcleNativeEmitGen") or 0) == v64;
                            end;

                            if v65 then
                                local v66 = descendant;
                                local u67 = (v66:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                EngineAttr.write(v66, "_PartIcleNativeDurationGen", u67);
                                EngineAttr.writeProp(descendant, "Enabled", true);
                                task.delay(u59, function() -- Line: 165
                                    -- upvalues: descendant (ref), u67 (copy), EngineAttr (ref)
                                    local v68 = descendant;
                                    local v69 = u67;
                                    local v70;

                                    if v68.Parent == nil then
                                        v70 = false;
                                    else
                                        v70 = (v68:GetAttribute("_PartIcleNativeDurationGen") or 0) == v69;
                                    end;

                                    if v70 then
                                        EngineAttr.writeProp(descendant, "Enabled", false);
                                    end;
                                end);
                            end;
                        end;
                    end;

                    if v60 > 0 then
                        task.delay(v60, doEmit);
                    else
                        doEmit();
                    end;
                end;
            end;
        end;
    end;
end;

function u1.EnableEmitSingle(u71: userdata, u72: any) -- Line: 175
    -- upvalues: parseDuration (copy), EngineAttr (copy), u1 (copy)
    if u71:GetAttribute("Transformed") then
        return;
    end;

    if u71:IsA("Trail") then
        local u73 = parseDuration(u71:GetAttribute("EmitDuration"));

        if u73 and u73 > 0 then
            local u74 = u71:GetAttribute("_PartIcleNativeEmitGen") or 0;
            local v75 = tonumber(u71:GetAttribute("EmitDelay")) or 0;

            local function doEnable() -- Line: 184
                -- upvalues: u72 (copy), u71 (copy), u74 (copy), EngineAttr (ref), u73 (copy)
                local v76 = u72;

                if not v76 or v76() then
                    local v77 = u71;
                    local v78 = u74;
                    local v79;

                    if v77.Parent == nil then
                        v79 = false;
                    else
                        v79 = (v77:GetAttribute("_PartIcleNativeEmitGen") or 0) == v78;
                    end;

                    if v79 then
                        local v80 = u71;
                        local u81 = (v80:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                        EngineAttr.write(v80, "_PartIcleNativeDurationGen", u81);
                        EngineAttr.writeProp(u71, "Enabled", true);
                        task.delay(u73, function() -- Line: 188
                            -- upvalues: u71 (ref), u81 (copy), EngineAttr (ref)
                            local v82 = u71;
                            local v83 = u81;
                            local v84;

                            if v82.Parent == nil then
                                v84 = false;
                            else
                                v84 = (v82:GetAttribute("_PartIcleNativeDurationGen") or 0) == v83;
                            end;

                            if v84 then
                                EngineAttr.writeProp(u71, "Enabled", false);
                            end;
                        end);
                    end;
                end;
            end;

            if v75 > 0 then
                task.delay(v75, doEnable);
            else
                doEnable();
            end;
        end;
    end;

    if u71:IsA("ParticleEmitter") then
        u1.fireEmitter(u71, u72);
    end;
end;

function u1.EnableEmitChildrenAndRepeatForAttachments(p85, p86) -- Line: 205
    -- upvalues: u1 (copy)
    for _, child in p85:GetChildren() do
        u1.EnableEmitSingle(child, p86);

        if child:IsA("Attachment") and not child:GetAttribute("Transformed") then
            u1.EnableEmitChildrenAndRepeatForAttachments(child, p86);
        end;
    end;
end;

return u1;