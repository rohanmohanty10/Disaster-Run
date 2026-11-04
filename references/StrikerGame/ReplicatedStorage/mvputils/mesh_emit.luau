 

 

local u1 = {};
u1.__index = u1;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(script.Types);

local function GetType(p2) -- Line: 10
    return p2.Start:IsA("Part") and p2.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh";
end;

local function GetPartType(p3: userdata) -- Line: 20
    return p3:IsA("Part") and p3:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh";
end;

local function RetrieveSettings(p4) -- Line: 30
    return p4:GetAttributes();
end;

local function RotateMesh(u5: userdata, u6: number, p7: number) -- Line: 34
    -- upvalues: RunService (copy)
    local u9 = RunService.Heartbeat:Connect(function() -- Line: 35
        -- upvalues: u5 (copy), u6 (copy)
        local v8 = u5;
        v8.CFrame = v8.CFrame * CFrame.Angles(0, math.rad(u6), 0);
    end);
    task.delay(p7, function() -- Line: 38
        -- upvalues: u9 (copy)
        u9:Disconnect();
    end);
end;

local function GenerateInRange(p10) -- Line: 43
    return not p10 and 0 or math.random(p10.Min, p10.Max);
end;

local function RetrieveProperities(p11: userdata) -- Line: 48
    local v12 = {};

    if (p11:IsA("Part") and p11:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh") == "SpecialMesh" then
        local v13 = p11:FindFirstChildOfClass("SpecialMesh");

        if not v13 then
            return {};
        end;

        v12.Scale = v13.Scale;
    else
        v12.Size = p11.Size;
    end;

    v12.Position = p11.CFrame.Position;

    return v12;
end;

function u1.new(p14) -- Line: 63
    -- upvalues: RetrieveProperities (copy), u1 (copy)
    local v15 = {
        Model = p14,
        Type = p14.Start:IsA("Part") and p14.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh",
        Properities = RetrieveProperities(p14.Start),
        EndProperities = RetrieveProperities(p14.End),
        Settings = p14:GetAttributes()
    };

    return setmetatable(v15, u1);
end;

function u1.SetFlipbook(p16: table, p17: userdata) -- Line: 74
    p16.__Flipbook = require(p17);
end;

function u1.RandomizeSize(p18: table, p19: vector, p20: vector) -- Line: 78
    if p18.Type == "SpecialMesh" then
        local EndProperities = p18.EndProperities;
        local math_random_ret = math.random(p19.X, p20.X);
        local math_random_ret2 = math.random(p19.Y, p20.Y);
        EndProperities.Scale = Vector3.new(math_random_ret, math_random_ret2, math.random(p19.Z, p20.Z));

        return;
    end;

    local EndProperities = p18.EndProperities;
    local math_random_ret = math.random(p19.X, p20.X);
    local math_random_ret2 = math.random(p19.Y, p20.Y);
    EndProperities.Size = Vector3.new(math_random_ret, math_random_ret2, math.random(p19.Z, p20.Z));
end;

function u1.PlayFlipbook(u21: table, u22: userdata) -- Line: 94
    -- upvalues: RunService (copy)
    local __Flipbook = u21.__Flipbook;

    if not __Flipbook then
        return;
    end;

    local u23 = 1;
    local u24 = 0;
    local u25 = nil;
    local u26 = 1 / (u21.Settings and (u21.Settings.FlipbookRate or 60) or 60);
    u25 = RunService.Heartbeat:Connect(function(p27) -- Line: 105
        -- upvalues: u24 (ref), u26 (copy), u23 (ref), __Flipbook (copy), u25 (ref), u21 (copy), u22 (copy)
        u24 = u24 + p27;

        if u26 <= u24 then
            u23 = u23 + 1;

            if u23 > #__Flipbook then
                u25:Disconnect();

                return;
            end;

            if u21.Type == "SpecialMesh" then
                local v28 = u22:FindFirstChildOfClass("Decal");

                if not v28 then
                    return;
                end;

                v28.Texture = __Flipbook[u23];
            else
                u22.TextureId = __Flipbook[u23];
            end;

            u24 = 0;
        end;
    end);
end;

local function computeSpawnCFrame(p29: any, p30: userdata?) -- Line: 126
    local v31 = typeof(p29) == "CFrame" and p29 and p29 or p29.CFrame;

    if p30 then
        local Attribute = p30:GetAttribute("Offset");

        if typeof(Attribute) == "Vector3" then
            v31 = v31 * CFrame.new(Attribute);
        end;
    end;

    return v31;
end;

function u1.Emit(u32, p33) -- Line: 138
    -- upvalues: Debris (copy), RotateMesh (copy), TweenService (copy)
    local Lifetime = u32.Settings.Lifetime;
    local v34 = Enum.EasingStyle[u32.Settings.EasingStyle];
    local v35 = Enum.EasingDirection[u32.Settings.EasingDirection];
    local v36 = u32.Settings.Transparency or 1;
    local v37 = u32.Settings.StartTransparency or 1;
    local RotationX = u32.Settings.RotationX;
    local v38 = not RotationX and 0 or math.random(RotationX.Min, RotationX.Max);
    local RotationY = u32.Settings.RotationY;
    local v39 = not RotationY and 0 or math.random(RotationY.Min, RotationY.Max);
    local RotationZ = u32.Settings.RotationZ;
    local v40 = not RotationZ and 0 or math.random(RotationZ.Min, RotationZ.Max);
    local TweenInfo_new_ret = TweenInfo.new(Lifetime, v34, v35);
    local u41 = u32.Model.Start:Clone();
    u32:PlayFlipbook(u41);
    local Model = u32.Model;
    local v42 = typeof(p33) == "CFrame" and p33 and p33 or p33.CFrame;

    if Model then
        local Attribute = Model:GetAttribute("Offset");

        if typeof(Attribute) == "Vector3" then
            v42 = v42 * CFrame.new(Attribute);
        end;
    end;

    u41.CFrame = v42 * CFrame.Angles(math.rad(v38), math.rad(v39), (math.rad(v40)));
    u41.Parent = workspace:FindFirstChild("Effects") or workspace;
    Debris:AddItem(u41, Lifetime);
    local v43 = u32.Model.Start.CFrame:ToObjectSpace(u32.Model.End.CFrame);
    u32.EndProperities.Position = nil;

    if u32.Settings.RotationSpeed then
        RotateMesh(u41, u32.Settings.RotationSpeed, Lifetime);
    end;

    if u32.Type == "SpecialMesh" then
        local u44 = u41:FindFirstChildOfClass("SpecialMesh");
        local v45 = u41:FindFirstChildOfClass("Decal");

        if u44 then
            local v46 = TweenService:Create(u44, TweenInfo_new_ret, u32.EndProperities);
            local v47 = TweenService:Create(u41, TweenInfo_new_ret, {
                CFrame = u41.CFrame * v43
            });
            v46:Play();
            v47:Play();
            v46.Completed:Once(function() -- Line: 175
                -- upvalues: u44 (copy), u32 (copy), u41 (copy)
                u44.Scale = u32.Properities.Scale or Vector3.new(1, 1, 1);
                u41.Transparency = 1;
            end);
        end;

        if v45 then
            v45.Transparency = v37;
            local TweenInfo_new_ret2 = TweenInfo.new(Lifetime, Enum.EasingStyle[u32.Settings.TransparencyEasingStyle], Enum.EasingDirection[u32.Settings.TransparencyEasingDirection]);
            local v48 = u32.Model.End:FindFirstChildOfClass("Decal");
            local v49 = {
                Transparency = v36
            };

            if v48 then
                v49.Color3 = v48.Color3;
            end;

            TweenService:Create(v45, TweenInfo_new_ret2, v49):Play();
        end;
    else
        u41.Transparency = v37;
        TweenInfo.new(Lifetime, Enum.EasingStyle[u32.Settings.TransparencyEasingStyle], Enum.EasingDirection[u32.Settings.TransparencyEasingDirection]);

        if u32.Settings.Movement then
            u32.EndProperities.CFrame = u41.CFrame * v43;
        end;

        u32.EndProperities.Transparency = v36;
        local v50 = TweenService:Create(u41, TweenInfo_new_ret, u32.EndProperities);
        v50:Play();
        v50.Completed:Once(function() -- Line: 206
            -- upvalues: u41 (copy), u32 (copy)
            u41.Size = u32.Properities.Size or Vector3.new(1, 1, 1);
            u41.Transparency = 1;
        end);
    end;
end;

function u1.EmitRate(u51: table, p52: number, p53: number, u54: any) -- Line: 213
    -- upvalues: RunService (copy)
    local u55 = p52 > 0 and 1 / p52 or (1 / 0);
    local u56 = 0;
    local u58 = RunService.Heartbeat:Connect(function(p57) -- Line: 216
        -- upvalues: u56 (ref), u55 (copy), u51 (copy), u54 (copy)
        u56 = u56 + p57;

        if u55 <= u56 then
            u56 = 0;
            u51:Emit(u54);
        end;
    end);
    task.delay(p53, function() -- Line: 223
        -- upvalues: u58 (copy)
        u58:Disconnect();
    end);
end;

function u1.EmitAt(p59, p60) -- Line: 229
    -- upvalues: u1 (copy)
    local v61 = u1.new(p60);
    local v62 = typeof(p59) == "CFrame" and p59 and p59 or p59.CFrame;

    if p60 then
        local Attribute = p60:GetAttribute("Offset");

        if typeof(Attribute) == "Vector3" then
            v62 = v62 * CFrame.new(Attribute);
        end;
    end;

    v61:Emit(v62);
end;

function u1.EnableAt(p63: number, p64: number, p65: any, p66: any) -- Line: 234
    -- upvalues: u1 (copy)
    local v67 = u1.new(p65);
    local v68 = typeof(p66) == "CFrame" and p66 and p66 or p66.CFrame;

    if p65 then
        local Attribute = p65:GetAttribute("Offset");

        if typeof(Attribute) == "Vector3" then
            v68 = v68 * CFrame.new(Attribute);
        end;
    end;

    v67:EmitRate(p63, p64, v68);
end;

return u1;