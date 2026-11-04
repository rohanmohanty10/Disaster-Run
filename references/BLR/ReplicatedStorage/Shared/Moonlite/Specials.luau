  

local script_Parent = script.Parent;
local RunService = game:GetService("RunService");
require(script_Parent.Types);
local u1 = {};

local function getValue(p2: userdata, p3: string, p4: any) -- Line: 70
    return p2:GetAttribute((`__moonlite_{p3}`)) or p4;
end;

local function setValue(p5: userdata, p6: string, p7: any, p8: any) -- Line: 74
    local v9 = `__moonlite_{p6}`;

    if p7 == p8 then
        p7 = nil;
    end;

    p5:SetAttribute(v9, p7);
end;

local function BoundProp(u10) -- Line: 78
    return function(u11: userdata, u12: any) -- Line: 79
        -- upvalues: u10 (copy)
        assert(u10.Get);

        return {
            Get = function() -- Line: 83, Name: Get
                -- upvalues: u10 (ref), u11 (copy), u12 (copy)
                return u10.Get(u11, u12);
            end,

            Set = function(p13) -- Line: 87, Name: Set
                -- upvalues: u10 (ref), u11 (copy), u12 (copy)
                u10.Set(p13, u11, u12);
            end
        };
    end;
end;

local function LazyAction(u14: function) -- Line: 94
    return function(u15: userdata) -- Line: 95
        -- upvalues: u14 (copy)
        return {
            Default = false,

            Set = function(p16: boolean) -- Line: 99, Name: Set
                -- upvalues: u14 (ref), u15 (copy)
                if p16 then
                    u14(u15);
                end;
            end
        };
    end;
end;

local function setCameraActive(u17: any, u18: userdata, p19: boolean) -- Line: 114
    -- upvalues: RunService (copy)
    if p19 and not u17._cameraRenderBound then
        RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function() -- Line: 116, Name: updateCamera
            -- upvalues: u17 (copy), u18 (copy)
            local _cameraAttachToPart = u17._cameraAttachToPart;
            local _cameraLookAtPart = u17._cameraLookAtPart;

            if _cameraAttachToPart then
                local CFrame2 = _cameraAttachToPart.CFrame;

                if _cameraLookAtPart then
                    CFrame2 = CFrame.new(CFrame2.Position, _cameraLookAtPart.Position);
                end;

                u18.CFrame = CFrame2;
            end;
        end);
        u17._cameraRenderBound = true;
        local _cameraAttachToPart = u17._cameraAttachToPart;
        local _cameraLookAtPart = u17._cameraLookAtPart;

        if _cameraAttachToPart then
            local CFrame2 = _cameraAttachToPart.CFrame;

            if _cameraLookAtPart then
                CFrame2 = CFrame.new(CFrame2.Position, _cameraLookAtPart.Position);
            end;

            u18.CFrame = CFrame2;
        end;

        if not u17.KeepCameraType then
            u18.CameraType = Enum.CameraType.Scriptable;
        end;
    elseif not p19 and u17._cameraRenderBound then
        RunService:UnbindFromRenderStep("MoonliteRenderCamera");

        if not u17.KeepCameraType then
            u18.CameraType = Enum.CameraType.Custom;
        end;

        u17._cameraRenderBound = false;
    end;
end;

