 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = {};

local function ClearZone(p2, u3) -- Line: 13
    -- upvalues: u1 (copy)
    if not p2 then
        return;
    end;

    if not p2 then
        if u1[p2].Connect then
            u1[p2].Connect:Disconnect();
        end;

        if u1[p2].Spin then
            u1[p2].Spin:Destroy();
        end;

        if u1[p2].Meshes then
            for _, v in u1[p2].Meshes do
                v:Destroy();
            end;

            u1[p2].Meshes = nil;
        end;

        table.clear(u1[p2]);
        u1[p2] = nil;

        return;
    end;

    local v4 = u1[p2];

    if not v4 then
        return;
    end;

    if u1[p2].Connect then
        u1[p2].Connect:Disconnect();
    end;

    if u1[p2].Spin then
        u1[p2].Spin:Destroy();
    end;

    if u1[p2].Connect then
        u1[p2].Connect = nil;
    end;

    if u1[p2].Spin then
        u1[p2].Spin = nil;
    end;

    if u1[p2].Meshes then
        for _, v in u1[p2].Meshes do
            v:Destroy();
        end;

        u1[p2].Meshes = nil;
    end;

    local Random_new_ret = Random.new();

    for _, v in v4 do
        if v then
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                local Keypoints = v.Transparency.Keypoints;
                task.spawn(function() -- Line: 51
                    -- upvalues: u3 (copy), Random_new_ret (copy), Keypoints (copy), v (copy)
                    if u3 then
                        if v and u3 then
                            v:Destroy();
                        end;

                        return;
                    end;

                    task.wait(Random_new_ret:NextNumber(0.3, 1.5));

                    for i = 0, 1, 0.05 do
                        local v5 = i;
                        local v6 = {};

                        for i2, v2 in Keypoints do
                            v6[i2] = NumberSequenceKeypoint.new(v2.Time, v2.Value + v5, v2.Envelope);
                        end;

                        v.Transparency = NumberSequence.new(v6);
                        task.wait(0.07);
                    end;

                    v.Transparency = NumberSequence.new(1);
                end);
            end;

            if u3 then
                if v then
                    v:Destroy();
                end;
            else
                task.delay(4, function() -- Line: 69
                    -- upvalues: v (copy)
                    if v then
                        v:Destroy();
                    end;
                end);
            end;
        end;
    end;

    if u1[p2].Connect then
        u1[p2].Connect:Disconnect();
    end;

    table.clear(u1[p2]);
    u1[p2] = nil;
end;

local function ClearRemovedZones() -- Line: 88
    -- upvalues: u1 (copy), ClearZone (copy)
    for i in u1 do
        if not i.Parent then
            ClearZone(i, true);
        end;
    end;
end;

local function colorCorrection(p7: table, p8: any, p9: any) -- Line: 96
    -- upvalues: Zones (copy)
    if not p8 then
        return;
    end;

    if table.find(Zones.NoColorChange, p9) then
        return;
    end;

    for i, v in p7 do
        if type(v) ~= "table" and i ~= "Connect" then
            if v:IsA("ParticleEmitter") then
                local Color = v.Color;
                local v10 = {};

                for i2 = 1, #Color.Keypoints do
                    local v11 = Color.Keypoints[i2];
                    local _ = v11.Value;
                    table.insert(v10, ColorSequenceKeypoint.new(v11.Time, v11.Value:Lerp(p8, 1)));
                    local _ = i2;
                end;

                v.Color = ColorSequence.new(v10);
            elseif v:IsA("Trail") then
                local Color = v.Color;
                local v12 = {};

                for i2 = 1, #Color.Keypoints do
                    local v13 = Color.Keypoints[i2];
                    local _ = v13.Value;
                    table.insert(v12, ColorSequenceKeypoint.new(v13.Time, v13.Value:Lerp(p8, 1)));
                    local _ = i2;
                end;

                v.Color = ColorSequence.new(v12);
            elseif v:IsA("Beam") then
                local Color = v.Color;
                local v14 = {};

                for i2 = 1, #Color.Keypoints do
                    local v15 = Color.Keypoints[i2];
                    local _ = v15.Value;
                    table.insert(v14, ColorSequenceKeypoint.new(v15.Time, p8));
                    local _ = i2;
                end;

                v.Color = ColorSequence.new(v14);
            end;
        end;
    end;
end;

