 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local u1 = script:FindFirstAncestor("BallController");
local Basketball = ReplicatedStorage.Basketball;
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local workspace_Gravity = workspace.Gravity;
local u5 = 0;
local u6 = nil;

local function debugPart(p7, p8) -- Line: 31
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Name = "DEBUG";
    Part.CFrame = CFrame.new(p7);
    Part.Anchored = true;
    Part.Transparency = 0;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Parent = workspace;
    game.Debris:AddItem(Part, p8 or 2);

    return Part;
end;

local function calculateBallTrajectory(p9: vector, p10: vector, p11: number, p12: number?) -- Line: 48
    -- upvalues: workspace_Gravity (copy)
    local v13 = p12 or workspace_Gravity;
    local v14 = p10 - p9;
    local Vector3_new_ret = Vector3.new(v14.X, 0, v14.Z);
    local Magnitude = Vector3_new_ret.Magnitude;
    local Unit = Vector3_new_ret.Unit;
    local v15 = (p11 + math.sqrt(p11 ^ 2 - v14.Y * 2 * v13)) / v13;

    return Magnitude / v15 * Unit + p11 * Vector3.new(0, 1, 0), v15;
end;

local function modifyBallGravityAsync(p16, p17, p18) -- Line: 70
    -- upvalues: workspace_Gravity (copy), u6 (ref), Debris (copy)
    local BodyForce = Instance.new("BodyForce");
    BodyForce.Name = "ExtraGravity";
    BodyForce.Force = Vector3.new(0, (1 - p18) * workspace_Gravity * u6.AssemblyMass, 0);
    BodyForce.Parent = u6;
    Debris:AddItem(BodyForce, p17);
    local v19 = 0;

    while v19 < p17 do
        local v20 = u6.Position - p16;

        if v20:Dot(v20) <= 4 then
            break;
        end;

        v19 = v19 + task.wait();
    end;

    BodyForce:Destroy();
end;

local function destroyBallBodyMoversAsync(p21, p22) -- Line: 91
    -- upvalues: u2 (ref), LocalPlayer (copy), u6 (ref), u3 (ref)
    local v23 = 0;

    while v23 < p22 do
        if u2.getBallNetworkOwner(p21) ~= LocalPlayer then
            return;
        end;

        for _, child in u6:GetChildren() do
            if child:IsA("BodyVelocity") or (child:IsA("LinearVelocity") or child:IsA("AlignPosition")) then
                child:Destroy();
                u3.Remove:Fire();

                return;
            end;
        end;

        v23 = v23 + task.wait();
    end;
end;

local function applyDragToBall(p24, p25) -- Line: 117
    -- upvalues: u5 (ref), u2 (ref), u6 (ref)
    u5 = u5 - p25;

    if u5 > 0 then
        return;
    end;

    u5 = 0;

    if u2.getPlayerPossessingBall(p24) or (not u2.localPlayerIsBallNetworkOwner(p24) or u6.Position.Y > 15) then
        u5 = 0.5;

        return;
    end;

    local AssemblyLinearVelocity = u6.AssemblyLinearVelocity;
    local v26 = 0.999 - p25 * 0.01;
    u6.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X * v26, AssemblyLinearVelocity.Y, AssemblyLinearVelocity.Z * v26);
end;

local function heartbeat(p27, p28) -- Line: 139
    -- upvalues: u6 (ref), Basketball (copy)
    u6 = Basketball.Value;

    if u6 == nil or u6.Parent == nil then
    end;
end;