local v20 = {};
local u26 = {
    Get = function(p21: userdata, p22: any) -- Line: 151, Name: Get
        return p22._cameraAttachToPart;
    end,

    Set = function(p23: userdata?, u24: userdata, u25: any) -- Line: 155, Name: Set
        -- upvalues: RunService (copy)
        if p23 then
            u25._activeCamera = u24;
            u25._cameraAttachToPart = p23;

            if not u25._cameraRenderBound then
                RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function() -- Line: 116, Name: updateCamera
                    -- upvalues: u25 (copy), u24 (copy)
                    local _cameraAttachToPart = u25._cameraAttachToPart;
                    local _cameraLookAtPart = u25._cameraLookAtPart;

                    if _cameraAttachToPart then
                        local CFrame2 = _cameraAttachToPart.CFrame;

                        if _cameraLookAtPart then
                            CFrame2 = CFrame.new(CFrame2.Position, _cameraLookAtPart.Position);
                        end;

                        u24.CFrame = CFrame2;
                    end;
                end);
                u25._cameraRenderBound = true;
                local _cameraAttachToPart = u25._cameraAttachToPart;
                local _cameraLookAtPart = u25._cameraLookAtPart;

                if _cameraAttachToPart then
                    local CFrame2 = _cameraAttachToPart.CFrame;

                    if _cameraLookAtPart then
                        CFrame2 = CFrame.new(CFrame2.Position, _cameraLookAtPart.Position);
                    end;

                    u24.CFrame = CFrame2;
                end;

                if not u25.KeepCameraType then
                    u24.CameraType = Enum.CameraType.Scriptable;
                end;
            end;
        else
            u25._cameraAttachToPart = nil;

            if u25._cameraRenderBound then
                RunService:UnbindFromRenderStep("MoonliteRenderCamera");

                if not u25.KeepCameraType then
                    u24.CameraType = Enum.CameraType.Custom;
                end;

                u25._cameraRenderBound = false;
            end;
        end;
    end
};

function v20.AttachToPart(u27: userdata, u28: any) -- Line: 79
    -- upvalues: u26 (copy)
    assert(u26.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u26 (ref), u27 (copy), u28 (copy)
            return u26.Get(u27, u28);
        end,

        Set = function(p29) -- Line: 87, Name: Set
            -- upvalues: u26 (ref), u27 (copy), u28 (copy)
            u26.Set(p29, u27, u28);
        end
    };
end;

local u35 = {
    Get = function(p30: userdata, p31: any) -- Line: 168, Name: Get
        return p31._cameraLookAtPart;
    end,

    Set = function(p32: userdata?, u33: userdata, u34: any) -- Line: 172, Name: Set
        -- upvalues: RunService (copy)
        if p32 then
            u34._activeCamera = u33;
            u34._cameraLookAtPart = p32;

            if not u34._cameraRenderBound then
                RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function() -- Line: 116, Name: updateCamera
                    -- upvalues: u34 (copy), u33 (copy)
                    local _cameraAttachToPart = u34._cameraAttachToPart;
                    local _cameraLookAtPart = u34._cameraLookAtPart;

                    if _cameraAttachToPart then
                        local CFrame2 = _cameraAttachToPart.CFrame;

                        if _cameraLookAtPart then
                            CFrame2 = CFrame.new(CFrame2.Position, _cameraLookAtPart.Position);
                        end;

                        u33.CFrame = CFrame2;
                    end;
                end);
                u34._cameraRenderBound = true;
                local _cameraAttachToPart = u34._cameraAttachToPart;
                local _cameraLookAtPart = u34._cameraLookAtPart;

                if _cameraAttachToPart then
                    local CFrame2 = _cameraAttachToPart.CFrame;

                    if _cameraLookAtPart then
                        CFrame2 = CFrame.new(CFrame2.Position, _cameraLookAtPart.Position);
                    end;

                    u33.CFrame = CFrame2;
                end;

                if not u34.KeepCameraType then
                    u33.CameraType = Enum.CameraType.Scriptable;
                end;
            end;

            if u34._updateCamera then
                u34._updateCamera();
            end;
        else
            u34._cameraLookAtPart = nil;

            if not u34._cameraAttachToPart and u34._cameraRenderBound then
                RunService:UnbindFromRenderStep("MoonliteRenderCamera");

                if not u34.KeepCameraType then
                    u33.CameraType = Enum.CameraType.Custom;
                end;

                u34._cameraRenderBound = false;
            end;
        end;
    end
};

function v20.LookAtPart(u36: userdata, u37: any) -- Line: 79
    -- upvalues: u35 (copy)
    assert(u35.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u35 (ref), u36 (copy), u37 (copy)
            return u35.Get(u36, u37);
        end,

        Set = function(p38) -- Line: 87, Name: Set
            -- upvalues: u35 (ref), u36 (copy), u37 (copy)
            u35.Set(p38, u36, u37);
        end
    };
end;

