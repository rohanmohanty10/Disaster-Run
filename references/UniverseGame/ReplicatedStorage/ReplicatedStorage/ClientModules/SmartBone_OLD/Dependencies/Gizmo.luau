  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Terrain = workspace:FindFirstChild("Terrain");
assert(Terrain, "No terrain object found under workspace...");
local AOTGizmoAdornment = Terrain:FindFirstChild("AOTGizmoAdornment");
local GizmoAdornment = Terrain:FindFirstChild("GizmoAdornment");

if not AOTGizmoAdornment then
    AOTGizmoAdornment = Instance.new("WireframeHandleAdornment");
    AOTGizmoAdornment.Adornee = Terrain;
    AOTGizmoAdornment.ZIndex = 1;
    AOTGizmoAdornment.AlwaysOnTop = true;
    AOTGizmoAdornment.Name = "AOTGizmoAdornment";
    AOTGizmoAdornment.Parent = Terrain;
end;

if not GizmoAdornment then
    GizmoAdornment = Instance.new("WireframeHandleAdornment");
    GizmoAdornment.Adornee = Terrain;
    GizmoAdornment.ZIndex = 1;
    GizmoAdornment.AlwaysOnTop = false;
    GizmoAdornment.Name = "GizmoAdornment";
    GizmoAdornment.Parent = Terrain;
end;

local Gizmos = script:WaitForChild("Gizmos");
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {
    AlwaysOnTop = true
};
local u6 = {};
local u7 = false;

local function Register(p8) -- Line: 48
    -- upvalues: u1 (ref)
    table.insert(u1, p8);
end;

local function Lerp(p9, p10, p11) -- Line: 76
    return p9 + (p10 - p9) * p11;
end;

local function deepCopy(p12) -- Line: 80
    -- upvalues: deepCopy (copy)
    local v13 = {};

    for i, v in pairs(p12) do
        if type(v) == "table" then
            local v = deepCopy(v);
        end;

        v13[i] = v;
    end;

    return v13;
end;

local u18 = {
    Enabled = true,
    ActiveRays = 0,
    ActiveInstances = 0,
    Styles = {
        Color = "Color3",
        Transparency = "Transparency",
        AlwaysOnTop = "AlwaysOnTop"
    },
    AOTWireframeHandle = AOTGizmoAdornment,
    WireframeHandle = GizmoAdornment,

    GetPoolSize = function() -- Line: 464, Name: GetPoolSize
        -- upvalues: u6 (copy)
        local v14 = 0;

        for _, v in u6 do
            v14 = v14 + #v;
        end;

        return v14;
    end,

    PushProperty = function(u15, u16) -- Line: 474, Name: PushProperty
        -- upvalues: u5 (copy), AOTGizmoAdornment (ref), GizmoAdornment (ref)
        u5[u15] = u16;

        if u15 == "AlwaysOnTop" then
            return;
        end;

        pcall(function() -- Line: 481
            -- upvalues: AOTGizmoAdornment (ref), u15 (copy), u16 (copy), GizmoAdornment (ref)
            AOTGizmoAdornment[u15] = u16;
            GizmoAdornment[u15] = u16;
        end);
    end,

    PopProperty = function(p17) -- Line: 487, Name: PopProperty
        -- upvalues: u5 (copy), AOTGizmoAdornment (ref)
        if u5[p17] then
            return u5[p17];
        end;

        return AOTGizmoAdornment[p17];
    end
};

function u18.SetStyle(p19, p20, p21) -- Line: 495
    -- upvalues: u18 (copy)
    if p19 and typeof(p19) == "Color3" then
        u18.PushProperty("Color3", p19);
    end;

    if p20 and typeof(p20) == "number" then
        u18.PushProperty("Transparency", p20);
    end;

    if p21 and typeof(p21) == "boolean" then
        u18.PushProperty("AlwaysOnTop", p21);
    end;
end;

function u18.DoCleaning() -- Line: 509
    -- upvalues: AOTGizmoAdornment (ref), GizmoAdornment (ref), u1 (ref), u6 (copy), u18 (copy)
    AOTGizmoAdornment:Clear();
    GizmoAdornment:Clear();

    for _, v in u1 do
        local ClassName = v.ClassName;

        if not u6[ClassName] then
            u6[ClassName] = {};
        end;

        v:Remove();
        table.insert(u6[ClassName], v);
    end;

    u1 = {};
    u18.ActiveRays = 0;
    u18.ActiveInstances = 0;
