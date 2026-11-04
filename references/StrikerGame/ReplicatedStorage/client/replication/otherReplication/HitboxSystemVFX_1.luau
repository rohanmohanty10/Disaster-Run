 
 

shared.HitboxParts = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local HitboxCodec = require(ReplicatedStorage.util.HitboxCodec);
local packets = require(ReplicatedStorage.packets);
local Color3_fromRGB_ret = Color3.fromRGB(255, 70, 70);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(70, 140, 255);
local Color3_fromRGB_ret4 = Color3.fromRGB(70, 255, 120);
local shapes = HitboxCodec.shapes;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};
local u3 = nil;
local table_create_ret = table.create(512, 0);
local table_create_ret2 = table.create(512, Vector3.new(0, 0, 0));
local u4 = 0;
local u5 = 0;
local u6 = nil;
local u7 = nil;
local u8 = 0;
local u9 = Vector3.new(0, 0, 0);
local u10 = Vector3.new(0, 0, 0);
local u11 = nil;

local function isEnabled() -- Line: 60
    -- upvalues: LocalPlayer (copy)
    local setting = LocalPlayer:FindFirstChild("setting");
    local v12;

    if setting then
        v12 = setting:FindFirstChild("showHitboxes");
    else
        v12 = nil;
    end;

    local v13;

    if v12 == nil then
        v13 = false;
    else
        v13 = v12:IsA("BoolValue") and v12.Value;
    end;

    return v13;
end;

local function isDebugTest() -- Line: 66
    -- upvalues: ReplicatedStorage (copy)
    local debugTest = ReplicatedStorage:FindFirstChild("debugTest");
    local v14;

    if debugTest == nil then
        v14 = false;
    else
        v14 = debugTest:IsA("BoolValue") and debugTest.Value;
    end;

    return v14;
end;

local function getFolder() -- Line: 71
    -- upvalues: u3 (ref)
    local v15 = u3;

    if v15 and v15.Parent then
        return v15;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "HitboxVisuals";
    Folder.Parent = workspace:FindFirstChild("Effects") or workspace;
    u3 = Folder;

    return Folder;
end;

local function createPart(p16: number) -- Line: 83
    -- upvalues: shapes (copy)
    local v17;

    if p16 == shapes.wedge then
        v17 = Instance.new("WedgePart");
    else
        v17 = Instance.new("Part");

        if p16 == shapes.sphere then
            v17.Shape = Enum.PartType.Ball;
        elseif p16 == shapes.cylinder then
            v17.Shape = Enum.PartType.Cylinder;
        end;
    end;

    v17.Anchored = true;
    v17.CanCollide = false;
    v17.CanQuery = false;
    v17.CanTouch = false;
    v17.CastShadow = false;
    v17.Material = Enum.Material.ForceField;
    v17.Transparency = 0.6;

    return v17;
end;

local function acquire(p18: number) -- Line: 106
    -- upvalues: u1 (copy), createPart (copy)
    local v19 = u1[p18];

    return v19 and table.remove(v19) or createPart(p18);
end;

local function release(p20: number, p21: userdata) -- Line: 117
    -- upvalues: u1 (copy)
    p21.Parent = nil;
    local v22 = u1[p20];

    if not v22 then
        v22 = {};
        u1[p20] = v22;
    end;

    table.insert(v22, p21);
end;

local function show(p23: number, p24, p25: vector, p26) -- Line: 127
    -- upvalues: u1 (copy), createPart (copy), u3 (ref), release (copy)
    local v27 = u1[p23];
    local v28 = v27 and table.remove(v27) or createPart(p23);
    v28.Size = p25;
    v28.CFrame = p24;
    v28.Color = p26;
    local v29 = u3;

    if not (v29 and v29.Parent) then
        v29 = Instance.new("Folder");
        v29.Name = "HitboxVisuals";
        v29.Parent = workspace:FindFirstChild("Effects") or workspace;
        u3 = v29;
    end;

    v28.Parent = v29;
    task.delay(0.35, release, p23, v28);
end;

