 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

local function createClone(p1: userdata) -- Line: 14
    -- upvalues: TweenService (copy)
    p1.Archivable = true;
    local v2 = p1:Clone();
    v2.Parent = workspace.Debris;

    for _, descendant in v2:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or descendant:IsA("Sound"))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if descendant:GetAttribute("Invis") and descendant.Name ~= "BALL" then
                if descendant.Name ~= "Model" then
                    descendant.Transparency = 0;
                end;
            else
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant:Destroy();
        end;
    end;

    return v2;
end;

local function poseClone(p3, p4) -- Line: 47
    for _, child in p3:GetChildren() do
        local v5 = p4:FindFirstChild(child.Name);

        if child:IsA("BasePart") and (v5 and v5:IsA("BasePart")) then
            child.CFrame = v5.CFrame;
        end;
    end;
end;

return function(p6, p7) -- Line: 57
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), createClone (copy), Debris (copy), VfxManager (copy), Essentials (copy), TweenService (copy)
    local TimeSent = p7.TimeSent;
    local v8 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p7.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Torso = Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p7.Task ~= "Normal" then
        if p7.Task == "Clone" then
            SfxManager:playSound({
                Sound = "BBZ star sliparound",
                Parent = HumanoidRootPart
            });
            Char.Archivable = true;
            task.spawn(function() -- Line: 208
                -- upvalues: HumanoidRootPart (copy), createClone (ref), Char (copy)
                local os_clock_ret = os.clock();

                while HumanoidRootPart.Parent ~= nil and os.clock() - os_clock_ret < 1 do
                    local u9 = createClone(Char);
                    task.delay(1, function() -- Line: 214
                        -- upvalues: u9 (copy)
                        u9:Destroy();
                    end);
                    task.wait(0.15);
                end;

                if Char then
                    Char.Archivable = false;
                end;
            end);
            local v10 = script.Forward.Startup:Clone();
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6054253578186035, 0.0004405975341796875, -0.5736310482025146) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);
            task.delay(0.15 - v8, function() -- Line: 232
                -- upvalues: HumanoidRootPart (copy), Torso (copy), Debris (ref), Essentials (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v11 = script.Forward["TorsoEnabling + Weld"]:Clone();
                    v11.CFrame = Torso.CFrame;
                    v11.Parent = Debris;
                    Essentials:Weld(v11, Torso);
                    VfxManager.Emit(v11);
                    VfxManager.DestroyEffect(v11, 3);
                end;
            end);
            task.delay(0.45 - v8, function() -- Line: 243
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v12 = script.Forward.Dribble_0:Clone();
                    v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.6405748128890991, -2.950352191925049, -2.0086309909820557) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
                    v12.Parent = Debris;
                    VfxManager.Emit(v12);
                    VfxManager.DestroyEffect(v12, 3);
                end;
            end);

            for _, descendant in Char:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                    if not Char:GetAttribute("Invis") or descendant.Name == "BALL" then
                        if descendant.Name ~= "HumanoidRootPart" and (descendant.Name ~= "RootPart" and descendant.Name ~= "Model") then
                            local Transparency = descendant.Transparency;
                            descendant.Transparency = 0.5;
                            task.delay(0.7, function() -- Line: 264
                                -- upvalues: descendant (copy), TweenService (ref), Transparency (copy)
                                if descendant then
                                    TweenService:Create(descendant, TweenInfo.new(0.3), {
                                        Transparency = Transparency
                                    }):Play();
                                end;
                            end);
                        end;
                    end;
                end;
            end;

            local Victim = p7.Victim;
            local u13 = Char:Clone();
            u13.Parent = workspace.Debris;
            VfxManager.DestroyEffect(u13, 1.5 - v8);
            u13.HumanoidRootPart.Anchored = true;
            u13:PivotTo(Victim.HumanoidRootPart.CFrame * CFrame.new(0, 1, -3) * CFrame.Angles(0, 3.141592653589793, 0));
            local Parent = u13:FindFirstChild("BALL", true).Parent;

            for _, descendant in u13:GetDescendants() do
                if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or descendant:IsA("Sound"))) then
                    descendant:Destroy();
                elseif descendant:IsA("Animator") then
                    for _, v in descendant:GetPlayingAnimationTracks() do
                        v:Stop();
                    end;
                elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                    if not Char:GetAttribute("Invis") or descendant.Name == "BALL" then
                        if descendant.Name ~= "HumanoidRootPart" and (descendant.Name ~= "RootPart" and descendant.Name ~= "Model") then
                            local _ = descendant.Transparency;
                            descendant.Transparency = 1;
                            TweenService:Create(descendant, TweenInfo.new(0.3), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end;
            end;

            local v14 = u13:FindFirstChild("Humanoid"):LoadAnimation(script.StarDriveLoop);
            v14.Looped = true;
            v14:Play();
            local v15 = Parent:FindFirstChild("AnimationController"):LoadAnimation(script.StarDriveLoopBall);
            v15.Looped = true;
            v15:Play();
            local v16 = 0.7 - v8;
            task.delay(v16, function() -- Line: 320
                -- upvalues: HumanoidRootPart (copy), u13 (copy), TweenService (ref), VfxManager (ref)
                if HumanoidRootPart then
                    for _, descendant in u13:GetDescendants() do
                        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                            if u13:GetAttribute("Invis") and (descendant.Name ~= "BALL" and descendant.Name ~= "Model") then
                                descendant.Transparency = 0;
                            else
                                TweenService:Create(descendant, TweenInfo.new(0.4), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end;

                    VfxManager.DestroyEffect(u13, 0.4);
                end;
            end);
            local os_clock_ret = os.clock();

            while os.clock() - os_clock_ret < v16 and HumanoidRootPart.Parent ~= nil do
                task.delay(0.2 - v8, function() -- Line: 342
                    -- upvalues: HumanoidRootPart (copy), SfxManager (ref), u13 (copy), Debris (ref), VfxManager (ref)
                    if HumanoidRootPart then
                        SfxManager:playSound({
                            Sound = "BBZ star poster loop on dribble",
                            Parent = HumanoidRootPart
                        });
                        local v17 = script.Forward.LoopDribble:Clone();
                        v17.CFrame = u13.HumanoidRootPart.CFrame * CFrame.new(0.19957470893859863, -2.950352191925049, 0.9193689823150635) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
                        v17.Parent = Debris;
                        VfxManager.Emit(v17);
                        VfxManager.DestroyEffect(v17, 3);
                    end;
                end);
                task.wait(0.617);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ star dribble",
        Parent = HumanoidRootPart
    });
    Char.Archivable = true;
    local u18 = 2 - v8;
    task.spawn(function() -- Line: 75
        -- upvalues: HumanoidRootPart (copy), u18 (copy), createClone (ref), Char (copy)
        local os_clock_ret = os.clock();

        while HumanoidRootPart.Parent ~= nil and os.clock() - os_clock_ret < u18 do
            local u19 = createClone(Char);
            task.delay(1, function() -- Line: 101
                -- upvalues: u19 (copy)
                u19:Destroy();
            end);
            task.wait(0.1);
        end;

        if Char then
            Char.Archivable = false;
        end;
    end);
    local v20 = script.Drive.Startup:Clone();
    v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.045424461364746094, -2.9579079151153564, 0.3341064453125) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
    v20.Parent = Debris;
    VfxManager.Emit(v20);
    VfxManager.DestroyEffect(v20, 3);
    task.delay(0.217 - v8, function() -- Line: 121
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v21 = script.Drive.Dribble_0:Clone();
            v21.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.7324256896972656, -2.9763522148132324, -1.7806310653686523) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v21.Parent = Debris;
            VfxManager.Emit(v21);
            VfxManager.DestroyEffect(v21, 3);
        end;
    end);
    task.delay(0.467 - v8, function() -- Line: 131
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v22 = script.Drive.Dribble_1:Clone();
            v22.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.4655745029449463, -2.9763522148132324, -1.9186310768127441) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v22.Parent = Debris;
            VfxManager.Emit(v22);
            VfxManager.DestroyEffect(v22, 3);
        end;
    end);
    task.delay(0.733 - v8, function() -- Line: 141
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v23 = script.Drive.Dribble_2:Clone();
            v23.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.7904255390167236, -2.9763522148132324, -2.9626312255859375) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v23.Parent = Debris;
            VfxManager.Emit(v23);
            VfxManager.DestroyEffect(v23, 3);
        end;
    end);
    task.delay(1.033 - v8, function() -- Line: 151
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v24 = script.Drive.Dribble_3:Clone();
            v24.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.07742524147033691, -2.950352191925049, -2.2106308937072754) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v24.Parent = Debris;
            VfxManager.Emit(v24);
            VfxManager.DestroyEffect(v24, 3);
        end;
    end);
    task.delay(1.417 - v8, function() -- Line: 161
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v25 = script.Drive.Dribble_4:Clone();
            v25.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.14742565155029297, -2.9763522148132324, -2.2036311626434326) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v25.Parent = Debris;
            VfxManager.Emit(v25);
            VfxManager.DestroyEffect(v25, 3);
        end;
    end);
    task.delay(1.6 - v8, function() -- Line: 171
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), Torso (copy), Essentials (ref)
        if HumanoidRootPart then
            local v26 = script.Drive.Dribble_5:Clone();
            v26.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.0884256362915039, -2.9763522148132324, -2.35063099861145) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v26.Parent = Debris;
            VfxManager.Emit(v26);
            VfxManager.DestroyEffect(v26, 3);
            task.wait(0.016666666666666666);

            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v27 = script.Drive["TorsoEnabling + Weld"]:Clone();
            v27.CFrame = Torso.CFrame;
            v27.Parent = Debris;
            VfxManager.Emit(v27);
            Essentials:Weld(v27, Torso);
            VfxManager.DestroyEffect(v27, 3);
        end;
    end);
    task.delay(1.683 - v8, function() -- Line: 191
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v28 = script.Drive.Dribble_6:Clone();
            v28.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.5894253253936768, -2.950352191925049, -0.21763086318969727) * CFrame.fromEulerAnglesYXZ(-0, -3.1415927410125732, 0);
            v28.Parent = Debris;
            VfxManager.Emit(v28);
            VfxManager.DestroyEffect(v28, 3);
        end;
    end);
end;