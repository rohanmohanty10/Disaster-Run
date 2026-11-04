 
 

local Pool = require(script.Parent.Pool);
local PartConstants = require(script.Parent.PartConstants);
local v1 = {};

local function nearestFrameAncestor(p2, p3) -- Line: 16
    local Parent = p2.Parent;

    while Parent and Parent ~= p3 do
        if Parent:IsA("BasePart") or (Parent:IsA("Attachment") or Parent:IsA("Model")) then
            return Parent;
        end;

        Parent = Parent.Parent;
    end;

    return p3;
end;

function v1.walk(u4, u5, u6, u7, u8, u9, u10) -- Line: 37
    -- upvalues: Pool (copy), PartConstants (copy), nearestFrameAncestor (copy)
    if u7 and u7[1] == false then
        return;
    end;

    local u11 = Pool._cloneMaps and Pool._cloneMaps[u6];
    local v12;

    if u8 then
        v12 = u8._parentCloneMap;
    else
        v12 = u8;
    end;

    if u11 and (v12 and v12 ~= u11) then
        local v13 = getmetatable(u11);

        if v13 then
            v13.__index = v12;
        else
            setmetatable(u11, {
                __index = v12
            });
        end;
    end;

    local u14 = {};

    local function visit(p15) -- Line: 48
        -- upvalues: u14 (copy), visit (copy)
        if p15:GetAttribute("Transformed") then
            u14[#u14 + 1] = p15;

            return;
        end;

        for _, child in p15:GetChildren() do
            visit(child);
        end;
    end;

    visit(u5);

    if #u14 == 0 then
        return;
    end;

    local u16 = PartConstants.resolveLinkCFrame(u5);

    local function fire(p17) -- Line: 58
        -- upvalues: u9 (copy), nearestFrameAncestor (ref), u5 (copy), u16 (copy), PartConstants (ref), u8 (copy), u7 (copy), u11 (copy), u10 (copy), u4 (copy), u6 (copy)
        local v18 = {
            ParentScale = u9
        };
        local v19 = nearestFrameAncestor(p17, u5);
        local v20 = v19 == u5 and u16 or PartConstants.resolveLinkCFrame(v19);
        v18._sourceParentCF = v20;

        if v19 ~= u5 then
            v18._linkLocal = u16:ToObjectSpace(v20);
        end;

        if u8 then
            v18.ChainCtx = u8.ChainCtx;
            v18.EmitIndex = u8.EmitIndex;
            v18.EmitCount = u8.EmitCount;
            v18._playToken = u8._playToken;
            v18._containerDrive = u8._containerDrive;
            v18._matte = u8._matte;
        end;

        v18._parentAlive = u7;
        v18._parentCloneMap = u11;

        if u10 then
            u10(p17, v18);
        end;

        u4:EnableEmit(p17, u6, v18);
    end;

    for _, v in ipairs(u14) do
        if v:IsA("Attachment") then
            fire(v);
        end;
    end;

    for _, v in ipairs(u14) do
        if not v:IsA("Attachment") then
            fire(v);
        end;
    end;
end;

function v1.keepPlace(p21, p22, p23) -- Line: 98
    -- upvalues: PartConstants (copy)
    if not (p21:IsA("BasePart") or (p21:IsA("Attachment") or p21:IsA("Model"))) then
        return;
    end;

    local v24 = PartConstants.resolveLinkCFrame(p21);
    p22._linkLocal = PartConstants.resolveLinkCFrame(p23):ToObjectSpace(v24);
    p22._rigPlace = p22._linkLocal;
    p22._sourceParentCF = v24;
end;

function v1.resolveCloneParent(p25, p26, p27) -- Line: 114
    if not p27 then
        return nil;
    end;

    local _parentCloneMap = p27._parentCloneMap;

    if _parentCloneMap then
        local Parent = p25.Parent;

        while Parent and Parent ~= workspace do
            local v28 = _parentCloneMap[Parent];

            if v28 then
                if v28:IsA("BasePart") then
                    return v28;
                end;

                break;
            end;

            Parent = Parent.Parent;
        end;
    end;

    if p27._parentAlive and (p26 and p26:IsA("BasePart")) then
        return p26;
    end;

    return nil;
end;

return v1;