 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("ContentProvider");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local v3 = Knit.CreateController({
    Name = "AnimationController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = Trove.new();
local u8 = Trove.new();
local u9 = {
    R = 0.01,
    L = 0.01,
    F = 0.01,
    B = 0.01
};
local u10 = 0.01;
local u11 = 0.01;
local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
local Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
local WalkSpeed = u2.WalkSpeed;

local function DontStop(p12) -- Line: 42
    for _, v in p12 do
        for _, v2 in v do
            if v2.IsPlaying == false then
                v2:Play();
            end;
        end;
    end;
end;

function v3.Animations(u13) -- Line: 50
    -- upvalues: u7 (copy), u8 (copy), u6 (ref), u5 (ref), AssemblyLinearVelocity (ref), HumanoidRootPart (ref), Vector3_new_ret (ref), WalkSpeed (ref), u2 (ref), u9 (copy), Essentials (copy), u4 (ref), u10 (ref), u11 (ref), RunService (copy), LocalPlayer (copy)
    if u7 then
        u7:Clean();
    end;

    if u8 then
        u8:Clean();
    end;

    local u14 = 0;
    local HasBall = u6.CharValues.HasBall;

    local function speed(p15) -- Line: 57
        -- upvalues: u5 (ref), u14 (ref), AssemblyLinearVelocity (ref), HumanoidRootPart (ref), Vector3_new_ret (ref), WalkSpeed (ref), u2 (ref), u9 (ref), Essentials (ref), u4 (ref), u10 (ref), u11 (ref)
        if u5:GetCharacterPossessingBall() == nil then
            u14 = workspace.Basketball.Position.Y;
        end;

        AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
        Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
        WalkSpeed = u2.WalkSpeed;

        if Vector3_new_ret.Magnitude < 2 then
            WalkSpeed = 0.01;
        end;

        local v16 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
        local v17 = {};
        local math_clamp_ret = math.clamp(v16.X / WalkSpeed, 0.02, 1);
        v17.R = math.abs(math_clamp_ret);
        local math_clamp_ret2 = math.clamp(v16.X / WalkSpeed, -1, -0.02);
        v17.L = math.abs(math_clamp_ret2);
        local math_clamp_ret3 = math.clamp(v16.Z / WalkSpeed, -1, -0.02);
        v17.F = math.abs(math_clamp_ret3);
        local math_clamp_ret4 = math.clamp(v16.Z / WalkSpeed, 0.02, 1);
        v17.B = math.abs(math_clamp_ret4);

        for i, v in v17 do
            u9[i] = Essentials:Lerp(u9[i], v, p15 * 15);
        end;

        if u4.States.Running then
            if u10 > 0.02 then
                u10 = Essentials:Lerp(u10, 0.02, p15 * 15);
            else
                u10 = 0.02;
            end;

            if Vector3_new_ret.Magnitude > 1 then
                u11 = Essentials:Lerp(u11, 1, p15 * 10);
            else
                u11 = Essentials:Lerp(u11, 0.01, p15 * 15);
            end;
        else
            if u11 > 0.01 then
                u11 = Essentials:Lerp(u11, 0.02, p15 * 15);
            else
                u11 = 0.02;
            end;

            if Vector3_new_ret.Magnitude > 1 then
                u10 = Essentials:Lerp(u10, 1, p15 * 10);
            else
                u10 = Essentials:Lerp(u10, 0.02, p15 * 15);
            end;
        end;

        if u10 <= 0.02 then
            u10 = 0.02;
        end;

        if u11 <= 0.02 then
            u11 = 0.02;
        end;
    end;

    local u18 = tick();
    u8:Connect(RunService.Heartbeat, function(p19) -- Line: 103
        -- upvalues: speed (copy), u18 (ref), LocalPlayer (ref), HasBall (ref), u6 (ref), u7 (ref), u13 (copy), u2 (ref), u4 (ref)
        speed(p19);

        if u18 + 0.1 > tick() then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if HasBall == u6.CharValues.HasBall then
            return;
        end;

        HasBall = u6.CharValues.HasBall;
        u18 = tick();
        u7:Clean();

        for i, v in u13.Anims do
            if i == "Movement" then
                for _, v2 in v do
                    v2:Stop();
                end;
            end;
        end;

        for i, v in u13.Ball do
            if i == "Movement" then
                for _, v2 in v do
                    v2:Stop();
                end;
            end;
        end;

        if u6.CharValues.HasBall and (u2:GetState() == Enum.HumanoidStateType.Jumping or u2:GetState() == Enum.HumanoidStateType.Freefall) and not u4.States.Ability then
            u13:StopAll();
            u13:PlayChar("Blocks", "Rebound", Enum.AnimationPriority.Action2);
            u13:PlayBall("Blocks", "Rebound", Enum.AnimationPriority.Action2);
        end;

        if u6.CharValues.HasBall then
            u13:WithBall();

            return;
        end;

        u13:NoBall();
    end);
    u8:Connect(u2.StateChanged, function(p20, p21) -- Line: 147
        -- upvalues: u4 (ref), u13 (copy)
        if p21 == Enum.HumanoidStateType.Jumping and u4.States.Shooting == false then
            u13:PlayChar("Blocks", "JumpBlock", Enum.AnimationPriority.Action2);
        end;
    end);
    u13:NoBall();
end;

function v3.NoBall(u22) -- Line: 156
    -- upvalues: Essentials (copy), Knit (copy), u7 (copy), RunService (copy), WalkSpeed (ref), u4 (ref), u6 (ref), u1 (ref), u9 (copy), u10 (ref), LocalPlayer (copy)
    local Idle = u22.Anims.Movement.Idle;
    local IdleDefense = u22.Anims.Movement.IdleDefense;
    local RunF = u22.Anims.Movement.RunF;
    local RunB = u22.Anims.Movement.RunB;
    local u23 = {
        F = u22.Anims.Movement.WalkF,
        L = u22.Anims.Movement.WalkL,
        R = u22.Anims.Movement.WalkR,
        B = u22.Anims.Movement.WalkB
    };
    local u24 = {
        F = u22.Anims.Movement.WalkDF,
        L = u22.Anims.Movement.WalkDL,
        R = u22.Anims.Movement.WalkDR,
        B = u22.Anims.Movement.WalkDB
    };
    local u25 = {
        F = u22.Anims.Movement.RunDF,
        L = u22.Anims.Movement.RunDL,
        R = u22.Anims.Movement.RunDR,
        B = u22.Anims.Movement.RunDB
    };
    Idle.Priority = Enum.AnimationPriority.Idle;
    IdleDefense.Priority = Enum.AnimationPriority.Idle;
    RunF.Priority = Enum.AnimationPriority.Action;
    RunB.Priority = Enum.AnimationPriority.Action;
    Essentials:SetProperty(u23, Enum.AnimationPriority.Action);
    Essentials:SetProperty(u24, Enum.AnimationPriority.Action);
    Essentials:SetProperty(u25, Enum.AnimationPriority.Action);
    local Controller = Knit.GetController("AbilityController");
    local u26 = tick();
    u7:Connect(RunService.Heartbeat, function(p27) -- Line: 199
        -- upvalues: u26 (ref), Idle (copy), IdleDefense (copy), WalkSpeed (ref), u23 (copy), u4 (ref), u24 (copy), u25 (copy), Controller (copy), u6 (ref), u1 (ref), RunF (ref), RunB (copy), u9 (ref), u10 (ref), u22 (copy), LocalPlayer (ref)
        if u26 > tick() then
            return;
        end;

        u26 = tick() + 0.1;

        if Idle.IsPlaying == false then
            Idle:Play();
        end;

        if IdleDefense.IsPlaying == false then
            IdleDefense:Play();
        end;

        if WalkSpeed < 0 then
            WalkSpeed = 0.025;
        end;

        for _, v in u23 do
            if v.IsPlaying then
                if u4.States.Defense then
                    v:AdjustSpeed(0.01);
                else
                    v:AdjustSpeed(WalkSpeed / 12);
                end;
            end;
        end;

        for _, v in u24 do
            if v.IsPlaying then
                if u4.States.Defense == false then
                    v:AdjustSpeed(0.01);
                else
                    v:AdjustSpeed(WalkSpeed / 12);
                end;
            end;
        end;

        for _, v in u25 do
            if v.IsPlaying then
                if u4.States.Defense == false then
                    v:AdjustSpeed(0.01);
                else
                    v:AdjustSpeed(WalkSpeed / 24);
                end;
            end;
        end;

        if Controller.ChaosMode and u6.CharValues.InAwakening or u1:GetAttribute("Chaos") then
            RunF:AdjustSpeed(WalkSpeed / 32);
        else
            RunF:AdjustSpeed(WalkSpeed / 24);
        end;

        RunB:AdjustSpeed(WalkSpeed / 24);

        for i, v in u23 do
            if u4.States.Defense then
                v:Stop(0.25);
            elseif u4.States.Running then
                v:Stop(0.25);
            else
                if not v.IsPlaying then
                    v:Play(0.25);
                end;

                if u9.F > 0.5 or u9.B > 0.5 then
                    if i == "F" or i == "B" then
                        if u9.F > 0.5 and i ~= "F" then
                            v:AdjustWeight(0.01);
                        else
                            v:AdjustWeight(u10);
                        end;
                    else
                        v:AdjustWeight(0.01);
                    end;
                else
                    v:AdjustWeight(u9[i]);
                end;
            end;
        end;

        for i, v in u24 do
            if u4.States.Defense == false then
                v:Stop(0.25);
            else
                if not v.IsPlaying then
                    v:Play(0.25);
                end;

                if u9.F > 0.5 or u9.B > 0.5 then
                    if i == "F" or i == "B" then
                        if u9.F > 0.5 and i ~= "F" then
                            v:AdjustWeight(0.01);
                        else
                            v:AdjustWeight(1);
                        end;
                    else
                        v:AdjustWeight(0.01);
                    end;
                else
                    v:AdjustWeight(u9[i]);
                end;
            end;
        end;

        if u4.States.Defense then
            if u4.States.Running then
                RunF:Stop(0.25);
                RunB:Stop(0.25);

                for i, v in u25 do
                    if not v.IsPlaying then
                        v:Play(0.25);
                    end;

                    if u9.F > 0.5 or u9.B > 0.5 then
                        if i == "F" or i == "B" then
                            if u9.F > 0.5 and i ~= "F" then
                                v:AdjustWeight(0.01);
                            else
                                v:AdjustWeight(1);
                            end;
                        else
                            v:AdjustWeight(0.01);
                        end;
                    else
                        v:AdjustWeight(u9[i]);
                    end;
                end;
            else
                RunF:Stop(0.25);
                RunB:Stop(0.25);

                for _, v in u25 do
                    v:Stop(0.25);
                end;
            end;

            IdleDefense:AdjustWeight(1);
            Idle:AdjustWeight(0.01);
        else
            if u4.States.Running then
                if u9.B > 0.1 then
                    RunF:Stop(0.25);

                    if not RunB.IsPlaying then
                        RunB:Play(0.25);
                    end;
                else
                    RunB:Stop(0.25);

                    if not RunF.IsPlaying then
                        RunF:Play(0.25);
                    end;
                end;
            else
                RunF:Stop(0.25);
                RunB:Stop(0.25);
            end;

            for _, v in u25 do
                v:Stop(0.25);
            end;

            IdleDefense:AdjustWeight(0.01);
            Idle:AdjustWeight(1);
        end;

        if Controller.ChaosMode and u6.CharValues.InAwakening or u1:GetAttribute("Chaos") then
            if RunF ~= u22.Anims.Chrollo.MonsterRun then
                RunF:Stop();
            end;

            RunF = u22.Anims.Chrollo.MonsterRun;
            u22.Anims.Chrollo.MonsterRun.Priority = Enum.AnimationPriority.Action;

            if u6.CharValues.HasBall then
                RunF:Stop();
            end;
        else
            if Controller.TailMode and u6.CharValues.InAwakening then
                if RunF ~= u22.Anims.ScaryMonster.TailRunOff then
                    RunF:Stop();
                end;

                RunF = u22.Anims.ScaryMonster.TailRunOff;
                u22.Anims.ScaryMonster.TailRunOff.Priority = Enum.AnimationPriority.Action;
                u22.Anims.ScaryMonster.TailRun:Stop();
                u22.Ball.ScaryMonster.TailRunBall:Stop();

                return;
            end;

            if LocalPlayer.Style.Value == "Goat" and u6.CharValues.InAwakening then
                if RunF ~= u22.Anims.Goat.GoatRunOff then
                    RunF:Stop();
                end;

                RunF = u22.Anims.Goat.GoatRunOff;
                u22.Anims.Goat.GoatRunOff.Priority = Enum.AnimationPriority.Action;
                u22.Anims.Goat.GoatRun:Stop();
                u22.Ball.Goat.GoatRunBall:Stop();

                return;
            end;

            if Controller.NinjaRun and u6.CharValues.InAwakening ~= true then
                if RunF ~= u22.Anims.Ninja.NinjaRun then
                    RunF:Stop();
                end;

                RunF = u22.Anims.Ninja.NinjaRun;
                u22.Anims.Ninja.NinjaRun.Priority = Enum.AnimationPriority.Action;
                u22.Anims.Ninja.TailDribble:Stop();
                u22.Ball.Ninja.TailDribbleBall:Stop();
                u22.Anims.Ninja.TailDribbleTail:Stop();

                return;
            end;

            if Controller.TailDribble then
                if RunF ~= u22.Anims.Movement.RunF then
                    RunF:Stop();
                end;

                RunF = u22.Anims.Movement.RunF;
                u22.Anims.Ninja.TailDribble:Stop();
                u22.Ball.Ninja.TailDribbleBall:Stop();
                u22.Anims.Ninja.TailDribbleTail:Stop();

                return;
            end;

            if RunF ~= u22.Anims.Movement.RunF then
                RunF:Stop();
            end;

            RunF = u22.Anims.Movement.RunF;
        end;
    end);
end;

function v3.WithBall(u28) -- Line: 411
    -- upvalues: Essentials (copy), Knit (copy), DontStop (copy), HumanoidRootPart (ref), u6 (ref), u4 (ref), WalkSpeed (ref), u9 (copy), u10 (ref), LocalPlayer (copy), u7 (copy), RunService (copy)
    local u29 = {
        ["false"] = u28.Anims.Movement.IdleBL,
        ["true"] = u28.Anims.Movement.IdleBR
    };
    local u30 = {
        ["false"] = u28.Anims.Movement.WalkBL,
        ["true"] = u28.Anims.Movement.WalkBR
    };
    local u31 = {
        ["false"] = u28.Anims.Movement.WalkBLB,
        ["true"] = u28.Anims.Movement.WalkBRB
    };
    local u32 = {
        ["false"] = u28.Anims.Movement.RunBL,
        ["true"] = u28.Anims.Movement.RunBR
    };
    local u33 = {
        ["false"] = u28.Ball.Movement.IdleL,
        ["true"] = u28.Ball.Movement.IdleR
    };
    local u34 = {
        ["false"] = u28.Ball.Movement.WalkL,
        ["true"] = u28.Ball.Movement.WalkR
    };
    local u35 = {
        ["false"] = u28.Ball.Movement.WalkBL,
        ["true"] = u28.Ball.Movement.WalkBR
    };
    local u36 = {
        ["false"] = u28.Ball.Movement.RunL,
        ["true"] = u28.Ball.Movement.RunR
    };
    local PumpFakeIdle = u28.Anims.Movement.PumpFakeIdle;
    local PumpFakeIdle2 = u28.Ball.Movement.PumpFakeIdle;
    PumpFakeIdle.Priority = Enum.AnimationPriority.Action;
    PumpFakeIdle2.Priority = Enum.AnimationPriority.Action;
    PumpFakeIdle:Play();
    PumpFakeIdle2:Play();
    local u37 = false;
    Essentials:SetProperty(u29, Enum.AnimationPriority.Idle);
    Essentials:SetProperty(u30, Enum.AnimationPriority.Movement);
    Essentials:SetProperty(u31, Enum.AnimationPriority.Movement);
    Essentials:SetProperty(u32, Enum.AnimationPriority.Action);
    Essentials:SetProperty(u33, Enum.AnimationPriority.Idle);
    Essentials:SetProperty(u34, Enum.AnimationPriority.Movement);
    Essentials:SetProperty(u35, Enum.AnimationPriority.Movement);
    Essentials:SetProperty(u36, Enum.AnimationPriority.Action);
    local Controller = Knit.GetController("AbilityController");

    local function characterAnims(p38) -- Line: 470
        -- upvalues: DontStop (ref), u29 (copy), PumpFakeIdle (copy), PumpFakeIdle2 (copy), HumanoidRootPart (ref), u6 (ref), u37 (ref), u4 (ref), u30 (copy), WalkSpeed (ref), u31 (copy), u32 (copy), u9 (ref), u10 (ref), Controller (copy), u28 (copy), LocalPlayer (ref)
        DontStop({ u29 });

        if not PumpFakeIdle.IsPlaying then
            PumpFakeIdle:Play();
        end;

        if not PumpFakeIdle2.IsPlaying then
            PumpFakeIdle2:Play();
        end;

        if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 or u6.CharValues.Dribbling then
            u37 = true;
            PumpFakeIdle:AdjustWeight(0.001);
            PumpFakeIdle2:AdjustWeight(0.001);
        elseif u37 == false then
            PumpFakeIdle:AdjustWeight(1);
            PumpFakeIdle2:AdjustWeight(1);
        end;

        if u4.States.PumpFake then
            PumpFakeIdle:AdjustWeight(1);
            PumpFakeIdle2:AdjustWeight(1);
        end;

        for _, v in u30 do
            if v.IsPlaying then
                v:AdjustSpeed(WalkSpeed / 12);
            end;
        end;

        for _, v in u31 do
            if v.IsPlaying then
                v:AdjustSpeed(WalkSpeed / 12);
            end;
        end;

        for _, v in u32 do
            if v.IsPlaying then
                v:AdjustSpeed(WalkSpeed / 24);
            end;
        end;

        local OnRight = u6.CharValues.OnRight;
        u29[tostring(OnRight)]:AdjustWeight(1);
        u29[tostring(not OnRight)]:AdjustWeight(0.01);

        if u9.B > 0.1 then
            u30[tostring(OnRight)]:Stop(0.125);
            u30[tostring(not OnRight)]:Stop(0.125);

            if u10 <= 0.1 then
                u31[tostring(OnRight)]:Stop(0.2);
            elseif not u31[tostring(OnRight)].IsPlaying then
                u31[tostring(OnRight)]:Play(0.2);
            end;

            u31[tostring(not OnRight)]:Stop();
        else
            u31[tostring(OnRight)]:Stop(0.125);
            u31[tostring(not OnRight)]:Stop(0.125);

            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude < 5 then
                u30[tostring(OnRight)]:Stop(0.2);
            elseif not u30[tostring(OnRight)].IsPlaying then
                u30[tostring(OnRight)]:Play(0.2);
            end;

            u30[tostring(not OnRight)]:Stop();
        end;

        if Controller.TailMode and u6.CharValues.InAwakening then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
                if not u28.Anims.ScaryMonster.TailRun.IsPlaying then
                    u28.Anims.ScaryMonster.TailRun:Play(0.2);
                end;
            else
                u28.Anims.ScaryMonster.TailRun:Stop(0.2);
            end;

            u28.Anims.ScaryMonster.TailRunOff:Stop();
            u32[tostring(OnRight)]:Stop(0.2);
            u32[tostring(not OnRight)]:Stop(0.2);

            return;
        end;

        if LocalPlayer.Style.Value == "Goat" and u6.CharValues.InAwakening then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
                if not u28.Anims.Goat.GoatRun.IsPlaying then
                    u28.Anims.Goat.GoatRun:Play(0.2);
                end;
            else
                u28.Anims.Goat.GoatRun:Stop(0.2);
            end;

            u28.Anims.Goat.GoatRunOff:Stop();
            u32[tostring(OnRight)]:Stop(0.2);
            u32[tostring(not OnRight)]:Stop(0.2);

            return;
        end;

        if Controller.TailDribble and u6.CharValues.InAwakening then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
                if not u28.Anims.Ninja.TailDribble.IsPlaying then
                    u28.Anims.Ninja.TailDribble:Play(0.2);
                end;

                if not u28.Anims.Ninja.TailDribbleTail.IsPlaying then
                    u28.Anims.Ninja.TailDribbleTail:Play(0.2);
                end;
            else
                u28.Anims.Ninja.TailDribbleTail:Stop(0.2);
                u28.Anims.Ninja.TailDribble:Stop(0.2);
            end;

            u28.Anims.Ninja.NinjaRun:Stop();
            u32[tostring(OnRight)]:Stop(0.2);
            u32[tostring(not OnRight)]:Stop(0.2);

            return;
        end;

        if u28.Anims.Chrollo.MonsterRun.IsPlaying then
            u28.Anims.Chrollo.MonsterRun:Stop(0.2);
        end;

        if u28.Anims.ScaryMonster.TailRun.IsPlaying then
            u28.Anims.ScaryMonster.TailRun:Stop(0.2);
        end;

        if u28.Anims.Goat.GoatRun.IsPlaying then
            u28.Anims.Goat.GoatRun:Stop(0.2);
        end;

        if u28.Anims.Ninja.NinjaRun.IsPlaying then
            u28.Anims.Ninja.NinjaRun:Stop(0.2);
        end;

        if u28.Anims.Ninja.TailDribble.IsPlaying then
            u28.Anims.Ninja.TailDribble:Stop(0.2);
        end;

        if u28.Anims.Ninja.TailDribbleTail.IsPlaying then
            u28.Anims.Ninja.TailDribbleTail:Stop(0.2);
        end;

        if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 and u4.States.Running then
            if not u32[tostring(OnRight)].IsPlaying then
                u32[tostring(OnRight)]:Play(0.2);
            end;
        else
            u32[tostring(OnRight)]:Stop(0.2);
        end;

        u32[tostring(not OnRight)]:Stop(0.2);
    end;

    local function ballAnims(p39) -- Line: 604
        -- upvalues: u34 (copy), WalkSpeed (ref), u35 (copy), u36 (copy), u6 (ref), u33 (copy), u9 (ref), u10 (ref), HumanoidRootPart (ref), Controller (copy), u28 (copy), LocalPlayer (ref), u4 (ref)
        for _, v in u34 do
            if v.IsPlaying then
                v:AdjustSpeed(WalkSpeed / 12);
            end;
        end;

        for _, v in u35 do
            if v.IsPlaying then
                v:AdjustSpeed(WalkSpeed / 12);
            end;
        end;

        for _, v in u36 do
            if v.IsPlaying then
                v:AdjustSpeed(WalkSpeed / 24);
            end;
        end;

        local OnRight = u6.CharValues.OnRight;

        if not u33[tostring(OnRight)].IsPlaying then
            u33[tostring(OnRight)]:Play(0.15);
        end;

        u33[tostring(not OnRight)]:Stop(0.15);

        if u9.B > 0.1 then
            u34[tostring(OnRight)]:Stop(0.125);
            u34[tostring(not OnRight)]:Stop(0.125);

            if u10 <= 0.1 then
                u35[tostring(OnRight)]:Stop(0.2);
            elseif not u35[tostring(OnRight)].IsPlaying then
                u35[tostring(OnRight)]:Play(0.2);
            end;

            u35[tostring(not OnRight)]:Stop();
        else
            u35[tostring(OnRight)]:Stop(0.125);
            u35[tostring(not OnRight)]:Stop(0.125);

            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude < 5 then
                u34[tostring(OnRight)]:Stop(0.2);
            elseif not u34[tostring(OnRight)].IsPlaying then
                u34[tostring(OnRight)]:Play(0.2);
            end;

            u34[tostring(not OnRight)]:Stop();
        end;

        if Controller.TailMode and u6.CharValues.InAwakening then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
                if not u28.Ball.ScaryMonster.TailRunBall.IsPlaying then
                    u28.Ball.ScaryMonster.TailRunBall:Play(0.2);
                end;
            else
                u28.Ball.ScaryMonster.TailRunBall:Stop(0.2);
            end;

            u36[tostring(OnRight)]:Stop(0.2);
            u36[tostring(not OnRight)]:Stop(0.2);

            return;
        end;

        if LocalPlayer.Style.Value == "Goat" and u6.CharValues.InAwakening then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
                if not u28.Ball.Goat.GoatRunBall.IsPlaying then
                    u28.Ball.Goat.GoatRunBall:Play(0.2);
                end;
            else
                u28.Ball.Goat.GoatRunBall:Stop(0.2);
            end;

            u36[tostring(OnRight)]:Stop(0.2);
            u36[tostring(not OnRight)]:Stop(0.2);

            return;
        end;

        if Controller.TailDribble and u6.CharValues.InAwakening then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
                if not u28.Ball.Ninja.TailDribbleBall.IsPlaying then
                    u28.Ball.Ninja.TailDribbleBall:Play(0.2);
                end;
            else
                u28.Ball.Ninja.TailDribbleBall:Stop(0.2);
            end;

            u36[tostring(OnRight)]:Stop(0.2);
            u36[tostring(not OnRight)]:Stop(0.2);

            return;
        end;

        if u28.Ball.ScaryMonster.TailRunBall.IsPlaying then
            u28.Ball.ScaryMonster.TailRunBall:Stop(0.2);
        end;

        if u28.Ball.Goat.GoatRunBall.IsPlaying then
            u28.Ball.Goat.GoatRunBall:Stop(0.2);
        end;

        if u28.Ball.Ninja.TailDribbleBall.IsPlaying then
            u28.Ball.Ninja.TailDribbleBall:Stop(0.2);
        end;

        if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 and u4.States.Running then
            if not u36[tostring(OnRight)].IsPlaying then
                u36[tostring(OnRight)]:Play(0.2);
            end;
        else
            u36[tostring(OnRight)]:Stop(0.2);
        end;

        u36[tostring(not OnRight)]:Stop(0.2);
    end;

    u7:Connect(RunService.Heartbeat, function(p40) -- Line: 704
        -- upvalues: characterAnims (copy), ballAnims (copy)
        characterAnims();
        ballAnims();
    end);
end;

function v3.LoadAnimations(p41) -- Line: 710
    -- upvalues: u1 (ref), ReplicatedStorage (copy), u2 (ref)
    table.clear(p41.Anims);
    table.clear(p41.Ball);
    local PlrBall = u1:WaitForChild("PlrBall");
    task.wait(0.01);

    for _, child in ReplicatedStorage.Assets.Animations:GetChildren() do
        p41.Anims[child.Name] = {};
        local v42 = child;

        for _, child2 in child:GetChildren() do
            p41.Anims[v42.Name][child2.Name] = u2:LoadAnimation(child2);
        end;
    end;

    for _, child in ReplicatedStorage.Assets.StyleAnimations:GetChildren() do
        p41.Anims[child.Name] = {};
        local v43 = child;

        for _, child2 in child:GetChildren() do
            if string.match(child2.Name, "Ball") then
                if p41.Ball[v43.Name] == nil then
                    p41.Ball[v43.Name] = {};
                end;

                p41.Ball[v43.Name][child2.Name] = PlrBall:WaitForChild("Anims"):WaitForChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(child2);
            else
                p41.Anims[v43.Name][child2.Name] = u2:LoadAnimation(child2);
            end;
        end;
    end;

    p41.Anims.Emotes = {};

    for _, child in ReplicatedStorage.Assets.EmoteAnimations:GetChildren() do
        p41.Anims.Emotes[child.Name] = u2:LoadAnimation(child);
    end;

    for _, child in ReplicatedStorage.Assets.BallAnimations:GetChildren() do
        p41.Ball[child.Name] = {};
        local v44 = child;

        for _, child2 in child:GetChildren() do
            p41.Ball[v44.Name][child2.Name] = PlrBall:WaitForChild("Anims").AnimationController.Animator:LoadAnimation(child2);
        end;
    end;

    p41:Animations();
end;

function v3.StopAll(p45, p46) -- Line: 754
    -- upvalues: Knit (copy)
    Knit.GetController("EmotesController"):CancelPlayingEmote();

    for _, v in p45.Anims do
        for _, v2 in v do
            v2:Stop();
        end;
    end;

    for _, v in p45.Ball do
        for _, v2 in v do
            v2:Stop();
        end;
    end;
end;

function v3.StopSpecific(p47, p48) -- Line: 770
    for _, v in p48 do
        for _, v2 in v do
            v2:Stop();
        end;
    end;
end;

function v3.PlayChar(p49: table, p50: string, p51: string, p52: any, p53: any) -- Line: 778
    p49.Anims[p50][p51].Priority = p52;
    p49.Anims[p50][p51]:Play();

    if p53 then
        return p49.Anims[p50][p51];
    end;
end;

function v3.StopChar(p54: table, p55: string, p56: string) -- Line: 787
    p54.Anims[p55][p56]:Stop();
end;

function v3.PlayBall(p57: table, p58: string, p59: string, p60: any, p61: any) -- Line: 791
    p57.Ball[p58][p59].Priority = p60;
    p57.Ball[p58][p59]:Play();

    if p61 then
        return p57.Ball[p58][p59];
    end;
end;

function v3.KnitStart(p62) -- Line: 800
    -- upvalues: u4 (ref), Knit (copy), u5 (ref), u6 (ref)
    u4 = Knit.GetController("MovementController");
    u5 = Knit.GetController("BallController");
    u6 = Knit.GetController("Network");
    p62:LoadAnimations();
end;

function v3.KnitInit(u63) -- Line: 808
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u63.Anims = {};
    u63.Ball = {};
    LocalPlayer.CharacterAdded:Connect(function(p64) -- Line: 812
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref), u63 (copy)
        u1 = p64;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        u63:LoadAnimations();
    end);
end;

return v3;