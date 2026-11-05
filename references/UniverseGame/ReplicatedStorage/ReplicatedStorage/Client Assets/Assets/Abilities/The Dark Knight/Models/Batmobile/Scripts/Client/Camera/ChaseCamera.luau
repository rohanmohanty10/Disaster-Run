  

 

local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local InputCategorizer = require(script.Parent.Parent.InputCategorizer);
local u1 = {
    [InputCategorizer.InputCategory.KeyboardAndMouse] = require(script.KeyboardAndMouse),
    [InputCategorizer.InputCategory.Gamepad] = require(script.Gamepad),
    [InputCategorizer.InputCategory.Touch] = require(script.Touch)
};
local pitchAndYawFromDirection = require(script.pitchAndYawFromDirection);
local CurrentCamera = Workspace.CurrentCamera;
local Chassis = script.Parent.Parent.Parent.Parent.Chassis;
local Value = Enum.RenderPriority.Camera.Value;
local u2 = CFrame.new();
local u3 = CFrame.new();
local u4 = Vector3.new(0, 0, 0);
local u5 = Vector3.new(0, 0, 0);
local u6 = false;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = nil;
local u11 = InputCategorizer.getLastInputCategory();
local u12 = false;
local u13 = {
    height = 7,
    distance = 15
};

local function onLastInputCategoryChanged(p14) -- Line: 59
    -- upvalues: u11 (ref), u1 (copy)
    u11 = p14;

    for i, v in u1 do
        if i == p14 then
            v:enable();
        else
            v:disable();
        end;
    end;
end;

local function update(p15) -- Line: 71
    -- upvalues: Chassis (copy), u1 (copy), u11 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), pitchAndYawFromDirection (copy), u2 (ref), u5 (ref), u4 (ref), u13 (ref), u3 (ref), CurrentCamera (copy)
    local AssemblyLinearVelocity = Chassis.AssemblyLinearVelocity;

    if AssemblyLinearVelocity.Magnitude < 10 then
        AssemblyLinearVelocity = Chassis.CFrame.LookVector;
    end;

    local v16 = u1[u11]:getInput(p15);

    if v16.Magnitude ~= 0 then
        u6 = true;
        u7 = os.clock();
        u8 = math.clamp(u8 - v16.Y, -1.3962634015954636, 1.3962634015954636);
        u9 = (u9 - v16.X) % 6.283185307179586;
    end;

    if u6 then
        if os.clock() - u7 > 3 then
            u6 = false;
        end;
    else
        local v17, v18 = pitchAndYawFromDirection(AssemblyLinearVelocity);
        u8 = v17;
        u9 = v18;
    end;

    u2 = u2:Lerp(CFrame.fromEulerAnglesYXZ(u8, u9, 0), (math.min(p15 * (u6 and 15 or 5), 1)));
    u5 = u5:Lerp(AssemblyLinearVelocity * 3 * (u6 and 0 or 1), (math.min(p15 * 10, 1)));
    u4 = u4 - AssemblyLinearVelocity * p15;
    u4 = u4:Lerp(Vector3.new(0, 0, 0), (math.min(p15 * 15, 1)));
    local v19 = u4 + Vector3.new(0, u13.height, 0) + u2:PointToWorldSpace((Vector3.new(0, 0, u13.distance)));
    local v20 = u5 + Vector3.new(0, u13.height * 0.5, 0);
    u3 = u3:Lerp(CFrame.lookAt(v19, v20, Vector3.new(0, 1, 0)), (math.min(p15 * (u6 and 15 or 5), 1)));
    CurrentCamera.CFrame = CFrame.new(Chassis.Position) * u3;
    CurrentCamera.Focus = CFrame.new(Chassis.Position);
end;

local function initializeValues() -- Line: 136
    -- upvalues: u2 (ref), Chassis (copy), u3 (ref), CurrentCamera (copy), u4 (ref), u5 (ref)
    u2 = Chassis.CFrame - Chassis.CFrame.Position;
    u3 = CFrame.new(Chassis.Position):ToObjectSpace(CurrentCamera.CFrame);
    u4 = Vector3.new(0, 0, 0);
    u5 = Vector3.new(0, 0, 0);
end;

return {
    setParameters = function(p21, p22) -- Line: 147, Name: setParameters
        -- upvalues: u13 (ref)
        u13 = p22;
    end,

    enable = function(p23) -- Line: 151, Name: enable
        -- upvalues: u12 (ref), u10 (ref), InputCategorizer (copy), onLastInputCategoryChanged (copy), u2 (ref), Chassis (copy), u3 (ref), CurrentCamera (copy), u4 (ref), u5 (ref), RunService (copy), Value (copy), update (copy)
        if u12 then
            return;
        end;

        u12 = true;
        u10 = InputCategorizer.lastInputCategoryChanged:Connect(onLastInputCategoryChanged);
        onLastInputCategoryChanged(InputCategorizer.getLastInputCategory());
        u2 = Chassis.CFrame - Chassis.CFrame.Position;
        u3 = CFrame.new(Chassis.Position):ToObjectSpace(CurrentCamera.CFrame);
        u4 = Vector3.new(0, 0, 0);
        u5 = Vector3.new(0, 0, 0);
        RunService:BindToRenderStep("CarChaseCamera", Value, update);
    end,

    disable = function(p24) -- Line: 164, Name: disable
        -- upvalues: u12 (ref), u10 (ref), u1 (copy), RunService (copy)
        if not u12 then
            return;
        end;

        u12 = false;

        if u10 then
            u10:Disconnect();
            u10 = nil;
        end;

        for _, v in u1 do
            v:disable();
        end;

        RunService:UnbindFromRenderStep("CarChaseCamera");
    end
};