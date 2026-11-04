 
 

game:GetService("CollectionService");
game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
game:GetService("SoundService");
game:GetService("TextService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local u1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local raycast = require(ReplicatedStorage.util.raycast);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local script_xamillmesh = require(script.xamillmesh);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.client.replication.TekrinnDialogue);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);

function u1.deflect() -- Line: 36
    -- upvalues: LocalPlayer (copy), animationUtil (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local Humanoid = Character.Humanoid;
    local _ = Character.HumanoidRootPart;
    local v2 = nil;

    for _, v in Humanoid.Animator:GetPlayingAnimationTracks() do
        if v.Name == "DashL" then
            v2 = "L";
        elseif v == "DashR" then
            v2 = "R";
        end;
    end;

    local v3 = (Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall) and "J" or v2;
    animationUtil:loadAnimation(Character, ReplicatedStorage.Resources.gkAssets["Deflect" .. (v3 or "F")]):Play();
end;

function u1.legacyballShockwave(u4, u5) -- Line: 71
    -- upvalues: RunService (copy), ReplicatedStorage (copy), Debris (copy), TweenService (copy)
    local l_time = time;
    local u6 = l_time() + 0.05;
    local u7 = nil;
    local u11 = RunService.PreRender:connect(function(p8) -- Line: 78
        -- upvalues: u4 (copy), u7 (ref), l_time (ref), u6 (ref), ReplicatedStorage (ref), u5 (copy), Debris (ref), TweenService (ref)
        if not u4:IsDescendantOf(game) then
            return;
        end;

        if not u4:FindFirstChild("velocity") then
            return;
        end;

        local Value = u4.velocity.Value;

        if Value.Magnitude < 150 then
            if u7 then
                u7:Destroy();
            end;

            return;
        end;

        if not u7 then
            l_time = time;
            u6 = l_time() + 0.05;
            u7 = ReplicatedStorage.Resources.shockwave:Clone();
            u7.Parent = u5;
            u7.Weld.Part0 = u5;
        end;

        if l_time and u6 then
            local v9 = l_time();

            if u6 > v9 then
                return;
            end;

            u6 = v9 + 0.05;
        end;

        local Position = u4.Value.Position;
        local CFrame_lookAt_ret = CFrame.lookAt(Position, Position + Value);
        local v10 = ReplicatedStorage.Resources.ballShockwave:Clone();
        v10.Parent = workspace.Effects;
        v10:PivotTo(CFrame_lookAt_ret);
        Debris:AddItem(v10, 0.3);

        for _, descendant in ipairs(v10:GetDescendants()) do
            if descendant:IsA("SpecialMesh") then
                local Scale = descendant.Scale;
                descendant.Scale = Vector3.new(0, 0, 0);
                TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Scale = Scale
                }):Play();
            elseif descendant:IsA("Decal") then
                TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
    local u12 = nil;
    u12 = u4.AncestryChanged:Once(function() -- Line: 131
        -- upvalues: u11 (ref), u12 (ref)
        if u11 then
            u11:Disconnect();
        end;

        if u12 then
            u12:Disconnect();
        end;
    end);
    task.delay(1, u12.Disconnect, u12);
    task.delay(1, u11.Disconnect, u11);
end;

function u1.ballShockwave(u13, u14, u15) -- Line: 140
    -- upvalues: RunService (copy), ReplicatedStorage (copy), vfxUtil (copy), Util (copy), LocalPlayer (copy), Debris (copy), TweenService (copy)
    local l_time = time;
    local u16 = l_time() + 0.1;
    local u17 = nil;
    local u18 = nil;
    u18 = RunService.PreRender:connect(function(p19) -- Line: 148
        -- upvalues: u13 (copy), u18 (ref), u17 (ref), u14 (copy), ReplicatedStorage (ref), vfxUtil (ref), Util (ref), LocalPlayer (ref), u15 (copy), l_time (ref), u16 (ref), Debris (ref), TweenService (ref)
        if not (u13 and u13:IsDescendantOf(game)) then
            u18:Disconnect();

            return;
        end;

        if not u13:FindFirstChild("velocity") then
            return;
        end;

        local Value = u13.velocity.Value;

        if Value.Magnitude > 30 then
            if u17 then
                u17.CFrame = u13.Value;
            else
                u17 = u14 and u14:Clone() or ReplicatedStorage.Resources.shockwave:Clone();
                u17.Anchored = true;
                u17.CFrame = u13.Value;
                u17.Parent = workspace.Effects;

                if u17:GetAttribute("EmitBallEffect") then
                    vfxUtil.forge.emit(u17);
                end;

                if u14 and Util.canshiftcolor(LocalPlayer, u15) then
                    vfxUtil.LeanTowardsColor(u17, u15:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u15:GetAttribute("CustomAlpha") or 0.985);
                end;
            end;
        elseif u17 then
            u17:Destroy();
        end;

        if l_time and u16 then
            local v20 = l_time();

            if u16 > v20 then
                return;
            end;

            u16 = v20 + 0.1;
        end;

        l_time = time;
        u16 = l_time() + 0.1;

        if Value.Magnitude >= 100 then
            local Position = u13.Value.Position;
            local CFrame_lookAt_ret = CFrame.lookAt(Position, Position + Value);
            local v21 = ReplicatedStorage.Resources.ballShockwave:Clone();
            v21.Parent = workspace.Effects;
            v21:PivotTo(CFrame_lookAt_ret * CFrame.Angles(0, 3.141592653589793, 0));
            Debris:AddItem(v21, 0.1);
            TweenService:Create(v21["2"], TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                CFrame = v21["2"].CFrame * CFrame.Angles(0, 0.8726646259971648, 0)
            }):Play();
            TweenService:Create(v21["2"].w1m, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Scale = Vector3.new(5.593, 5, 5.497)
            }):Play();
            TweenService:Create(v21["2"].w1d, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            TweenService:Create(v21["1"].Mesh, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Scale = Vector3.new(0.482, 0.03, 0.03)
            }):Play();
            TweenService:Create(v21["1"].Decal, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end);
    local u22 = nil;
    u22 = u13.AncestryChanged:Once(function() -- Line: 278
        -- upvalues: u18 (ref), u22 (ref), u17 (ref)
        if u18 then
            u18:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u17 then
            for _, descendant in u17:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u17.Destroy, u17);
        end;
    end);
    task.delay(1, u22.Disconnect, u22);
    task.delay(1, u18.Disconnect, u18);
    task.delay(1, function() -- Line: 297
        -- upvalues: u17 (ref)
        if u17 then
            for _, descendant in u17:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u17.Destroy, u17);
        end;
    end);