return {
    initialize = function(u29) -- Line: 149, Name: initializeBallPhysicsClient
        -- upvalues: u3 (ref), Knit (copy), u4 (ref), u2 (ref), u1 (copy), RunService (copy), u6 (ref), Basketball (copy)
        u3 = Knit.GetService("BallService");
        u4 = Knit.GetController("FeatureFlagController");
        u2 = require(u1.BallStateClient);

        if u4:GetFeatureFlag("EnableBallPhysicsRewrite") then
            RunService.Heartbeat:Connect(function(p30) -- Line: 155
                -- upvalues: u29 (copy), u6 (ref), Basketball (ref)
                u6 = Basketball.Value;

                if u6 == nil or u6.Parent ~= nil then
                end;
            end);
        end;
    end,

    teleportServerBallToPlayerAnimationBall = function(p31) -- Line: 238, Name: teleportServerBallToPlayerAnimationBall
        -- upvalues: u6 (ref), Basketball (copy), u2 (ref)
        u6 = Basketball.Value;
        local Components, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42 = u2.getLastCharacterToPossessBall(p31).PlrBall.Anims.BALL.CFrame:GetComponents();
        local math_clamp_ret = math.clamp(Components, -152.5, 152.39999389648438);
        local math_clamp_ret2 = math.clamp(v32, 1.5, 500);
        local math_clamp_ret3 = math.clamp(v33, -387.5, -207.5);
        u6.CFrame = CFrame.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3, v34, v35, v36, v37, v38, v39, v40, v41, v42);
    end,

    ballSpeedIsLessThan = function(p43, p44) -- Line: 228, Name: ballSpeedIsLessThan
        -- upvalues: u6 (ref)
        if u6 == nil then
            return true;
        end;

        local AssemblyLinearVelocity = u6.AssemblyLinearVelocity;

        return AssemblyLinearVelocity:Dot(AssemblyLinearVelocity) < p44 ^ 2;
    end,

    throwBall = function(p45, p46, p47) -- Line: 162, Name: throwBall
        -- upvalues: LocalPlayer (copy), u2 (ref), workspace_Gravity (copy), u6 (ref), modifyBallGravityAsync (copy), destroyBallBodyMoversAsync (copy)
        local v48 = p47 or {};

        if typeof(p46) ~= "Vector3" then
            error((`{p46} is not a Vector3!`));
        end;

        if typeof(v48) ~= "table" then
            error((`{v48} is not a table!`));
        end;

        local v49 = v48.GravityMultiplier or 1;
        local v50 = v48.VerticalVelocity or 60;
        local v51;

        if v48.CleanUpBodyMovers == nil then
            v51 = false;
        else
            v51 = v48.CleanUpBodyMovers;
        end;

        if typeof(v49) ~= "number" then
            error((`Options.GravityMultiplier = {v49} is not a number!`));
        end;

        if typeof(v50) ~= "number" then
            error((`Options.VerticalVelocity = {v50} is not a number!`));
        end;

        if typeof(v51) ~= "boolean" then
            error((`Options.CleanUpBodyMovers = {v51} is not a boolean!`));
        end;

        if LocalPlayer:GetAttribute("DesyncPlr") then
            return;
        end;

        if u2.getBallNetworkOwner(p45) ~= LocalPlayer then
            error((`LocalPlayer "{LocalPlayer}" can't throw the ball because they aren't the network owner of the ball!`));
        end;

        local CFrame2 = u2.getLastCharacterToPossessBall(p45).PlrBall.Anims.BALL.CFrame;
        local v52 = v49 or workspace_Gravity;
        local v53 = p46 - CFrame2.Position;
        local Vector3_new_ret = Vector3.new(v53.X, 0, v53.Z);
        local Magnitude = Vector3_new_ret.Magnitude;
        local Unit = Vector3_new_ret.Unit;
        local v54 = (v50 + math.sqrt(v50 ^ 2 - v53.Y * 2 * v52)) / v52;
        u6.CFrame = CFrame2;
        u6.AssemblyLinearVelocity = Magnitude / v54 * Unit + v50 * Vector3.new(0, 1, 0);

        if math.abs(1 - v49) > 0.01 then
            task.spawn(modifyBallGravityAsync, p46, v54, v49);
        end;

        if v48.CleanUpBodyMovers then
            task.spawn(destroyBallBodyMoversAsync, v54);
        end;
    end
};