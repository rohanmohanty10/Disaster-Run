 

 

local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil");
local UserFlag = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD");
local UserFlag2 = v1.getUserFlag("UserControlModuleEnabledAPI");
local StarterPlayer = game:GetService("StarterPlayer");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local Workspace = game:GetService("Workspace");
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
local UserFlag3 = v1.getUserFlag("UserAbilitiesUserInterfaceB");
local u2 = UserFlag3 and "ControlState" or "PlayerControlState";
local u3 = {};
u3.__index = u3;

function u3._calculatePlayerInputValues(p4: userdata) -- Line: 15
    local Character = p4.Character;

    if Character == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");

    if Humanoid == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false;
    end;

    local InputContexts = p4:FindFirstChild("InputContexts");

    if InputContexts == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false;
    end;

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext");

    if CharacterContext == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false;
    end;

    local MoveAction = CharacterContext.MoveAction;
    local RotationAction = CharacterContext:FindFirstChild("RotationAction");
    local v5;

    if RotationAction == nil then
        v5 = false;
    else
        v5 = RotationAction:GetState();
    end;

    local function isValidInput2D(p6) -- Line: 36
        return p6.X == p6.X and (p6.Y == p6.Y and p6.X ~= (1 / 0)) and p6.Y ~= (1 / 0);
    end;

    local function isValidInput3D(p7: vector) -- Line: 44
        return p7.X == p7.X and (p7.Y == p7.Y and (p7.Z == p7.Z and (p7.X ~= (1 / 0) and p7.Y ~= (1 / 0)))) and p7.Z ~= (1 / 0);
    end;

    local v8;

    if MoveAction == nil then
        v8 = Vector2.new(0, 0);
    else
        v8 = MoveAction:GetState();
    end;

    local LookVector = p4:GetCameraState().CFrame.LookVector;

    if v8.X ~= v8.X or (v8.Y ~= v8.Y or v8.X == (1 / 0)) or v8.Y == (1 / 0) or (LookVector.X ~= LookVector.X or (LookVector.Y ~= LookVector.Y or (LookVector.Z ~= LookVector.Z or (LookVector.X == (1 / 0) or LookVector.Y == (1 / 0)))) or LookVector.Z == (1 / 0) or LookVector.Magnitude <= 0) then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false;
    end;

    if Humanoid and Humanoid:GetState() ~= Enum.HumanoidStateType.Swimming then
        LookVector = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    end;

    local Unit = LookVector:Cross(Vector3.new(0, 1, 0)).Unit;

    return LookVector * v8.Y + Unit * v8.X, LookVector, v5;
end;

function u3.CloneInputsIfAbsent(p9: userdata) -- Line: 74
    -- upvalues: StarterPlayer (copy)
    if p9:FindFirstChild("InputContexts") then
        return;
    end;

    local v10 = StarterPlayer.PlayerModule.InputContexts:Clone();
    v10.CharacterContext.Enabled = true;
    v10.CameraContext.Enabled = true;
    v10.Parent = p9;
end;

function u3.FireCustomInputs(p11: userdata) -- Line: 83
    -- upvalues: UserGameSettings (copy)
    local InputContexts = p11:FindFirstChild("InputContexts");

    if not InputContexts then
        return;
    end;

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext");

    if not CharacterContext then
        return;
    end;

    if not InputContexts:FindFirstChild("CameraContext") then
        return;
    end;

    local RotationAction = CharacterContext:FindFirstChild("RotationAction");
    local v12 = RotationAction and RotationAction:FindFirstChild("RotationScriptableBinding");

    if v12 then
        v12:Fire(UserGameSettings.RotationType == Enum.RotationType.CameraRelative);
    end;
end;

