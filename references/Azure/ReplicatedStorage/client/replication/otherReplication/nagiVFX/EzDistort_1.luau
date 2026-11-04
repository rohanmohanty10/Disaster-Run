 
 

game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local script_FinalLerp = require(script.FinalLerp);
require(script.Maid);
require(script.SharedTypes);
local script_FastSignal = require(script.FastSignal);
local Immediate = require(script.FastSignal.Immediate);
local script_PresetCreator = require(script.PresetCreator);
local script_Paramarizer = require(script.Paramarizer);
local u1 = {
    DistortionID = 1,
    DistortionPresets = require(script.DistortionPresets),
    DistortionEffects = {}
};
local u2 = {};
u2.__index = u2;
local table_freeze_ret = table.freeze({
    R00 = { -1.2, 1.2 },
    R01 = { -1, 1 },
    R02 = { -0.5, 0.5 },
    R10 = { -1, 1 },
    R11 = { -1.2, 1.2 },
    R12 = { -0.5, 0.5 },
    R20 = { -0.5, 0.5 },
    R21 = { -0.5, 0.5 },
    R22 = { -1.2, 1.2 }
});
local table_freeze_ret2 = table.freeze({ "R00", "R01", "R02", "R10", "R11", "R12", "R20", "R21", "R22" });

function u1.newNamedDistortionMatrix(p3) -- Line: 103
    -- upvalues: script_Paramarizer (copy)
    return script_Paramarizer.newNamedDistortionMatrix(p3);
end;

function u1.newDistortionParams(p4) -- Line: 118
    -- upvalues: script_Paramarizer (copy)
    return script_Paramarizer.newDistortionParams(p4);
end;

function u1.fromDistortionPreset(p5) -- Line: 126
    -- upvalues: u1 (copy), script_PresetCreator (copy)
    local v6 = u1.new(p5.DistortionParams);

    return v6, script_PresetCreator.new(v6, p5);
end;

function u1.new(p7) -- Line: 133
    -- upvalues: u1 (copy), u2 (copy), script_FinalLerp (copy), Immediate (copy), script_FastSignal (copy), RunService (copy)
    local v8 = {
        DistortionParams = u1.newDistortionParams(p7)
    };
    local u9 = setmetatable(v8, u2);
    u9.TargetDistortionComponents = {
        R00 = 1,
        R01 = 0,
        R02 = 0,
        R10 = 0,
        R11 = 1,
        R12 = 0,
        R20 = 0,
        R21 = 0,
        R22 = 1
    };
    u9.LerpObjects = {};

    for i, _ in u9.TargetDistortionComponents do
        u9.LerpObjects[i] = script_FinalLerp.new(u9.TargetDistortionComponents[i], script_FinalLerp.newLerpParams({
            Snap = 0.0001,
            LerpTime = u9.DistortionParams.EaseTime,
            LerpFailTime = u9.DistortionParams.FadeoutTime,

            LerpTarget = function() -- Line: 158, Name: LerpTarget
                -- upvalues: u9 (copy), i (copy)
                return u9:_getDistortionComponent(i);
            end,

            LerpFailTarget = u9.TargetDistortionComponents[i],

            LerpCondition = function() -- Line: 164, Name: LerpCondition
                -- upvalues: u9 (copy)
                return u9.Toggled;
            end
        }));
    end;

    u9.Signals = {
        Destroying = Immediate.new(),
        Updated = script_FastSignal.new()
    };
    u9.Toggled = false;
    u9.Camera = u9.DistortionParams.TargetCamera or workspace.CurrentCamera;
    u9.PreDistortionMatrix = u9.Camera.CFrame;
    u9.DistortionID = u1.DistortionID;
    local v10 = u1;
    v10.DistortionID = v10.DistortionID + 1;
    RunService:BindToRenderStep(`EzDistortPreDistortion{u9.DistortionID}`, 199, function(p11: number) -- Line: 182
        -- upvalues: u9 (copy)
        u9:_doPreDistort(p11);
    end);
    RunService:BindToRenderStep(`EzDistortPostDistortion{u9.DistortionID}`, 201 + u9.DistortionParams.Priority, function(p12: number) -- Line: 186
        -- upvalues: u9 (copy)
        u9:_doDistort(p12);
    end);

    return u9;
end;

function u2._doDistort(p13: table, p14: number) -- Line: 194
    p13.PreDistortionMatrix = p13.Camera.CFrame;
    local Camera = p13.Camera;
    Camera.CFrame = Camera.CFrame * p13:GetCurrentDistortionCFrame();
    p13.Signals.Updated:Fire(p14);
end;

function u2._doPreDistort(p15: table, p16: number) -- Line: 202
    p15.Camera.CFrame = p15.PreDistortionMatrix;
end;

