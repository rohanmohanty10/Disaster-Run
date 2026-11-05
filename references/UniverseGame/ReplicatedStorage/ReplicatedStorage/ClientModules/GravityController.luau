  

 

local RunService = game:GetService("RunService");
local Utility = script:WaitForChild("Utility");
local CharacterModules = script:WaitForChild("CharacterModules");
local Maid = require(Utility:WaitForChild("Maid"));
require(Utility:WaitForChild("Signal"));
local Camera = require(CharacterModules:WaitForChild("Camera"));
local Control = require(CharacterModules:WaitForChild("Control"));
local Collider = require(script:WaitForChild("Collider"));
local StateTracker = require(script:WaitForChild("StateTracker"));
local u1 = {};
u1.__index = u1;
u1.ClassName = "GravityController";

function u1.new(p2) -- Line: 29
    -- upvalues: u1 (copy), Camera (copy), Control (copy), Collider (copy), StateTracker (copy), Maid (copy)
    local v3 = setmetatable({}, u1);
    v3.Player = p2;
    v3.Character = game.Workspace.Effects:WaitForChild(p2.Name .. "_Pilot");
    v3.Humanoid = v3.Character:WaitForChild("Humanoid");
    v3.HRP = v3.Character:WaitForChild("HumanoidRootPart");
    v3._gravityUp = Vector3.new(0, 1, 0);
    v3._characterMass = 0;
    v3._camera = Camera.new(v3);
    v3._control = Control.new(v3);
    v3._collider = Collider.new(v3);
    v3._fallStart = v3.HRP.Position.y;
    v3._prevPart = workspace.Terrain;
    v3._prevCFrame = CFrame.new();
    v3.StateTracker = StateTracker.new(v3);
    v3.Maid = Maid.new();
    init(v3);

    return v3;
end;

local function getRotationBetween(p4, p5, p6) -- Line: 59
    local v7 = p4:Dot(p5);
    local v8 = p4:Cross(p5);

    if v7 < -0.99999 then
        return CFrame.fromAxisAngle(p6, 3.141592653589793);
    end;

    return CFrame.new(0, 0, 0, v8.x, v8.y, v8.z, 1 + v7);
end;

local function getModelMass(p9) -- Line: 65
    local v10 = 0;

    for _, descendant in pairs(p9:GetDescendants()) do
        if descendant:IsA("BasePart") and not descendant.Massless then
            v10 = v10 + descendant:GetMass();
        end;
    end;

    return v10;
end;

local function onJumpRequest(p11) -- Line: 75
    if not p11.StateTracker.Jumped and p11._collider:IsGrounded(true) then
        p11.HRP.Velocity = p11.HRP.Velocity + p11._gravityUp * p11.Humanoid.JumpPower * 1.5;
        p11.StateTracker:RequestJump();
    end;
end;

local function onHeartbeat(p12, p13) -- Line: 83
    local v14 = p12._collider:GetStandingPart();

    if v14 and (p12._prevPart and p12._prevPart == v14) then
        local v15 = p12._prevCFrame:ToObjectSpace(p12.HRP.CFrame);
        p12.HRP.CFrame = v14.CFrame * v15;
    end;

    p12._prevPart = v14;

    if v14 then
        v14 = v14.CFrame;
    end;

    p12._prevCFrame = v14;
end;