u1.Camera = v20;
u1.Terrain = {};
local u39 = {
    Camera = {
        AttachToPart = true,
        LookAtPart = true
    },
    Humanoid = {
        AddAccessory = true,
        ChangeState = true,
        EquipTool = true,
        MoveTo = true,
        Move = true,
        PlayEmote = true,
        RemoveAccessories = true,
        TakeDamage = true,
        UnequipTools = true
    },
    ParticleEmitter = {
        Emit = true,
        Clear = true
    },
    Sound = {
        PlayOnce = true,
        SetTime = true,
        Play = true,
        Resume = true,
        Pause = true,
        Stop = true
    }
};

for _, v in Enum.Material:GetEnumItems() do
    if pcall(function() -- Line: 199
        -- upvalues: v (copy)
        workspace.Terrain:GetMaterialColor(v);
    end) then
        local u43 = {
            Get = function(p40: userdata) -- Line: 205, Name: Get
                -- upvalues: v (copy)
                return p40:GetMaterialColor(v);
            end,

            Set = function(p41, p42: userdata) -- Line: 209, Name: Set
                -- upvalues: v (copy)
                p42:SetMaterialColor(v, p41);
            end
        };

        u1.Terrain[`MC_{v.Name}`] = function(u44: userdata, u45: any) -- Line: 79
            -- upvalues: u43 (copy)
            assert(u43.Get);

            return {
                Get = function() -- Line: 83, Name: Get
                    -- upvalues: u43 (ref), u44 (copy), u45 (copy)
                    return u43.Get(u44, u45);
                end,

                Set = function(p46) -- Line: 87, Name: Set
                    -- upvalues: u43 (ref), u44 (copy), u45 (copy)
                    u43.Set(p46, u44, u45);
                end
            };
        end;
    end;
end;

local Color3_new_ret = Color3.new(1, 1, 1);
local v47 = {};
local u51 = {
    Get = function(p48: userdata) -- Line: 224, Name: Get
        return p48:GetPivot();
    end,

    Set = function(p49, p50: userdata) -- Line: 228, Name: Set
        p50:PivotTo(p49);
    end
};

function v47.CFrame(u52: userdata, u53: any) -- Line: 79
    -- upvalues: u51 (copy)
    assert(u51.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u51 (ref), u52 (copy), u53 (copy)
            return u51.Get(u52, u53);
        end,

        Set = function(p54) -- Line: 87, Name: Set
            -- upvalues: u51 (ref), u52 (copy), u53 (copy)
            u51.Set(p54, u52, u53);
        end
    };
end;

local u60 = {
    Get = function(p55: userdata) -- Line: 234, Name: Get
        -- upvalues: Color3_new_ret (copy)
        return p55:GetAttribute("__moonlite_Color") or Color3_new_ret;
    end,

    Set = function(p56, p57: userdata) -- Line: 238, Name: Set
        -- upvalues: Color3_new_ret (copy)
        for _, descendant in p57:GetDescendants() do
            if descendant:IsA("BasePart") then
                local Color = descendant.Color;
                local v58 = descendant:GetAttribute("__moonlite_Color") or Color;

                if v58 ~= p56 then
                    local v59;

                    if p56 == v58 then
                        v59 = nil;
                    else
                        v59 = p56;
                    end;

                    descendant:SetAttribute("__moonlite_Color", v59);
                    descendant.Color = p56;
                end;
            end;
        end;

        if p56 == Color3_new_ret then
            p56 = nil;
        end;

        p57:SetAttribute("__moonlite_Color", p56);
    end
};

function v47.Color(u61: userdata, u62: any) -- Line: 79
    -- upvalues: u60 (copy)
    assert(u60.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u60 (ref), u61 (copy), u62 (copy)
            return u60.Get(u61, u62);
        end,

        Set = function(p63) -- Line: 87, Name: Set
            -- upvalues: u60 (ref), u61 (copy), u62 (copy)
            u60.Set(p63, u61, u62);
        end
    };
end;

local u67 = {
    Get = function(p64: userdata) -- Line: 255, Name: Get
        return p64:GetScale();
    end,

    Set = function(p65: number, p66: userdata) -- Line: 259, Name: Set
        p66:ScaleTo(p65);
    end
};