function u2._setDistortionComponent(p17: table, p18: any, p19: number) -- Line: 207
    -- upvalues: table_freeze_ret2 (copy), table_freeze_ret (copy)
    if not p19 then
        return;
    end;

    local v20 = typeof(p19) == "number";
    local v21 = `Expected number for DistortionComponentValue, got '{typeof(p19)}'`;
    assert(v20, v21);
    local v22 = table.find(table_freeze_ret2, p18) and true or false;
    local v23 = `Expected DistortionComponent, got '{p19}'`;
    assert(v22, v23);
    local v24 = table_freeze_ret[p18][1];
    local v25 = table_freeze_ret[p18][2];

    if not p17.DistortionParams.DisableClamps then
        p19 = math.clamp(p19, v24, v25);
    end;

    p17.TargetDistortionComponents[p18] = p19;
end;

function u2._getDistortionComponent(p26, p27) -- Line: 226
    return p26.TargetDistortionComponents[p27];
end;

function u2._getDistortionLerp(p28, p29) -- Line: 231
    return p28.LerpObjects[p29]:Get();
end;

function u2.Toggle(p30) -- Line: 236
    p30.Toggled = not p30.Toggled;
end;

function u2.Enable(p31) -- Line: 241
    p31.Toggled = true;
end;

function u2.Disable(p32) -- Line: 246
    p32.Toggled = false;
end;

function u2.SetScale(p33: table, p34: number, p35: number) -- Line: 255
    p33:_setDistortionComponent("R00", p34);
    p33:_setDistortionComponent("R11", p35);
end;

function u2.SetShear(p36: table, p37: number, p38: number) -- Line: 265
    p36:_setDistortionComponent("R01", p37);
    p36:_setDistortionComponent("R10", p38);
end;

function u2.SetStretch(p39: table, p40: number, p41: number) -- Line: 275
    p39:_setDistortionComponent("R02", p40);
    p39:_setDistortionComponent("R12", p41);
end;

function u2.SetTranslation(p42: table, p43: number, p44: number) -- Line: 285
    p42:_setDistortionComponent("R20", p43);
    p42:_setDistortionComponent("R21", p44);
end;

function u2.SetZoom(p45: table, p46: number) -- Line: 295
    p45:_setDistortionComponent("R22", p46);
end;

function u2.SetCustomDistortion(p47: table, p48: number, p49: number, p50: number, p51: number, p52: number, p53: number, p54: number, p55: number, p56: number) -- Line: 311
    p47:_setDistortionComponent("R00", p48);
    p47:_setDistortionComponent("R01", p49);
    p47:_setDistortionComponent("R02", p50);
    p47:_setDistortionComponent("R10", p51);
    p47:_setDistortionComponent("R11", p52);
    p47:_setDistortionComponent("R12", p53);
    p47:_setDistortionComponent("R20", p54);
    p47:_setDistortionComponent("R21", p55);
    p47:_setDistortionComponent("R22", p56);
end;

function u2.FromCFrame(p57: table, p58) -- Line: 324
    local _, _, _, v59, v60, v61, v62, v63, v64, v65, v66, v67 = p58:GetComponents();
    p57:SetCustomDistortion(v59, v60, v61, v62, v63, v64, v65, v66, v67);
end;

function u2.FromNamedDistortionMatrix(p68, p69) -- Line: 331
    p68:SetCustomDistortion(p69.ScaleX, p69.ShearX, p69.StretchX, p69.ShearY, p69.ScaleY, p69.StretchY, p69.TranslationX, p69.TranslationY, p69.Zoom);
end;

function u2.ResetToIdentity(p70) -- Line: 346
    p70.TargetDistortionComponents = {
        R00 = 1,
        R01 = 0,
        R02 = 0,
        R10 = 0,
        R11 = 1,
        R12 = 0,
        R20 = 0,
        R21 = 0,
        R22 = 1
    };
end;

function u2.GetCurrentDistortionCFrame(p71) -- Line: 367
    return CFrame.new(0, 0, 0, p71:_getDistortionLerp("R00"), p71:_getDistortionLerp("R01"), p71:_getDistortionLerp("R02"), p71:_getDistortionLerp("R10"), p71:_getDistortionLerp("R11"), p71:_getDistortionLerp("R12"), p71:_getDistortionLerp("R20"), p71:_getDistortionLerp("R21"), p71:_getDistortionLerp("R22"));
end;

function u2.GetTargetDistortionCFrame(p72) -- Line: 382
    return CFrame.new(0, 0, 0, p72:_getDistortionComponent("R00"), p72:_getDistortionComponent("R01"), p72:_getDistortionComponent("R02"), p72:_getDistortionComponent("R10"), p72:_getDistortionComponent("R11"), p72:_getDistortionComponent("R12"), p72:_getDistortionComponent("R20"), p72:_getDistortionComponent("R21"), p72:_getDistortionComponent("R22"));
end;

function u2.Destroy(p73) -- Line: 397
    -- upvalues: RunService (copy)
    for _, v in p73.LerpObjects do
        v:Destroy();
    end;

    p73.Signals.Destroying:Fire();

    for _, v in p73.Signals do
        v:Destroy();
    end;

    p73.Camera.CFrame = p73.PreDistortionMatrix;
    RunService:UnbindFromRenderStep((`EzDistortPreDistortion{p73.DistortionID}`));
    RunService:UnbindFromRenderStep((`EzDistortPostDistortion{p73.DistortionID}`));
    setmetatable(p73, nil);
    table.clear(p73);
end;

return u1;