local function showCone(p30, p31: number, p32: number, p33) -- Line: 136
    -- upvalues: shapes (copy), u1 (copy), createPart (copy), u3 (ref), release (copy)
    local math_rad_ret = math.rad(p32 / 2);
    local Position = p30.Position;

    for i = 0, 18 do
        local v34 = (i / 18 - 0.5) * 2 * math_rad_ret;
        local v35 = Position + (p30.LookVector * math.cos(v34) + p30.RightVector * math.sin(v34)).Unit * p31;
        local box = shapes.box;
        local v36 = CFrame.lookAt(Position, v35) * CFrame.new(0, 0, -p31 / 2);
        local Vector3_new_ret = Vector3.new(0.05, 0.05, p31);
        local v37 = u1[box];
        local v38 = v37 and table.remove(v37) or createPart(box);
        v38.Size = Vector3_new_ret;
        v38.CFrame = v36;
        v38.Color = p33;
        local v39 = u3;

        if not (v39 and v39.Parent) then
            v39 = Instance.new("Folder");
            v39.Name = "HitboxVisuals";
            v39.Parent = workspace:FindFirstChild("Effects") or workspace;
            u3 = v39;
        end;

        v38.Parent = v39;
        task.delay(0.35, release, box, v38);
        local _ = i;
    end;
end;

local function onCast(p40: buffer) -- Line: 147
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), HitboxCodec (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), shapes (copy), showCone (copy), u1 (copy), createPart (copy), u3 (ref), release (copy), Color3_fromRGB_ret3 (copy)
    local setting = LocalPlayer:FindFirstChild("setting");
    local v41;

    if setting then
        v41 = setting:FindFirstChild("showHitboxes");
    else
        v41 = nil;
    end;

    local v42;

    if v41 == nil then
        v42 = false;
    else
        v42 = v41:IsA("BoolValue") and v41.Value;
    end;

    if v42 then
        local debugTest = ReplicatedStorage:FindFirstChild("debugTest");
        local v43;

        if debugTest == nil then
            v43 = false;
        else
            v43 = debugTest:IsA("BoolValue") and debugTest.Value;
        end;

        if not v43 then
            for _, v in HitboxCodec.decode(p40) do
                local v44;

                if v.hit then
                    v44 = Color3_fromRGB_ret;
                else
                    v44 = Color3_fromRGB_ret2;
                end;

                if v.shape == shapes.cone then
                    showCone(v.cframe, v.size.X, v.size.Y, v44);
                else
                    local shape = v.shape;
                    local cframe = v.cframe;
                    local size = v.size;
                    local v45 = u1[shape];
                    local v46 = v45 and table.remove(v45) or createPart(shape);
                    v46.Size = size;
                    v46.CFrame = cframe;
                    v46.Color = v44;
                    local v47 = u3;

                    if not (v47 and v47.Parent) then
                        v47 = Instance.new("Folder");
                        v47.Name = "HitboxVisuals";
                        v47.Parent = workspace:FindFirstChild("Effects") or workspace;
                        u3 = v47;
                    end;

                    v46.Parent = v47;
                    task.delay(0.35, release, shape, v46);
                end;

                for _, v2 in v.hurtboxes do
                    local box = shapes.box;
                    local cframe = v2.cframe;
                    local size = v2.size;
                    local v48 = u1[box];
                    local v49 = v48 and table.remove(v48) or createPart(box);
                    v49.Size = size;
                    v49.CFrame = cframe;
                    v49.Color = Color3_fromRGB_ret3;
                    local v50 = u3;

                    if not (v50 and v50.Parent) then
                        v50 = Instance.new("Folder");
                        v50.Name = "HitboxVisuals";
                        v50.Parent = workspace:FindFirstChild("Effects") or workspace;
                        u3 = v50;
                    end;

                    v49.Parent = v50;
                    task.delay(0.35, release, box, v49);
                end;
            end;
        end;
    end;
end;

local function removeLive(p51: number) -- Line: 165
    -- upvalues: u2 (copy), shapes (copy), u1 (copy)
    local v52 = u2[p51];

    if v52 then
        u2[p51] = nil;
        v52.part.Transparency = 0.6;
        local box = shapes.box;
        local part = v52.part;
        part.Parent = nil;
        local v53 = u1[box];

        if not v53 then
            v53 = {};
            u1[box] = v53;
        end;

        table.insert(v53, part);
    end;
end;

local function getRoot() -- Line: 174
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local v54 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");

    if v54 and v54:IsA("BasePart") then
        return v54;
    end;

    return nil;
end;

local function resetHistory(p55: userdata?) -- Line: 186
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref), u9 (ref), u10 (ref), u11 (ref), u2 (copy)
    u4 = 0;
    u5 = 0;
    u6 = p55;
    u7 = nil;
    u9 = Vector3.new(0, 0, 0);
    u10 = Vector3.new(0, 0, 0);
    u11 = nil;

    for _, v in u2 do
        v.anchor = nil;
    end;