function v47.Scale(u68: userdata, u69: any) -- Line: 79
    -- upvalues: u67 (copy)
    assert(u67.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u67 (ref), u68 (copy), u69 (copy)
            return u67.Get(u68, u69);
        end,

        Set = function(p70) -- Line: 87, Name: Set
            -- upvalues: u67 (ref), u68 (copy), u69 (copy)
            u67.Set(p70, u68, u69);
        end
    };
end;

local u75 = {
    Get = function(p71: userdata) -- Line: 265, Name: Get
        return p71:GetAttribute("__moonlite_Reflectance") or 0;
    end,

    Set = function(p72: number, p73: userdata) -- Line: 269, Name: Set
        if (p73:GetAttribute("__moonlite_Reflectance") or 0) ~= p72 then
            for _, descendant in p73:GetDescendants() do
                if descendant:IsA("BasePart") then
                    local Reflectance = descendant.Reflectance;
                    local v74 = descendant:GetAttribute("__moonlite_BaseReflectance") or Reflectance;
                    descendant.Reflectance = v74 + (1 - v74) * p72;
                end;
            end;

            if p72 == 0 then
                p72 = nil;
            end;

            p73:SetAttribute("__moonlite_Reflectance", p72);
        end;
    end
};

function v47.Reflectance(u76: userdata, u77: any) -- Line: 79
    -- upvalues: u75 (copy)
    assert(u75.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u75 (ref), u76 (copy), u77 (copy)
            return u75.Get(u76, u77);
        end,

        Set = function(p78) -- Line: 87, Name: Set
            -- upvalues: u75 (ref), u76 (copy), u77 (copy)
            u75.Set(p78, u76, u77);
        end
    };
end;

local u82 = {
    Get = function(p79: userdata) -- Line: 287, Name: Get
        return p79:GetAttribute("__moonlite_Transparency") or 0;
    end,

    Set = function(p80: number, p81: userdata) -- Line: 291, Name: Set
        if (p81:GetAttribute("__moonlite_Transparency") or 0) ~= p80 then
            for _, descendant in p81:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.LocalTransparencyModifier = p80;
                end;
            end;

            if p80 == 0 then
                p80 = nil;
            end;

            p81:SetAttribute("__moonlite_Transparency", p80);
        end;
    end
};

function v47.Transparency(u83: userdata, u84: any) -- Line: 79
    -- upvalues: u82 (copy)
    assert(u82.Get);

    return {
        Get = function() -- Line: 83, Name: Get
            -- upvalues: u82 (ref), u83 (copy), u84 (copy)
            return u82.Get(u83, u84);
        end,

        Set = function(p85) -- Line: 87, Name: Set
            -- upvalues: u82 (ref), u83 (copy), u84 (copy)
            u82.Set(p85, u83, u84);
        end
    };
end;

u1.Model = v47;
local v92 = {
    AddAccessory = function(u86: userdata) -- Line: 313, Name: AddAccessory
        return {
            Default = nil,

            Set = function(p87: userdata?) -- Line: 319, Name: Set
                -- upvalues: u86 (copy)
                if p87 then
                    pcall(u86.AddAccessory, u86, p87);
                end;
            end
        };
    end,

    ChangeState = function(u88: userdata) -- Line: 327, Name: ChangeState
        return {
            Default = Enum.HumanoidStateType.None,

            Set = function(p89) -- Line: 331, Name: Set
                -- upvalues: u88 (copy)
                u88:ChangeState(p89);
            end
        };
    end,

    EquipTool = function(u90: userdata) -- Line: 337, Name: EquipTool
        return {
            Default = nil,

            Set = function(p91: userdata?) -- Line: 343, Name: Set
                -- upvalues: u90 (copy)
                if p91 then
                    pcall(u90.EquipTool, u90, p91);
                end;
            end
        };
    end
};

local function u94(p93: userdata) -- Line: 351
    p93.Jump = true;
end;

