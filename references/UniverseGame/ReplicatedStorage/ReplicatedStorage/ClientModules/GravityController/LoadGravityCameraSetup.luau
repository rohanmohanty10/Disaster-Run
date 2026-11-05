  

 

if game["Run Service"]:IsClient() then
    local PlayerModule = game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule");
    local CameraInjector = script:WaitForChild("CameraInjector");
    require(CameraInjector);
    local CameraModule = PlayerModule:WaitForChild("CameraModule");
    local FakeUserSettings = require(script:WaitForChild("FakeUserSettings"));
    local UserGameSettings = FakeUserSettings():GetService("UserGameSettings");
    local u1 = FakeUserSettings():SafeIsUserFeatureEnabled("UserFlagEnableNewVRSystem");
    local u2 = 0.15;
    local u3 = Vector3.new(0, 1, 0);
    local u4 = CFrame.new();
    local Terrain = workspace.Terrain;
    local u5 = Terrain;
    local CFrame2 = Terrain.CFrame;
    local u6 = CFrame.new();

    local function getRotationBetween(p7, p8, p9) -- Line: 40
        local v10 = p7:Dot(p8);
        local v11 = p7:Cross(p8);

        if v10 < -0.99999 then
            return CFrame.fromAxisAngle(p9, 3.141592653589793);
        end;

        return CFrame.new(0, 0, 0, v11.x, v11.y, v11.z, 1 + v10);
    end;

    local function twistAngle(p12, p13) -- Line: 46
        local v14, v15 = p12:ToAxisAngle();
        local v16 = math.cos(v15 / 2);
        local v17 = math.sin(v15 / 2) * v14;
        local v18 = v17:Dot(p13) * p13;
        local _, v19 = CFrame.new(0, 0, 0, v18.x, v18.y, v18.z, v16):ToAxisAngle();
        local v20 = v17:Dot(p13);

        return math.sign(v20) * v19;
    end;

    local function calculateUpCFrame(p21) -- Line: 55
        -- upvalues: u3 (ref), getRotationBetween (copy), u2 (ref), u4 (ref)
        local v22 = getRotationBetween(u3, p21:GetUpVector(u3), workspace.CurrentCamera.CFrame.RightVector);
        local v23 = CFrame.new():Lerp(v22, u2);
        u3 = v23 * u3;
        u4 = v23 * u4;
    end;

    local function calculateSpinCFrame(p24) -- Line: 66
        -- upvalues: Terrain (ref), u5 (ref), CFrame2 (ref), u3 (ref), twistAngle (copy), u6 (ref)
        local v25;

        if Terrain == u5 then
            local v26 = Terrain.CFrame - Terrain.CFrame.p;
            local v27 = CFrame2 - CFrame2.p;
            local v28 = v26:VectorToObjectSpace(u3);
            v25 = twistAngle(v27:ToObjectSpace(v26), v28);
        else
            v25 = 0;
        end;

        u6 = CFrame.fromEulerAnglesYXZ(0, v25, 0);
        u5 = Terrain;
        CFrame2 = Terrain.CFrame;
    end;

    local u29 = require(CameraModule);
    local CameraInput = require(CameraModule:WaitForChild("CameraInput"));
    local BaseCamera = require(CameraModule:WaitForChild("BaseCamera"));
    local Poppercam = require(CameraModule:WaitForChild("Poppercam"));
    local CameraUtils = require(CameraModule:WaitForChild("CameraUtils"));
    local ControlModule = require(PlayerModule:WaitForChild("ControlModule"));
    require(PlayerModule);
    local u79 = {
        Load = {},

        LoadCamera = function(p30) -- Line: 101, Name: LoadCamera
            -- upvalues: CameraModule (copy), Terrain (ref), u2 (ref), u1 (copy), calculateUpCFrame (copy), calculateSpinCFrame (copy), u4 (ref), u6 (ref), CameraInput (copy), u29 (copy)
            if p30 ~= true then
                require(CameraModule);

                return;
            end;

            local v31 = require(CameraModule);

            function v31.GetUpVector(p32) -- Line: 105
                return p32;
            end;

            function v31.SetSpinpart(p33) -- Line: 109
                -- upvalues: Terrain (ref)
                Terrain = p33;
            end;

            function v31.SetTransitionRate(p34) -- Line: 113
                -- upvalues: u2 (ref)
                u2 = p34;
            end;

            function v31.GetTransitionRate() -- Line: 117
                -- upvalues: u2 (ref)
                return u2;
            end;

            function v31.Update(p35, p36) -- Line: 121
                -- upvalues: u1 (ref), calculateUpCFrame (ref), calculateSpinCFrame (ref), u4 (ref), u6 (ref), CameraInput (ref)
                if p35.activeCameraController then
                    p35.activeCameraController:UpdateMouseBehavior();
                    local v37, v38 = p35.activeCameraController:Update(p36);
                    local v39 = CFrame.new(v38.p);

                    if not u1 then
                        p35.activeCameraController:ApplyVRTransform();
                    end;

                    calculateUpCFrame(p35, p36);
                    calculateSpinCFrame(p35);
                    local v40 = p35.activeMouseLockController and p35.activeMouseLockController:GetIsMouseLocked() and Vector3.new(-1.75, 0, 0) or Vector3.new(0, 0, 0);
                    local v41 = v39:ToObjectSpace(v37);
                    local v42 = u4 * u6 * v41;
                    local v43 = v39 - v37:VectorToWorldSpace(v40) + v42:VectorToWorldSpace(v40);
                    local v44 = v43 * v42;

                    if p35.activeOcclusionModule then
                        v44, v43 = p35.activeOcclusionModule:Update(p36, v44, v43);
                    end;

                    game.Workspace.CurrentCamera.CFrame = v44;
                    game.Workspace.CurrentCamera.Focus = v43;

                    if p35.activeTransparencyController then
                        p35.activeTransparencyController:Update();
                    end;

                    if CameraInput.getInputEnabled() then
                        CameraInput.resetInputForFrameEnd();
                    end;
                end;
            end;

            function v31.IsFirstPerson(p45) -- Line: 164
                if p45.activeCameraController then
                    return p45.activeCameraController.inFirstPerson;
                end;

                return false;
            end;

            function v31.IsMouseLocked(p46) -- Line: 171
                if p46.activeCameraController then
                    return p46.activeCameraController:GetIsMouseLocked();
                end;

                return false;
            end;

            function v31.IsToggleMode(p47) -- Line: 178
                if p47.activeCameraController then
                    return p47.activeCameraController.isCameraToggle;
                end;

                return false;
            end;

            function v31.IsCamRelative(p48) -- Line: 185
                return p48:IsMouseLocked() or p48:IsFirstPerson();
            end;
        end,

        LoadBaseCam = function(p49) -- Line: 195, Name: LoadBaseCam
            -- upvalues: CameraModule (copy), u4 (ref), UserGameSettings (copy), BaseCamera (copy)
            if p49 ~= true then
                require(CameraModule:WaitForChild("BaseCamera"));

                return;
            end;

            local BaseCamera2 = require(CameraModule:WaitForChild("BaseCamera"));

            function BaseCamera2.CalculateNewLookCFrameFromArg(p50, p51, p52) -- Line: 199
                -- upvalues: u4 (ref)
                local v53 = u4:VectorToObjectSpace(p51 or p50:GetCameraLookVector());
                local v54 = math.asin(v53.y);
                local v55 = math.clamp(p52.y, v54 + -1.3962634015954636, v54 + 1.3962634015954636);
                local v56 = Vector2.new(p52.x, v55);
                local v57 = CFrame.new(Vector3.new(0, 0, 0), v53);

                return CFrame.Angles(0, -v56.x, 0) * v57 * CFrame.Angles(-v56.y, 0, 0);
            end;

            function BaseCamera2.CalculateNewLookCFrame(p58, p59) -- Line: 212
                return p58:CalculateNewLookCFrameFromArg(p59, p58.rotateInput);
            end;

            local UpdateMouseBehavior = BaseCamera2.UpdateMouseBehavior;

            function BaseCamera2.UpdateMouseBehavior(p60) -- Line: 218
                -- upvalues: UpdateMouseBehavior (copy), UserGameSettings (ref)
                UpdateMouseBehavior(p60);

                if UserGameSettings.RotationType == Enum.RotationType.CameraRelative then
                    UserGameSettings.RotationType = Enum.RotationType.MovementRelative;
                end;
            end;
        end,

        LoadPopper = function(p61) -- Line: 230, Name: LoadPopper
            -- upvalues: CameraModule (copy), Poppercam (copy)
            if p61 ~= true then
                require(CameraModule:WaitForChild("Poppercam"));

                return;
            end;

            local Poppercam2 = require(CameraModule:WaitForChild("Poppercam"));
            local ZoomController = require(CameraModule:WaitForChild("ZoomController"));

            function Poppercam2.Update(p62, p63, p64, p65, p66) -- Line: 237
                -- upvalues: ZoomController (copy)
                local v67 = p65 * (p64 - p64.p);
                local v68 = p62.focusExtrapolator:Step(p63, v67);
                local v69 = ZoomController.Update(p63, v67, v68);

                return v67 * CFrame.new(0, 0, v69), p65;
            end;
        end,

        LoadUtil = function(p70) -- Line: 249, Name: LoadUtil
            -- upvalues: CameraModule (copy), u4 (ref), CameraUtils (copy)
            if p70 == true then
                require(CameraModule:WaitForChild("CameraUtils")).GetAngleBetweenXZVectors = function(p71, p72) -- Line: 253, Name: GetAngleBetweenXZVectors
                    -- upvalues: u4 (ref)
                    local v73 = u4:VectorToObjectSpace(p71);
                    local v74 = u4:VectorToObjectSpace(p72);

                    return math.atan2(v74.X * v73.Z - v74.Z * v73.X, v74.X * v73.X + v74.Z * v73.Z);
                end;

                return;
            end;

            require(CameraModule:WaitForChild("CameraUtils"));
        end,

        LoadControl = function(p75) -- Line: 264, Name: LoadControl
            -- upvalues: PlayerModule (copy), ControlModule (copy)
            if p75 ~= true then
                require(PlayerModule:WaitForChild("ControlModule"));

                return;
            end;

            local ControlModule2 = require(PlayerModule:WaitForChild("ControlModule"));
            local TouchJump = require(PlayerModule.ControlModule:WaitForChild("TouchJump"));

            function ControlModule2.IsJumping(p76) -- Line: 269
                if not p76.activeController then
                    return false;
                end;

                local v77 = p76.activeController:GetIsJumping() or p76.touchJumpController and p76.touchJumpController:GetIsJumping();

                return v77;
            end;

            local UpdateEnabled = TouchJump.UpdateEnabled;

            function TouchJump.UpdateEnabled(p78) -- Line: 279
                -- upvalues: UpdateEnabled (copy)
                p78.jumpStateEnabled = true;
                UpdateEnabled(p78);
            end;
        end
    };

    function u79.LoadAll() -- Line: 289
        -- upvalues: u79 (copy)
        for i, v in pairs(u79) do
            if i ~= "UnloadAll" and (i ~= "LoadAll" and typeof(v) == "function") then
                print("exe" .. i, v);
                v(true);
            end;
        end;
    end;

    function u79.UnloadAll() -- Line: 300
        -- upvalues: u79 (copy)
        for i, v in pairs(u79) do
            if i ~= "UnloadAll" and i ~= "LoadAll" then
                v(false);
            end;
        end;
    end;

    require(CameraModule:WaitForChild("VehicleCamera"));
    local VehicleCameraCore = require(CameraModule.VehicleCamera:WaitForChild("VehicleCameraCore"));
    local setTransform = VehicleCameraCore.setTransform;

    function VehicleCameraCore.setTransform(p80, p81) -- Line: 313
        -- upvalues: u4 (ref), setTransform (copy)
        return setTransform(p80, u4:ToObjectSpace(p81 - p81.p) + p81.p);
    end;

    return u79;
end;