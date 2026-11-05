  

 

local TweenService = game:GetService("TweenService");
local CurrentCamera = workspace.CurrentCamera;

return function(u1, p2) -- Line: 4
    -- upvalues: CurrentCamera (copy), TweenService (copy)
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local u3 = false;
    local u4 = nil;
    local u5 = nil;
    u4 = u1:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 13
        -- upvalues: u3 (ref), CurrentCamera (ref), u4 (ref), u5 (ref)
        u3 = true;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        u4:Disconnect();
        u5:Disconnect();
        u4 = nil;
        u5 = nil;
    end);
    u5 = p2:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 21
        -- upvalues: u3 (ref), CurrentCamera (ref), u4 (ref), u5 (ref)
        u3 = true;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        u4:Disconnect();
        u5:Disconnect();
        u4 = nil;
        u5 = nil;
    end);
    wait(0.8);

    if u1.Parent ~= workspace.Living or p2.Parent ~= workspace.Living then
        return;
    end;

    local u6 = -1;
    local u7 = 0;
    local _ = u1.HumanoidRootPart.CFrame;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    local function updcam(p8, p9, p10) -- Line: 35
        -- upvalues: CurrentCamera (ref), TweenService (ref)
        CurrentCamera.CFrame = p8;

        if p9 then
            CurrentCamera.FieldOfView = p9;
        end;

        if p10 then
            TweenService:Create(CurrentCamera, p10[1], p10[2]);
        end;
    end;

    local v12 = game["Run Service"].RenderStepped:Connect(function(p11) -- Line: 43
        -- upvalues: u7 (ref)
        u7 = u7 + p11;
    end);
    local u43 = {
        [0] = function() -- Line: 47
            -- upvalues: u1 (copy), u7 (ref), CurrentCamera (ref), TweenService (ref)
            local v13, v14, v15 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(-1.5 - u7 / 10, -0.5, -5)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0).Position);
            CurrentCamera.CFrame = v13;

            if v14 then
                CurrentCamera.FieldOfView = v14;
            end;

            if v15 then
                TweenService:Create(CurrentCamera, v15[1], v15[2]);
            end;
        end,

        [1] = function() -- Line: 50
            -- upvalues: u1 (copy), u7 (ref), CurrentCamera (ref), TweenService (ref)
            local v16, v17, v18 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(u7 / 10 + 1, -0.5, -5)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0).Position);
            CurrentCamera.CFrame = v16;

            if v17 then
                CurrentCamera.FieldOfView = v17;
            end;

            if v18 then
                TweenService:Create(CurrentCamera, v18[1], v18[2]);
            end;
        end,

        [2] = function() -- Line: 53
            -- upvalues: u1 (copy), CurrentCamera (ref), TweenService (ref)
            local v19, v20, v21 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(-0.2, 0.5, -3.5)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0).Position);
            CurrentCamera.CFrame = v19;

            if v20 then
                CurrentCamera.FieldOfView = v20;
            end;

            if v21 then
                TweenService:Create(CurrentCamera, v21[1], v21[2]);
            end;
        end,

        [3] = function() -- Line: 56
            -- upvalues: u1 (copy), CurrentCamera (ref), TweenService (ref)
            local v22, v23, v24 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(2, 1.7, 3.5)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, -3).Position);
            CurrentCamera.CFrame = v22;

            if v23 then
                CurrentCamera.FieldOfView = v23;
            end;

            if v24 then
                TweenService:Create(CurrentCamera, v24[1], v24[2]);
            end;
        end,

        [4] = function() -- Line: 59
            -- upvalues: u1 (copy), CurrentCamera (ref), TweenService (ref)
            local v25, v26, v27 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(2, 1.7, 3.5)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, -3).Position);
            CurrentCamera.CFrame = v25;

            if v26 then
                CurrentCamera.FieldOfView = v26;
            end;

            if v27 then
                TweenService:Create(CurrentCamera, v27[1], v27[2]);
            end;
        end,

        [5] = function() -- Line: 62
            -- upvalues: u1 (copy), CurrentCamera (ref), TweenService (ref)
            local v28, v29, v30 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(-3, 2, 1)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 2, -3).Position);
            CurrentCamera.CFrame = v28;

            if v29 then
                CurrentCamera.FieldOfView = v29;
            end;

            if v30 then
                TweenService:Create(CurrentCamera, v30[1], v30[2]);
            end;
        end,

        [6] = function() -- Line: 65
            -- upvalues: u1 (copy), CurrentCamera (ref), TweenService (ref)
            local v31, v32, v33 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(0, 12, -6)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 2, -6).Position);
            CurrentCamera.CFrame = v31;

            if v32 then
                CurrentCamera.FieldOfView = v32;
            end;

            if v33 then
                TweenService:Create(CurrentCamera, v33[1], v33[2]);
            end;
        end,

        [7] = function() -- Line: 68
            -- upvalues: u1 (copy), u7 (ref), CurrentCamera (ref), TweenService (ref)
            local v34, v35, v36 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(0, 6, -12 - u7 * 2)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 2, -6).Position);
            CurrentCamera.CFrame = v34;

            if v35 then
                CurrentCamera.FieldOfView = v35;
            end;

            if v36 then
                TweenService:Create(CurrentCamera, v36[1], v36[2]);
            end;
        end,

        [8] = function() -- Line: 71
            -- upvalues: u1 (copy), u7 (ref), CurrentCamera (ref), TweenService (ref)
            local v37, v38, v39 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(u7 / 10 + 3, 2, 1)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 2, -6).Position);
            CurrentCamera.CFrame = v37;

            if v38 then
                CurrentCamera.FieldOfView = v38;
            end;

            if v39 then
                TweenService:Create(CurrentCamera, v39[1], v39[2]);
            end;
        end,

        [9] = function() -- Line: 74
            -- upvalues: u1 (copy), u7 (ref), CurrentCamera (ref), TweenService (ref)
            local v40, v41, v42 = CFrame.new((u1.HumanoidRootPart.CFrame * CFrame.new(-3 - u7 / 10, 2, 1)).Position, u1.HumanoidRootPart.CFrame * CFrame.new(0, 2, -3).Position);
            CurrentCamera.CFrame = v40;

            if v41 then
                CurrentCamera.FieldOfView = v41;
            end;

            if v42 then
                TweenService:Create(CurrentCamera, v42[1], v42[2]);
            end;
        end
    };

    local function rs() -- Line: 78
        -- upvalues: u3 (ref), u6 (ref), u43 (copy), u7 (ref)
        if not u3 then
            u6 = u6 + 1;
            u43[u6]();
            u7 = 0;
        end;
    end;

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(3);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(4.8);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(2);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(1);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(1.5);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(1.5);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(0.75);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(1.75);

    if not u3 then
        u6 = u6 + 1;
        u43[u6]();
        u7 = 0;
    end;

    wait(1.3);
    v12:Disconnect();

    if u4 then
        u4:Disconnect();
    end;

    if u5 then
        u5:Disconnect();
    end;

    if not u3 then
        CurrentCamera.CameraType = Enum.CameraType.Custom;
    end;
end;