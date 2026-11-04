 

 

local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local u1 = {};

local function linkFrame(p2, p3) -- Line: 20
    -- upvalues: PartConstants (copy)
    local v4 = PartConstants.resolveLinkCFrame(p2);

    if p3 then
        return v4 * p3;
    end;

    return v4;
end;

local u5 = { "LinkPosX", "LinkPosY", "LinkPosZ", "LinkRotX", "LinkRotY", "LinkRotZ" };

function u1.readAxes(p6) -- Line: 29
    -- upvalues: u5 (copy)
    local v7 = nil;

    for _, v in ipairs(u5) do
        local v8 = p6:GetAttribute(v) ~= false;
        v7 = not v8 and (v7 or {}) or v7;

        if v7 then
            v7[v] = v8;
        end;
    end;

    if v7 then
        for _, v in ipairs(u5) do
            if v7[v] == nil then
                v7[v] = true;
            end;
        end;
    end;

    return v7;
end;

local function maskFrame(p9, p10, p11) -- Line: 45
    local Position = p9.Position;
    local Position2 = p10.Position;
    local Vector3_new_ret = Vector3.new(p11.LinkPosX and Position.X or Position2.X, p11.LinkPosY and Position.Y or Position2.Y, p11.LinkPosZ and Position.Z or Position2.Z);
    local Rotation = p9.Rotation;

    if not (p11.LinkRotX and (p11.LinkRotY and p11.LinkRotZ)) then
        local v12, v13, v14 = p9:ToEulerAnglesYXZ();
        local v15, v16, v17 = p10:ToEulerAnglesYXZ();

        if p11.LinkRotX then
            v15 = v12 or v15;
        end;

        if p11.LinkRotY then
            v16 = v13 or v16;
        end;

        if p11.LinkRotZ then
            v17 = v14 or v17;
        end;

        Rotation = CFrame.fromEulerAnglesYXZ(v15, v16, v17);
    end;

    return CFrame.new(Vector3_new_ret) * Rotation;
end;

local function maskReference(p18, p19) -- Line: 62
    -- upvalues: PartConstants (copy)
    local _sourceItem = p18._sourceItem;

    if p18._nestedDriven or not (_sourceItem and _sourceItem.Parent) then
        return p19;
    end;

    return PartConstants.resolveLinkCFrame(_sourceItem);
end;

function u1.captureEmitFrame(p20) -- Line: 69
    -- upvalues: PartConstants (copy)
    if p20.LinkAxes and p20.Link then
        local _linkLocal = p20._linkLocal;
        local v21 = PartConstants.resolveLinkCFrame(p20.Link);

        if _linkLocal then
            v21 = v21 * _linkLocal;
        end;

        local _sourceItem = p20._sourceItem;

        if not p20._nestedDriven and (_sourceItem and _sourceItem.Parent) then
            v21 = PartConstants.resolveLinkCFrame(_sourceItem);
        end;

        p20._linkMaskRefCF = v21;
    end;
end;

function u1.spawnAxes(p22, p23) -- Line: 76
    if p23 and p23._parentAlive ~= nil then
        return nil;
    end;

    return p22.LinkAxes;
end;

local function maskedLinkFrame(p24, p25, p26, p27) -- Line: 82
    -- upvalues: PartConstants (copy), maskFrame (copy)
    local v28 = PartConstants.resolveLinkCFrame(p24);

    if p25 then
        v28 = v28 * p25;
    end;

    if p26 and p27 then
        return maskFrame(v28, p27, p26);
    end;

    return v28;
end;

function u1.positionOnly(p29) -- Line: 89
    return p29 == "Follow" and true or p29 == "Pivot";
end;

function u1.usesLinkSpace(p30, p31) -- Line: 94
    local v32;

    if p30 == "Weld" or (p30 == "WeldWithoutRotation" or p30 == "RigidLocal") then
        v32 = p31 ~= nil;
    else
        v32 = false;
    end;

    return v32;
end;

function u1.applyPositionRule(p33, p34) -- Line: 99
    -- upvalues: u1 (copy)
    if u1.positionOnly(p33) then
        return CFrame.new(p34.Position);
    end;

    return p34;
end;

