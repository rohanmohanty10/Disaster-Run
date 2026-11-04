 
 

local u1 = require("./effects/beam");
local u2 = require("./effects/spin");
local u3 = require("./effects/mesh");
local u4 = require("./effects/bezier");
local u5 = require("./effects/screen");
local u6 = require("./effects/particle");
local u7 = require("./effects/lightning");
local u8 = require("./effects/camera_shake");
local u9 = require("./effects/tween_property");
local u10 = require("./effects/shockwave_ring");
local u11 = require("./effects/shockwave_line");
local u12 = require("./effects/shockwave_debris");
local u13 = require("./mod/attributes");
require("./types");
local u14 = require("./mod/utility");
local u15 = require("./pkg/Promise");
local u71 = {
    particle = function(p16: userdata, p17: any, u18: table, p19: table, p20: number) -- Line: 22, Name: particle
        -- upvalues: u13 (copy), u14 (copy), u6 (copy)
        local v21 = u13.get(p16, "EmitCount", 0);
        local v22 = u13.get(p16, "EmitDuration", 0);

        if v21 <= 0 and v22 <= 0 then
            return;
        end;

        if p16:IsDescendantOf(workspace) then
            u14.try("failed to emit particle with error: %s", u6.emit, p16, p16, p17, p20);

            return;
        end;

        local v23, u24 = u14.cloneParticleAncestry(p16, p19);

        if not v23 then
            return;
        end;

        local v25 = p16:Clone();
        v25.Archivable = false;
        v25.Parent = v23;

        if u18[u24] then
            u18[u24] = u18[u24] + 1;
        else
            u24.Parent = workspace.Terrain;
            u18[u24] = 1;
        end;

        table.insert(p17, function() -- Line: 54
            -- upvalues: u18 (copy), u24 (copy)
            local v26 = u18;
            local v27 = u24;
            v26[v27] = v26[v27] - 1;

            if u18[u24] <= 0 then
                u24:Destroy();
            end;
        end);
        u14.try("failed to emit particle with error: %s", u6.emit, p16, v25, p17, p20);
    end,

    beam = function(p28: userdata, p29: any, p30: number) -- Line: 68, Name: beam
        -- upvalues: u13 (copy), u14 (copy), u1 (copy)
        local Attachment0 = p28.Attachment0;
        local Attachment1 = p28.Attachment1;

        if not (Attachment0 and Attachment1) then
            return;
        end;

        local v31 = p28:Clone();
        v31.Archivable = false;
        v31.Parent = workspace.Terrain;
        local NumberRange_new_ret = NumberRange.new(1, 1);

        if u13.get(p28, "Length_Scale_Start", NumberRange_new_ret, true) ~= NumberRange_new_ret or u13.get(p28, "Length_Scale_End", NumberRange_new_ret, true) ~= NumberRange_new_ret then
            local v32 = Attachment0:Clone();
            local v33 = Attachment1:Clone();
            table.insert(p29, v32);
            table.insert(p29, v33);
            v32.Name = "_ForgeTempAttachment";
            v33.Name = "_ForgeTempAttachment";
            v32:AddTag(u14.EMIT_EXCLUDE_TAG);
            v33:AddTag(u14.EMIT_EXCLUDE_TAG);
            v31.Attachment0 = v32;
            v31.Attachment1 = v33;
            v32.Parent = Attachment0.Parent;
            v33.Parent = Attachment1.Parent;
        end;

        table.insert(p29, v31);
        u14.try("failed to emit beam with error: %s", u1.emit, p28, v31, p29, p30);
    end,

    trail = function(p34: userdata) -- Line: 109, Name: trail
        p34.Enabled = true;
    end,

    bezier = function(p35: userdata, p36: any, p37: boolean?) -- Line: 113, Name: bezier
        -- upvalues: u14 (copy), u4 (copy)
        local v38 = p35:FindFirstChildOfClass("Part");

        if not v38 then
            return;
        end;

        if not p37 and p35:GetAttribute("Enabled") then
            p35:SetAttribute("Enabled", false);
        end;

        local v39 = v38:Clone();
        v39.Locked = true;
        table.insert(p36, v39);
        u14.try("failed to emit bezier with error: %s", u4.emit, p35, v39, p36, p37);
    end,

    lightning = function(p40: userdata, p41: any, p42: boolean?) -- Line: 132, Name: lightning
        -- upvalues: u14 (copy), u7 (copy)
        local v43 = p40:FindFirstChildOfClass("Part");

        if not v43 then
            return;
        end;

        if not p42 and p40:GetAttribute("Enabled") then
            p40:SetAttribute("Enabled", false);
        end;

        local v44 = v43:Clone();
        v44.Locked = true;
        table.insert(p41, v44);
        u14.try("failed to emit lightning with error: %s", u7.emit, p40, v44, p41, p42);
    end,

    mesh = function(u45: userdata, u46: any, u47: any, u48: number, u49: boolean?) -- Line: 151, Name: mesh
        -- upvalues: u13 (copy), u15 (copy), u14 (copy), u3 (copy)
        local Start = u45:FindFirstChild("Start");

        if not Start then
            return;
        end;

        if not u49 and u45:GetAttribute("Enabled") then
            u45:SetAttribute("Enabled", false);
        end;

        local v50 = {};

        for i = 1, u13.get(u45, "EmitCount", 1) do
            table.insert(v50, u15.new(function(p51) -- Line: 173
                -- upvalues: u14 (ref), u3 (ref), u45 (copy), Start (copy), u46 (copy), u47 (copy), u48 (copy), u49 (copy)
                u14.try("failed to emit mesh with error: %s", u3.emit, u45, u14.assembleMeshVFX(Start, u46, u47), u46, u48, u49);
                p51();
            end));
            local _ = i;
        end;

        u15.all(v50):await();
    end,

    spin = function(p52: userdata, p53: any) -- Line: 192, Name: spin
        -- upvalues: u14 (copy), u2 (copy)
        if u14.lock(p52) then
            return;
        end;

        u14.try("failed to emit spinning model with error: %s", u2.emit, p52, p53);
        u14.unlock(p52);
    end,

    camera_shake = function(p54: userdata, p55: any) -- Line: 201, Name: camera_shake
        -- upvalues: u14 (copy), u8 (copy)
        u14.try("failed to emit camera shake with error: %s", u8.emit, p54, p55);
    end,

    tween_property = function(p56: userdata, p57: any) -- Line: 205, Name: tween_property
        -- upvalues: u14 (copy), u9 (copy)
        if not p56.Parent or u14.lock(p56) then
            return;
        end;

        u14.try("failed to emit tween property with error: %s", u9.emit, p56.Parent, p56, p57);
        u14.unlock(p56);
    end,

    screen = function(p58: userdata, p59: any) -- Line: 215, Name: screen
        -- upvalues: u14 (copy), u5 (copy)
        local v60, v61 = u14.try("failed to emit screen effect with error: %s", u5.emit, p58, p59);

        if v60 then
            return v61;
        end;

        return false;
    end,

    shockwave_ring = function(p62: userdata, p63: userdata, p64: any) -- Line: 221, Name: shockwave_ring
        -- upvalues: u14 (copy), u10 (copy)
        u14.try("failed to emit shockwave ring with error: %s", u10.emit, p62, p63, p64);
    end,

    shockwave_debris = function(p65: userdata, p66: userdata, p67: any) -- Line: 225, Name: shockwave_debris
        -- upvalues: u14 (copy), u12 (copy)
        u14.try("failed to emit shockwave debris with error: %s", u12.emit, p65, p66, p67);
    end,

    shockwave_line = function(p68: userdata, p69: userdata, p70: any) -- Line: 229, Name: shockwave_line
        -- upvalues: u14 (copy), u11 (copy)
        u14.try("failed to emit shockwave line with error: %s", u11.emit, p68, p69, p70);
    end
};