local function EmitZone(p16, p17, p18) -- Line: 140
    -- upvalues: ReplicatedStorage (copy), colorCorrection (copy), VfxManager (copy)
    if not p16 then
        return;
    end;

    if not p16 then
        return;
    end;

    print("emit zone", p17);
    local v19 = ReplicatedStorage.Assets.Zones:FindFirstChild(p17);

    if not v19 then
        return;
    end;

    local Emit = v19:FindFirstChild("Emit");

    if not Emit then
        return;
    end;

    local u20 = Emit:Clone();

    if p18 then
        colorCorrection(u20:GetDescendants(), p18, p17);
    end;

    for _, child in u20:GetChildren() do
        local v21 = p16:FindFirstChild(child.Name);

        if v21 then
            for _, child2 in child:GetChildren() do
                local u22 = child2:Clone();
                u22.Parent = v21;

                if u22:IsA("Attachment") then
                    VfxManager.Emit(u22);
                elseif u22:IsA("ParticleEmitter") then
                    u22:Emit(u22:GetAttribute("EmitCount") or 10);
                end;

                task.delay(10, function() -- Line: 171
                    -- upvalues: u22 (ref)
                    u22:Destroy();
                end);
            end;
        end;
    end;

    task.delay(10, function() -- Line: 177
        -- upvalues: u20 (ref)
        u20:Destroy();
    end);
end;