end;

function u1.gkthrow(p23) -- Line: 309
    -- upvalues: mainreplication (copy)
    mainreplication.fov(true, 120, 1.117, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    task.wait(1.117);
    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.cameraShake(10, 2, 10);
end;

function u1.ballhitground(p24, p25) -- Line: 317
    -- upvalues: ReplicatedStorage (copy), soundUtil (copy)
    if p24 then
        local v26 = ReplicatedStorage.Resources.groundhit:Clone();
        v26.Position = p24;
        v26.Parent = workspace.Effects;

        for _, descendant in ipairs(v26:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        soundUtil:play(ReplicatedStorage.Resources[`ball hit ground {Random.new():NextInteger(1, 3)}`], v26);
        task.delay(3, v26.Destroy, v26);
    end;
end;

function u1.ballwhizz(p27, p28) -- Line: 335
    -- upvalues: ReplicatedStorage (copy), soundUtil (copy)
    local v29 = ReplicatedStorage.Resources.groundhit:Clone();
    v29.Position = p27;
    v29.Parent = workspace.Effects;
    soundUtil:play(ReplicatedStorage.Resources[`ball hit ground {Random.new():NextInteger(1, 3)}`], v29);
    task.delay(3, v29.Destroy, v29);
end;

function u1.volleyLine(p30, p31) -- Line: 345
    -- upvalues: actionUtil (copy), LocalPlayer (copy), ReplicatedStorage (copy), TweenService (copy), vfxUtil (copy)
    if p31 and actionUtil.checkGK(LocalPlayer.Character) then
        local u32 = ReplicatedStorage.Resources.VolleyIndicator:Clone();
        u32.CFrame = p31;
        u32.Parent = workspace.Effects;
        local v33 = TweenService:Create(u32.Attachment1, TweenInfo.new(1), {
            CFrame = u32.Attachment0.CFrame
        });
        v33:Play();
        v33.Completed:Once(function() -- Line: 354
            -- upvalues: TweenService (ref), u32 (copy)
            TweenService:Create(u32, TweenInfo.new(1), {
                Transparency = 1
            }):Play();
        end);
        vfxUtil.disposal(u32, 2);
    end;
end;

function u1.shockwaveVolley(p34, p35) -- Line: 363
    -- upvalues: u1 (copy), script_xamillmesh (copy), ReplicatedStorage (copy), mainreplication (copy), Players (copy), LocalPlayer (copy)
    local v36 = p34.HumanoidRootPart or p34.PrimaryPart;
    u1.volleyLine(p34, p35);
    script_xamillmesh.StartMeshEmitter(v36, ReplicatedStorage.Resources.LowForward, CFrame.identity, 1.5);
    mainreplication.cameraShake(30, 1.35, 7);

    if Players:GetPlayerFromCharacter(p34) == LocalPlayer then
        mainreplication.ultFlash(0.5, 0.5);
    end;
end;

function u1.raycastEffect(p37, p38) -- Line: 378
    -- upvalues: raycast (copy)
    local v39 = raycast(p37.Position, Vector3.new(0, 1, 0) * -p37.Size.Y * 2);

    if v39 and v39.Instance.Transparency < 1 then
        local v40 = p38:Clone();
        v40.Parent = workspace.Effects;
        v40.CFrame = CFrame.new(v39.Position, v39.Position + p37.CFrame.LookVector);

        for _, descendant in ipairs(v40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(15);
                descendant.Color = ColorSequence.new(v39.Instance.Color);
            end;
        end;

        task.delay(3, v40.Destroy, v40);
    end;
end;

function u1.legacyrunDash(u41) -- Line: 397
    -- upvalues: Players (copy), mainreplication (copy), RunService (copy), TweenService (copy), soundUtil (copy), ReplicatedStorage (copy), u1 (copy)
    local u42 = u41.HumanoidRootPart or u41.PrimaryPart;
    local u43 = u41:FindFirstChildOfClass("Humanoid");
    local u44;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u41) then
        mainreplication.destroyPosition(u41);
        u44 = Instance.new("BodyPosition");
        u44.MaxForce = Vector3.new(30000, 0, 30000);
        u44.P = 2500;
        u44.D = 500;
        u44.Parent = u42;
        local v46 = RunService.PreRender:Connect(function(p45) -- Line: 436
            -- upvalues: u44 (ref), u42 (copy)
            u44.Position = u42.CFrame.LookVector * 1.55 + u42.Position;
        end);
        task.delay(0.25, v46.Disconnect, v46);
        task.delay(0.25, u44.Destroy, u44);
        TweenService:Create(u44, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            P = 12500,
            D = 300
        }):Play();
    else
        u44 = nil;
    end;

    task.delay(0.25, function() -- Line: 449
        -- upvalues: u43 (copy), soundUtil (ref), ReplicatedStorage (ref), u42 (copy), u44 (ref), u41 (copy), TweenService (ref), u1 (ref), Players (ref), mainreplication (ref), RunService (ref)
        if u43.FloorMaterial == Enum.Material.Air then
            soundUtil:play(ReplicatedStorage.Resources["Air dash"], u42);
        else
            soundUtil:play(ReplicatedStorage.Resources["Air dash dashed"], u42);
        end;

        if u44 then
            u44:Destroy();
        end;

        local u47 = ReplicatedStorage.Resources.runEff:Clone();
        u47.Weld.Part0 = u42;
        u47.Parent = u41;
        local u48 = false;
        task.delay(0.55, function() -- Line: 464
            -- upvalues: u48 (ref), u47 (copy)
            u48 = true;

            for _, descendant in ipairs(u47:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u47.Destroy, u47);
        end);
        task.spawn(function() -- Line: 474
            -- upvalues: u48 (ref), ReplicatedStorage (ref), u41 (ref), u42 (ref), TweenService (ref)
            while not u48 do
                local v49 = ReplicatedStorage.Resources.Wl:Clone();
                v49.Parent = u41;
                v49.CFrame = u42.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
                v49.Size = Vector3.new(4.924, 6.935, 7.16);
                v49.Mesh.Scale = Vector3.new(0.127, 0.231, 0.23);
                task.delay(0.5, v49.Destroy, v49);
                TweenService:Create(v49.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                TweenService:Create(v49.Mesh, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = Vector3.new(0.556, 0.153, 0.157)
                }):Play();
                TweenService:Create(v49, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(17.813, 4.602, 4.884),
                    CFrame = v49.CFrame * CFrame.new(4, 0, 0)
                }):Play();
                task.wait(0.1);
            end;
        end);
        u1.raycastEffect(u42, ReplicatedStorage.Resources.DashSmoke, 3);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u41) then
            return;
        end;

        mainreplication.cameraShake(15, 0.35, 5);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local BodyPosition = Instance.new("BodyPosition");
        BodyPosition.MaxForce = Vector3.new(30000, 0, 30000);
        BodyPosition.P = 12500;
        BodyPosition.D = 300;
        BodyPosition.Parent = u42;
        local v51 = RunService.PreRender:Connect(function(p50) -- Line: 504
            -- upvalues: BodyPosition (copy), u42 (ref)
            BodyPosition.Position = u42.CFrame.LookVector * 3.55 + u42.Position;
        end);
        task.delay(0.55, v51.Disconnect, v51);
        task.delay(0.55, BodyPosition.Destroy, BodyPosition);
        task.wait(0.275);
        TweenService:Create(BodyPosition, TweenInfo.new(0.55, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            P = 2500,
            D = 500
        }):Play();
    end);