function u71.dispatch(p72: any, p73: any, p74: table, p75: table, p76: any, p77: number) -- Line: 234
    -- upvalues: u71 (copy), u14 (copy)
    local ClassName = p72.ClassName;

    if ClassName == "ParticleEmitter" then
        u71.particle(p72, p73, p74, p75, p77);

        return;
    end;

    if ClassName == "Beam" then
        u71.beam(p72, p73, p77);

        return;
    end;

    if ClassName == "Trail" then
        u71.trail(p72);

        return;
    end;

    if ClassName == "RayValue" then
        if p72:HasTag(u14.SCREENSHAKE_TAG) then
            u71.camera_shake(p72, p73);

            return;
        end;

        u71.tween_property(p72, p73);

        return;
    end;

    if p72:HasTag(u14.BEZIER_TAG) then
        u71.bezier(p72, p73);

        return;
    end;

    if p72:HasTag(u14.LIGHTNING_TAG) then
        u71.lightning(p72, p73);

        return;
    end;

    if ClassName == "Model" then
        if u14.isMeshVFX(p72) then
            u71.mesh(p72, p73, p76, p77);

            return;
        end;

        u71.spin(p72, p73);

        return;
    end;

    local v78 = ClassName == "Part" and u14.findFirstClassWithTag(p72, "Attachment", u14.SHOCKWAVE_TAG);

    if v78 then
        local v79 = p72.Parent and (p72.Parent.Name or "") or "";

        if v79 == "Rings" then
            u71.shockwave_ring(v78, p72, p73);

            return;
        end;

        if v79 == "Debris" then
            u71.shockwave_debris(v78, p72, p73);

            return;
        end;

        if v79 == "Lines" then
            u71.shockwave_line(v78, p72, p73);
        end;
    end;
end;

u71.enabled_registry = {
    mesh = {
        check = function(p80: userdata) -- Line: 308, Name: check
            -- upvalues: u14 (copy)
            return u14.isMeshVFX(p80);
        end,

        emit = function(p81: userdata, p82: any, p83: any) -- Line: 311, Name: emit
            -- upvalues: u71 (copy)
            u71.mesh(p81, p82, p83, 1, true);
        end
    },
    bezier = {
        check = function(p84: userdata) -- Line: 317, Name: check
            -- upvalues: u14 (copy)
            return p84:HasTag(u14.BEZIER_TAG);
        end,

        emit = function(p85: userdata, p86: any, p87: any) -- Line: 320, Name: emit
            -- upvalues: u71 (copy)
            u71.bezier(p85, p86, true);
        end
    },
    lightning = {
        check = function(p88: userdata) -- Line: 326, Name: check
            -- upvalues: u14 (copy)
            return p88:HasTag(u14.LIGHTNING_TAG);
        end,

        emit = function(p89: userdata, p90: any, p91: any) -- Line: 329, Name: emit
            -- upvalues: u71 (copy)
            u71.lightning(p89, p90, true);
        end
    }
};

return u71;