function u3.SendInputToCCLCharacter(p13: userdata) -- Line: 102
    -- upvalues: AvatarAbilitiesInterface (copy), u3 (copy)
    if not p13 then
        return;
    end;

    local v14 = AvatarAbilitiesInterface.get(p13);
    local InputContexts = p13:FindFirstChild("InputContexts");

    if not InputContexts then
        return;
    end;

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext");

    if not CharacterContext then
        return;
    end;

    for _, v in v14:GetAbilities() do
        local v15 = CharacterContext:FindFirstChild(v .. "Action");

        if v15 then
            v14:SendInput(v, v15:GetState());
        end;
    end;

    local v16, v17, v18 = u3._calculatePlayerInputValues(p13);
    v14:SendInput("Move", v16);
    v14:SendInput("CameraLookDirection", v17);
    v14:SendInput("CameraRelativeRotation", v18);
end;

function u3.SendInputToHumanoidForServerAuth(p19: userdata) -- Line: 123
    -- upvalues: u3 (copy)
    local Character = p19.Character;

    if Character == nil then
        return;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");

    if Humanoid == nil then
        return;
    end;

    local InputContexts = p19:FindFirstChild("InputContexts");

    if InputContexts == nil then
        return;
    end;

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext");

    if CharacterContext == nil then
        return;
    end;

    local JumpAction = CharacterContext.JumpAction;
    local v20, v21, v22 = u3._calculatePlayerInputValues(p19);
    Humanoid:Move(v20);
    Humanoid.AutoRotate = not v22;

    if v22 and (Humanoid.SeatPart == nil and (Humanoid.RootPart ~= nil and not (Humanoid.Sit or Humanoid.RootPart:IsGrounded()))) then
        Humanoid.RootPart.CFrame = CFrame.new(Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + v21);
    end;

    local v23;

    if JumpAction == nil then
        v23 = false;
    else
        v23 = JumpAction:GetState();
    end;

    Humanoid.Jump = v23;
end;

function u3.setupPlayerControlState(p24) -- Line: 152
    p24:AddVector3Field("Move", Vector3.new(0, 0, 0), 1);
    p24:AddBoolField("Jump", false);
    p24:AddBoolField("RotateToLookDirection", false);
    p24:AddUnitVector3Field("LookDirection", Vector3.new(0, 0, 1));
end;

function u3.watchForPlayerControlState(p25: userdata) -- Line: 160
    -- upvalues: u2 (copy), u3 (copy)
    local function watchCharacter(p26: userdata) -- Line: 161
        -- upvalues: u2 (ref), u3 (ref)
        local function onPCSAdded(p27: userdata) -- Line: 162
            -- upvalues: u2 (ref), u3 (ref)
            if p27:IsA(u2) then
                u3.setupPlayerControlState(p27);
            end;
        end;

        local v28 = p26:FindFirstChildOfClass(u2);

        if v28 then
            u3.setupPlayerControlState(v28);
        end;

        p26.ChildAdded:Connect(onPCSAdded);
    end;

    if p25.Character then
        local Character = p25.Character;

        local function v30(p29: userdata) -- Line: 162
            -- upvalues: u2 (ref), u3 (ref)
            if p29:IsA(u2) then
                u3.setupPlayerControlState(p29);
            end;
        end;

        local v31 = Character:FindFirstChildOfClass(u2);

        if v31 then
            u3.setupPlayerControlState(v31);
        end;

        Character.ChildAdded:Connect(v30);
    end;

    p25.CharacterAdded:Connect(watchCharacter);
end;

function u3.createPlayerControlState(u32: userdata) -- Line: 176
    -- upvalues: UserFlag3 (copy), u2 (copy), u3 (copy)
    local function createForCharacter(p33: userdata) -- Line: 177
        -- upvalues: UserFlag3 (ref), u2 (ref), u32 (copy), u3 (ref)
        if UserFlag3 then
            if p33:FindFirstChildOfClass(u2) then
                return;
            end;
        elseif p33:FindFirstChild(u2) then
            return;
        end;

        local Instance_new_ret = Instance.new(u2);
        Instance_new_ret.Owner = u32;
        Instance_new_ret.Parent = p33;
        u3.setupPlayerControlState(Instance_new_ret);
    end;

    if u32.Character then
        local Character = u32.Character;
        local v34;

        if UserFlag3 then
            if not Character:FindFirstChildOfClass(u2) then
                v34 = Instance.new(u2);
                v34.Owner = u32;
                v34.Parent = Character;
                u3.setupPlayerControlState(v34);
            end;
        elseif not Character:FindFirstChild(u2) then
            v34 = Instance.new(u2);
            v34.Owner = u32;
            v34.Parent = Character;
            u3.setupPlayerControlState(v34);
        end;
    end;

    u32.CharacterAdded:Connect(createForCharacter);
