 

 

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local CharacterClone = require(script_Parent.CharacterClone);
local Idle = require(Parent.Animation.AnimationConfig).PublishedIds.Idle;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy)
    p2.Visible = false;

    return setmetatable({
        viewport = p2
    }, u1);
end;

local function restHead(p3, p4) -- Line: 22
    local Torso = p3:FindFirstChild("Torso");
    local RootJoint = p4:FindFirstChild("RootJoint");

    if Torso then
        Torso = Torso:FindFirstChild("Neck");
    end;

    if RootJoint and (RootJoint:IsA("Motor6D") and (Torso and Torso:IsA("Motor6D"))) then
        return p4.CFrame * RootJoint.C0 * RootJoint.C1:Inverse() * Torso.C0 * Torso.C1:Inverse();
    end;

    return p4.CFrame * CFrame.new(0, 1.5, 0);
end;

function u1.show(u5, u6, p7) -- Line: 34
    -- upvalues: CharacterClone (copy), restHead (copy), Idle (copy)
    if not p7 and (u6 and (u5.source == u6 and (u5.model and u5.model.Parent))) then
        return true;
    end;

    local v8 = (not p7 or u5.source ~= u6) and 1 or (u5.tries or 0) + 1;
    u5:clear();
    local u9, v10, v11 = CharacterClone.copy(u6);

    if not u9 then
        return false;
    end;

    u5.tries = v8;

    if not CharacterClone.dressed(u9) and v8 < CharacterClone.RETRIES then
        task.delay(CharacterClone.RETRY_SECONDS, function() -- Line: 47
            -- upvalues: u5 (copy), u9 (copy), u6 (copy)
            if u5.model == u9 and u9.Parent then
                u5:show(u6, true);
            end;
        end);
    end;

    local Head = u9:FindFirstChild("Head");
    local v12 = Head and (Head:IsA("BasePart") and Head.Size.Y) or 1;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = u5.viewport;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 30;
    Camera.Parent = u5.viewport;
    u5.viewport.CurrentCamera = Camera;
    u9:PivotTo(CFrame.Angles(0, -0.3141592653589793, 0));
    u9.Name = "Portrait";
    u9.Parent = WorldModel;
    local v13 = restHead(u9, v11).Position - Vector3.new(0, v12 * 0.5, 0);
    Camera.CFrame = CFrame.lookAt(v13 + Vector3.new(0, v12 * 0.1, -(v12 * 2.7 * 0.5 / 0.2679491924311227)), v13);
    local v14 = v10:FindFirstChildOfClass("Animator");

    if v14 and Idle then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = Idle;
        local success, result = pcall(v14.LoadAnimation, v14, Animation);

        if success and result then
            result.Looped = true;
            result:Play(0);
            u5.track = result;
        end;
    end;

    u5.model = u9;
    u5.world = WorldModel;
    u5.camera = Camera;
    u5.source = u6;
    u5.viewport.Visible = true;

    return true;
end;

function u1.clear(p15) -- Line: 84
    if p15.track then
        p15.track:Stop(0);
        p15.track:Destroy();
        p15.track = nil;
    end;

    if p15.camera then
        if p15.viewport.CurrentCamera == p15.camera then
            p15.viewport.CurrentCamera = nil;
        end;

        p15.camera:Destroy();
        p15.camera = nil;
    end;

    if p15.world then
        p15.world:Destroy();
        p15.world = nil;
    end;

    p15.model = nil;
    p15.source = nil;
    p15.viewport.Visible = false;
end;

u1.destroy = u1.clear;

return u1;