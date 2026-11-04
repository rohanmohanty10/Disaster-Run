  

local function cutsceneCharacter() -- Line: 3
    for _, child in workspace:GetChildren() do
        if child:IsA("Model") and (child:GetAttribute("CutsceneChar") and (child:GetAttribute("AikuSelfishCaptainActor") and (child:FindFirstChild("Head") and child.Head:FindFirstChild("FlowAuraEyes")))) then
            return child;
        end;
    end;

    error("Selfish Captain replacement character is missing");
end;

local function prepareScenePhysics() -- Line: 9
    -- upvalues: cutsceneCharacter (copy)
    local VFX = workspace:FindFirstChild("VFX");

    if not VFX then
        return;
    end;

    local u1 = {};

    for _, v in { VFX, cutsceneCharacter() } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("BasePart") then
                table.insert(u1, descendant);
            end;
        end;
    end;

    local function enforce() -- Line: 19
        -- upvalues: u1 (copy)
        for _, v in u1 do
            if v.Parent then
                v.CanCollide = false;
                v.CanTouch = false;
                v.CanQuery = false;
            end;
        end;
    end;

    for _, v in u1 do
        if v.Parent then
            v.CanCollide = false;
            v.CanTouch = false;
            v.CanQuery = false;
        end;
    end;

    local u2 = game:GetService("RunService").PreSimulation:Connect(enforce);
    VFX.Destroying:Once(function() -- Line: 26
        -- upvalues: u2 (copy)
        u2:Disconnect();
    end);
end;

local function impactFlash() -- Line: 29
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer.PlayerGui:FindFirstChild("AikuSelfishCaptainImpactFrames");
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("Flash");
    end;

    if not LocalPlayer then
        return;
    end;

    LocalPlayer.BackgroundColor3 = Color3.new(1, 1, 1);
    LocalPlayer.Visible = true;
    task.wait(0.03333333333333333);

    if not LocalPlayer.Parent then
        return;
    end;

    LocalPlayer.BackgroundColor3 = Color3.new(0, 0, 0);
    task.wait(0.03333333333333333);

    if LocalPlayer.Parent then
        LocalPlayer.Visible = false;
    end;
end;

local u5 = {
    { 1, function() -- Line: 43
            -- upvalues: prepareScenePhysics (copy)
            prepareScenePhysics();
            shared.vfx.emit(workspace.VFX.SelfishCaptain_CutsceneVFX.BlackBox);
        end },
    { 1, function() -- Line: 47
            -- upvalues: cutsceneCharacter (copy)
            local v3 = cutsceneCharacter();
            shared.vfx.emit(v3.Head.FlowAuraEyes);
            shared.vfx.emit(v3["Right Leg"].FlowAuraRightLeg, v3.Torso.FlowAuraTorso, v3["Right Arm"].FlowAuraRightArm, v3["Left Leg"].FlowAuraLeftLeg, v3["Left Arm"].FlowAuraLeftArm);
        end },
    { 2, function() -- Line: 53
            shared.vfx.emit(workspace.VFX.SelfishCaptain_CutsceneVFX.CamZoom);
        end },
    { 634, function() -- Line: 56
            shared.vfx.emit(workspace.VFX.SelfishCaptain_CutsceneVFX.ShotStartup);
        end },
    { 636, function() -- Line: 59
            -- upvalues: cutsceneCharacter (copy)
            local v4 = cutsceneCharacter();
            shared.vfx.emit(v4.Head.FlowAuraEyes2);
            shared.vfx.emit(workspace.VFX.SelfishCaptain_CutsceneVFX.WindGust2);
        end },
    { 701, function() -- Line: 65
            -- upvalues: impactFlash (copy)
            task.spawn(impactFlash);
            shared.vfx.emit(workspace.VFX.SelfishCaptain_CutsceneVFX.Shot);
            shared.vfx.emit(workspace.VFX.SelfishCaptain_CutsceneVFX.WindGust2);
        end }
};

return function(u6) -- Line: 73
    -- upvalues: u5 (copy)
    task.spawn(function() -- Line: 74
        -- upvalues: u6 (copy), u5 (ref)
        local v7 = 0;

        while u6:IsPlaying() do
            local CurrentFrame = u6.CurrentFrame;

            for _, v in u5 do
                if v[1] <= CurrentFrame and v7 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v7 = CurrentFrame;
        end;
    end);
end;