function u1.spawnFrame(p35, p36, p37, p38, p39, p40, p41) -- Line: 108
    -- upvalues: PartConstants (copy), maskFrame (copy)
    local v42 = PartConstants.resolveLinkCFrame(p36);

    if p39 then
        v42 = v42 * p39;
    end;

    local v43;

    if p35 == "Follow" then
        v43 = CFrame.new(v42.Position) * p38.Rotation;
    elseif p36 == p37 then
        v43 = p38;
    else
        local v44 = p40 and p40.Rotation:Inverse() * p38.Rotation or p38.Rotation;
        v43 = CFrame.new(v42.Position) * v42.Rotation * v44;
    end;

    if p41 then
        return maskFrame(v43, p38, p41);
    end;

    return v43;
end;

function u1.originFrame(p45, p46, p47, p48) -- Line: 129
    -- upvalues: u1 (copy)
    local LinkMode = p45.LinkMode;
    local v49 = LinkMode == "WeldWithoutRotation" and "Follow" or LinkMode;

    if v49 == "RigidLocal" and p45._originLinkCF then
        return p45._originLinkCF;
    end;

    if not p46 or p46.Parent == nil then
        return p45._originLinkCF;
    end;

    local v50;

    if v49 == "Pivot" and p45._originPivotRot then
        local v51 = u1.spawnFrame("Follow", p46, p47, p48, nil, nil, p45.LinkAxes);
        v50 = CFrame.new(v51.Position) * p45._originPivotRot;
    else
        v50 = u1.spawnFrame(v49, p46, p47, p48, nil, nil, p45.LinkAxes);

        if v49 == "Pivot" then
            p45._originPivotRot = v50.Rotation;
        end;
    end;

    p45._originLinkCF = v50;

    return v50;
end;

function u1.emitParentFrame(p52, p53, p54, p55, p56) -- Line: 147
    -- upvalues: u1 (copy), PartConstants (copy), maskFrame (copy)
    if not p53 then
        return CFrame.new();
    end;

    local applyPositionRule = u1.applyPositionRule;
    local v57 = PartConstants.resolveLinkCFrame(p53);

    if p54 then
        v57 = v57 * p54;
    end;

    if p55 and p56 then
        v57 = maskFrame(v57, p56, p55);
    end;

    return applyPositionRule(p52, v57);
end;

function u1.toParentSpace(p58, p59) -- Line: 154
    local CFrame_new_ret = CFrame.new();

    if p59 then
        if p59:IsA("BasePart") then
            CFrame_new_ret = p59.CFrame;
        elseif p59:IsA("Attachment") then
            CFrame_new_ret = p59.WorldCFrame;
        end;
    end;

    return CFrame_new_ret:ToObjectSpace(p58);
end;

function u1.emitAttachmentParentFrame(p60, p61, p62, p63, p64, p65) -- Line: 167
    -- upvalues: u1 (copy), PartConstants (copy), maskFrame (copy)
    if not p61 then
        return CFrame.new();
    end;

    local applyPositionRule = u1.applyPositionRule;
    local toParentSpace = u1.toParentSpace;
    local v66 = PartConstants.resolveLinkCFrame(p61);

    if p63 then
        v66 = v66 * p63;
    end;

    if p64 and p65 then
        v66 = maskFrame(v66, p65, p64);
    end;

    return applyPositionRule(p60, toParentSpace(v66, p62));
end;

function u1.rigidSnapshot(p67, p68, p69) -- Line: 173
    if p67 == "RigidLocal" and p68 then
        return p69;
    end;

    return nil;
end;

function u1.rigidWorldSnapshot(p70, p71, p72, p73, p74) -- Line: 179
    -- upvalues: PartConstants (copy), maskFrame (copy)
    if p70 ~= "RigidLocal" or not p71 then
        return nil;
    end;

    local v75 = PartConstants.resolveLinkCFrame(p71);

    if p72 then
        v75 = v75 * p72;
    end;

    if p73 and p74 then
        return maskFrame(v75, p74, p73);
    end;

    return v75;
end;

function u1.isValid(p76, p77) -- Line: 186
    -- upvalues: Pool (copy)
    if p77 and p77.Parent ~= nil then
        return Pool.linkGen(p77) == (p76._linkGen or 0);
    end;

    return false;
end;

function u1.freeze(p78) -- Line: 193
    p78._frozenLinkCF = p78._lastLinkCF or CFrame.new();
    p78.Link = nil;
end;