local function onGravityStep(p16, p17) -- Line: 95
    -- upvalues: getRotationBetween (copy)
    local CFrame2 = workspace.CurrentCamera.CFrame;
    local _gravityUp = p16._gravityUp;
    local v18 = p16:GetGravityUp(_gravityUp);
    local v19 = getRotationBetween(_gravityUp, v18, CFrame2.XVector);
    p16._gravityUp = CFrame.new():Lerp(v19, 0.1) * _gravityUp;
    local v20 = CFrame2.ZVector:Dot(v18);
    local v21 = -(math.abs(v20) > 0.5 and math.sign(v20) * CFrame2.YVector or -CFrame2.ZVector):Cross(v18).Unit;
    local v22 = -v21:Cross(v18).Unit;
    local v23 = p16._control:GetMoveVector();
    local v24 = v22 * v23.z - v21 * v23.x;
    local Magnitude = v24.Magnitude;
    local v25;

    if Magnitude > 0 then
        v24 = v24 / Magnitude;
        v25 = true;
    else
        v25 = false;
    end;

    local v26 = -p16.HRP.CFrame.ZVector;
    local v27 = v26:Dot(v22) * v22 + v26:Dot(v21) * v21;
    local Unit = v27:Cross(v18).Unit;
    local v28 = CFrame.new();
    local v29 = CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit, v18, -v27);

    if p16._camera.CameraModule:IsCamRelative() then
        v29 = CFrame.fromMatrix(Vector3.new(0, 0, 0), -v21, v18);
    elseif v25 then
        v28 = v28:Lerp(getRotationBetween(v27, v24, v18), 0.5);
    end;

    local v30 = workspace.Gravity * p16._characterMass * (Vector3.new(0, 1, 0) - v18);
    local Velocity = p16.HRP.Velocity;
    local v31 = p16.Humanoid.WalkSpeed * v24;
    local v32 = Velocity - Velocity:Dot(v18) * v18;
    local v33 = v31 - (v32:Dot(v32) < 1 and Vector3.new(0, 0, 0) or v32);
    local Magnitude2 = v33.Magnitude;
    local v34 = math.min(10000, 30 * p16._characterMass * Magnitude2 / (p17 * 60));
    p16.StateTracker:Update(p16._gravityUp, p16._collider:IsGrounded(false), v25);
    p16._collider:Update((v34 > 0 and v33 / Magnitude2 * v34 or Vector3.new(0, 0, 0)) + v30, v28 * v29);
end;

function init(u35)
    -- upvalues: getModelMass (copy), RunService (copy), onGravityStep (copy)
    u35.Maid:Mark(u35._camera);
    u35.Maid:Mark(u35._control);
    u35.Maid:Mark(u35._collider);
    u35._characterMass = getModelMass(u35.Character);
    u35.Maid:Mark(u35.Character.AncestryChanged:Connect(function() -- Line: 173
        -- upvalues: u35 (copy), getModelMass (ref)
        u35._characterMass = getModelMass(u35.Character);
    end));
    u35.Humanoid.PlatformStand = true;
    u35.Maid:Mark(u35.Humanoid:GetPropertyChangedSignal("Jump"):Connect(function() -- Line: 178
        -- upvalues: u35 (copy)
        if u35.Humanoid.Jump then
            local v36 = u35;

            if not v36.StateTracker.Jumped and v36._collider:IsGrounded(true) then
                v36.HRP.Velocity = v36.HRP.Velocity + v36._gravityUp * v36.Humanoid.JumpPower * 1.5;
                v36.StateTracker:RequestJump();
            end;

            u35.Humanoid.Jump = false;
        end;
    end));
    u35.Maid:Mark(u35.StateTracker.Changed:Connect(function(p37, p38) -- Line: 185
        -- upvalues: u35 (copy)
        if p37 == Enum.HumanoidStateType.Freefall then
            u35._fallStart = u35.HRP.Position:Dot(u35._gravityUp);
        end;
    end));
    u35.Maid:Mark(RunService.Heartbeat:Connect(function(p39) -- Line: 191
        -- upvalues: u35 (copy)
        local v40 = u35;
        local v41 = v40._collider:GetStandingPart();

        if v41 and (v40._prevPart and v40._prevPart == v41) then
            local v42 = v40._prevCFrame:ToObjectSpace(v40.HRP.CFrame);
            v40.HRP.CFrame = v41.CFrame * v42;
        end;

        v40._prevPart = v41;

        if v41 then
            v41 = v41.CFrame;
        end;

        v40._prevCFrame = v41;
    end));
    RunService:BindToRenderStep("GravityStep", Enum.RenderPriority.Camera.Value - 1, function(p43) -- Line: 195
        -- upvalues: onGravityStep (ref), u35 (copy)
        onGravityStep(u35, p43);
    end);
    u35.Humanoid.StateChanged:Wait();
    u35.StateTracker.Changed:Fire(u35.StateTracker.State, 0);
end;

function u1.ResetGravity(p44, p45) -- Line: 205
    p44._gravityUp = p45;
    p44._fallStart = p44.HRP.Position:Dot(p45);
end;

function u1.GetFallHeight(p46) -- Line: 210
    return p46.StateTracker.State ~= Enum.HumanoidStateType.Freefall and 0 or p46.HRP.Position:Dot(p46._gravityUp) - p46._fallStart;
end;

function u1.GetGravityUp(p47, p48) -- Line: 218
    return p48;
end;

function u1.Destroy(p49) -- Line: 222
    -- upvalues: RunService (copy)
    RunService:UnbindFromRenderStep("GravityStep");
    p49.Maid:Sweep();
    p49.Humanoid.PlatformStand = false;
end;

return u1;