  

 

local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local u1 = {};
u1.__index = u1;
local u2 = CFrame.new();

local function cframeToAxis(p3) -- Line: 12
    local v4, v5 = p3:toAxisAngle();

    return v4 * v5;
end;

local function axisToCFrame(p6) -- Line: 17
    -- upvalues: u2 (copy)
    local magnitude = p6.magnitude;

    if magnitude > 0.00001 then
        return CFrame.fromAxisAngle(p6, magnitude);
    end;

    return u2;
end;

local function extractRotation(p7) -- Line: 25
    local _, _, _, v8, v9, v10, v11, v12, v13, v14, v15, v16 = p7:components();

    return CFrame.new(0, 0, 0, v8, v9, v10, v11, v12, v13, v14, v15, v16);
end;

function u1.new() -- Line: 30
    -- upvalues: u1 (copy)
    return setmetatable({
        lastCFrame = nil
    }, u1);
end;

function u1.Step(p17, p18, p19) -- Line: 36
    -- upvalues: u2 (copy)
    local v20 = p17.lastCFrame or p19;
    p17.lastCFrame = p19;
    local p = p19.p;
    local _, _, _, v21, v22, v23, v24, v25, v26, v27, v28, v29 = p19:components();
    local u30 = CFrame.new(0, 0, 0, v21, v22, v23, v24, v25, v26, v27, v28, v29);
    local p2 = v20.p;
    local _, _, _, v31, v32, v33, v34, v35, v36, v37, v38, v39 = v20:components();
    local v40 = CFrame.new(0, 0, 0, v31, v32, v33, v34, v35, v36, v37, v38, v39);
    local u41 = (p - p2) / p18;
    local v42, v43 = (u30 * v40:inverse()):toAxisAngle();
    local u44 = v42 * v43 / p18;

    return {
        extrapolate = function(p45) -- Line: 51, Name: extrapolate
            -- upvalues: u41 (copy), p (copy), u44 (copy), u2 (ref), u30 (copy)
            local v46 = u44 * p45;
            local magnitude = v46.magnitude;
            local v47;

            if magnitude > 0.00001 then
                v47 = CFrame.fromAxisAngle(v46, magnitude);
            else
                v47 = u2;
            end;

            return v47 * u30 + (u41 * p45 + p);
        end,

        posVelocity = u41,
        rotVelocity = u44
    };
end;

function u1.Reset(p48) -- Line: 64
    p48.lastCFrame = nil;
end;

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"));
local u49 = setmetatable({}, BaseOcclusion);
u49.__index = u49;

function u49.new() -- Line: 74
    -- upvalues: BaseOcclusion (copy), u49 (copy), u1 (copy)
    local v50 = BaseOcclusion.new();
    local v51 = setmetatable(v50, u49);
    v51.focusExtrapolator = u1.new();

    return v51;
end;

function u49.GetOcclusionMode(p52) -- Line: 80
    return Enum.DevCameraOcclusionMode.Zoom;
end;

function u49.Enable(p53, p54) -- Line: 84
    p53.focusExtrapolator:Reset();
end;

function u49.Update(p55, p56, p57, p58, p59) -- Line: 88
    -- upvalues: ZoomController (copy)
    local v60 = CFrame.new(p58.p, p57.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    local v61 = p55.focusExtrapolator:Step(p56, v60);
    local v62 = ZoomController.Update(p56, v60, v61);

    return v60 * CFrame.new(0, 0, v62), p58;
end;

function u49.CharacterAdded(p63, p64, p65) -- Line: 101
end;

function u49.CharacterRemoving(p66, p67, p68) -- Line: 105
end;

function u49.OnCameraSubjectChanged(p69, p70) -- Line: 108
end;

return u49;