function v92.Jump(u95: userdata) -- Line: 95
    -- upvalues: u94 (copy)
    return {
        Default = false,

        Set = function(p96: boolean) -- Line: 99, Name: Set
            -- upvalues: u94 (ref), u95 (copy)
            if p96 then
                u94(u95);
            end;
        end
    };
end;

function v92.MoveTo(u97: userdata) -- Line: 355
    local Attribute = u97:GetAttribute("MoveToDefault");

    if typeof(Attribute) ~= "Vector3" then
        local RootPart = u97.RootPart;
        Attribute = not RootPart and Vector3.new(0, 0, 0) or RootPart.Position;
        u97:SetAttribute("MoveToDefault", Attribute);
    end;

    return {
        Default = Attribute,

        Set = function(p98: vector) -- Line: 373, Name: Set
            -- upvalues: u97 (copy)
            u97:MoveTo(p98);
        end
    };
end;

function v92.Move(u99: userdata) -- Line: 379
    local Attribute = u99:GetAttribute("MoveDefault");

    if typeof(Attribute) ~= "Vector3" then
        local RootPart = u99.RootPart;
        Attribute = not RootPart and Vector3.new(0, 0, 0) or RootPart.CFrame.LookVector;
        u99:SetAttribute("MoveDefault", Attribute);
    end;

    return {
        Default = Attribute,

        Set = function(p100: vector) -- Line: 397, Name: Set
            -- upvalues: u99 (copy)
            u99:Move(p100);
        end
    };
end;

function v92.PlayEmote(u101: userdata) -- Line: 403
    return {
        Default = "",

        Set = function(p102: string) -- Line: 407, Name: Set
            -- upvalues: u101 (copy)
            u101:PlayEmote(p102);
        end
    };
end;

local function u104(p103: userdata) -- Line: 413
    p103:RemoveAccessories();
end;

function v92.RemoveAccessories(u105: userdata) -- Line: 95
    -- upvalues: u104 (copy)
    return {
        Default = false,

        Set = function(p106: boolean) -- Line: 99, Name: Set
            -- upvalues: u104 (ref), u105 (copy)
            if p106 then
                u104(u105);
            end;
        end
    };
end;

function v92.Sit(u107: userdata) -- Line: 417
    return {
        Set = function(p108: boolean) -- Line: 419, Name: Set
            -- upvalues: u107 (copy)
            u107.Sit = p108;
        end
    };
end;

function v92.TakeDamage(u109: userdata) -- Line: 425
    return {
        Set = function(p110: number) -- Line: 427, Name: Set
            -- upvalues: u109 (copy)
            u109:TakeDamage(p110);
        end
    };
end;

local function u112(p111: userdata) -- Line: 433
    p111:UnequipTools();
end;

function v92.UnequipTools(u113: userdata) -- Line: 95
    -- upvalues: u112 (copy)
    return {
        Default = false,

        Set = function(p114: boolean) -- Line: 99, Name: Set
            -- upvalues: u112 (ref), u113 (copy)
            if p114 then
                u112(u113);
            end;
        end
    };
end;

u1.Humanoid = v92;
local v115 = {};

local function u117(p116: userdata) -- Line: 443
    p116:Clear();
end;

function v115.Clear(u118: userdata) -- Line: 95
    -- upvalues: u117 (copy)
    return {
        Default = false,

        Set = function(p119: boolean) -- Line: 99, Name: Set
            -- upvalues: u117 (ref), u118 (copy)
            if p119 then
                u117(u118);
            end;
        end
    };
end;

function v115.Emit(u120: userdata) -- Line: 447
    local Attribute = u120:GetAttribute("EmitCount");

    return {
        Default = type(Attribute) ~= "number" and 0 or Attribute,

        Set = function(p121: number) -- Line: 457, Name: Set
            -- upvalues: u120 (copy)
            if p121 > 0 then
                u120:Emit(p121);
            end;
        end
    };
end;

u1.ParticleEmitter = v115;
local v122 = {};

local function u125(p123: userdata) -- Line: 471
    local v124 = p123:Clone();
    v124.Parent = p123.Parent;
    v124.PlayOnRemove = true;
    v124:Destroy();
end;

