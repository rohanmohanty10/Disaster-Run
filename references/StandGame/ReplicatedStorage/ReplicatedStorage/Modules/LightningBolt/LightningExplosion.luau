 

 

if #game:GetService("ServerStorage"):GetChildren() <= 0 then
    local l__Parent__1 = require(script.Parent);
    local l__LightningSparks__2 = require(script.Parent.LightningSparks);
    local u1 = Random.new();
    local l__clock__3 = os.clock;
    function RandomVectorOffsetBetween(p2, p3, p4)
        -- upvalues: u1 (copy)
        local v5 = CFrame.lookAt(Vector3.new(), p2) * CFrame.Angles(0, 0, u1:NextNumber(0, 6.283185307179586));
        local l__Angles__4 = CFrame.Angles;
        local v6 = u1:NextNumber(math.cos(p4), (math.cos(p3)));
        return (v5 * l__Angles__4(math.acos(v6), 0, 0)).LookVector;
    end;
    local u7 = {};
    local u8 = {};
    u8.__index = u8;
    function u8.new(p9, p10, p11, p12, p13, p14, p15, p16, p17) --[[ Line: 22 ]]
        -- upvalues: u8 (copy), u1 (copy), l__Parent__1 (copy), l__LightningSparks__2 (copy), l__clock__3 (copy), u7 (copy)
        local v18 = setmetatable({}, u8);
        v18.Size = p10 or 1;
        v18.NumBolts = p11 or 14;
        v18.Color = p12 or ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1));
        v18.BoltColor = p13 or Color3.new(0.3, 0.3, 1);
        v18.UpVector = p14 or Vector3.new(0, 1, 0);
        v18.Particle1 = p15;
        v18.Particle2 = p16;
        v18.Particle3 = p17;
        local l__CurrentCamera__5 = workspace.CurrentCamera;
        local v19 = Instance.new("Part");
        v19.Name = "LightningExplosion";
        v19.Anchored = true;
        v19.CanCollide = false;
        v19.Locked = true;
        v19.CastShadow = false;
        v19.Transparency = 1;
        v19.Size = Vector3.new(0.05, 0.05, 0.05);
        v19.CFrame = CFrame.lookAt(p9 + Vector3.new(0, 0.5, 0), p9 + Vector3.new(0, 0.5, 0) + v18.UpVector) * CFrame.lookAt(Vector3.new(), Vector3.new(0, 1, 0)):inverse();
        v19.Parent = l__CurrentCamera__5;
        local v20 = Instance.new("Attachment");
        v20.Parent = v19;
        v20.CFrame = CFrame.new();
        local v21 = script.ExplosionBrightspot:Clone();
        local v22 = script.GlareEmitter:Clone();
        local v23 = script.PlasmaEmitter:Clone();
        local v24 = math.clamp(v18.Size, 0, 1);
        v22.Size = NumberSequence.new(v24 * 30);
        v23.Size = NumberSequence.new(v24 * 18);
        v23.Speed = NumberRange.new(v24 * 100);
        v21.Parent = v20;
        v22.Parent = v20;
        v23.Parent = v20;
        local l__Color__6 = v18.Color;
        if typeof(l__Color__6) == "Color3" then
            local v25 = ColorSequence.new(l__Color__6);
            local v26 = ColorSequence.new(l__Color__6);
            v22.Color = v25;
            v23.Color = v26;
            local v27, _, v28 = Color3.toHSV(l__Color__6);
            v21.Color = ColorSequence.new(Color3.fromHSV(v27, 0.5, v28));
        else
            v22.Color = l__Color__6;
            v23.Color = l__Color__6;
            local l__Keypoints__7 = l__Color__6.Keypoints;
            for v29 = 1, #l__Keypoints__7 do
                local v30, _, v31 = Color3.toHSV(l__Keypoints__7[v29].Value);
                l__Keypoints__7[v29] = ColorSequenceKeypoint.new(l__Keypoints__7[v29].Time, Color3.fromHSV(v30, 0.5, v31));
            end;
            v21.Color = ColorSequence.new(l__Keypoints__7);
        end;
        local v32 = v18.Particle1 or v18.Particle1 == nil;
        local v33 = v18.Particle2 or v18.Particle2 == nil;
        local v34 = v18.Particle3 or v18.Particle3 == nil;
        v21.Enabled = v32;
        v22.Enabled = v33;
        v23.Enabled = v34;
        local v35 = {};
        for _ = 1, v18.NumBolts do
            local v36 = {};
            local v37 = {};
            local l__WorldPosition__8 = v20.WorldPosition;
            local v38 = RandomVectorOffsetBetween(v18.UpVector, 1.1344640137963142, 1.3962634015954636);
            v36.WorldPosition = l__WorldPosition__8;
            v36.WorldAxis = v38;
            local v39 = v20.WorldPosition + v36.WorldAxis * u1:NextNumber(20, 40) * 1.4 * v24;
            local v40 = RandomVectorOffsetBetween(-v18.UpVector, 1.2217304763960306, 1.9198621771937625);
            v37.WorldPosition = v39;
            v37.WorldAxis = v40;
            local v41 = l__Parent__1.new(v36, v37, 10);
            v41.AnimationSpeed = 0;
            v41.Thickness = 1;
            v41.Color = v18.BoltColor;
            v41.PulseLength = 0.8;
            v41.ColorOffsetSpeed = 20;
            v41.Frequency = 2;
            local v42 = v24 * 4;
            v41.MinRadius = 0;
            v41.MaxRadius = v42;
            v41.FadeLength = 0.4;
            v41.PulseSpeed = 5;
            v41.MinThicknessMultiplier = 0.7;
            v41.MaxThicknessMultiplier = 1;
            local v43 = l__LightningSparks__2.new(v41, 5);
            v43.MinDistance = 7.5;
            v43.MaxDistance = 10;
            v41.Velocity = (v37.WorldPosition - v36.WorldPosition).Unit * 0.1 * v24;
            v35[#v35 + 1] = v41;
        end;
        v18.Bolts = v35;
        v18.Attachment = v20;
        v18.Part = v19;
        v18.StartT = l__clock__3();
        v18.RefIndex = #u7 + 1;
        u7[v18.RefIndex] = v18;
        return v18;
    end;
    function u8.Destroy(p44) --[[ Line: 126 ]]
        -- upvalues: u7 (copy)
        u7[p44.RefIndex] = nil;
        p44.Part:Destroy();
        for v45 = 1, #p44.Bolts do
            p44.Bolts[v45] = nil;
        end;
    end;
    game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 137 ]]
        -- upvalues: u7 (copy), l__clock__3 (copy)
        for _, v46 in pairs(u7) do
            local v47 = l__clock__3() - v46.StartT;
            local l__Attachment__9 = v46.Attachment;
            if v47 < 0.7 then
                if v47 > 0.2 then
                    local l__ExplosionBrightspot__10 = l__Attachment__9.ExplosionBrightspot;
                    local l__GlareEmitter__11 = l__Attachment__9.GlareEmitter;
                    local l__PlasmaEmitter__12 = l__Attachment__9.PlasmaEmitter;
                    l__ExplosionBrightspot__10.Enabled = false;
                    l__GlareEmitter__11.Enabled = false;
                    l__PlasmaEmitter__12.Enabled = false;
                end;
                for v48 = 1, #v46.Bolts do
                    local v49 = v46.Bolts[v48];
                    v49.Attachment1.WorldPosition = v49.Attachment1.WorldPosition + v49.Velocity;
                end;
            else
                v46:Destroy();
            end;
        end;
    end);
    return u8;
end;