local function HideZone(p23, u24) -- Line: 182
    -- upvalues: u1 (copy)
    local v25 = u1[p23];

    if not v25 then
        return;
    end;

    for _, v in v25 do
        if v and (typeof(v) == "Instance" and (v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")))) then
            task.spawn(function() -- Line: 189
                -- upvalues: v (copy), u24 (copy)
                if v then
                    v.Enabled = false;
                    task.wait(u24);
                    v.Enabled = true;
                end;
            end);
        end;
    end;
end;

local function Zone(u26: any, p27: any, p28: string, p29: any, p30: any) -- Line: 201
    -- upvalues: ReplicatedStorage (copy), u1 (copy), ClearZone (copy), SfxManager (copy), Essentials (copy), VfxManager (copy), RunService (copy), colorCorrection (copy)
    if not u26 then
        return;
    end;

    if not u26 then
        return;
    end;

    local v31 = ReplicatedStorage.Assets.Zones:FindFirstChild(p27);

    if not v31 then
        return;
    end;

    if p28 then
        local Color3_fromHex_ret = Color3.fromHex(p28);
        p28 = Color3.fromRGB(Color3_fromHex_ret.R * 255, Color3_fromHex_ret.G * 255, Color3_fromHex_ret.B * 255);
    end;

    if u1[u26] then
        ClearZone(u26, p29);
    end;

    u1[u26] = {};
    SfxManager:playSound({
        Sound = "ZoneActivate",
        Parent = u26.PrimaryPart
    });

    if v31:FindFirstChild("Emit") and p30 then
        local u32 = v31.Emit:Clone();
        u32.Parent = u26.HumanoidRootPart;
        u32.CFrame = u26.HumanoidRootPart.CFrame;
        Essentials:Weld(u32, u26.HumanoidRootPart);
        VfxManager.Emit(u32[p30]);
        task.delay(3, function() -- Line: 230
            -- upvalues: u32 (copy)
            u32:Destroy();
        end);
    end;

    local Aura = v31:FindFirstChild("Aura");

    if Aura:GetAttribute("Ground") then
        for _, child in Aura:GetChildren() do
            local u33 = child:Clone();
            u33.CanCollide = false;
            u33.Parent = u26.HumanoidRootPart;
            u33:PivotTo(CFrame.new(u26.HumanoidRootPart.Position.X, 1.15, u26.HumanoidRootPart.Position.Z));
            u33.Anchored = true;
            local u34 = nil;
            u34 = RunService.Heartbeat:Connect(function(p35) -- Line: 245
                -- upvalues: u1 (ref), u26 (copy), u34 (ref), u33 (copy)
                if not u1[u26] then
                    u34:Disconnect();
                    u33:Destroy();

                    return;
                end;

                if not u26.Parent then
                    u34:Disconnect();
                    u33:Destroy();

                    return;
                end;

                if workspace:FindFirstChild(u26.Name) == nil then
                    u34:Disconnect();
                    u33:Destroy();

                    return;
                end;

                if game.Players:FindFirstChild(u26.Name) == nil then
                    u34:Disconnect();
                    u33:Destroy();

                    return;
                end;

                if game.Players:FindFirstChild(u26.Name).Team ~= game.Teams.Visitor then
                    u33:PivotTo(CFrame.new(u26.HumanoidRootPart.Position.X, 1.15, u26.HumanoidRootPart.Position.Z));

                    return;
                end;

                u34:Disconnect();
                u33:Destroy();
            end);
            u1[u26].Connect = u34;
            table.insert(u1[u26], u33);

            for _, descendant in u33:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    table.insert(u1[u26], descendant);
                end;
            end;
        end;
    else
        for _, child in Aura:GetChildren() do
            local u36 = u26:FindFirstChild(child.Name);

            if u36 then
                if child:GetAttribute("Spin") then
                    local u37 = child:Clone();
                    u37.CanCollide = false;
                    u37.Parent = workspace;
                    u37.CFrame = u36.CFrame;
                    u37.Anchored = true;
                    u1[u26].Spin = u37;

                    if p28 then
                        colorCorrection(u37:GetDescendants(), p28, p27);
                    end;

                    local u38 = 0;
                    local u39 = nil;
                    u39 = RunService.Heartbeat:Connect(function(p40) -- Line: 284
                        -- upvalues: u1 (ref), u26 (copy), u39 (ref), u37 (copy), u36 (copy), u38 (ref)
                        if not u1[u26] then
                            u39:Disconnect();
                            u37:Destroy();

                            return;
                        end;

                        if not u26.Parent then
                            u39:Disconnect();
                            u37:Destroy();

                            return;
                        end;

                        if workspace:FindFirstChild(u26.Name) == nil then
                            u39:Disconnect();
                            u37:Destroy();

                            return;
                        end;

                        if game.Players:FindFirstChild(u26.Name) == nil then
                            u39:Disconnect();
                            u37:Destroy();

                            return;
                        end;

                        if game.Players:FindFirstChild(u26.Name).Team == game.Teams.Visitor then
                            u39:Disconnect();
                            u37:Destroy();

                            return;
                        end;

                        u37.CFrame = u36.CFrame * CFrame.fromEulerAngles(0, math.rad(u38), 0);
                        u38 = u38 + p40 * 70;

                        if u38 >= 360 then
                            u38 = 0;
                        end;
                    end);
                    u1[u26].Connect = u39;
                else
                    for _, child2 in child:GetChildren() do
                        local v41 = child2:Clone();
                        v41.Parent = u36;

                        if v41:IsA("MeshPart") then
                            v41.CFrame = u36.CFrame;
                            Essentials:Weld(v41, u36);

                            if not u1[u26].Meshes then
                                u1[u26].Meshes = {};
                            end;

                            table.insert(u1[u26].Meshes, v41);
                        end;

                        if v41:IsA("Attachment") then
                            for _, descendant in v41:GetDescendants() do
                                if descendant:IsA("Beam") or descendant:IsA("Trail") then
                                    local Keypoints = descendant.Transparency.Keypoints;
                                    task.spawn(function() -- Line: 315
                                        -- upvalues: Keypoints (copy), descendant (copy)
                                        local v42 = {};

                                        for i, v in Keypoints do
                                            v42[i] = NumberSequenceKeypoint.new(v.Time, v.Value + 1, v.Envelope);
                                        end;

                                        descendant.Transparency = NumberSequence.new(v42);

                                        for i = 1, 0, -0.05 do
                                            local v43 = i;
                                            local v44 = {};

                                            for i2, v in Keypoints do
                                                v44[i2] = NumberSequenceKeypoint.new(v.Time, v.Value + v43, v.Envelope);
                                            end;

                                            descendant.Transparency = NumberSequence.new(v44);
                                            task.wait(0.05);
                                        end;
                                    end);
                                    table.insert(u1[u26], descendant);
                                elseif descendant:IsA("ParticleEmitter") and descendant.Enabled then
                                    table.insert(u1[u26], descendant);
                                end;
                            end;
                        end;

                        if v41:IsA("ParticleEmitter") and not v41.Enabled then
                            if not u1[u26].Meshes then
                                u1[u26].Meshes = {};
                            end;

                            table.insert(u1[u26].Meshes, v41);
                        elseif u1[u26] then
                            table.insert(u1[u26], v41);
                        end;
                    end;
                end;
            end;
        end;
    end;

    if u1[u26] and p28 then
        colorCorrection(u1[u26], p28, p27);
    end;
end;

return function(p45, p46) -- Line: 363
    -- upvalues: u1 (copy), ClearZone (copy), Zone (copy), HideZone (copy)
    for i in u1 do
        if not i.Parent then
            ClearZone(i, true);
        end;
    end;

    if p46.Activate then
        Zone(p46.Char or p46.Plr.Character, p46.ZoneType or p46.Plr.Zone.Value, p46.Color, p46.FastClear, p46.RNG);

        return;
    end;

    if p46.Hide then
        HideZone(p46.Char or p46.Plr.Character, p46.Time or 1);

        return;
    end;

    ClearZone(p46.Char or p46.Plr.Character);
end;