end;

function u1.runDash(u52, u53, u54, p55) -- Line: 519
    -- upvalues: Players (copy), soundUtil (copy), ReplicatedStorage (copy), mainreplication (copy), TweenService (copy), Lighting (copy)
    local u56 = Players.LocalPlayer == Players:GetPlayerFromCharacter(u52);
    local u57 = u52.HumanoidRootPart or u52.PrimaryPart;
    u52:FindFirstChildOfClass("Humanoid");
    local u58 = 0.7;
    task.delay(p55 or 0.133, function() -- Line: 528
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), u57 (copy), mainreplication (ref), TweenService (ref), u58 (ref), u54 (copy), u53 (copy), u52 (copy), u56 (copy), Lighting (ref)
        soundUtil:play(ReplicatedStorage.Resources["Air dash"], u57);
        mainreplication.Emit(u57, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
        local u59 = ReplicatedStorage.Resources.rundasheff:Clone();
        u59.main.Weld.Part0 = u57;
        u59.Parent = workspace.Effects;
        local C0 = u59.main.Weld.C0;
        task.spawn(function() -- Line: 545
            -- upvalues: u59 (copy), u57 (ref), C0 (copy)
            while u59.Parent do
                local AssemblyLinearVelocity = u57.AssemblyLinearVelocity;

                if Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude > 0.1 then
                    local v60 = u57.CFrame:VectorToObjectSpace(AssemblyLinearVelocity);

                    if v60.Magnitude > 0.1 then
                        local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), v60.Unit);
                        u59.main.Weld.C0 = C0 * CFrame_lookAt_ret;
                    end;
                end;

                task.wait();
            end;
        end);
        u59.Air.Size = Vector3.new(4.998, 0.503, 4.998);
        u59.Air.Transparency = 0.8;
        local Air = u59.main.Air;
        Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
        TweenService:Create(u59.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            C0 = u59.main.Air.C0 * CFrame.new(0, 15, 0)
        }):Play();
        TweenService:Create(u59.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(17.136, 1.132, 16.878),
            Transparency = 1
        }):Play();
        u59.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u59.Wind1.Transparency = 0.9;
        TweenService:Create(u59.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 592
            -- upvalues: u59 (copy), TweenService (ref)
            u59.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u59.Wind1.Transparency = 0.9;
            TweenService:Create(u59.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
        end);
        u59.End.Size = Vector3.new(5, 1, 5);
        u59.End.Transparency = 0.65;
        local End = u59.main.End;
        End.C0 = End.C0 * CFrame.new(0, 0, 0);
        TweenService:Create(u59.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u59.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u59.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 626
            -- upvalues: u59 (copy), TweenService (ref)
            u59.End.Size = Vector3.new(5, 1, 5);
            u59.End.Transparency = 0.65;
            local End2 = u59.main.End;
            End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
            TweenService:Create(u59.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u59.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u59.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
        end);
        u59.A.Size = Vector3.new(14.29, 4.752, 5.444);
        u59.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
        u59.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
        u59.A.Decal.Transparency = 0.9;
        TweenService:Create(u59.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            C0 = u59.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
        }):Play();
        TweenService:Create(u59.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Size = Vector3.new(33.166, 4.752, 5.443)
        }):Play();
        TweenService:Create(u59.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(0.715, 0.303, 0.315)
        }):Play();
        TweenService:Create(u59.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        u58 = 0.55;

        if not u54 then
            local v61 = u53 and 150 or 170;
            local v62 = u52:GetAttribute("GoGoStriker") or u52:GetAttribute("AccelerateDashes");

            if v62 and v62 > 0 then
                local v63 = u52:GetAttribute("GoGoStriker") and "GoGoStriker" or "AccelerateDashes";
                v61 = v61 * (v63 == "AccelerateDashes" and 1.2 or 1.5);
                u52:SetAttribute(v63, v62 - 1);

                if u56 then
                    soundUtil:play(ReplicatedStorage.Resources["Air dash dashed"], u57);
                    local TweenInfo_new_ret = TweenInfo.new(0.4);
                    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                    ColorCorrectionEffect.TintColor = v63 == "AccelerateDashes" and Color3.new(0.4, 0.4, 0.4) or Color3.new(1, 0, 1);
                    ColorCorrectionEffect.Contrast = 0.5;
                    ColorCorrectionEffect.Parent = Lighting;
                    local BlurEffect = Instance.new("BlurEffect");
                    BlurEffect.Size = 8;
                    BlurEffect.Parent = Lighting;
                    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    TweenService:Create(BlurEffect, TweenInfo_new_ret, {
                        Size = 0
                    }):Play();
                    task.delay(TweenInfo_new_ret.Time, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
                    task.delay(TweenInfo_new_ret.Time, BlurEffect.Destroy, BlurEffect);
                end;
            end;

            mainreplication.bodyVelocity(u57, v61, u58, nil, nil, nil, TweenInfo.new(u58 + 0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
        end;

        task.delay(2, u59.Destroy, u59);

        if not u56 then
            return;
        end;

        mainreplication.cameraShake(10, 0.4, 5);
        mainreplication.fov(false, 75);
        mainreplication.fov(true, 70, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.getTackle(p64, p65) -- Line: 722
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Players (copy), Lighting (copy), TweenService (copy)
    local v66 = p65:FindFirstChild("HumanoidRootPart") or p65.PrimaryPart;
    local v67 = p64.HumanoidRootPart or p64.PrimaryPart;

    if v66 then
        mainreplication.Emit(v66, ReplicatedStorage.Resources.getTackleHit, 3, CFrame.new(0, -2, 0));
    end;

    mainreplication.bodyVelocity(v67, 110, 0.3, nil, nil, nil, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p64) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p65) then
        mainreplication.cameraShake(11, 0.5, 4);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p65) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(1, BlurEffect.Destroy, BlurEffect);
            local v68 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v68.Parent = Lighting;
            v68.TintColor = Color3.fromRGB(255, 255, 255);
            v68.Brightness = 0.4;
            v68.Contrast = 1;
            v68.Saturation = -1;
            TweenService:Create(v68, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.5, v68.Destroy, v68);
        end;
    end;
end;

function u1.getDoberman(p69, p70) -- Line: 779
    -- upvalues: Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
    if not p70.HumanoidRootPart then
        local _ = p70.PrimaryPart;
    end;

    if not p69.HumanoidRootPart then
        local _ = p69.PrimaryPart;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p69) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p70) then
        mainreplication.cameraShake(11, 1, 6);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p70) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(1, BlurEffect.Destroy, BlurEffect);
            local v71 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v71.Parent = Lighting;
            v71.TintColor = Color3.fromRGB(255, 255, 255);
            v71.Brightness = 0.4;
            v71.Contrast = 1;
            v71.Saturation = -1;
            TweenService:Create(v71, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.5, v71.Destroy, v71);
        end;
    end;
