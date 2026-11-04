  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), RunService (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = require(script.Subtitles)({
        Name = "Kunigami",
        Icon = ""
    });
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local u3 = false;
    task.spawn(function() -- Line: 27
        -- upvalues: Char (copy), RunService (ref), u3 (ref)
        local VFX = workspace:WaitForChild("VFX", 5);

        if not VFX then
            return;
        end;

        local script_CamAnim = script.CamAnim;
        local u4 = script.CamRig:Clone();
        u4.RootPart.CFrame = Char.HumanoidRootPart.CFrame;
        u4.Parent = VFX;
        u4.Name = "Blr";
        local v5 = u4.AnimationController.Animator:LoadAnimation(script_CamAnim);
        v5:Play();
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v6 = RunService.Heartbeat:Connect(function() -- Line: 43
            -- upvalues: u4 (copy)
            workspace.CurrentCamera.CFrame = u4.CamPart.CFrame;
        end);
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until u3 or os.clock() - os_clock_ret > 30;

        v6:Disconnect();
        v5:Stop();
        v5:Destroy();
        u4:Destroy();
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Rekysui = Char
    }, "KunigamiAwk", script.CodeEvents, nil, v2, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    u3 = true;
end;