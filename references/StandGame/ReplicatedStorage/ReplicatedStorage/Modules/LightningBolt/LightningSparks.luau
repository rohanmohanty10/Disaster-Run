 

 

if #game:GetService("ServerStorage"):GetChildren() <= 0 then
    local l__Parent__1 = require(script.Parent);
    local u1 = {};
    local u2 = Random.new();
    local u3 = {};
    u3.__index = u3;
    function u3.new(p4, p5) --[[ Line: 14 ]]
        -- upvalues: u3 (copy), u1 (copy)
        local v6 = setmetatable({}, u3);
        v6.Enabled = true;
        v6.LightningBolt = p4;
        v6.MaxSparkCount = p5 or 10;
        v6.MinSpeed = 4;
        v6.MaxSpeed = 6;
        v6.MinDistance = 3;
        v6.MaxDistance = 6;
        v6.MinPartsPerSpark = 8;
        v6.MaxPartsPerSpark = 10;
        v6.SparksN = 0;
        v6.SlotTable = {};
        v6.RefIndex = #u1 + 1;
        u1[v6.RefIndex] = v6;
        return v6;
    end;
    function u3.Destroy(p7) --[[ Line: 37 ]]
        -- upvalues: u1 (copy)
        u1[p7.RefIndex] = nil;
        for v8, v9 in pairs(p7.SlotTable) do
            if v9.Parts[1].Parent == nil then
                p7.SlotTable[v8] = nil;
            end;
        end;
    end;
    function RandomVectorOffset(p10, p11)
        -- upvalues: u2 (copy)
        local v12 = CFrame.lookAt(Vector3.new(), p10) * CFrame.Angles(0, 0, u2:NextNumber(0, 6.283185307179586));
        local l__Angles__2 = CFrame.Angles;
        local v13 = u2:NextNumber(math.cos(p11), 1);
        return (v12 * l__Angles__2(math.acos(v13), 0, 0)).LookVector;
    end;
    game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 53 ]]
        -- upvalues: u1 (copy), u2 (copy), l__Parent__1 (copy)
        for _, v14 in pairs(u1) do
            if v14.Enabled == true and v14.SparksN < v14.MaxSparkCount then
                local l__LightningBolt__3 = v14.LightningBolt;
                if l__LightningBolt__3.Parts[1].Parent == nil then
                    v14:Destroy();
                    return;
                end;
                local l__Parts__4 = l__LightningBolt__3.Parts;
                local v15 = #l__Parts__4;
                local v16 = {};
                for v17 = 1, #l__Parts__4 do
                    if l__Parts__4[v17].Transparency < 0.3 then
                        v16[#v16 + 1] = (v17 - 0.5) / v15;
                    end;
                end;
                local v18, v19;
                if #v16 == 0 then
                    v18 = nil;
                    v19 = nil;
                else
                    v18 = math.ceil(v16[1] * v14.MaxSparkCount);
                    v19 = math.ceil(v16[#v16] * v14.MaxSparkCount);
                end;
                for _ = 1, u2:NextInteger(1, v14.MaxSparkCount - v14.SparksN) do
                    if #v16 == 0 then
                        break;
                    end;
                    local v20 = {};
                    for v21 = v18, v19 do
                        if v14.SlotTable[v21] == nil then
                            v20[#v20 + 1] = v21;
                        end;
                    end;
                    if #v20 ~= 0 then
                        local v22 = v20[u2:NextInteger(1, #v20)];
                        local v23 = u2:NextNumber(-0.5, 0.5);
                        local v24 = (v22 - 0.5 + v23) / v14.MaxSparkCount;
                        local v25 = 10;
                        local v26 = 1;
                        for v27 = 1, #v16 do
                            local v28 = math.abs(v16[v27] - v24);
                            if v28 < v25 then
                                v26 = math.floor(v16[v27] * v15 + 0.5 + 0.5);
                                v25 = v28;
                            end;
                        end;
                        local v29 = l__Parts__4[v26];
                        local v30 = {};
                        local v31 = {};
                        v30.WorldPosition = v29.Position + v23 * v29.CFrame.RightVector * v29.Size.X;
                        v31.WorldPosition = v30.WorldPosition + RandomVectorOffset(v29.CFrame.RightVector, 0.7853981633974483) * u2:NextNumber(v14.MinDistance, v14.MaxDistance);
                        v30.WorldAxis = (v31.WorldPosition - v30.WorldPosition).Unit;
                        v31.WorldAxis = v30.WorldAxis;
                        local v32 = l__Parent__1.new(v30, v31, u2:NextInteger(v14.MinPartsPerSpark, v14.MaxPartsPerSpark));
                        v32.MinRadius = 0;
                        v32.MaxRadius = 0.8;
                        v32.AnimationSpeed = 0;
                        v32.Thickness = v29.Size.Y / 2;
                        v32.MinThicknessMultiplier = 1;
                        v32.MaxThicknessMultiplier = 1;
                        v32.PulseLength = 0.5;
                        v32.PulseSpeed = u2:NextNumber(v14.MinSpeed, v14.MaxSpeed);
                        v32.FadeLength = 0.25;
                        local v33, _, v34 = Color3.toHSV(v29.Color);
                        v32.Color = Color3.fromHSV(v33, 0.5, v34);
                        v14.SlotTable[v22] = v32;
                    end;
                end;
            end;
            local v35 = 0;
            for v36, v37 in pairs(v14.SlotTable) do
                if v37.Parts[1].Parent == nil then
                    v14.SlotTable[v36] = nil;
                else
                    v35 = v35 + 1;
                end;
            end;
            v14.SparksN = v35;
        end;
    end);
    return u3;
end;