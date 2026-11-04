 
 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local v1 = {};

local function getBezierCFrame(p2: number, p3, p4, p5, p6) -- Line: 9
    local v7 = 1 - p2;
    local v8 = v7 * v7;
    local v9 = p2 * p2;
    local v10 = p3.Position * (v8 * v7) + p4.Position * (v8 * 3 * p2) + p5.Position * (v7 * 3 * v9) + p6.Position * (v9 * p2);
    local v11 = (p4.Position - p3.Position) * (v8 * 3) + (p5.Position - p4.Position) * (v7 * 6 * p2) + (p6.Position - p5.Position) * (v9 * 3);

    if v11.Magnitude < 0.001 then
        if p2 < 0.5 then
            v11 = (p4.Position - p3.Position).Unit;
        else
            v11 = (p6.Position - p5.Position).Unit;
        end;

        if v11.Magnitude < 0.001 then
            local v12 = p6.Position - p3.Position;
            v11 = v12.Magnitude < 0.001 and Vector3.new(0, 0, -1) or v12;
        end;
    end;

    return CFrame.lookAt(v10, v10 + v11);
end;

function v1.Create(u13, p14: table) -- Line: 43
    -- upvalues: TweenService (copy), RunService (copy), getBezierCFrame (copy), Debris (copy)
    local v15 = p14 or {};

    if typeof(u13) ~= "CFrame" then
        warn("BezierChargeEffect.Create: \'targetCFrame\' must be a CFrame value, but received an " .. typeof(u13) .. ". Did you pass a Part/Instance instead of Part.CFrame?");

        return;
    end;

    local v16 = v15.Count or 30;
    local u17 = v15.SpawnRadius or 20;
    local u18 = v15.MinDuration or 0.8;
    local u19 = v15.MaxDuration or 1.5;
    local u20 = v15.Lifetime or 2;
    local ParticleTemplate = v15.ParticleTemplate;
    local u21 = v15.ControlPointHeight or 15;
    local u22 = v15.RandomControlOffset or 8;
    local u23 = v15.Parent or workspace.Effects;
    local u24 = v15.EasingStyle or Enum.EasingStyle.Quart;
    local u25 = v15.EasingDirection or Enum.EasingDirection.Out;
    local u26 = v15.SpawnDelay or 0.05;
    local ColorSequence = v15.ColorSequence;
    local TransparencySequence = v15.TransparencySequence;
    local u27 = v15.SwirlStrength or 0;

    if ParticleTemplate and ParticleTemplate:IsA("BasePart") then
        for i = 1, v16 do
            task.spawn(function() -- Line: 89
                -- upvalues: u26 (copy), i (copy), ParticleTemplate (copy), u23 (copy), u17 (copy), u13 (copy), u18 (copy), u19 (copy), u22 (copy), u27 (copy), u21 (copy), u24 (copy), u25 (copy), TweenService (ref), RunService (ref), getBezierCFrame (ref), ColorSequence (copy), TransparencySequence (copy), Debris (ref), u20 (copy)
                if u26 > 0 then
                    task.wait(i * u26);
                end;

                local u28 = ParticleTemplate:Clone();
                u28.Anchored = false;
                u28.CanCollide = false;
                u28.CanTouch = false;
                u28.Massless = true;
                u28.Parent = u23;
                local v29 = math.random() * 2 - 1;
                local v30 = math.random() * 2 - 1;
                local v31 = math.random() * 2 - 1;
                local v32 = Vector3.new(v29, v30, v31).Unit * math.random(0, u17);
                local CFrame_new_ret = CFrame.new(u13.Position + v32);
                u28.CFrame = CFrame_new_ret;
                local v33 = math.random(u18 * 100, u19 * 100) / 100;
                local u34 = u13;
                local v35 = CFrame_new_ret:Lerp(u34, 0.5);
                local math_abs_ret = math.abs(u22);
                local v36 = math.random() * 2 - 1;
                local v37 = math.random() * 2 - 1;
                local v38 = math.random() * 2 - 1;
                local v39 = Vector3.new(v36, v37, v38).Unit * (math.random() * math_abs_ret);
                local v40 = math.random() * 2 - 1;
                local v41 = math.random() * 2 - 1;
                local v42 = math.random() * 2 - 1;
                local v43 = Vector3.new(v40, v41, v42).Unit * (math.random() * math_abs_ret);
                local Unit = (u34.Position - CFrame_new_ret.Position).Unit;
                local v44 = Unit:Cross(Vector3.new(0, 1, 0));

                if v44.Magnitude < 0.001 then
                    v44 = Unit:Cross(Vector3.new(0, 0, -1));
                end;

                local Unit2 = v44.Unit;
                local v45 = Unit2 * (math.random() * 2 - 1) * u27;
                local v46 = Unit2 * (math.random() * 2 - 1) * u27;
                local v47 = CFrame_new_ret.Position:Lerp(v35.Position, 0.3) + Vector3.new(0, u21, 0) + v39 + v45;
                local v48 = v35.Position:Lerp(u34.Position, 0.7) + Vector3.new(0, u21, 0) + v43 + v46;
                local CFrame_new_ret2 = CFrame.new(v47);
                local CFrame_new_ret3 = CFrame.new(v48);
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 0;
                NumberValue.Parent = nil;
                local u49 = TweenService:Create(NumberValue, TweenInfo.new(v33, u24, u25, 0, false, 0), {
                    Value = 1
                });
                local u50 = nil;
                u50 = RunService.Heartbeat:Connect(function() -- Line: 169
                    -- upvalues: u28 (copy), u49 (copy), getBezierCFrame (ref), NumberValue (copy), CFrame_new_ret (copy), CFrame_new_ret2 (copy), CFrame_new_ret3 (copy), u34 (copy), u50 (ref)
                    if u28 and (u28.Parent and u49.PlaybackState == Enum.PlaybackState.Playing) then
                        u28.CFrame = getBezierCFrame(NumberValue.Value, CFrame_new_ret, CFrame_new_ret2, CFrame_new_ret3, u34);

                        return;
                    end;

                    if u50 then
                        u50:Disconnect();
                        u50 = nil;
                    end;
                end);
                local v51 = ColorSequence and u28:FindFirstChildOfClass("Trail");

                if v51 then
                    v51.Color = ColorSequence;
                end;

                local v52 = TransparencySequence and u28:FindFirstChildOfClass("Trail");

                if v52 then
                    v52.Transparency = TransparencySequence;
                end;

                u49:Play();
                u49.Completed:Connect(function() -- Line: 195
                    -- upvalues: u50 (ref), NumberValue (copy)
                    if u50 then
                        u50:Disconnect();
                        u50 = nil;
                    end;

                    NumberValue:Destroy();
                end);
                Debris:AddItem(u28, u20);
            end);
            local _ = i;
        end;

        return;
    end;

    warn("BezierChargeEffect.Create: ParticleTemplate is required and must be a BasePart.");
end;

return v1;