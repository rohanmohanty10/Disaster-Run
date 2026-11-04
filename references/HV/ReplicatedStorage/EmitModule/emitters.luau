 

 

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
require("./types");
local u13 = require("./mod/utility");
local u14 = require("./pkg/Promise");
local u66 = {
    particle = function(p15: userdata, p16: any, p17: table, p18: table, p19: number) -- Line: 21, Name: particle
        -- upvalues: u13 (copy), u6 (copy)
        local Attribute = u13.getAttribute(p15, "EmitCount", 0);
        local Attribute2 = u13.getAttribute(p15, "EmitDuration", 0);

        if Attribute <= 0 and Attribute2 <= 0 then
            return;
        end;

        if p15:IsDescendantOf(workspace) then
            u13.try("failed to emit particle with error: %s", u6.emit, p15, p15, p16, p19);

            return;
        end;

        local v20, v21 = u13.cloneParticleAncestry(p15, p18);

        if not v20 then
            return;
        end;

        table.insert(p16, v21);
        local v22 = p15:Clone();
        v22.Archivable = false;
        v22.Parent = v20;

        if not p17[v21] then
            v21.Parent = workspace.Terrain;
        end;

        if p17[v21] then
            p17[v21] = p17[v21] + 1;
        else
            p17[v21] = 1;
        end;

        u13.try("failed to emit particle with error: %s", u6.emit, p15, v22, p16, p19);
        p17[v21] = p17[v21] - 1;
    end,

    beam = function(p23: userdata, p24: any, p25: number) -- Line: 66, Name: beam
        -- upvalues: u13 (copy), u1 (copy)
        local Attachment0 = p23.Attachment0;
        local Attachment1 = p23.Attachment1;

        if not (Attachment0 and Attachment1) then
            return;
        end;

        local v26 = p23:Clone();
        v26.Archivable = false;
        v26.Parent = workspace.Terrain;
        local NumberRange_new_ret = NumberRange.new(1, 1);

        if u13.getAttribute(p23, "Length_Scale_Start", NumberRange_new_ret, true) ~= NumberRange_new_ret or u13.getAttribute(p23, "Length_Scale_End", NumberRange_new_ret, true) ~= NumberRange_new_ret then
            local v27 = Attachment0:Clone();
            local v28 = Attachment1:Clone();
            table.insert(p24, v27);
            table.insert(p24, v28);
            v27.Name = "ForgeTempAttachment";
            v28.Name = "ForgeTempAttachment";
            v26.Attachment0 = v27;
            v26.Attachment1 = v28;
            v27.Parent = Attachment0.Parent;
            v28.Parent = Attachment1.Parent;
        end;

        table.insert(p24, v26);
        u13.try("failed to emit beam with error: %s", u1.emit, p23, v26, p24, p25);
    end,

    trail = function(p29: userdata) -- Line: 104, Name: trail
        p29.Enabled = true;
    end,

    bezier = function(p30: userdata, p31: any, p32: boolean?) -- Line: 108, Name: bezier
        -- upvalues: u13 (copy), u4 (copy)
        local v33 = p30:FindFirstChildOfClass("Part");

        if not v33 then
            return;
        end;

        if not p32 and p30:GetAttribute("Enabled") then
            p30:SetAttribute("Enabled", false);
        end;

        local v34 = v33:Clone();
        v34.Locked = true;
        table.insert(p31, v34);
        u13.try("failed to emit bezier with error: %s", u4.emit, p30, v34, p31, p32);
    end,

    lightning = function(p35: userdata, p36: any, p37: boolean?) -- Line: 127, Name: lightning
        -- upvalues: u13 (copy), u7 (copy)
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
        u13.try("failed to emit lightning with error: %s", u7.emit, p35, v39, p36, p37);
    end,

    mesh = function(u40: userdata, u41: any, u42: any, u43: number, u44: boolean?) -- Line: 146, Name: mesh
        -- upvalues: u13 (copy), u14 (copy), u3 (copy)
        local Start = u40:FindFirstChild("Start");

        if not Start then
            return;
        end;

        if not u44 and u40:GetAttribute("Enabled") then
            u40:SetAttribute("Enabled", false);
        end;

        local v45 = {};

        for i = 1, u13.getAttribute(u40, "EmitCount", 1) do
            table.insert(v45, u14.new(function(p46) -- Line: 168
                -- upvalues: u13 (ref), u3 (ref), u40 (copy), Start (copy), u41 (copy), u42 (copy), u43 (copy), u44 (copy)
                u13.try("failed to emit mesh with error: %s", u3.emit, u40, u13.assembleMeshVFX(Start, u41, u42), u41, u43, u44);
                p46();
            end));
            local _ = i;
        end;

        u14.all(v45):await();
    end,

    spin = function(p47: userdata, p48: any) -- Line: 187, Name: spin
        -- upvalues: u13 (copy), u2 (copy)
        if u13.lock(p47) then
            return;
        end;

        u13.try("failed to emit spinning model with error: %s", u2.emit, p47, p48);
        u13.unlock(p47);
    end,

    camera_shake = function(p49: userdata, p50: any) -- Line: 196, Name: camera_shake
        -- upvalues: u13 (copy), u8 (copy)
        u13.try("failed to emit camera shake with error: %s", u8.emit, p49, p50);
    end,

    tween_property = function(p51: userdata, p52: any) -- Line: 200, Name: tween_property
        -- upvalues: u13 (copy), u9 (copy)
        if not p51.Parent or u13.lock(p51) then
            return;
        end;

        u13.try("failed to emit tween property with error: %s", u9.emit, p51.Parent, p51, p52);
        u13.unlock(p51);
    end,

    screen = function(p53: userdata, p54: any) -- Line: 210, Name: screen
        -- upvalues: u13 (copy), u5 (copy)
        local v55, v56 = u13.try("failed to emit screen effect with error: %s", u5.emit, p53, p54);

        if v55 then
            return v56;
        end;

        return false;
    end,

    shockwave_ring = function(p57: userdata, p58: userdata, p59: any) -- Line: 216, Name: shockwave_ring
        -- upvalues: u13 (copy), u10 (copy)
        u13.try("failed to emit shockwave ring with error: %s", u10.emit, p57, p58, p59);
    end,

    shockwave_debris = function(p60: userdata, p61: userdata, p62: any) -- Line: 220, Name: shockwave_debris
        -- upvalues: u13 (copy), u12 (copy)
        u13.try("failed to emit shockwave debris with error: %s", u12.emit, p60, p61, p62);
    end,

    shockwave_line = function(p63: userdata, p64: userdata, p65: any) -- Line: 224, Name: shockwave_line
        -- upvalues: u13 (copy), u11 (copy)
        u13.try("failed to emit shockwave line with error: %s", u11.emit, p63, p64, p65);
    end
};