end;

local function recordHistory() -- Line: 199
    -- upvalues: LocalPlayer (copy), u6 (ref), u4 (ref), u5 (ref), u7 (ref), u9 (ref), u10 (ref), u11 (ref), u2 (copy), u8 (ref), table_create_ret (copy), table_create_ret2 (copy)
    local Character = LocalPlayer.Character;
    local v56;

    if Character then
        v56 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");

        if not (v56 and v56:IsA("BasePart")) then
            v56 = nil;
        end;
    else
        v56 = nil;
    end;

    if v56 ~= u6 then
        u4 = 0;
        u5 = 0;
        u6 = v56;
        u7 = nil;
        u9 = Vector3.new(0, 0, 0);
        u10 = Vector3.new(0, 0, 0);
        u11 = nil;

        for _, v in u2 do
            v.anchor = nil;
        end;
    end;

    if not v56 then
        return;
    end;

    local os_clock_ret = os.clock();
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Position = v56.Position;
    local v57 = u7;

    if v57 then
        local v58 = os_clock_ret - u8;
        local v59 = Position - v57;
        local Magnitude = v59.Magnitude;

        if Magnitude > 4 and 600 * v58 < Magnitude then
            u10 = u10 + (v59 - u9 * v58);
        elseif v58 > 0 then
            u9 = v59 / v58;
        end;
    end;

    u7 = Position;
    u8 = os_clock_ret;
    local v60 = Position - u10;
    u11 = v60;

    if u5 > 0 then
        local v61 = ServerTimeNow - table_create_ret[u4];

        if v61 > 0.25 or v61 < -0.004166666666666667 then
            u5 = 0;
        elseif v61 < 0.004166666666666667 then
            return;
        end;
    end;

    u4 = u4 % 512 + 1;
    u5 = math.min(u5 + 1, 512);
    table_create_ret[u4] = ServerTimeNow;
    table_create_ret2[u4] = v60;
end;

local function pathAt(p62: number) -- Line: 239
    -- upvalues: u5 (ref), u4 (ref), table_create_ret (copy), table_create_ret2 (copy)
    if u5 == 0 then
        return nil;
    end;

    local v63 = u4;
    local v64 = table_create_ret[v63];
    local v65 = table_create_ret2[v63];

    if v64 <= p62 then
        return v65;
    end;

    for i = 2, u5 do
        v63 = v63 == 1 and 512 or v63 - 1;
        local v66 = table_create_ret[v63];
        local v67 = table_create_ret2[v63];

        if v66 <= p62 then
            return v67:Lerp(v65, (p62 - v66) / (v64 - v66));
        end;

        v64 = v66;
        v65 = v67;
        local _ = i;
    end;

    return nil;
end;

local function getOwnCFrame(p68: table) -- Line: 262
    -- upvalues: u11 (ref)
    local anchor = p68.anchor;
    local v69 = u11;

    if anchor and v69 then
        return p68.to + (v69 - anchor);
    end;

    return p68.to;
end;

