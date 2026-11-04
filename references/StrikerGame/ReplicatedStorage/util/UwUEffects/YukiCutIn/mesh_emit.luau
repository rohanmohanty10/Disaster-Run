 

 

local u1 = {};
u1.__index = u1;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(script.Types);

local function GetType(p2) -- Line: 8
    return p2.Start:IsA("Part") and p2.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh";
end;

local function GetPartType(p3: userdata) -- Line: 17
    return p3:IsA("Part") and p3:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh";
end;

local function RetrieveSettings(p4) -- Line: 29
    return p4:GetAttributes();
end;

local function RotateMesh(u5: userdata, u6: number, p7: number) -- Line: 33
    -- upvalues: RunService (copy)
    local u10 = RunService.Heartbeat:Connect(function(p8) -- Line: 36
        -- upvalues: u5 (copy), u6 (copy)
        local v9 = u5;
        v9.CFrame = v9.CFrame * CFrame.Angles(0, math.rad(u6), 0);
    end);
    task.delay(p7, function() -- Line: 39
        -- upvalues: u10 (copy)
        u10:Disconnect();
    end);
end;

local function GenerateInRange(p11) -- Line: 45
    return not p11 and 0 or math.random(p11.Min, p11.Max);
end;

local function RetrieveProperities(p12: userdata) -- Line: 52
    local v13 = {};

    if (p12:IsA("Part") and p12:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh") == "SpecialMesh" then
        local v14 = p12:FindFirstChildOfClass("SpecialMesh");

        if not v14 then
            return {};
        end;

        v13.Scale = v14.Scale;
    else
        v13.Size = p12.Size;
    end;

    v13.Position = p12.CFrame.Position;

    return v13;
end;

function u1.new(p15) -- Line: 67
    -- upvalues: RetrieveProperities (copy), u1 (copy)
    local v16 = {
        Model = p15,
        Type = p15.Start:IsA("Part") and p15.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh",
        Properities = RetrieveProperities(p15.Start),
        EndProperities = RetrieveProperities(p15.End),
        Settings = p15:GetAttributes()
    };

    return setmetatable(v16, u1);
end;

function u1.SetFlipbook(p17: table, p18: userdata) -- Line: 78
    p17.__Flipbook = require(p18);
end;

function u1.RandomizeSize(p19: table, p20: vector, p21: vector) -- Line: 82
    if p19.Type == "SpecialMesh" then
        local EndProperities = p19.EndProperities;
        local math_random_ret = math.random(p20.X, p21.X);
        local math_random_ret2 = math.random(p20.Y, p21.Y);
        EndProperities.Scale = Vector3.new(math_random_ret, math_random_ret2, math.random(p20.Z, p21.Z));

        return;
    end;

    local EndProperities = p19.EndProperities;
    local math_random_ret = math.random(p20.X, p21.X);
    local math_random_ret2 = math.random(p20.Y, p21.Y);
    EndProperities.Size = Vector3.new(math_random_ret, math_random_ret2, math.random(p20.Z, p21.Z));
end;

function u1.PlayFlipbook(u22: table, u23: userdata) -- Line: 90
    -- upvalues: RunService (copy)
    local __Flipbook = u22.__Flipbook;

    if not __Flipbook then
        return;
    end;

    local u24 = 1;
    local u25 = 0;
    local u26 = nil;
    u26 = RunService.Heartbeat:Connect(function(p27) -- Line: 96
        -- upvalues: u25 (ref), u22 (copy), u24 (ref), __Flipbook (copy), u26 (ref), u23 (copy)
        u25 = u25 + p27;

        if u25 >= (1 / u22.Settings.FlipbookRate or 0.016666666666666666) then
            u24 = u24 + 1;

            if u24 > #__Flipbook then
                u26:Disconnect();

                return;
            end;

            if u22.Type == "SpecialMesh" then
                local v28 = u23:FindFirstChildOfClass("Decal");

                if not v28 then
                    return;
                end;

                v28.Texture = __Flipbook[u24];
            else
                u23.TextureId = __Flipbook[u24];
            end;

            u25 = 0;
        end;
    end);
end;

function u1.Emit(u29, p30) -- Line: 115
    -- upvalues: Debris (copy), RotateMesh (copy), TweenService (copy)
    local Lifetime = u29.Settings.Lifetime;
    local v31 = Enum.EasingStyle[u29.Settings.EasingStyle];
    local v32 = Enum.EasingDirection[u29.Settings.EasingDirection];
    local v33 = u29.Settings.Transparency or 1;
    local v34 = u29.Settings.StartTransparency or 1;
    local RotationX = u29.Settings.RotationX;
    local v35 = not RotationX and 0 or math.random(RotationX.Min, RotationX.Max);
    local RotationY = u29.Settings.RotationY;
    local v36 = not RotationY and 0 or math.random(RotationY.Min, RotationY.Max);
    local RotationZ = u29.Settings.RotationZ;
    local v37 = not RotationZ and 0 or math.random(RotationZ.Min, RotationZ.Max);
    local TweenInfo_new_ret = TweenInfo.new(Lifetime, v31, v32);
    local u38 = u29.Model.Start:Clone();
    u29:PlayFlipbook(u38);
    u38.CFrame = (typeof(p30) == "CFrame" and p30 and p30 or p30.CFrame) * CFrame.Angles(math.rad(v35), math.rad(v36), (math.rad(v37)));
    u38.Parent = workspace.Effects;
    Debris:AddItem(u38, Lifetime);
    local v39 = u29.Model.Start.CFrame:ToObjectSpace(u29.Model.End.CFrame);
    u29.EndProperities.Position = nil;

    if u29.Settings.RotationSpeed then
        RotateMesh(u38, u29.Settings.RotationSpeed, Lifetime);
    end;

    if u29.Type == "SpecialMesh" then
        local u40 = u38:FindFirstChildOfClass("SpecialMesh");
        local v41 = u38:FindFirstChildOfClass("Decal");

        if u40 then
            local v42 = TweenService:Create(u40, TweenInfo_new_ret, u29.EndProperities);
            local v43 = TweenService:Create(u38, TweenInfo_new_ret, {
                CFrame = u38.CFrame * v39
            });
            v42:Play();
            v43:Play();
            v42.Completed:Once(function() -- Line: 154
                -- upvalues: u40 (copy), u29 (copy), u38 (copy)
                u40.Scale = u29.Properities.Scale or Vector3.new(1, 1, 1);
                u38.Transparency = 1;
            end);
        end;

        if v41 then
            v41.Transparency = v34;
            TweenService:Create(v41, TweenInfo.new(Lifetime, Enum.EasingStyle[u29.Settings.TransparencyEasingStyle], Enum.EasingDirection[u29.Settings.TransparencyEasingDirection]), {
                Transparency = v33,
                Color3 = u29.Model.End:FindFirstChildOfClass("Decal").Color3
            }):Play();
        end;
    else
        u38.Transparency = v34;
        TweenInfo.new(Lifetime, Enum.EasingStyle[u29.Settings.TransparencyEasingStyle], Enum.EasingDirection[u29.Settings.TransparencyEasingDirection]);

        if u29.Settings.Movement then
            u29.EndProperities.CFrame = u38.CFrame * v39;
        end;

        u29.EndProperities.Transparency = v33;
        local v44 = TweenService:Create(u38, TweenInfo_new_ret, u29.EndProperities);
        v44:Play();
        v44.Completed:Once(function() -- Line: 177
            -- upvalues: u38 (copy), u29 (copy)
            u38.Size = u29.Properities.Size or Vector3.new(1, 1, 1);
            u38.Transparency = 1;
        end);
    end;
end;

function u1.EmitRate(u45: table, u46: number, p47: number, u48: any) -- Line: 184
    -- upvalues: RunService (copy)
    local u49 = 0;
    local u51 = RunService.Heartbeat:Connect(function(p50) -- Line: 186
        -- upvalues: u49 (ref), u46 (copy), u45 (copy), u48 (copy)
        u49 = u49 + p50;

        if u49 > u46 / 60 then
            u49 = 0;
            u45:Emit(u48);
        end;
    end);
    task.delay(p47, function() -- Line: 193
        -- upvalues: u51 (copy)
        u51:Disconnect();
    end);
end;

return u1;