function v122.PlayOnce(u126: userdata) -- Line: 95
    -- upvalues: u125 (copy)
    return {
        Default = false,

        Set = function(p127: boolean) -- Line: 99, Name: Set
            -- upvalues: u125 (ref), u126 (copy)
            if p127 then
                u125(u126);
            end;
        end
    };
end;

function v122.SetTime(u128: userdata) -- Line: 478
    return {
        Default = 0,

        Set = function(p129: number) -- Line: 482, Name: Set
            -- upvalues: u128 (copy)
            u128.TimePosition = p129;
        end
    };
end;

local function u131(p130: userdata) -- Line: 488
    p130:Play();
end;

function v122.Play(u132: userdata) -- Line: 95
    -- upvalues: u131 (copy)
    return {
        Default = false,

        Set = function(p133: boolean) -- Line: 99, Name: Set
            -- upvalues: u131 (ref), u132 (copy)
            if p133 then
                u131(u132);
            end;
        end
    };
end;

local function u135(p134: userdata) -- Line: 492
    p134:Resume();
end;

function v122.Resume(u136: userdata) -- Line: 95
    -- upvalues: u135 (copy)
    return {
        Default = false,

        Set = function(p137: boolean) -- Line: 99, Name: Set
            -- upvalues: u135 (ref), u136 (copy)
            if p137 then
                u135(u136);
            end;
        end
    };
end;

local function u139(p138: userdata) -- Line: 496
    p138:Pause();
end;

function v122.Pause(u140: userdata) -- Line: 95
    -- upvalues: u139 (copy)
    return {
        Default = false,

        Set = function(p141: boolean) -- Line: 99, Name: Set
            -- upvalues: u139 (ref), u140 (copy)
            if p141 then
                u139(u140);
            end;
        end
    };
end;

local function u143(p142: userdata) -- Line: 500
    p142:Stop();
end;

function v122.Stop(u144: userdata) -- Line: 95
    -- upvalues: u143 (copy)
    return {
        Default = false,

        Set = function(p145: boolean) -- Line: 99, Name: Set
            -- upvalues: u143 (ref), u144 (copy)
            if p145 then
                u143(u144);
            end;
        end
    };
end;

u1.Sound = v122;
local u146 = {};
local u147 = {};
local u148 = {};
local u154 = {
    __index = function(p149: any, p150: string) -- Line: 524, Name: __index
        -- upvalues: u147 (copy), u1 (copy)
        local _target = p149._target;
        local ClassName = _target.ClassName;
        local v151 = u147[ClassName];

        if v151 == nil then
            v151 = {};

            for i, v in u1 do
                if _target:IsA(i) then
                    for i2, v2 in v do
                        v151[i2] = v2;
                    end;
                end;
            end;

            u147[ClassName] = v151;
        end;

        local v152 = v151[p150];
        local v153;

        if v152 then
            v153 = v152(_target, p149._work);
            rawset(p149, p150, v153);
        else
            v153 = nil;
        end;

        return v153;
    end
};

return {
    Get = function(p155: any, u156: userdata, p157: string) -- Line: 562, Name: get
        -- upvalues: u148 (copy), u154 (copy)
        local u158 = u148[u156];

        if not u158 then
            u158 = setmetatable({
                _target = u156,
                _work = p155
            }, u154);
            u156.Destroying:Connect(function() -- Line: 572
                -- upvalues: u148 (ref), u156 (copy), u158 (ref)
                if u148[u156] == u158 then
                    u148[u156] = nil;
                end;
            end);
            u148[u156] = assert(u158);
        end;

        return u158[p157];
    end,

    Static = function(p159: userdata, p160: string) -- Line: 586, Name: static
        -- upvalues: u146 (copy), u39 (copy)
        local ClassName = p159.ClassName;

        if not u146[ClassName] then
            local v161 = {};

            for i, v in pairs(u39) do
                if p159:IsA(i) then
                    for i2, v2 in v do
                        v161[i2] = v2;
                    end;
                end;
            end;

            u146[ClassName] = v161;
        end;

        return u146[ClassName][p160] == true;
    end,

    Index = u1
};