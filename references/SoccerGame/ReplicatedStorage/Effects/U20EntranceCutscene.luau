  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

local function playEntrance(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), ReplicatedStorage (copy), RunService (copy), Essentials (copy), CutsceneUtils (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    local Attribute = ReplicatedStorage.GameValues:GetAttribute("IntroStartedAt");
    local v2 = Attribute and workspace:GetServerTimeNow() - Attribute or 0;
    local v3;

    if v2 > 1 and v2 <= 15.5 then
        v3 = 15.5 - v2 - 0.5;

        if v3 < 3 then
            return;
        end;
    else
        v3 = nil;
    end;

    local BallSpawn = workspace:WaitForChild("BallSpawn");
    local u4 = CFrame.new(BallSpawn.Position.X, -500, BallSpawn.Position.Z) * BallSpawn.CFrame.Rotation;
    game.SoundService.SoundGroup.OST.Playing = false;
    local u5 = {};

    if LocalPlayer.Team ~= game.Teams.Visitor then
        u5.FL1 = Character;
        local v6 = {};
        local v7 = {};

        for _, v in Players:GetPlayers() do
            local Character2 = v.Character;

            if v ~= LocalPlayer and (Character2 and v.Team ~= game.Teams.Visitor) then
                if v.Team == LocalPlayer.Team then
                    table.insert(v6, Character2);
                else
                    table.insert(v7, Character2);
                end;
            end;
        end;

        local function fillRandom(p8, p9) -- Line: 63
            -- upvalues: u5 (copy)
            for _, v in p9 do
                if #p8 == 0 then
                    break;
                end;

                local math_random_ret = math.random(#p8);
                u5[v] = p8[math_random_ret];
                table.remove(p8, math_random_ret);
            end;
        end;

        fillRandom(v6, { "FL2", "FL3" });
        fillRandom(v7, { "FR1", "FR2", "FR3" });
    end;

    task.spawn(function() -- Line: 105
        -- upvalues: u4 (copy), RunService (ref)
        local VFX = workspace:WaitForChild("VFX", 15);

        if not VFX then
            return;
        end;

        local u10 = script.Cam:Clone();
        u10.Name = "U20HybridCamRig";
        u10:PivotTo(u4);
        u10.Parent = workspace;
        u10.AnimationController.Animator:LoadAnimation(script.CamAnim):Play();
        local u11 = nil;
        task.spawn(function() -- Line: 121
            -- upvalues: VFX (copy), u11 (ref)
            local Blr = VFX:WaitForChild("Blr", 10);

            if Blr then
                Blr = Blr:WaitForChild("CamPart", 5);
            end;

            u11 = Blr;
        end);
        local u12 = {};

        local function pushSample(p13, p14) -- Line: 129
            -- upvalues: u12 (copy)
            local v15 = u12[#u12];

            if not v15 or p13 ~= v15.cf then
                u12[#u12 + 1] = {
                    t = p14,
                    cf = p13
                };

                if #u12 > 12 then
                    table.remove(u12, 1);
                end;
            end;
        end;

        local os_clock_ret = os.clock();
        local u16 = nil;
        local u17 = 0;
        RunService:BindToRenderStep("U20CamSync", Enum.RenderPriority.Last.Value, function() -- Line: 142
            -- upvalues: os_clock_ret (copy), u11 (ref), u10 (copy), u12 (copy), u16 (ref), u17 (ref), pushSample (copy)
            local os_clock_ret2 = os.clock();
            local v18 = os_clock_ret2 - os_clock_ret < 4 and true or not u11;
            local v19;

            if v18 then
                if not u10.Parent then
                    return;
                end;

                v19 = u10.CamPart;
            else
                if u10.Parent then
                    u10:Destroy();
                    table.clear(u12);
                    u16 = nil;
                end;

                v19 = u11;
            end;

            local CFrame2 = v19.CFrame;

            if not v18 and u16 then
                if u16.LookVector:Dot(CFrame2.LookVector) < 0 then
                    u17 = u17 + 1;

                    if u17 < 4 then
                        CFrame2 = CFrame.new(CFrame2.Position) * (u16 - u16.Position);
                    else
                        u17 = 0;
                    end;
                else
                    u17 = 0;
                end;
            end;

            u16 = CFrame2;
            pushSample(CFrame2, os_clock_ret2);
            local v20 = os_clock_ret2 - 0.06666666666666667;

            for i = #u12 - 1, 1, -1 do
                local v21 = u12[i];
                local v22 = u12[i + 1];

                if v21.t <= v20 then
                    if v20 < v22.t and v22.t > v21.t then
                        if (v22.cf.Position - v21.cf.Position).Magnitude < 50 and v22.cf.LookVector:Dot(v21.cf.LookVector) > 0 then
                            CFrame2 = v21.cf:Lerp(v22.cf, (v20 - v21.t) / (v22.t - v21.t));
                        else
                            CFrame2 = v22.cf;
                        end;
                    else
                        CFrame2 = v22.cf;
                    end;

                    break;
                end;

                local _ = i;
            end;

            workspace.CurrentCamera.CFrame = CFrame2;
            workspace.CurrentCamera.FieldOfView = 20;
        end);
    end);
    local v23 = Essentials:HideCosmetics(Character);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene({
        MoonFileName = "U20EntranceCutscene",
        Character = Character,
        CharsToReplace = u5,
        CodeEvents = script.CodeEvents,
        Length = v3,
        SoundCues = script.SoundEvents,
        OriginCFrame = u4
    });
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v23);
    pcall(RunService.UnbindFromRenderStep, RunService, "U20CamSync");
    local U20HybridCamRig = workspace:FindFirstChild("U20HybridCamRig");

    if U20HybridCamRig then
        U20HybridCamRig:Destroy();
    end;
end;

local u24 = false;

return function(u25) -- Line: 236
    -- upvalues: u24 (ref), playEntrance (copy), RunService (copy)
    if u24 then
        return;
    end;

    u24 = true;
    local v26, v27 = xpcall(function() -- Line: 242
        -- upvalues: playEntrance (ref), u25 (copy)
        playEntrance(u25);
    end, debug.traceback);
    u24 = false;

    if not v26 then
        pcall(RunService.UnbindFromRenderStep, RunService, "U20CamSync");
        local U20HybridCamRig = workspace:FindFirstChild("U20HybridCamRig");

        if U20HybridCamRig then
            U20HybridCamRig:Destroy();
        end;

        warn("U20 entrance cutscene failed:\n" .. tostring(v27));
    end;
end;