local function onLive(p70: buffer) -- Line: 271
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), u2 (copy), shapes (copy), u1 (copy), HitboxCodec (copy), createPart (copy), u3 (ref), pathAt (copy), u11 (ref), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret3 (copy)
    local setting = LocalPlayer:FindFirstChild("setting");
    local v71;

    if setting then
        v71 = setting:FindFirstChild("showHitboxes");
    else
        v71 = nil;
    end;

    local v72;

    if v71 == nil then
        v72 = false;
    else
        v72 = v71:IsA("BoolValue") and v71.Value;
    end;

    if not v72 then
        local debugTest = ReplicatedStorage:FindFirstChild("debugTest");
        local v73;

        if debugTest == nil then
            v73 = false;
        else
            v73 = debugTest:IsA("BoolValue") and debugTest.Value;
        end;

        if not v73 then
            for i in u2 do
                local v74 = u2[i];

                if v74 then
                    u2[i] = nil;
                    v74.part.Transparency = 0.6;
                    local box = shapes.box;
                    local part = v74.part;
                    part.Parent = nil;
                    local v75 = u1[box];

                    if not v75 then
                        v75 = {};
                        u1[box] = v75;
                    end;

                    table.insert(v75, part);
                end;
            end;

            return;
        end;
    end;

    local os_clock_ret = os.clock();

    for _, v in HitboxCodec.decodeFrames(p70) do
        local v76 = u2[v.id];

        if v76 and v.own then
            v76.from = v.cframe;
            v76.to = v.cframe;
            v76.start = os_clock_ret;
        elseif v76 then
            v76.interval = math.clamp(v76.interval + (os_clock_ret - v76.seen - v76.interval) * 0.2, 0.004166666666666667, 0.2);
            v76.from = v76.part.CFrame;
            v76.to = v.cframe;
            v76.start = os_clock_ret;
        else
            local box = shapes.box;
            local v77 = u1[box];
            local v78 = v77 and table.remove(v77) or createPart(box);
            v78.Transparency = 0.75;
            v78.CFrame = v.cframe;
            local v79 = u3;

            if not (v79 and v79.Parent) then
                v79 = Instance.new("Folder");
                v79.Name = "HitboxVisuals";
                v79.Parent = workspace:FindFirstChild("Effects") or workspace;
                u3 = v79;
            end;

            v78.Parent = v79;
            v78.Name = tostring(v.id);
            v76 = {
                interval = 0.03333333333333333,
                anchor = nil,
                part = v78,
                seen = os_clock_ret,
                from = v.cframe,
                to = v.cframe,
                start = os_clock_ret,
                own = v.own
            };
            u2[v.id] = v76;
        end;

        local time = v.time;
        v76.seen = os_clock_ret;
        v76.own = v.own;
        local v80;

        if v.own and time then
            v80 = pathAt(time);
        else
            v80 = nil;
        end;

        v76.anchor = v80;

        if v.own then
            local anchor = v76.anchor;
            local v81 = u11;
            local v82;

            if anchor and v81 then
                v82 = v76.to + (v81 - anchor);
            else
                v82 = v76.to;
            end;

            v76.part.CFrame = v82;
        end;

        v76.part.Size = v.size;
        local v83;

        if v.own then
            v83 = Color3_fromRGB_ret4;
        else
            v83 = Color3_fromRGB_ret3;
        end;

        v76.part.Color = v83;
    end;
end;

local function renderLive() -- Line: 326
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), recordHistory (copy), u2 (copy), shapes (copy), u1 (copy), u11 (ref)
    local setting = LocalPlayer:FindFirstChild("setting");
    local v84;

    if setting then
        v84 = setting:FindFirstChild("showHitboxes");
    else
        v84 = nil;
    end;

    local v85;

    if v84 == nil then
        v85 = false;
    else
        v85 = v84:IsA("BoolValue") and v84.Value;
    end;

    if v85 then
        recordHistory();
    else
        local debugTest = ReplicatedStorage:FindFirstChild("debugTest");
        local v86;

        if debugTest == nil then
            v86 = false;
        else
            v86 = debugTest:IsA("BoolValue") and debugTest.Value;
        end;

        if v86 then
            recordHistory();
        end;
    end;

    if not next(u2) then
        return;
    end;

    local os_clock_ret = os.clock();

    for i, v in u2 do
        if os_clock_ret - v.seen > 0.3 then
            local v87 = u2[i];

            if v87 then
                u2[i] = nil;
                v87.part.Transparency = 0.6;
                local box = shapes.box;
                local part = v87.part;
                part.Parent = nil;
                local v88 = u1[box];

                if not v88 then
                    v88 = {};
                    u1[box] = v88;
                end;

                table.insert(v88, part);
            end;
        elseif v.own then
            local anchor = v.anchor;
            local v89 = u11;
            local v90;

            if anchor and v89 then
                v90 = v.to + (v89 - anchor);
            else
                v90 = v.to;
            end;

            v.part.CFrame = v90;
        else
            local math_clamp_ret = math.clamp((os_clock_ret - v.start) / v.interval, 0, 1);
            v.part.CFrame = v.from:Lerp(v.to, math_clamp_ret);
        end;
    end;
end;

if RunService:IsClient() then
    packets.bytenet_hitboxCast.listen(onCast);
    packets.bytenet_hitboxLive.listen(onLive);
    packets.bytenet_hitboxPing.listen(function(p91: number) -- Line: 351
        -- upvalues: packets (copy)
        packets.bytenet_hitboxPing.send(p91);
    end);
    RunService.RenderStepped:Connect(renderLive);
end;

return {};