end;

function u1.doberman(p72) -- Line: 825
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), TweenService (copy), Players (copy)
    local v73 = p72.HumanoidRootPart or p72.PrimaryPart;
    local v74 = 1.75;
    task.wait(0.75);
    mainreplication.bodyVelocity(v73, 90, v74, nil, nil, nil, TweenInfo.new(v74 + 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
    mainreplication.Emit(v73, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
    local u75 = ReplicatedStorage.Resources.rundasheff:Clone();
    u75.main.Weld.Part0 = v73;
    u75.Parent = workspace.Effects;
    u75.Air.Size = Vector3.new(4.998, 0.503, 4.998);
    u75.Air.Transparency = 0.8;
    local Air = u75.main.Air;
    Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
    TweenService:Create(u75.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        C0 = u75.main.Air.C0 * CFrame.new(0, 15, 0)
    }):Play();
    TweenService:Create(u75.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(17.136, 1.132, 16.878),
        Transparency = 1
    }):Play();
    u75.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
    u75.Wind1.Transparency = 0.9;
    TweenService:Create(u75.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(19.108, 11.452, 11.292),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 880
        -- upvalues: u75 (copy), TweenService (ref)
        u75.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u75.Wind1.Transparency = 0.9;
        TweenService:Create(u75.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
    end);
    u75.End.Size = Vector3.new(5, 1, 5);
    u75.End.Transparency = 0.65;
    local End = u75.main.End;
    End.C0 = End.C0 * CFrame.new(0, 0, 0);
    TweenService:Create(u75.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        C0 = u75.main.End.C0 * CFrame.new(0, -15, 0)
    }):Play();
    TweenService:Create(u75.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        Size = Vector3.new(12.999, 2.766, 12.999),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 914
        -- upvalues: u75 (copy), TweenService (ref)
        u75.End.Size = Vector3.new(5, 1, 5);
        u75.End.Transparency = 0.65;
        local End2 = u75.main.End;
        End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
        TweenService:Create(u75.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u75.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u75.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
    end);
    u75.A.Size = Vector3.new(14.29, 4.752, 5.444);
    u75.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
    u75.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
    u75.A.Decal.Transparency = 0.9;
    TweenService:Create(u75.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        C0 = u75.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
    }):Play();
    TweenService:Create(u75.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Size = Vector3.new(33.166, 4.752, 5.443)
    }):Play();
    TweenService:Create(u75.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Scale = Vector3.new(0.715, 0.303, 0.315)
    }):Play();
    TweenService:Create(u75.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    task.delay(2, u75.Destroy, u75);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p72) then
        mainreplication.cameraShake(11, 1, 7);
    end;
