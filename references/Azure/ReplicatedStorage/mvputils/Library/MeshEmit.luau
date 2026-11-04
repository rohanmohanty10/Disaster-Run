 

 

local u1 = {};
u1.__index = u1;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local BeamEmit = require(script.Parent.BeamEmit);
require(script.Types);

local function GetType(p2) -- Line: 10
    return p2.Start:IsA("Part") and p2.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh";
end;

local function GetPartType(p3: userdata) -- Line: 19
    return p3:IsA("Part") and p3:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh";
end;

local function RetrieveSettings(p4) -- Line: 31
    return p4:GetAttributes();
end;

local function RotateMesh(u5: userdata, u6: number, p7: number) -- Line: 35
    -- upvalues: RunService (copy)
    local u10 = RunService.Heartbeat:Connect(function(p8) -- Line: 37
        -- upvalues: u5 (copy), u6 (copy)
        local v9 = u5;
        v9.CFrame = v9.CFrame * CFrame.Angles(0, math.rad(u6), 0);
    end);
    task.delay(p7, function() -- Line: 40
        -- upvalues: u10 (copy)
        u10:Disconnect();
    end);
end;

local function GenerateInRange(p11) -- Line: 46
    return not p11 and 0 or math.random(p11.Min, p11.Max);
end;

local function RetrieveProperities(p12: userdata) -- Line: 53
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

function u1.new(p15) -- Line: 68
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

function u1.SetFlipbook(p17: table, p18: userdata) -- Line: 79
    p17.__Flipbook = require(p18);
end;

function u1.RandomizeSize(p19: table, p20: vector, p21: vector) -- Line: 83
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

