 

 

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

function v1.Fire(p13: userdata, p14, u15, p16: table) -- Line: 44
    -- upvalues: TweenService (copy), RunService (copy), getBezierCFrame (copy), Debris (copy)
    if not (p13 and p13:IsA("Model")) then
        return nil;
    end;

    if not (p14 and u15) then
        return nil;
    end;

    local v17 = p16 or {};
    local v18 = p13:Clone();
    local PrimaryPart = v18.PrimaryPart;

    if not PrimaryPart then
        v18:Destroy();

        return nil;
    end;

    PrimaryPart.CFrame = p14 * (v17.Offset or CFrame.new());
    v18.Parent = v17.Parent or workspace;
    local CFrame2 = PrimaryPart.CFrame;
    local v19 = v17.Lifetime or 5;
    local v20 = v17.Duration or 1;
    local v21 = v17.EasingStyle or Enum.EasingStyle.Quad;
    local v22 = v17.EasingDirection or Enum.EasingDirection.Out;

    if v17.ControlPoints and #v17.ControlPoints >= 2 then
        local u23 = v17.ControlPoints[1];
        local u24 = v17.ControlPoints[2];
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        NumberValue.Name = "ProjectileBezierProgress";
        NumberValue.Parent = nil;
        local u25 = TweenService:Create(NumberValue, TweenInfo.new(v20, v21, v22, 0, false, 0), {
            Value = 1
        });
        local u26 = nil;
        u26 = RunService.Heartbeat:Connect(function() -- Line: 106
            -- upvalues: PrimaryPart (copy), u25 (copy), getBezierCFrame (ref), NumberValue (copy), CFrame2 (copy), u23 (copy), u24 (copy), u15 (copy), u26 (ref)
            if PrimaryPart and (PrimaryPart.Parent and u25.PlaybackState == Enum.PlaybackState.Playing) then
                PrimaryPart.CFrame = getBezierCFrame(NumberValue.Value, CFrame2, u23, u24, u15);

                return;
            end;

            if u26 then
                u26:Disconnect();
                u26 = nil;
            end;
        end);
        u25:Play();
        u25.Completed:Connect(function() -- Line: 119
            -- upvalues: u26 (ref), NumberValue (copy)
            if u26 then
                u26:Disconnect();
                u26 = nil;
            end;

            NumberValue:Destroy();
        end);
    else
        local v27 = TweenService:Create(PrimaryPart, TweenInfo.new(v20, v21, v22, 0, false, 0), {
            CFrame = u15
        });
        v27:Play();
        v27.Completed:Connect(function(p28) -- Line: 140
            local _ = p28 == Enum.TweenStatus.Completed;
        end);
    end;

    Debris:AddItem(v18, v19);

    return v18;
end;

return v1;