end;

function u18.ScheduleCleaning() -- Line: 523
    -- upvalues: u7 (ref), u18 (copy)
    if u7 then
        return;
    end;

    u7 = true;
    task.delay(0, function() -- Line: 530
        -- upvalues: u18 (ref), u7 (ref)
        u18.DoCleaning();
        u7 = false;
    end);
end;

function u18.AddDebrisInSeconds(p22, p23) -- Line: 537
    -- upvalues: u3 (copy)
    local v24 = {
        "Seconds",
        p22,
        os.clock(),
        p23
    };
    table.insert(u3, v24);
end;

function u18.AddDebrisInFrames(p25, p26) -- Line: 541
    -- upvalues: u3 (copy)
    table.insert(u3, {
        "Frames",
        p25,
        0,
        p26
    });
end;

function u18.TweenProperties(p27, p28, p29) -- Line: 545
    -- upvalues: deepCopy (copy), u4 (copy)
    local v30 = {
        Time = 0,
        p_Properties = p27,
        Properties = deepCopy(p27),
        Goal = p28,
        TweenInfo = p29
    };
    table.insert(u4, v30);
    local u31 = #u4;

    return function() -- Line: 559
        -- upvalues: u4 (ref), u31 (copy)
        table.remove(u4, u31);
    end;
end;

function u18.Init() -- Line: 564
    -- upvalues: RunService (copy), u4 (copy), TweenService (copy), u3 (copy), u2 (copy)
    RunService.RenderStepped:Connect(function(p32) -- Line: 565
        -- upvalues: u4 (ref), TweenService (ref), u3 (ref), u2 (ref)
        for i, v in u4 do
            v.Time = v.Time + p32;
            local v33 = v.Time / v.TweenInfo.Time;
            local v34 = v33 > 1 and 1 or v33;

            local function LerpProperty(p35, p36, p37) -- Line: 574
                if type(p35) == "number" then
                    return p35 + (p36 - p35) * p37;
                end;

                return p35:Lerp(p36, p37);
            end;

            for i2, v2 in v.Properties do
                if v.Goal[i2] then
                    local v38 = TweenService:GetValue(v34, v.TweenInfo.EasingStyle, v.TweenInfo.EasingDirection);
                    local v39 = v.Goal[i2];
                    local v40;

                    if type(v2) == "number" then
                        v40 = v2 + (v39 - v2) * v38;
                    else
                        v40 = v2:Lerp(v39, v38);
                    end;

                    v.p_Properties[i2] = v40;
                end;
            end;

            if v34 == 1 then
                table.remove(u4, i);
            end;
        end;

        for i, v in u3 do
            local v41 = v[2];
            local v42 = v[3];
            local v43 = v[4];

            if v[1] == "Seconds" then
                if v41 < os.clock() - v42 then
                    table.remove(u3, i);
                else
                    v43();
                end;
            elseif v41 < v42 then
                table.remove(u3, i);
            else
                v[2] = v[2] + 1;
                v43();
            end;
        end;

        for i, v in u2 do
            local v44 = v[2];

            if v44.Enabled then
                if v44.Destroy then
                    table.remove(u2, i);
                end;

                v[1]:Update(v44);
            end;
        end;
    end);
end;

function u18.SetEnabled(p45) -- Line: 641
    -- upvalues: u18 (copy)
    u18.Enabled = p45;

    if p45 == false then
        u18.DoCleaning();
    end;
end;

local function Request(p46) -- Line: 63
    -- upvalues: u6 (copy)
    if not u6[p46] then
        return Instance.new(p46);
    end;

    if not u6[p46][1] then
        return Instance.new(p46);
    end;

    local v47 = u6[p46][1];
    table.remove(u6[p46], 1);

    return v47;
end;

local function Release(p48) -- Line: 52
    -- upvalues: u6 (copy)
    local ClassName = p48.ClassName;

    if not u6[ClassName] then
        u6[ClassName] = {};
    end;

    p48:Remove();
    table.insert(u6[ClassName], p48);
end;

local function Retain(p49, p50) -- Line: 44
    -- upvalues: u2 (copy)
    table.insert(u2, { p49, p50 });
end;

for _, child in Gizmos:GetChildren() do
    u18[child.Name] = require(child).Init(u18, u5, Request, Release, Retain, Register);
end;

return u18;