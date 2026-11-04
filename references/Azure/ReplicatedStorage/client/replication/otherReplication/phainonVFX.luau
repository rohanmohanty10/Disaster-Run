 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local packets = require(ReplicatedStorage.packets);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = {};

local function is_local_character(p2) -- Line: 25
    -- upvalues: LocalPlayer (copy), Players (copy)
    return LocalPlayer == Players:GetPlayerFromCharacter(p2);
end;

local function get_stride_resources() -- Line: 29
    -- upvalues: vfxUtil (copy)
    local Resources = vfxUtil.getResources();

    if Resources then
        Resources = Resources:FindFirstChild("phainon");
    end;

    if Resources then
        return Resources:FindFirstChild("Stride");
    end;

    return nil;
end;

local function get_mouse_hit_position(p3) -- Line: 38
    -- upvalues: LocalPlayer (copy), UserInputService (copy), workspace_CurrentCamera (copy)
    local Mouse = LocalPlayer:GetMouse();

    if Mouse and Mouse.Hit then
        return Mouse.Hit.Position;
    end;

    local MouseLocation = UserInputService:GetMouseLocation();
    local v4 = workspace_CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p3 };
    local v5 = workspace:Raycast(v4.Origin, v4.Direction * 800, RaycastParams_new_ret);

    if v5 then
        return v5.Position;
    end;

    local v6 = v4.Origin + v4.Direction * 80;
    local X = v6.X;
    local Y = p3:GetPivot().Position.Y;

    return Vector3.new(X, Y, v6.Z);
end;

