 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local AffectSpeed = require(ReplicatedStorage.Shared.Tables.AffectSpeed);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u3 = Trove.new();
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = tick();
local v8 = Knit.CreateController({
    Name = "MovementController"
});
local u9 = { "PostMatch" };
local u10 = {};
local u11 = {};
local u12 = {};

local function DestroyRemovedCharacter(u13) -- Line: 38
    task.delay(1, function() -- Line: 39
        -- upvalues: u13 (copy)
        if u13.Parent == nil then
            u13:Destroy();
        end;
    end);
end;

function v8.WalkSpeed(u14) -- Line: 48
    -- upvalues: RunService (copy), u1 (ref), u6 (ref), HumanoidRootPart (ref), Zones (copy), LocalPlayer (copy), u5 (ref), u7 (ref), u2 (ref), ReplicatedStorage (copy), AffectSpeed (copy), u9 (copy), u4 (ref), u10 (copy), u11 (copy), Essentials (copy)
    local u15 = 18;
    local u16 = tick();
    local u17 = tick();
    u14.ExtraBoosts = {};
    RunService.Heartbeat:Connect(function(p18) -- Line: 55
        -- upvalues: u1 (ref), u14 (copy), u6 (ref), HumanoidRootPart (ref), u16 (ref), u17 (ref), Zones (ref), LocalPlayer (ref), u5 (ref), u7 (ref), u2 (ref), ReplicatedStorage (ref), AffectSpeed (ref), u9 (ref), u4 (ref), u10 (ref), u11 (ref), u15 (ref), Essentials (ref)
        if u1:FindFirstChild("IsRagdoll") == nil then
            return;
        end;

        u14.States.Defense = u6.CharValues.Defense;
        u14.States.Stunned = u6.CharValues.Stunned;
        u14.States.HasBall = u6.CharValues.HasBall;
        u14.States.Spotted = u6.CharValues.BeingSpotted;
        local v19;

        if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 3 then
            v19 = u14.AlwaysRun or u14.States.ActualRunning;
        else
            v19 = false;
        end;

        u14.States.Running = v19;
        u14.States.ActualRunning = true;

        if u14.States.Shooting and not u14.States.HasBall then
            u14.States.Shooting = false;
            u14.States.AimAssist = false;
        end;

        if u14.States.Stunned == false then
            u16 = tick();
        else
            u14.States.Dunking = false;

            if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                u16 = tick();
            end;

            if u16 + 3.5 < tick() then
                u6.CharValues.Stunned = false;
            end;
        end;

        if u14.States.HasBall then
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 10 and not u14.States.PumpFake or u6.CharValues.Dribbling then
                u14.States.HasMoved = true;
            end;
        else
            u17 = tick();
            u14.States.HasMoved = false;
            u14.States.PumpFake = false;
            u14.States.AimAssist = false;
        end;

        u14.States.AfterStun = u16 + 1 < tick();

        if u1.IsRagdoll.Value then
            u14.States.Stunned = true;
            u16 = tick();
        end;

        local v20 = p18 * 9;
        local v21 = Zones.ZoneSpeedBoosts[LocalPlayer.Zone.Value];
        local v22 = 18 + u14.Boost;

        if u14.States.Running then
            v20 = p18 * 5;

            if v21 and (u6.CharValues.InZone and u6.CharValues.InZone) then
                if u14.States.HasBall then
                    v22 = v22 + (v21[4] or 0);
                else
                    v22 = v22 + (v21[3] or 0);
                end;
            end;
        elseif v21 and (u6.CharValues.InZone and u6.CharValues.InZone) then
            if u14.States.HasBall then
                v22 = v22 + (v21[2] or 0);
            else
                v22 = v22 + (v21[1] or 0);
            end;
        end;

        if v21 and u6.CharValues.InZone then
            if u14.States.Defense then
                v22 = v22 + (v21[5] or 0);
            end;

            if u5:GetPlayerPossessingBall() == nil then
                v22 = v22 + (v21[6] or 0);
            end;

            if u6.CharValues.Inside then
                v22 = v22 + (v21[7] or 0);
            end;
        end;

        if u6.CharValues.InZone then
            if LocalPlayer.Zone.Value == "777" and (u6.CharValues.ZoneRNG == 1 or u6.CharValues.ZoneRNG == 3) then
                v22 = v22 + 5.5;
            elseif LocalPlayer.Zone.Value == "Dinosaur" then
                local v23 = (u5:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude / 11.6;
                v22 = v22 + math.min(v23, 8);
            end;
        end;

        if u5:BallPlayerZoneIsActive() then
            local PreviousBallPlayer = u5:GetPreviousBallPlayer();

            if PreviousBallPlayer and (PreviousBallPlayer ~= LocalPlayer and (PreviousBallPlayer.Team == LocalPlayer.Team and (PreviousBallPlayer.Zone.Value == "Dime" and (u17 + 5 > tick() and u6.CharValues.HasBall)))) then
                v22 = v22 + 4;
            end;
        end;

        for _, v in u14.ExtraBoosts do
            v22 = v22 + v;
        end;

        if u6.Player.Statistics.Points < 10 then
            v22 = v22 + v22 * (10 / (u6.Player.Statistics.Points + 2) / 100);
        end;

        if u14.States.Dunking == false and (u14.States.Shooting == false and u14.States.HasBall == true) then
            u7 = tick();
            u2.JumpHeight = 0;
        elseif u7 > tick() then
            u2.JumpHeight = 0;
        else
            u2.JumpHeight = Zones.JumpHeight[LocalPlayer.Zone.Value] and (u6.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2;
        end;

        if u14.States.Stunned and not ReplicatedStorage.GameValues.TipOff.Value then
            u7 = tick();
            u2.JumpHeight = 0;
        end;

        if u14.States.NoJump then
            u7 = tick();
            u2.JumpHeight = 0;
        end;

        for i, v in u14.States do
            if AffectSpeed[i] and (v == true or typeof(v) == "number") then
                v22 = v22 + AffectSpeed[i];
            end;
        end;

        for _, v in u9 do
            if LocalPlayer.PlayerGui[v].Enabled then
                v22 = 0;
                break;
            end;
        end;

        if LocalPlayer.Style.Value == "Symbiote" and u6.CharValues.InAwakening then
            v22 = v22 + 3;
        end;

        if LocalPlayer.Style.Value == "Goat" and u6.CharValues.InAwakening then
            v22 = v22 + 5;
        end;

        if u4.InLibertyCrown then
            v22 = v22 + 4;
        end;

        if LocalPlayer:GetAttribute("PAINTSpeedBoost") then
            v22 = v22 + 4;
        end;

        if LocalPlayer:GetAttribute("SmokeTrickSpeedBoost") then
            v22 = v22 + 4.5;
        end;

        if LocalPlayer:GetAttribute("CutTheLightsSpeedBoost") then
            v22 = v22 + 4;
        end;

        if LocalPlayer:GetAttribute("VampiricSpeedStack") then
            v22 = v22 + LocalPlayer:GetAttribute("VampiricSpeedStack") * 4;
        end;

        if LocalPlayer:GetAttribute("Tri-SlashSpeedBoost") then
            v22 = v22 + LocalPlayer:GetAttribute("Tri-SlashSpeedBoost");
        end;

        if LocalPlayer:GetAttribute("VampiricSpeedDrain") and LocalPlayer:GetAttribute("VampiricSpeedDrain") > workspace:GetServerTimeNow() then
            v22 = v22 - 8;
        end;

        if LocalPlayer:GetAttribute("FearSlow") then
            v22 = v22 - 4 * LocalPlayer:GetAttribute("FearSlow");
        end;

        if LocalPlayer.Team ~= game.Teams.Visitor and #u10 > 0 then
            for _, v in u10 do
                if v.Team ~= LocalPlayer.Team then
                    v22 = v22 - 4;
                    break;
                end;
            end;
        end;

        if LocalPlayer.Team ~= game.Teams.Visitor and #u11 > 0 then
            for _, v in u11 do
                if v.Team ~= LocalPlayer.Team then
                    v22 = v22 - 4;
                    break;
                end;
            end;
        end;

        if LocalPlayer:GetAttribute("SoulStringsSlow") and LocalPlayer:GetAttribute("SoulStringsSlow") > workspace:GetServerTimeNow() then
            if u14.States.Running then
                v22 = v22 - 8;
            end;

            v22 = v22 - 8;
        end;

        if workspace:GetAttribute("Isolation") or (workspace:GetAttribute("LukaIllusion") or workspace:GetAttribute("TimeErasure")) then
            v22 = v22 * 0.2;
        end;

        if v22 <= 0 then
            v22 = 0;
            u15 = 0;
        end;

        u15 = Essentials:Lerp(u15, v22, v20);
        u2.WalkSpeed = u15;
    end);
end;

function v8.Resets(p24) -- Line: 306
    -- upvalues: u3 (copy), u2 (ref), Zones (copy), LocalPlayer (copy), u6 (ref), u7 (ref), HumanoidRootPart (ref)
    u3:Clean();
    u3:Connect(u2.StateChanged, function(p25, p26) -- Line: 309
        -- upvalues: Zones (ref), LocalPlayer (ref), u6 (ref), u7 (ref)
        if p26 == Enum.HumanoidStateType.Jumping then
            if Zones.JumpSpeed[LocalPlayer.Zone.Value] and u6.CharValues.InZone then
                u7 = tick() + Zones.JumpSpeed[LocalPlayer.Zone.Value];

                return;
            end;

            u7 = tick() + 2;
        end;
    end);
    u3:Connect(HumanoidRootPart.Touched, function(p27) -- Line: 319
        -- upvalues: u6 (ref)
        if p27 == nil then
            return;
        end;

        if p27.Parent == nil then
            return;
        end;

        if p27.Parent.Name == "InPoint" then
            u6.CharValues.Inside = true;
        end;
    end);
    u3:Connect(HumanoidRootPart.TouchEnded, function(p28) -- Line: 327
        -- upvalues: u6 (ref)
        if p28 == nil then
            return;
        end;

        if p28.Parent == nil then
            return;
        end;

        if p28.Parent.Name == "InPoint" then
            u6.CharValues.Inside = false;
        end;
    end);
    u2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
end;

function v8.KnitStart(u29) -- Line: 338
    -- upvalues: u4 (ref), Knit (copy), u5 (ref), u6 (ref), LocalPlayer (copy)
    u4 = Knit.GetController("AbilityController");
    u5 = Knit.GetController("BallController");
    u6 = Knit.GetController("Network");
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 358
        -- upvalues: u29 (copy)
        u29.Boost = 0;
    end);
    u29:WalkSpeed();
    u29:Resets();
end;

function v8.KnitInit(u30) -- Line: 366
    -- upvalues: u2 (ref), LocalPlayer (copy), u1 (ref), HumanoidRootPart (ref), Players (copy), Trove (copy), u12 (copy), u10 (copy), u11 (copy), DestroyRemovedCharacter (copy)
    u30.States = {
        ActualRunning = true,
        NoAbility = false,
        Running = false,
        Defense = false,
        HasBall = false,
        Shooting = false,
        Stealing = false,
        Stunned = false,
        Kneeling = false,
        Spotted = false,
        Dunking = false,
        Ability = false,
        NoWalk = false,
        NoJump = false,
        HasMoved = false,
        AfterStun = false,
        AimAssist = false,
        AbilitiesUsable = 0
    };
    u30.Boost = 0;
    u30.AlwaysRun = false;
    u2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    LocalPlayer.CharacterAdded:Connect(function(p31) -- Line: 392
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref), u30 (copy)
        u1 = p31;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");

        for i, _ in u30.States do
            u30.States[i] = false;
        end;

        u30.States.Running = true;
        u30.States.AbilitiesUsable = 0;
        u30:Resets();
    end);
    Players.PlayerAdded:Connect(function(u32) -- Line: 407
        -- upvalues: Trove (ref), u12 (ref), u10 (ref), u11 (ref)
        local v33 = Trove.new();
        u12[u32] = v33;
        v33:Connect(u32:GetAttributeChangedSignal("WildcardZone"), function() -- Line: 411
            -- upvalues: u10 (ref), u32 (copy)
            if table.find(u10, u32) then
                table.remove(u10, table.find(u10, u32));
            end;

            if u32:GetAttribute("WildcardZone") then
                table.insert(u10, u32);
            end;
        end);
        v33:Connect(u32:GetAttributeChangedSignal("ManipulatorZone"), function() -- Line: 421
            -- upvalues: u11 (ref), u32 (copy)
            if table.find(u11, u32) then
                table.remove(u11, table.find(u11, u32));
            end;

            if u32:GetAttribute("ManipulatorZone") then
                table.insert(u11, u32);
            end;
        end);
    end);
    Players.PlayerRemoving:Connect(function(p34) -- Line: 432
        -- upvalues: u10 (ref), u11 (ref), u12 (ref)
        if table.find(u10, p34) then
            table.remove(u10, table.find(u10, p34));
        end;

        if table.find(u11, p34) then
            table.remove(u11, table.find(u11, p34));
        end;

        if u12[p34] then
            u12[p34]:Destroy();
            u12[p34] = nil;
        end;

        if p34.Character then
            local Character = p34.Character;
            task.delay(1, function() -- Line: 39
                -- upvalues: Character (copy)
                if Character.Parent == nil then
                    Character:Destroy();
                end;
            end);
        end;
    end);

    for _, v in Players:GetPlayers() do
        v.CharacterRemoving:Connect(DestroyRemovedCharacter);
    end;

    Players.PlayerAdded:Connect(function(p35) -- Line: 455
        -- upvalues: DestroyRemovedCharacter (ref)
        p35.CharacterRemoving:Connect(DestroyRemovedCharacter);
    end);
end;

return v8;