end;

function u1.dash(p76, p77, u78) -- Line: 970
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), mainreplication (copy), RunService (copy)
    local u79 = p76.HumanoidRootPart or p76.PrimaryPart;
    local v80 = p77 and 0.45 or 0.6;
    local v81 = p77 and 180 or 110;

    if not p77 then
        if u78 then
            v81 = -v81 or v81;
        end;

        mainreplication.bodyVelocity(u79, v81, v80, nil, "RightVector", nil, TweenInfo.new(v80 + 0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

        return;
    end;

    soundUtil:play(ReplicatedStorage.Resources[u78 and "jumpgrab" or "rightgrab"], u79);
    local u82, u83 = mainreplication.bodyVelocity(u79, v81 + v81 * 0.2, v80, nil, nil, true, TweenInfo.new(v80 + 0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
    mainreplication.cameraShake(10, 1, 3);
    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

    if u82 then
        u82.MaxForce = Vector3.new(30000, 30000, 30000);
    end;

    local u84 = nil;
    u84 = RunService.PreRender:connect(function(p85) -- Line: 1002
        -- upvalues: u82 (copy), u84 (ref), u78 (copy), u79 (copy), u83 (copy)
        if not u82:IsDescendantOf(game) then
            u84:Disconnect();

            return;
        end;

        if u78 then
            u82.Velocity = u79.CFrame.RightVector * -u83.Value + u79.CFrame.UpVector * 5;

            return;
        end;

        u82.Velocity = u79.CFrame.RightVector * u83.Value + u79.CFrame.UpVector * 5;
    end);
end;

function u1.gkHitBallDash(p86) -- Line: 1028
    -- upvalues: mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy)
    local v87 = p86.HumanoidRootPart or p86.PrimaryPart;
    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.bright(0.1, 0.5);
    mainreplication.fov(false, 50);
    mainreplication.fov(true, 70, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    soundUtil:play(ReplicatedStorage.Resources.gkAssets[`catch {math.random(1, 3)}`], v87);
end;

function u1.slice(p88, p89) -- Line: 1042
    -- upvalues: ReplicatedStorage (copy), Players (copy), mainreplication (copy)
    local v90 = p88.HumanoidRootPart or p88.PrimaryPart;
    local v91 = p89 and 0.3 or 0.45;

    if not p89 then
        local u92 = ReplicatedStorage.Resources.armdrip:Clone();
        u92.Parent = p88;
        u92.Weld.Part0 = p88["Left Leg"];
        local u93 = ReplicatedStorage.Resources.armdrip:Clone();
        u93.Parent = p88;
        u93.Weld.Part0 = p88["Right Leg"];
        task.delay(v91, function() -- Line: 1057
            -- upvalues: u92 (copy), u93 (copy)
            for _, descendant in ipairs(u92:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(u93:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u92.Destroy, u92);
            task.delay(2, u93.Destroy, u93);
        end);
    end;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p88) then
        return;
    end;

    local v94 = mainreplication.bodyVelocity(v90, 200, v91 + (p89 and 0.3 or 0), nil, nil, nil, TweenInfo.new(v91 + 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));

    if v94 and p89 then
        v94.MaxForce = Vector3.new(30000, 30000, 30000);
    end;

    mainreplication.destroyPosition(p88);
end;

function u1.tackle(p95, p96) -- Line: 1093
    -- upvalues: mainreplication (copy), RunService (copy), ReplicatedStorage (copy), TweenService (copy)
    local u97 = p95.HumanoidRootPart or p95.PrimaryPart;
    local v98 = p96 and 0.5 or 0.45;

    if p96 then
        local u99, u100 = mainreplication.bodyVelocity(u97, 216, v98, nil, nil, true, TweenInfo.new(v98 + 0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
        mainreplication.cameraShake(10, 1, 3);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if u99 then
            u99.MaxForce = Vector3.new(30000, 30000, 30000);
            local u101 = nil;
            u101 = RunService.PreRender:connect(function(p102) -- Line: 1121
                -- upvalues: u99 (copy), u101 (ref), mainreplication (ref), u97 (copy), u100 (copy)
                if u99:IsDescendantOf(game) then
                    u99.Velocity = mainreplication.fixVelocity(u97, u97.CFrame.LookVector * u100.Value + u97.CFrame.UpVector * 5);

                    return;
                end;

                u101:Disconnect();
            end);
        end;
    else
        mainreplication.bodyVelocity(u97, 200, v98, nil, nil, nil, TweenInfo.new(v98 + 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
    end;

    mainreplication.Emit(u97, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
    local u103 = ReplicatedStorage.Resources.rundasheff:Clone();
    u103.main.Weld.C0 = CFrame.new(0, -2, 0);
    u103.main.Weld.Part0 = u97;
    u103.Parent = workspace.Effects;
    u103.Air.Size = Vector3.new(4.998, 0.503, 4.998);
    u103.Air.Transparency = 0.8;
    local Air = u103.main.Air;
    Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
    TweenService:Create(u103.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        C0 = u103.main.Air.C0 * CFrame.new(0, 15, 0)
    }):Play();
    TweenService:Create(u103.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(17.136, 1.132, 16.878),
        Transparency = 1
    }):Play();
    u103.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
    u103.Wind1.Transparency = 0.9;
    TweenService:Create(u103.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(19.108, 11.452, 11.292),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 1183
        -- upvalues: u103 (copy), TweenService (ref)
        u103.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u103.Wind1.Transparency = 0.9;
        TweenService:Create(u103.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
    end);
    u103.End.Size = Vector3.new(5, 1, 5);
    u103.End.Transparency = 0.65;
    local End = u103.main.End;
    End.C0 = End.C0 * CFrame.new(0, 0, 0);
    TweenService:Create(u103.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        C0 = u103.main.End.C0 * CFrame.new(0, -15, 0)
    }):Play();
    TweenService:Create(u103.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        Size = Vector3.new(12.999, 2.766, 12.999),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 1217
        -- upvalues: u103 (copy), TweenService (ref)
        u103.End.Size = Vector3.new(5, 1, 5);
        u103.End.Transparency = 0.65;
        local End2 = u103.main.End;
        End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
        TweenService:Create(u103.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u103.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u103.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
    end);
    u103.A.Size = Vector3.new(14.29, 4.752, 5.444);
    u103.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
    u103.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
    u103.A.Decal.Transparency = 0.9;
    TweenService:Create(u103.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        C0 = u103.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
    }):Play();
    TweenService:Create(u103.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Size = Vector3.new(33.166, 4.752, 5.443)
    }):Play();
    TweenService:Create(u103.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Scale = Vector3.new(0.715, 0.303, 0.315)
    }):Play();
    TweenService:Create(u103.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    task.delay(2, u103.Destroy, u103);
end;

local function hueRecolor(p104: any, p105: number) -- Line: 1274
    -- upvalues: hueRecolor (copy)
    if typeof(p104) == "ColorSequence" then
        local v106 = {};

        for _, v in ipairs(p104.Keypoints) do
            table.insert(v106, ColorSequenceKeypoint.new(v.Time, hueRecolor(v.Value, p105)));
        end;

        return ColorSequence.new(v106);
    end;

    local _, _, v107 = p104:ToHSV();
    local v108, v109 = p105:ToHSV();

    return Color3.fromHSV(v108, v109, v107);
end;

function u1.comms_ping(p110, p111, p112) -- Line: 1288
    -- upvalues: ReplicatedStorage (copy), hueRecolor (copy), TweenService (copy), Players (copy), soundUtil (copy)
    local v113 = `{p110}-ping`;
    local v114 = `{p110}-pingind`;
    local v115 = `{p110}-pingplayer`;
    pcall(game.Destroy, workspace.Effects:FindFirstChild(v113));
    pcall(game.Destroy, workspace.Effects:FindFirstChild(v114));
    pcall(game.Destroy, workspace.Effects:FindFirstChild(v115));
    local Ping = ReplicatedStorage.Resources.Ping;
    local v116 = Ping.Pings:FindFirstChild(p111);

    if not v116 then
        return;
    end;

    local v117 = v116:GetAttribute("Color") or Color3.new(1, 1, 1);
    local v118 = Ping.Ping:Clone();
    v118.Name = v113;
    v118.CFrame = p112;

    for _, v in v118:QueryDescendants("ParticleEmitter,Beam") do
        v.Color = hueRecolor(v.Color, v117);
    end;

    v118.Parent = workspace.Effects;

    for _, v in v118.Attachment.Beamatt:QueryDescendants("Beam") do
        v.Enabled = true;
        task.delay(0.27, function() -- Line: 1316
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;

    for _, v in v118:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;

    for _, v in v118.Attachment.Beamatt.Pointer:QueryDescendants("Beam") do
        TweenService:Create(v, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Width0 = 0,
            Width1 = 0
        }):Play();
    end;

    task.delay(0.5, v118.Destroy, v118);
    local v119 = Ping.Indicator:Clone();
    v119.Name = v114;
    v119.WorldCFrame = v118.CFrame * v119.CFrame;
    v119.Parent = workspace.Effects;
    local u120 = Players:FindFirstChild(p110);
    local u121;

    if u120 and u120:IsA("Player") then
        u121 = Ping.Player:Clone();
        u121.WorldCFrame = v118.CFrame * u121.CFrame;
        u121.Bill.Label.BackgroundColor3 = v117;
        u121.Bill.Label.UIStroke.Color = v117;
        u121.Name = v115;
        u121.Parent = workspace.Effects;
        task.spawn(function() -- Line: 1353
            -- upvalues: u121 (ref), Players (ref), u120 (copy)
            u121.Bill.Label.Image = Players:GetUserThumbnailAsync(u120.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
        end);
        TweenService:Create(u121.Bill, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            Size = UDim2.fromScale(3, 3)
        }):Play();
    else
        u121 = nil;
    end;

    local v122 = v116:Clone();
    v122.Parent = v119;

    if p111 == "Countdown" then
        for i = 3, 1, -1 do
            v122.TextLabel.Text = i;
            soundUtil:play("uishow", v119);
            task.wait(1);
            local _ = i;
        end;

        v122.TextLabel.Text = "GO!";
        soundUtil:play("confirm", v119);
    elseif p111 == "Flow" then
        local v123 = workspace.characters:FindFirstChild(p110);
        local v124 = not (v123 and v123:FindFirstChild("state")) and "...%" or `{math.floor(v123.state.flow.Value)}%`;
        v122.TextLabel.Text = v124;
        soundUtil:play("uishow", v119);
    else
        soundUtil:play("uishow", v119);
    end;

    local TweenInfo_new_ret = TweenInfo.new(1);
    local TweenInfo_new_ret2 = TweenInfo.new(TweenInfo_new_ret.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    TweenService:Create(v119, TweenInfo_new_ret, {
        WorldCFrame = v119.WorldCFrame * CFrame.new(0, 2, 0)
    }):Play();

    for _, v in v119:QueryDescendants("TextLabel") do
        TweenService:Create(v, TweenInfo_new_ret2, {
            TextTransparency = 1
        }):Play();
    end;

    for _, v in v119:QueryDescendants("ImageLabel") do
        TweenService:Create(v, TweenInfo_new_ret2, {
            ImageTransparency = 1
        }):Play();
    end;

    for _, v in v119:QueryDescendants("UIStroke") do
        TweenService:Create(v, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
    end;

    if u121 then
        TweenService:Create(u121.Bill.Label, TweenInfo_new_ret2, {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u121.Bill.Label.UIStroke, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
    end;

    task.delay(TweenInfo_new_ret2.Time, v119.Destroy, v119);
    task.delay(TweenInfo_new_ret2.Time, u121.Destroy, v119);
end;

return u1;