function u1.phainon_stride(p7: any, p8: boolean?, p9: boolean?) -- Line: 58
    -- upvalues: vfxUtil (copy), mainreplication (copy), LocalPlayer (copy), Players (copy)
    local Root = vfxUtil.getRoot(p7);

    if not Root then
        return;
    end;

    local v10 = p9 and 92 or 78;
    local v11 = p9 and 0.7 or 0.45;
    local v12 = vfxUtil.character_trove(p7);
    v12:Add(function() -- Line: 68
        -- upvalues: mainreplication (ref)
        mainreplication.fov(true, 70, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);

    if LocalPlayer == Players:GetPlayerFromCharacter(p7) then
        local v13 = mainreplication.bodyVelocity(Root, v10, v11, true, "LookVector", nil, TweenInfo.new(v11, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0));

        if v13 then
            v12:Add(v13);
        end;

        mainreplication.fov(true, 78, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    local Resources = vfxUtil.getResources();

    if Resources then
        Resources = Resources:FindFirstChild("phainon");
    end;

    local v14;

    if Resources then
        v14 = Resources:FindFirstChild("Stride");
    else
        v14 = nil;
    end;

    local v15 = v14 and (v14:FindFirstChild("VFX") or v14:FindFirstChild("Rush"));

    if v15 then
        local v16 = v12:Construct(v15);

        if v16:IsA("Model") then
            vfxUtil.setupAura(p7, v16, true);
            v16.Parent = workspace.Effects;
        elseif v16:IsA("Attachment") then
            v16.Parent = Root;
        end;

        local Compiled = v14:FindFirstChild("Compiled");

        if Compiled then
            vfxUtil.execute_compiled(Compiled, v12, v16);
        end;
    end;

    v12:Add(task.delay(v11 + 0.35, v12.Destroy, v12));
end;

function u1.phainon_stride_land(p17: any, p18: any, p19: boolean?) -- Line: 109
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), Players (copy), mainreplication (copy)
    if not p18 then
        return;
    end;

    local Root = vfxUtil.getRoot(p17);

    if not Root then
        return;
    end;

    if LocalPlayer == Players:GetPlayerFromCharacter(p17) then
        mainreplication.cameraShake(12, 0.45, 3, nil);
    end;

    local Resources = vfxUtil.getResources();

    if Resources then
        Resources = Resources:FindFirstChild("phainon");
    end;

    local v20;

    if Resources then
        v20 = Resources:FindFirstChild("Stride");
    else
        v20 = nil;
    end;

    local v21 = v20 and (v20:FindFirstChild("Land") or v20:FindFirstChild("Slash"));

    if v21 then
        local v22 = vfxUtil.character_trove(p17);
        local v23 = v22:Construct(v21);

        if v23:IsA("Model") then
            vfxUtil.setupAura(p17, v23, true);
            v23.Parent = workspace.Effects;
        elseif v23:IsA("Attachment") then
            v23.Parent = Root;
        end;

        local Compiled = v20:FindFirstChild("Compiled");

        if Compiled then
            vfxUtil.execute_compiled(Compiled, v22, v23);
        end;

        v22:Add(task.delay(1.5, v22.Destroy, v22));
    end;

    if p19 then
        return;
    end;

    if vfxUtil.getRoot(p18) and LocalPlayer == Players:GetPlayerFromCharacter(p18) then
        mainreplication.highlight(p18, Color3.fromRGB(255, 120, 60), 0.35);
    end;
end;

function u1.phainon_stride_clash_loop(p24, p25) -- Line: 153
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), Players (copy), mainreplication (copy)
    if not p25 then
        return;
    end;

    local Root = vfxUtil.getRoot(p24);

    if not Root then
        return;
    end;

    if LocalPlayer == Players:GetPlayerFromCharacter(p24) or LocalPlayer == Players:GetPlayerFromCharacter(p25) then
        mainreplication.fov(true, 58, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    end;

    local Resources = vfxUtil.getResources();

    if Resources then
        Resources = Resources:FindFirstChild("phainon");
    end;

    local v26;

    if Resources then
        v26 = Resources:FindFirstChild("Stride");
    else
        v26 = nil;
    end;

    local v27 = v26 and (v26:FindFirstChild("Clash") or v26:FindFirstChild("ClashLoop"));

    if v27 then
        local v28 = vfxUtil.character_trove(p24);
        local v29 = v28:Construct(v27);

        if v29:IsA("Model") then
            vfxUtil.setupAura(p24, v29, true);
            v29.Parent = workspace.Effects;
        elseif v29:IsA("Attachment") then
            v29.Parent = Root;
        end;

        v28:Add(task.delay(1.35, v28.Destroy, v28));
    end;
end;

function u1.phainon_stride_clash_resolve(p30: any, p31: any, p32: boolean?) -- Line: 184
    -- upvalues: LocalPlayer (copy), Players (copy), mainreplication (copy), vfxUtil (copy)
    if not p31 then
        return;
    end;

    if LocalPlayer == Players:GetPlayerFromCharacter(p30) then
        mainreplication.fov(true, 70, 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

        if p32 then
            mainreplication.cameraShake(14, 0.55, 4, nil);
        else
            mainreplication.cameraShake(10, 0.35, 2, nil);
        end;
    end;

    local Resources = vfxUtil.getResources();

    if Resources then
        Resources = Resources:FindFirstChild("phainon");
    end;

    local v33;

    if Resources then
        v33 = Resources:FindFirstChild("Stride");
    else
        v33 = nil;
    end;

    if not v33 then
        return;
    end;

    local v34 = v33:FindFirstChild(p32 and "ClashWin" or "ClashFail");

    if v34 then
        local v35 = vfxUtil.character_trove(p30);
        local v36 = v35:Construct(v34);

        if v36:IsA("Model") then
            vfxUtil.setupAura(p30, v36, true);
            v36.Parent = workspace.Effects;
        elseif v36:IsA("Attachment") then
            v36.Parent = vfxUtil.getRoot(p30);
        end;

        v35:Add(task.delay(1.5, v35.Destroy, v35));
    end;
end;

function u1.phainon_pyric_corpus(p37: any, p38: string?) -- Line: 218
end;

function u1.phainon_deliverance(p39: any, p40: boolean?) -- Line: 220
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), Players (copy), mainreplication (copy)
    if not p40 then
        return;
    end;

    local Root = vfxUtil.getRoot(p39);

    if not Root then
        return;
    end;

    if LocalPlayer == Players:GetPlayerFromCharacter(p39) then
        mainreplication.springcamerashake(25, 35);
    end;

    local Resources = vfxUtil.getResources();

    if Resources then
        Resources = Resources:FindFirstChild("phainon");
    end;

    if Resources then
        Resources = Resources:FindFirstChild("Deliverance");
    end;

    if not Resources then
        return;
    end;

    local v41 = vfxUtil.character_trove(p39);
    local v42 = Resources:FindFirstChild("Feint") or Resources:FindFirstChild("Pyric");

    if v42 then
        local v43 = v41:Construct(v42);

        if v43:IsA("Attachment") then
            v43.Parent = Root;
            shared.vfx.emit(v43);
        else
            v43.Parent = workspace.Effects;

            if v43:IsA("Model") then
                vfxUtil.setupAura(p39, v43, true);
            end;
        end;
    end;

    v41:Add(task.delay(1.2, v41.Destroy, v41));
end;

function u1.phainon_let_there_be_light(p44: any, p45: boolean?) -- Line: 258
end;

function u1.phainon_let_there_be_light_shot(p46: any, p47: boolean?) -- Line: 260
end;

function u1.phainon_agony_windup(p48) -- Line: 262
end;

function u1.phainon_agony(p49, p50) -- Line: 264
end;

function u1.phainon_tear_open_aim(u51) -- Line: 266
    -- upvalues: LocalPlayer (copy), Players (copy), vfxUtil (copy), trove (copy), packets (copy), UserInputService (copy), RunService (copy), get_mouse_hit_position (copy)
    if LocalPlayer ~= Players:GetPlayerFromCharacter(u51) then
        return;
    end;

    local Root = vfxUtil.getRoot(u51);

    if not Root then
        return;
    end;

    local u52 = trove.new();
    u52:AttachToInstance(u51);
    local Color3_fromRGB_ret = Color3.fromRGB(255, 140, 50);
    local Part = Instance.new("Part");
    Part.Name = "PhainonTearTarget";
    Part.Size = Vector3.new(5, 0.15, 5);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret;
    Part.Transparency = 0.35;
    Part.Parent = workspace.Effects;
    u52:Add(Part);
    local Part2 = Instance.new("Part");
    Part2.Shape = Enum.PartType.Cylinder;
    Part2.Size = Vector3.new(0.1, 8, 8);
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Material = Enum.Material.Neon;
    Part2.Color = Color3_fromRGB_ret;
    Part2.Transparency = 0.55;
    Part2.Parent = workspace.Effects;
    u52:Add(Part2);
    local u53 = Root.Position + Root.CFrame.LookVector * 45;
    local u54 = false;

    local function confirm_shot() -- Line: 311
        -- upvalues: u54 (ref), packets (ref), u53 (ref), u52 (copy)
        if u54 then
            return;
        end;

        u54 = true;
        packets.bytenet_use.send({ "skill5", u53 });
        u52:Destroy();
    end;

    u52:Add(UserInputService.InputBegan:Connect(function(p55, p56) -- Line: 320
        -- upvalues: u54 (ref), packets (ref), u53 (ref), u52 (copy)
        if p56 or u54 then
            return;
        end;

        if p55.UserInputType == Enum.UserInputType.MouseButton1 or p55.UserInputType == Enum.UserInputType.Touch then
            if u54 then
                return;
            end;

            u54 = true;
            packets.bytenet_use.send({ "skill5", u53 });
            u52:Destroy();
        end;
    end));
    local os_clock_ret = os.clock();
    u52:Add(RunService.RenderStepped:Connect(function() -- Line: 334
        -- upvalues: u53 (ref), get_mouse_hit_position (ref), u51 (copy), packets (ref), Part (copy), Part2 (copy), u54 (ref), os_clock_ret (copy), u52 (copy)
        u53 = get_mouse_hit_position(u51) or u53;
        packets.bytenet_use.send({ "phainon_aim", u53 });
        Part.CFrame = CFrame.new(u53 + Vector3.new(0, 0.1, 0));
        Part2.CFrame = CFrame.new(u53 + Vector3.new(0, 0.05, 0)) * CFrame.Angles(0, 0, 1.5707963267948966);

        if not u54 and os.clock() - os_clock_ret >= 5 then
            if u54 then
                return;
            end;

            u54 = true;
            packets.bytenet_use.send({ "skill5", u53 });
            u52:Destroy();
        end;
    end));
    u52:Add(task.delay(5.5, u52.Destroy, u52));
end;

function u1.phainon_tear_open_meteor(p57: any, p58: vector?) -- Line: 349
    -- upvalues: vfxUtil (copy)
    if vfxUtil.getRoot(p57) and typeof(p58) == "Vector3" then
    end;
end;

function u1.phainon_tear_open_sky(p59: any, p60: vector?, p61: boolean?, p62: number?) -- Line: 358
    -- upvalues: u1 (copy)
    u1.phainon_tear_open_meteor(p59, p60);
end;

function u1.phainon_awaken(p63: any, p64: number?) -- Line: 367
end;

function u1.phainon_flow_blackhole(p65) -- Line: 369
end;

function u1.phainon_flow_blackhole_end(p66) -- Line: 371
end;

return u1;