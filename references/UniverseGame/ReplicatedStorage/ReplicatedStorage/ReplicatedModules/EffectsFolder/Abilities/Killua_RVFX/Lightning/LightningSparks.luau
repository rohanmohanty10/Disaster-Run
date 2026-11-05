  

 

local LightningBolt = require(script.Parent:WaitForChild("LightningBolt"));
local u1 = {};
local u2 = Random.new();
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5) -- Line: 11
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

function u3.Destroy(p7) -- Line: 34
    -- upvalues: u1 (copy)
    u1[p7.RefIndex] = nil;

    for i, v in pairs(p7.SlotTable) do
        if v.Parts[1].Parent == nil then
            p7.SlotTable[i] = nil;
        end;
    end;
end;

function RandomVectorOffset(p8, p9)
    -- upvalues: u2 (copy)
    local v10 = CFrame.lookAt(Vector3.new(), p8) * CFrame.Angles(0, 0, u2:NextNumber(0, 6.283185307179586));
    local Angles = CFrame.Angles;
    local v11 = u2:NextNumber(math.cos(p9), 1);

    return (v10 * Angles(math.acos(v11), 0, 0)).LookVector;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 50
    -- upvalues: u1 (copy), u2 (copy), LightningBolt (copy)
    for _, v in pairs(u1) do
        if v.Enabled == true and v.SparksN < v.MaxSparkCount then
            local LightningBolt2 = v.LightningBolt;

            if LightningBolt2.Parts[1].Parent == nil then
                v:Destroy();

                return;
            end;

            local Parts = LightningBolt2.Parts;
            local v12 = #Parts;
            local v13 = {};

            for i = 1, #Parts do
                if Parts[i].Transparency < 0.3 then
                    v13[#v13 + 1] = (i - 0.5) / v12;
                end;
            end;

            local v14, v15;

            if #v13 == 0 then
                v14 = nil;
                v15 = nil;
            else
                v14 = math.ceil(v13[1] * v.MaxSparkCount);
                v15 = math.ceil(v13[#v13] * v.MaxSparkCount);
            end;

            for _ = 1, u2:NextInteger(1, v.MaxSparkCount - v.SparksN) do
                if #v13 == 0 then
                    break;
                end;

                local v16 = {};

                for i = v14, v15 do
                    if v.SlotTable[i] == nil then
                        v16[#v16 + 1] = i;
                    end;
                end;

                if #v16 ~= 0 then
                    local v17 = v16[u2:NextInteger(1, #v16)];
                    local v18 = u2:NextNumber(-0.5, 0.5);
                    local v19 = (v17 - 0.5 + v18) / v.MaxSparkCount;
                    local v20 = 10;
                    local v21 = 1;

                    for i = 1, #v13 do
                        local v22 = math.abs(v13[i] - v19);

                        if v22 < v20 then
                            v21 = math.floor(v13[i] * v12 + 0.5 + 0.5);
                            v20 = v22;
                        end;
                    end;

                    local v23 = Parts[v21];
                    local v24 = {};
                    local v25 = {};
                    v24.WorldPosition = v23.Position + v18 * v23.CFrame.RightVector * v23.Size.X;
                    v25.WorldPosition = v24.WorldPosition + RandomVectorOffset(v23.CFrame.RightVector, 0.7853981633974483) * u2:NextNumber(v.MinDistance, v.MaxDistance);
                    v24.WorldAxis = (v25.WorldPosition - v24.WorldPosition).Unit;
                    v25.WorldAxis = v24.WorldAxis;
                    local v26 = LightningBolt.new(v24, v25, u2:NextInteger(v.MinPartsPerSpark, v.MaxPartsPerSpark));
                    v26.MinRadius = 0;
                    v26.MaxRadius = 0.8;
                    v26.AnimationSpeed = 0;
                    v26.Thickness = v23.Size.Y / 2;
                    v26.MinThicknessMultiplier = 1;
                    v26.MaxThicknessMultiplier = 1;
                    v26.PulseLength = 0.5;
                    v26.PulseSpeed = u2:NextNumber(v.MinSpeed, v.MaxSpeed);
                    v26.FadeLength = 0.25;
                    local v27, _, v28 = Color3.toHSV(v23.Color);
                    v26.Color = Color3.fromHSV(v27, 0.5, v28);
                    v.SlotTable[v17] = v26;
                end;
            end;
        end;

        local v29 = 0;

        for i, v2 in pairs(v.SlotTable) do
            if v2.Parts[1].Parent == nil then
                v.SlotTable[i] = nil;
            else
                v29 = v29 + 1;
            end;
        end;

        v.SparksN = v29;
    end;
end);

return u3;