function u1.PlayFlipbook(u22: table, u23: userdata) -- Line: 91
    -- upvalues: RunService (copy)
    local __Flipbook = u22.__Flipbook;

    if not __Flipbook then
        return;
    end;

    local u24 = 1;
    local u25 = 0;
    local u26 = nil;
    u26 = RunService.Heartbeat:Connect(function(p27) -- Line: 97
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

function u1.QuickEmit(p29: table, p30: userdata, p31: any) -- Line: 115
    -- upvalues: BeamEmit (copy), u1 (copy)
    if not p30:FindFirstChildWhichIsA("Beam", true) then
        if p30:IsA("Model") then
            local v32 = u1.new(p30);
            v32:Emit(p31);

            if p30:GetAttribute("Duration") and p30:GetAttribute("Rate") then
                v32:EmitRate(p30:GetAttribute("Rate"), p30:GetAttribute("Duration"), p31);
            end;

            return v32;
        end;

        warn(p30.Name .. " Is Not A Mesh Model");

        return;
    end;

    local Attribute = p30:GetAttribute("RotationX");
    local v33 = not Attribute and 0 or math.random(Attribute.Min, Attribute.Max);
    local Attribute2 = p30:GetAttribute("RotationY");
    local v34 = not Attribute2 and 0 or math.random(Attribute2.Min, Attribute2.Max);
    local Attribute3 = p30:GetAttribute("RotationZ");
    local v35 = not Attribute3 and 0 or math.random(Attribute3.Min, Attribute3.Max);
    p30.CFrame = (typeof(p31) == "CFrame" and p31 and p31 or p31.CFrame) * CFrame.new(p30:GetAttribute("Offset")) * CFrame.Angles(math.rad(v33), math.rad(v34), (math.rad(v35)));
    BeamEmit(p30, {
        Properties = {
            Brightness = p30:GetAttribute("Brightness"),
            LightEmission = p30:GetAttribute("LightEmission", 1),
            TextureSpeed = p30:GetAttribute("TextureSpeed", 0.45),
            Width0 = p30:GetAttribute("Width0", 2),
            Width1 = p30:GetAttribute("Width", 15)
        },
        RotationSpeed = p30:GetAttribute("RotationSpeed"),
        Rotation = p30:GetAttribute("Rotation"),
        Offset = p30:GetAttribute("FinalOffset"),
        Duration = p30:GetAttribute("Duration"),
        Easing = p30:GetAttribute("Easing"),
        EasingDirection = p30:GetAttribute("EasingDirection")
    });
end;

function u1.GroupEmit(p36: table, p37: userdata, p38: any) -- Line: 150
    for _, child in p37:GetChildren() do
        p36:QuickEmit(child, p38);
    end;
end;

function u1.Emit(p39, p40) -- Line: 156
    -- upvalues: Debris (copy), RotateMesh (copy), TweenService (copy)
    local Lifetime = p39.Settings.Lifetime;
    local v41 = Enum.EasingStyle[p39.Settings.EasingStyle];
    local v42 = Enum.EasingDirection[p39.Settings.EasingDirection];
    local v43 = p39.Settings.Transparency or 1;
    local v44 = p39.Settings.StartTransparency or 1;
    local RotationX = p39.Settings.RotationX;
    local v45 = not RotationX and 0 or math.random(RotationX.Min, RotationX.Max);
    local RotationY = p39.Settings.RotationY;
    local v46 = not RotationY and 0 or math.random(RotationY.Min, RotationY.Max);
    local RotationZ = p39.Settings.RotationZ;
    local v47 = not RotationZ and 0 or math.random(RotationZ.Min, RotationZ.Max);
    local TweenInfo_new_ret = TweenInfo.new(Lifetime, v41, v42);
    local u48 = p39.Model.Start:Clone();
    p39:PlayFlipbook(u48);
    u48.CFrame = (typeof(p40) == "CFrame" and p40 and p40 or p40.CFrame) * CFrame.new(p39.Model:GetAttribute("Offset")) * CFrame.Angles(math.rad(v45), math.rad(v46), (math.rad(v47)));
    u48.Parent = workspace:FindFirstChild("Ignore") or workspace.Effects;
    Debris:AddItem(u48, Lifetime);
    local v49 = p39.Model.Start.CFrame:ToObjectSpace(p39.Model.End.CFrame);
    p39.EndProperities.Position = nil;

    if p39.Settings.RotationSpeed then
        RotateMesh(u48, p39.Settings.RotationSpeed, Lifetime);
    end;

    local Attribute = p39.Model:GetAttribute("FlipbookTexture");

    if Attribute then
        p39:SetFlipbook(p39.Model[Attribute]);
        p39:PlayFlipbook(u48);
    end;

    if p39.Type == "SpecialMesh" then
        local v50 = u48:FindFirstChildOfClass("SpecialMesh");
        local v51 = u48:FindFirstChildOfClass("Decal");

        if v50 then
            local v52 = TweenService:Create(v50, TweenInfo_new_ret, p39.EndProperities);
            local v53 = TweenService:Create(u48, TweenInfo_new_ret, {
                CFrame = u48.CFrame * v49
            });
            v52:Play();
            v53:Play();
            v52.Completed:Once(function() -- Line: 199
                -- upvalues: u48 (copy)
                u48.Transparency = 1;
            end);
        end;

        if v51 then
            v51.Transparency = v44;
            TweenService:Create(v51, TweenInfo.new(Lifetime, Enum.EasingStyle[p39.Settings.TransparencyEasingStyle], Enum.EasingDirection[p39.Settings.TransparencyEasingDirection]), {
                Transparency = v43,
                Color3 = p39.Model.End:FindFirstChildOfClass("Decal").Color3
            }):Play();
        end;
    else
        u48.Transparency = v44;
        TweenInfo.new(Lifetime, Enum.EasingStyle[p39.Settings.TransparencyEasingStyle], Enum.EasingDirection[p39.Settings.TransparencyEasingDirection]);

        if p39.Settings.Movement then
            p39.EndProperities.CFrame = u48.CFrame * v49;
        end;

        p39.EndProperities.Transparency = v43;
        local v54 = TweenService:Create(u48, TweenInfo_new_ret, p39.EndProperities);
        v54:Play();
        v54.Completed:Once(function() -- Line: 222
            -- upvalues: u48 (copy)
            u48.Transparency = 1;
        end);
    end;
end;

function u1.Stop(p55) -- Line: 229
    p55.EmitStopped = true;
end;

function u1.EmitRate(u56: table, u57: number, p58: number, u59: any) -- Line: 233
    -- upvalues: RunService (copy)
    local u60 = 0;
    local u61 = nil;
    u61 = RunService.Heartbeat:Connect(function(p62) -- Line: 236
        -- upvalues: u56 (copy), u61 (ref), u60 (ref), u57 (copy), u59 (copy)
        if u56.EmitStopped then
            u61:Disconnect();
            u61 = nil;

            return;
        end;

        u60 = u60 + p62;

        if u60 > u57 / 60 then
            u60 = 0;

            if typeof(u59) == "Instance" then
                u56:Emit(u59.CFrame);

                return;
            end;

            u56:Emit(u59);
        end;
    end);
    task.delay(p58, function() -- Line: 248
        -- upvalues: u61 (ref)
        if not u61 then
            return;
        end;

        u61:Disconnect();
    end);
end;

return u1;