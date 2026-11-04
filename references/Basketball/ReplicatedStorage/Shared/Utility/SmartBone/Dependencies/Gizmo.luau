 
 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Terrain = workspace:WaitForChild("Terrain");
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
        local v14;

        if type(v) == "table" then
            v14 = deepCopy(v);
        else
            v14 = v;
        end;

        v13[i] = v14;
    end;

    return v13;
end;

local u19 = {
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

    GetPoolSize = function() -- Line: 472, Name: GetPoolSize
        -- upvalues: u6 (copy)
        local v15 = 0;

        for _, v in u6 do
            v15 = v15 + #v;
        end;

        return v15;
    end,

    PushProperty = function(u16, u17) -- Line: 482, Name: PushProperty
        -- upvalues: u5 (copy), AOTGizmoAdornment (ref), GizmoAdornment (ref)
        u5[u16] = u17;

        if u16 == "AlwaysOnTop" then
            return;
        end;

        pcall(function() -- Line: 489
            -- upvalues: AOTGizmoAdornment (ref), u16 (copy), u17 (copy), GizmoAdornment (ref)
            AOTGizmoAdornment[u16] = u17;
            GizmoAdornment[u16] = u17;
        end);
    end,

    PopProperty = function(p18) -- Line: 495, Name: PopProperty
        -- upvalues: u5 (copy), AOTGizmoAdornment (ref)
        if u5[p18] then
            return u5[p18];
        end;

        return AOTGizmoAdornment[p18];
    end
};

function u19.SetStyle(p20, p21, p22) -- Line: 503
    -- upvalues: u19 (copy)
    if p20 and typeof(p20) == "Color3" then
        u19.PushProperty("Color3", p20);
    end;

    if p21 and typeof(p21) == "number" then
        u19.PushProperty("Transparency", p21);
    end;

    if p22 and typeof(p22) == "boolean" then
        u19.PushProperty("AlwaysOnTop", p22);
    end;
end;

function u19.DoCleaning() -- Line: 517
    -- upvalues: AOTGizmoAdornment (ref), GizmoAdornment (ref), u1 (ref), u6 (copy), u19 (copy)
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
    u19.ActiveRays = 0;
    u19.ActiveInstances = 0;
end;

function u19.ScheduleCleaning() -- Line: 531
    -- upvalues: u7 (ref), u19 (copy)
    if u7 then
        return;
    end;

    u7 = true;
    task.delay(0, function() -- Line: 538
        -- upvalues: u19 (ref), u7 (ref)
        u19.DoCleaning();
        u7 = false;
    end);
end;

function u19.AddDebrisInSeconds(p23: number, p24: any) -- Line: 545
    -- upvalues: u3 (copy)
    local v25 = {
        "Seconds",
        p23,
        os.clock(),
        p24
    };
    table.insert(u3, v25);
end;

function u19.AddDebrisInFrames(p26: number, p27: any) -- Line: 549
    -- upvalues: u3 (copy)
    table.insert(u3, {
        "Frames",
        p26,
        0,
        p27
    });
end;

function u19.TweenProperties(p28: table, p29: table, p30: userdata) -- Line: 553
    -- upvalues: deepCopy (copy), u4 (copy)
    local v31 = {
        Time = 0,
        p_Properties = p28,
        Properties = deepCopy(p28),
        Goal = p29,
        TweenInfo = p30
    };
    table.insert(u4, v31);
    local u32 = #u4;

    return function() -- Line: 567
        -- upvalues: u4 (ref), u32 (copy)
        table.remove(u4, u32);
    end;
end;

function u19.Init() -- Line: 572
    -- upvalues: RunService (copy), u4 (copy), TweenService (copy), u3 (copy), u2 (copy)
    RunService.RenderStepped:Connect(function(p33) -- Line: 573
        -- upvalues: u4 (ref), TweenService (ref), u3 (ref), u2 (ref)
        for i, v in u4 do
            v.Time = v.Time + p33;
            local v34 = v.Time / v.TweenInfo.Time;
            local v35 = v34 > 1 and 1 or v34;

            local function LerpProperty(p36, p37, p38) -- Line: 582
                if type(p36) == "number" then
                    return p36 + (p37 - p36) * p38;
                end;

                return p36:Lerp(p37, p38);
            end;

            local v39 = i;
            local v40 = v;

            for i2, v2 in v.Properties do
                if v40.Goal[i2] then
                    local Value = TweenService:GetValue(v35, v40.TweenInfo.EasingStyle, v40.TweenInfo.EasingDirection);
                    local v41 = v40.Goal[i2];
                    local v42;

                    if type(v2) == "number" then
                        v42 = v2 + (v41 - v2) * Value;
                    else
                        v42 = v2:Lerp(v41, Value);
                    end;

                    v40.p_Properties[i2] = v42;
                end;
            end;

            if v35 == 1 then
                table.remove(u4, v39);
            end;
        end;

        for i, v in u3 do
            local v43 = v[2];
            local v44 = v[3];
            local v45 = v[4];

            if v[1] == "Seconds" then
                if v43 < os.clock() - v44 then
                    table.remove(u3, i);
                else
                    v45();
                end;
            elseif v43 < v44 then
                table.remove(u3, i);
            else
                v[2] = v[2] + 1;
                v45();
            end;
        end;

        for i, v in u2 do
            local v46 = v[2];

            if v46.Enabled then
                if v46.Destroy then
                    table.remove(u2, i);
                end;

                v[1]:Update(v46);
            end;
        end;
    end);
end;

function u19.SetEnabled(p47) -- Line: 649
    -- upvalues: u19 (copy)
    u19.Enabled = p47;

    if p47 == false then
        u19.DoCleaning();
    end;
end;

local function Request(p48) -- Line: 63
    -- upvalues: u6 (copy)
    if not u6[p48] then
        return Instance.new(p48);
    end;

    if not u6[p48][1] then
        return Instance.new(p48);
    end;

    local v49 = u6[p48][1];
    table.remove(u6[p48], 1);

    return v49;
end;

local function Release(p50) -- Line: 52
    -- upvalues: u6 (copy)
    local ClassName = p50.ClassName;

    if not u6[ClassName] then
        u6[ClassName] = {};
    end;

    p50:Remove();
    table.insert(u6[ClassName], p50);
end;

local function Retain(p51, p52) -- Line: 44
    -- upvalues: u2 (copy)
    table.insert(u2, { p51, p52 });
end;

for _, child in Gizmos:GetChildren() do
    u19[child.Name] = require(child).Init(u19, u5, Request, Release, Retain, Register);
end;

return u19;