function u66.dispatch(p67: any, p68: any, p69: table, p70: table, p71: any, p72: number) -- Line: 229
    -- upvalues: u66 (copy), u13 (copy)
    local ClassName = p67.ClassName;

    if ClassName == "ParticleEmitter" then
        u66.particle(p67, p68, p69, p70, p72);

        return;
    end;

    if ClassName == "Beam" then
        u66.beam(p67, p68, p72);

        return;
    end;

    if ClassName == "Trail" then
        u66.trail(p67);

        return;
    end;

    if ClassName == "RayValue" then
        if p67:HasTag(u13.SCREENSHAKE_TAG) then
            u66.camera_shake(p67, p68);

            return;
        end;

        u66.tween_property(p67, p68);

        return;
    end;

    if p67:HasTag(u13.BEZIER_TAG) then
        u66.bezier(p67, p68);

        return;
    end;

    if p67:HasTag(u13.LIGHTNING_TAG) then
        u66.lightning(p67, p68);

        return;
    end;

    if ClassName == "Model" then
        if u13.isMeshVFX(p67) then
            u66.mesh(p67, p68, p71, p72);

            return;
        end;

        u66.spin(p67, p68);

        return;
    end;

    local v73 = ClassName == "Part" and u13.findFirstClassWithTag(p67, "Attachment", u13.SHOCKWAVE_TAG);

    if v73 then
        local v74 = p67.Parent and (p67.Parent.Name or "") or "";

        if v74 == "Rings" then
            u66.shockwave_ring(v73, p67, p68);

            return;
        end;

        if v74 == "Debris" then
            u66.shockwave_debris(v73, p67, p68);

            return;
        end;

        if v74 == "Lines" then
            u66.shockwave_line(v73, p67, p68);
        end;
    end;
end;

u66.enabled_registry = {
    mesh = {
        check = function(p75: userdata) -- Line: 303, Name: check
            -- upvalues: u13 (copy)
            return u13.isMeshVFX(p75);
        end,

        emit = function(p76: userdata, p77: any, p78: any) -- Line: 306, Name: emit
            -- upvalues: u66 (copy)
            u66.mesh(p76, p77, p78, 1, true);
        end
    },
    bezier = {
        check = function(p79: userdata) -- Line: 312, Name: check
            -- upvalues: u13 (copy)
            return p79:HasTag(u13.BEZIER_TAG);
        end,

        emit = function(p80: userdata, p81: any, p82: any) -- Line: 315, Name: emit
            -- upvalues: u66 (copy)
            u66.bezier(p80, p81, true);
        end
    },
    lightning = {
        check = function(p83: userdata) -- Line: 321, Name: check
            -- upvalues: u13 (copy)
            return p83:HasTag(u13.LIGHTNING_TAG);
        end,

        emit = function(p84: userdata, p85: any, p86: any) -- Line: 324, Name: emit
            -- upvalues: u66 (copy)
            u66.lightning(p84, p85, true);
        end
    }
};

return u66;