function u1.worldFrame(p79, p80) -- Line: 200
    -- upvalues: PartConstants (copy), maskFrame (copy)
    if p79.LinkMode == "RigidLocal" then
        return p79._rigidLocalParentCF or CFrame.new();
    end;

    local _linkLocal = p79._linkLocal;
    local v81 = PartConstants.resolveLinkCFrame(p80);

    if _linkLocal then
        v81 = v81 * _linkLocal;
    end;

    local LinkAxes = p79.LinkAxes;

    if LinkAxes then
        if not p79._linkMaskRefCF then
            local _sourceItem = p79._sourceItem;
            local v82;

            if p79._nestedDriven or not (_sourceItem and _sourceItem.Parent) then
                v82 = v81;
            else
                v82 = PartConstants.resolveLinkCFrame(_sourceItem);
            end;

            p79._linkMaskRefCF = v82;
        end;

        v81 = maskFrame(v81, p79._linkMaskRefCF, LinkAxes);
    end;

    p79._lastLinkCF = v81;

    return v81;
end;

local function currentFrame(p83) -- Line: 215
    -- upvalues: u1 (copy)
    if p83.LinkMode == "RigidLocal" then
        return p83._rigidLocalParentCF;
    end;

    local Link = p83.Link;

    if Link then
        if u1.isValid(p83, Link) then
            return u1.worldFrame(p83, Link);
        end;

        u1.freeze(p83);
    end;

    return p83._frozenLinkCF;
end;

function u1.parentFrame(p84) -- Line: 226
    -- upvalues: u1 (copy)
    local v85;

    if p84.LinkMode == "RigidLocal" then
        v85 = p84._rigidLocalParentCF;
    else
        local Link = p84.Link;

        if not Link then
            v85 = p84._frozenLinkCF;

            if not v85 then
                return CFrame.new(), false;
            end;

            if u1.positionOnly(p84.LinkMode) then
                return CFrame.new(v85.Position), false;
            end;

            return v85, true;
        end;

        if not u1.isValid(p84, Link) then
            u1.freeze(p84);
            v85 = p84._frozenLinkCF;

            if not v85 then
                return CFrame.new(), false;
            end;

            if u1.positionOnly(p84.LinkMode) then
                return CFrame.new(v85.Position), false;
            end;

            return v85, true;
        end;

        v85 = u1.worldFrame(p84, Link);
    end;

    if not v85 then
        return CFrame.new(), false;
    end;

    if u1.positionOnly(p84.LinkMode) then
        return CFrame.new(v85.Position), false;
    end;

    return v85, true;
end;

function u1.attachmentParentFrame(p86) -- Line: 234
    -- upvalues: u1 (copy)
    local v87, v88, v89;

    if p86.LinkMode == "RigidLocal" then
        v87 = p86._rigidLocalParentCF;
    else
        local Link = p86.Link;

        if not Link then
            v87 = p86._frozenLinkCF;

            if not v87 then
                return CFrame.new(), false, false;
            end;

            v88 = p86.VisualPart and p86.VisualPart.Parent;

            if not v88 then
                return CFrame.new(), false, false;
            end;

            v89 = u1.toParentSpace(v87, v88);

            if u1.positionOnly(p86.LinkMode) then
                return CFrame.new(v89.Position), false, true;
            end;

            return v89, true, true;
        end;

        if not u1.isValid(p86, Link) then
            u1.freeze(p86);
            v87 = p86._frozenLinkCF;

            if not v87 then
                return CFrame.new(), false, false;
            end;

            v88 = p86.VisualPart and p86.VisualPart.Parent;

            if not v88 then
                return CFrame.new(), false, false;
            end;

            v89 = u1.toParentSpace(v87, v88);

            if u1.positionOnly(p86.LinkMode) then
                return CFrame.new(v89.Position), false, true;
            end;

            return v89, true, true;
        end;

        v87 = u1.worldFrame(p86, Link);
    end;

    if not v87 then
        return CFrame.new(), false, false;
    end;

    v88 = p86.VisualPart and p86.VisualPart.Parent;

    if not v88 then
        return CFrame.new(), false, false;
    end;

    v89 = u1.toParentSpace(v87, v88);

    if u1.positionOnly(p86.LinkMode) then
        return CFrame.new(v89.Position), false, true;
    end;

    return v89, true, true;
end;

function u1.reapplyFrame(p90, p91, p92) -- Line: 247
    -- upvalues: u1 (copy)
    if p90 ~= "WeldWithoutRotation" then
        if u1.positionOnly(p90) then
            return CFrame.new(p91.Position) * p92;
        end;

        return p91 * p92;
    end;

    local v93 = p91:VectorToWorldSpace(p92.Position);
    local v94 = p92 - p92.Position;

    return CFrame.new(p91.Position + v93) * v94;
end;

return u1;