end;

function u3.writeInputToPCS(p35: userdata, p36: any, p37: boolean) -- Line: 193
    -- upvalues: UserFlag2 (copy), UserFlag3 (copy), u2 (copy), UserGameSettings (copy), Workspace (copy), UserFlag (copy), AvatarAbilitiesInterface (copy)
    local v38;

    if UserFlag2 then
        v38 = p36.data;
    else
        v38 = nil;
    end;

    local Character = p35.Character;

    if not Character then
        return;
    end;

    local v39;

    if UserFlag3 then
        v39 = Character:FindFirstChildOfClass(u2);
    else
        v39 = Character:FindFirstChild(u2);
    end;

    if not v39 then
        return;
    end;

    local humanoid = p36.humanoid;

    if not humanoid then
        return;
    end;

    local v40;

    if p37 then
        v40 = p35:FindFirstChild("InputContexts");
    else
        v40 = script.Parent.Parent:FindFirstChild("InputContexts");
    end;

    local v41, v42;

    if UserFlag2 then
        v41 = v38.isJumping;
        v42 = v38.worldMoveVector;
    else
        if v40 then
            v40 = v40:FindFirstChild("CharacterContext");
        end;

        if not v40 then
            return;
        end;

        local MoveAction = v40:FindFirstChild("MoveAction");
        local JumpAction = v40:FindFirstChild("JumpAction");
        local v43;

        if MoveAction then
            v43 = MoveAction:GetState();
        else
            v43 = Vector2.zero;
        end;

        if JumpAction then
            v41 = JumpAction:GetState();
        else
            v41 = false;
        end;

        v42 = p36:calculateRawMoveVector(humanoid, (Vector3.new(v43.X, 0, -v43.Y)));
    end;

    local v44 = UserGameSettings.RotationType == Enum.RotationType.CameraRelative;
    local v45 = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
    local Vector3_new_ret = Vector3.new(v45.X, 0, v45.Z);
    local v46 = {
        Move = v42,
        RotateToLookDirection = v44,
        LookDirection = Vector3_new_ret.Magnitude <= 0.001 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit
    };

    if not (UserFlag and AvatarAbilitiesInterface.get(p35):isEnabled()) then
        v46.Jump = v41;
    end;

    v39:UpdateFields(v46);
end;

function u3.processPCSInputs(p47: userdata) -- Line: 247
    -- upvalues: UserFlag3 (copy), u2 (copy)
    local Character = p47.Character;

    if Character == nil then
        return;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");

    if Humanoid == nil then
        return;
    end;

    local v48;

    if UserFlag3 then
        v48 = Character:FindFirstChildOfClass(u2);
    else
        v48 = Character:FindFirstChild(u2);
    end;

    if v48 == nil then
        return;
    end;

    local State = v48:GetState();
    local Move = State.Move;
    local Jump = State.Jump;
    local RotateToLookDirection = State.RotateToLookDirection;
    local LookDirection = State.LookDirection;

    if Move then
        Humanoid:Move(Move);
    end;

    Humanoid.AutoRotate = not RotateToLookDirection;

    if RotateToLookDirection and (LookDirection ~= nil and (Humanoid.RootPart ~= nil and not (Humanoid.Sit or (Humanoid.SeatPart ~= nil or Humanoid.RootPart:IsGrounded())))) then
        Humanoid.RootPart.CFrame = CFrame.new(Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + LookDirection);
    end;

    Humanoid.Jump = Jump or false;
end;

return u3;